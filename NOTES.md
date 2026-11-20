# BidNile Online Auctions - Database Architecture & Design Notes

This document provides answers to **Section 03 (NOTES.md)**.

---

## 1. The 4 Schemas, Their Tables, and Why

The database is organized into four logical business schemas:

| Schema | Tables | Architectural Rationale |
| :--- | :--- | :--- |
| **`Logistics`** | `Country`, `City`, `Warehouse`, `Employee` | Encompasses physical operational hubs, geographic coverage (countries and cities), warehouse facilities where goods are inspected and held, and assigned warehouse staff. |
| **`Members`** | `Member`, `Wallet` | Encapsulates user accounts, identity verification, invitations/referrals, and financial ledgers (wallet balance, held funds for live bids). |
| **`Catalogue`** | `Category`, `Item`, `ItemPhoto` | Manages the product tree (categories), item listings with flexible JSON technical specifications, condition grades (1 to 10), and the photo gallery. |
| **`Sales`** | `Auction`, `Bid`, `AuctionFollower`* | Powers real-time timed bidding, starting prices, reserve prices, bid increments, and user engagement/watchlists. (*`AuctionFollower` is transferred to `Marketing` in Task 3.12). |

---

## 2. Mapping of Relationship Types in BidNile

| Relationship Type | Location in BidNile | Implementation & Mapping Strategy |
| :--- | :--- | :--- |
| **1:1** | `Members.Member` ↔ `Members.Wallet` | `Wallet` has `MemberId UNIQUEIDENTIFIER NOT NULL UNIQUE` referencing `Member(MemberId)`. |
| **1:1** | `Logistics.Warehouse` ↔ `Logistics.Employee` (Manager) | `Warehouse` has `ManagerEmployeeId INT NULL UNIQUE` referencing `Employee(EmployeeId)`. |
| **1:N** | `Logistics.Warehouse` → `Logistics.Employee` (Staff) | `Employee` has `WarehouseId INT NOT NULL` referencing `Warehouse(WarehouseId)`. |
| **1:N** | `Catalogue.Item` → `Sales.Auction` | An item can be listed across multiple successive auctions if unsold. `Auction` has `ItemId INT NOT NULL` referencing `Item(ItemId)`. |
| **1:N** | `Sales.Auction` → `Sales.Bid` | `Bid` has `AuctionId INT NOT NULL` referencing `Auction(AuctionId)`. |
| **M:N** | `Sales.Auction` ↔ `Members.Member` (Followers) | Junction table `Sales.AuctionFollower` with composite primary key `(AuctionId, MemberId)` and foreign keys to both tables. |
| **Recursive (1:N)** | `Members.Member` → `Members.Member` (Referrals) | `InvitedByMemberId UNIQUEIDENTIFIER NULL` on `Member` references `Member(MemberId)`. |
| **Recursive (1:N)** | `Catalogue.Category` → `Catalogue.Category` (Tree) | `ParentCategoryId INT NULL` on `Category` references `Category(CategoryId)` to model subcategories under parent categories. |
| **Circular** | `Warehouse` ↔ `Employee` | `Employee` has `WarehouseId` referencing `Warehouse` (where employee works), while `Warehouse` has `ManagerEmployeeId` referencing `Employee` (who manages the facility). |
| **Weak Entity** | `Catalogue.ItemPhoto` | Identified strictly in the context of its parent item and sequence position `(ItemId, Position)`. Foreign key `FK_ItemPhoto_Item` specifies `ON DELETE CASCADE`. |

---

## 3. Data Type Choices

### Why `GUID (UNIQUEIDENTIFIER)` for Members and `BIGINT` for Bids?
- **Members (`UNIQUEIDENTIFIER`)**: Members register from mobile apps, which generate unique member IDs client-side offline before requests hit the server. Sequential `INT` numbers cannot be safely generated offline on distributed mobile devices without collisions. `UNIQUEIDENTIFIER` with `NEWID()` guarantees globally unique client-side generation.
- **Bids (`BIGINT`)**: BidNile anticipates hundreds of millions of bids annually, quickly surpassing the 2.14 billion limit of a 32-bit signed integer (`INT`). `BIGINT` (64-bit signed integer, up to 9.22 quintillion) prevents integer overflow failure.

### Why `FLOAT` for GPS but `DECIMAL` for Money?
- **GPS (`FLOAT`)**: Latitude and longitude are continuous physical measurements with numerous decimal places provided by map providers. `FLOAT` is computationally efficient and standard for spatial math, where minor floating-point rounding is acceptable.
- **Money (`DECIMAL(12, 2)`)**: Financial ledgers and balances require exact base-10 precision. Binary floating-point representation (`FLOAT`) introduces precision and approximation errors (e.g. $0.1 + 0.2 \neq 0.3$), which are unacceptable for financial transactions.

### Why `DATETIMEOFFSET` for Auctions?
- BidNile operates across Egypt (`UTC+02:00`), Saudi Arabia (`UTC+03:00`), and the UAE (`UTC+04:00`). Using `DATETIME` or `DATETIME2` without timezone offsets creates ambiguity regarding auction start and end times across regions. `DATETIMEOFFSET` records the exact point in time alongside the explicit UTC offset, ensuring consistent comparison across different timezones.

---

## 4. Why Can't the Circular Relationship Be Created Inside `CREATE TABLE`?

In SQL Server, `CREATE TABLE` requires any referenced parent table to already exist. In the circular relationship between `Warehouse` and `Employee`:
- Creating `Warehouse` first with a foreign key to `Employee` fails because `Employee` does not yet exist.
- Creating `Employee` first with a foreign key to `Warehouse` fails because `Warehouse` does not yet exist.

Neither table can be created with an inline foreign key pointing to the other. Therefore, tables must be created first without the circular foreign keys (or leaving the column nullable), and foreign key constraints are added subsequently using `ALTER TABLE ... ADD CONSTRAINT`.

---

## 5. Table Population Order (Task 4)

Because foreign key constraints are active, tables were populated in topological dependency order:

1. **`Logistics.Country`**: Root geographic lookup table.
2. **`Logistics.City`**: References `Country`.
3. **`Members.Member`**: References `City`. Members with `InvitedByMemberId = NULL` are inserted first, followed by members who were invited.
4. **`Members.Wallet`**: References `Member`.
5. **`Logistics.Warehouse`**: References `City`. Rows are inserted with `ManagerEmployeeId = NULL` initially to avoid circular FK violations.
6. **`Logistics.Employee`**: References `Member` and `Warehouse`.
7. **`Logistics.Warehouse` (Update)**: Warehouses are updated with their respective `ManagerEmployeeId` values.
8. **`Catalogue.Category`**: Root categories (`ParentCategoryId = NULL`) inserted before subcategories.
9. **`Catalogue.Item`**: References `Member` (Seller, Inspector), `Category`, and `Warehouse`.
10. **`Catalogue.ItemPhoto`**: References `Item`.
11. **`Sales.Auction`**: References `Item`.
12. **`Sales.Bid`**: References `Auction` and `Member`.
13. **`Marketing.AuctionFollower`**: References `Auction` and `Member`.

---

## 6. The Errors in Tasks 3.6 and 3.11, and How They Were Fixed

### Task 3.6 Error & Resolution
- **Error Encountered**:
  ```text
  Msg 5074, Level 16, State 1:
  The object 'CK_Warehouse_Capacity' is dependent on column 'MaxItems'.
  ALTER TABLE ALTER COLUMN MaxItems failed because one or more objects access this column.
  ```
- **Cause**: SQL Server prohibits altering the data type of a column that is referenced by an active CHECK constraint.
- **Fix**:
  1. Drop the constraint: `ALTER TABLE Logistics.Warehouse DROP CONSTRAINT CK_Warehouse_MaxItems;`
  2. Alter column type: `ALTER TABLE Logistics.Warehouse ALTER COLUMN MaxItems SMALLINT NOT NULL;` (since `SMALLINT` fits up to 32,767, meeting the 30,000 requirement).
  3. Re-create constraint: `ALTER TABLE Logistics.Warehouse ADD CONSTRAINT CK_Warehouse_MaxItems CHECK (MaxItems > 0 AND MaxItems <= 30000);`

### Task 3.11 Error & Resolution
- **Error Encountered**:
  ```text
  Msg 5074, Level 16, State 1:
  The object 'DF_Member_IsVerified' is dependent on column 'IsVerified'.
  ALTER TABLE DROP COLUMN IsVerified failed because one or more objects access this column.
  ```
- **Cause**: The column `IsVerified` has a bound DEFAULT constraint (`DF_Member_IsVerified`). SQL Server disallows dropping a column while a constraint depends on it.
- **Fix**:
  1. Add replacement column: `ALTER TABLE Members.Member ADD VerifiedAt DATETIME2(3) NULL;`
  2. Drop the default constraint: `ALTER TABLE Members.Member DROP CONSTRAINT DF_Member_IsVerified;`
  3. Drop the column: `ALTER TABLE Members.Member DROP COLUMN IsVerified;`

---

## 7. LeetCode 238 Hand Trace (Task 5 Reference)

For array `nums = [1, 2, 3, 4]`:

| Index `i` | Value | Prefix Product (before `i`) | Suffix Product (after `i`) | Final Result (`Prefix * Suffix`) |
| :---: | :---: | :---: | :---: | :---: |
| **0** | 1 | 1 | $2 \times 3 \times 4 = 24$ | $1 \times 24 = \mathbf{24}$ |
| **1** | 2 | 1 | $3 \times 4 = 12$ | $1 \times 12 = \mathbf{12}$ |
| **2** | 3 | $1 \times 2 = 2$ | 4 | $2 \times 4 = \mathbf{8}$ |
| **3** | 4 | $1 \times 2 \times 3 = 6$ | 1 | $6 \times 1 = \mathbf{6}$ |

**Result**: `[24, 12, 8, 6]`
