

USE master;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF DB_ID('BidNile') IS NOT NULL
BEGIN
    ALTER DATABASE BidNile SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE BidNile;
END
GO

CREATE DATABASE BidNile;
GO

USE BidNile;
GO

SET QUOTED_IDENTIFIER ON;
GO

-- ============================================================================
-- TASK 2: CREATE SCHEMAS & TABLES

-- ============================================================================
-- Create 4 initial business schemas

CREATE SCHEMA Logistics;
GO

CREATE SCHEMA Members;
GO

CREATE SCHEMA Catalogue;
GO

CREATE SCHEMA Sales;
GO

-- 1. Logistics.Country

CREATE TABLE Logistics.Country (
    CountryCode CHAR(2) NOT NULL,
    NameEn VARCHAR(50) NOT NULL,
    NameAr NVARCHAR(50) NOT NULL,
    PhoneCode VARCHAR(10) NULL,
    CONSTRAINT PK_Country PRIMARY KEY (CountryCode),
    CONSTRAINT CK_Country_CountryCode CHECK (CountryCode IN ('EG', 'SA', 'AE'))
);
GO

-- 2. Logistics.City

CREATE TABLE Logistics.City (
    CityId INT IDENTITY(1, 1) NOT NULL,
    Name NVARCHAR(60) NOT NULL,
    CountryCode CHAR(2) NOT NULL,
    CONSTRAINT PK_City PRIMARY KEY (CityId),
    CONSTRAINT UQ_City_CountryCode_Name UNIQUE (CountryCode, Name)
);
GO

-- 3. Logistics.Warehouse

CREATE TABLE Logistics.Warehouse (
    WarehouseId INT IDENTITY(1, 1) NOT NULL,
    Name NVARCHAR(80) NOT NULL,
    Capacity INT NOT NULL,
    CityId INT NOT NULL,
    Latitude FLOAT NOT NULL,
    Longitude FLOAT NOT NULL,
    ManagerEmployeeId INT NULL,
    ManagerStartDate DATE NULL,
    CONSTRAINT PK_Warehouse PRIMARY KEY (WarehouseId),
    CONSTRAINT UQ_Warehouse_Name UNIQUE (Name),
    CONSTRAINT CK_Warehouse_Capacity CHECK (Capacity > 0),
    CONSTRAINT CK_Warehouse_Latitude CHECK (Latitude BETWEEN -90.0 AND 90.0),
    CONSTRAINT CK_Warehouse_Longitude CHECK (Longitude BETWEEN -180.0 AND 180.0)
);
GO

CREATE UNIQUE NONCLUSTERED INDEX UQ_Warehouse_ManagerEmployeeId
ON Logistics.Warehouse (ManagerEmployeeId)
WHERE ManagerEmployeeId IS NOT NULL;
GO

-- 4. Logistics.Employee

CREATE TABLE Logistics.Employee (
    EmployeeId INT IDENTITY(1, 1) NOT NULL,
    MemberId UNIQUEIDENTIFIER NOT NULL,
    WarehouseId INT NOT NULL,
    HireDate DATE NOT NULL CONSTRAINT DF_Employee_HireDate DEFAULT (CAST(GETDATE() AS DATE)),
    CONSTRAINT PK_Employee PRIMARY KEY (EmployeeId),
    CONSTRAINT UQ_Employee_MemberId UNIQUE (MemberId)
);
GO

-- 5. Members.Member

CREATE TABLE Members.Member (
    MemberId UNIQUEIDENTIFIER NOT NULL CONSTRAINT DF_Member_MemberId DEFAULT NEWID(),
    FullName NVARCHAR(100) NOT NULL,
    Email VARCHAR(254) NOT NULL,
    Mobile VARCHAR(16) NOT NULL,
    NationalId VARCHAR(20) NOT NULL,
    BirthDate DATE NOT NULL,
    IsVerified BIT NOT NULL CONSTRAINT DF_Member_IsVerified DEFAULT 0,
    RegisteredAt DATETIME2(3) NOT NULL CONSTRAINT DF_Member_RegisteredAt DEFAULT SYSUTCDATETIME(),
    CityId INT NOT NULL,
    InvitedByMemberId UNIQUEIDENTIFIER NULL,
    CONSTRAINT PK_Member PRIMARY KEY (MemberId),
    CONSTRAINT UQ_Member_Email UNIQUE (Email),
    CONSTRAINT UQ_Member_NationalId UNIQUE (NationalId),
    CONSTRAINT CK_Member_Age CHECK (BirthDate <= DATEADD(YEAR, -18, CAST(GETDATE() AS DATE)))
);
GO

-- 6. Members.Wallet

CREATE TABLE Members.Wallet (
    WalletId INT IDENTITY(1, 1) NOT NULL,
    MemberId UNIQUEIDENTIFIER NOT NULL,
    Balance DECIMAL(12, 2) NOT NULL CONSTRAINT DF_Wallet_Balance DEFAULT 0.00,
    HeldAmount DECIMAL(12, 2) NOT NULL CONSTRAINT DF_Wallet_HeldAmount DEFAULT 0.00,
    Currency CHAR(3) NOT NULL CONSTRAINT DF_Wallet_Currency DEFAULT 'EGP',
    LastUpdatedAt DATETIME2(3) NOT NULL CONSTRAINT DF_Wallet_LastUpdatedAt DEFAULT SYSUTCDATETIME(),
    CONSTRAINT PK_Wallet PRIMARY KEY (WalletId),
    CONSTRAINT UQ_Wallet_MemberId UNIQUE (MemberId),
    CONSTRAINT CK_Wallet_Balance CHECK (Balance >= 0.00),
    CONSTRAINT CK_Wallet_HeldAmount CHECK (HeldAmount >= 0.00 AND HeldAmount <= Balance)
);
GO

-- 7. Catalogue.Category

CREATE TABLE Catalogue.Category (
    CategoryId INT NOT NULL,
    ParentCategoryId INT NULL,
    NameEn VARCHAR(50) NOT NULL,
    NameAr NVARCHAR(50) NOT NULL,
    CommissionRate DECIMAL(5, 2) NOT NULL,
    CONSTRAINT PK_Category PRIMARY KEY (CategoryId),
    CONSTRAINT UQ_Category_NameEn UNIQUE (NameEn),
    CONSTRAINT CK_Category_CommissionRate CHECK (CommissionRate >= 0.00 AND CommissionRate <= 30.00)
);
GO

-- 8. Catalogue.Item

CREATE TABLE Catalogue.Item (
    ItemId INT IDENTITY(1, 1) NOT NULL,
    Title NVARCHAR(150) NOT NULL,
    Description NVARCHAR(MAX) NULL,
    ConditionScore TINYINT NOT NULL,
    Specifications NVARCHAR(MAX) NOT NULL,
    SellerMemberId UNIQUEIDENTIFIER NOT NULL,
    CategoryId INT NOT NULL,
    WarehouseId INT NULL,
    InspectorMemberId UNIQUEIDENTIFIER NULL,
    ListedAt DATETIME2(3) NOT NULL CONSTRAINT DF_Item_ListedAt DEFAULT SYSUTCDATETIME(),
    CONSTRAINT PK_Item PRIMARY KEY (ItemId),
    CONSTRAINT CK_Item_ConditionScore CHECK (ConditionScore BETWEEN 1 AND 10),
    CONSTRAINT CK_Item_Specifications_Json CHECK (ISJSON(Specifications) = 1),
    CONSTRAINT CK_Item_Seller_Not_Inspector CHECK (InspectorMemberId IS NULL OR SellerMemberId <> InspectorMemberId)
);
GO

-- 9. Catalogue.ItemPhoto

CREATE TABLE Catalogue.ItemPhoto (
    ItemId INT NOT NULL,
    Position TINYINT NOT NULL,
    PhotoUrl VARCHAR(500) NOT NULL,
    IsMain BIT NOT NULL CONSTRAINT DF_ItemPhoto_IsMain DEFAULT 0,
    CONSTRAINT PK_ItemPhoto PRIMARY KEY (ItemId, Position),
    CONSTRAINT CK_ItemPhoto_Position CHECK (Position BETWEEN 1 AND 20)
);
GO

-- 10. Sales.Auction

CREATE TABLE Sales.Auction (
    AuctionId INT IDENTITY(1, 1) NOT NULL,
    ItemId INT NOT NULL,
    StartingPrice DECIMAL(12, 2) NOT NULL,
    ReservePrice DECIMAL(12, 2) NULL,
    BidIncrement DECIMAL(12, 2) NOT NULL CONSTRAINT DF_Auction_BidIncrement DEFAULT 50.00,
    StartsAt DATETIMEOFFSET(0) NOT NULL,
    EndsAt DATETIMEOFFSET(0) NOT NULL,
    Status VARCHAR(20) NOT NULL CONSTRAINT DF_Auction_Status DEFAULT 'Draft',
    CONSTRAINT PK_Auction PRIMARY KEY (AuctionId),
    CONSTRAINT CK_Auction_StartingPrice CHECK (StartingPrice > 0.00),
    CONSTRAINT CK_Auction_ReservePrice CHECK (ReservePrice IS NULL OR ReservePrice >= StartingPrice),
    CONSTRAINT CK_Auction_BidIncrement CHECK (BidIncrement > 0.00),
    CONSTRAINT CK_Auction_Dates CHECK (EndsAt > StartsAt),
    CONSTRAINT CK_Auction_Status CHECK (Status IN ('Draft', 'Live', 'Ended', 'Cancelled'))
);
GO

-- 11. Sales.Bid

CREATE TABLE Sales.Bid (
    BidId BIGINT IDENTITY(1, 1) NOT NULL,
    AuctionId INT NOT NULL,
    MemberId UNIQUEIDENTIFIER NOT NULL,
    Amount DECIMAL(12, 2) NOT NULL,
    PlacedAt DATETIME2(3) NOT NULL CONSTRAINT DF_Bid_PlacedAt DEFAULT SYSUTCDATETIME(),
    IpAddress VARCHAR(45) NOT NULL,
    CONSTRAINT PK_Bid PRIMARY KEY (BidId),
    CONSTRAINT CK_Bid_Amount CHECK (Amount > 0.00),
    CONSTRAINT UQ_Bid_Auction_Amount UNIQUE (AuctionId, Amount)
);
GO

-- 12. Sales.AuctionFollower

CREATE TABLE Sales.AuctionFollower (
    AuctionId INT NOT NULL,
    MemberId UNIQUEIDENTIFIER NOT NULL,
    FollowedAt DATETIME2(3) NOT NULL CONSTRAINT DF_AuctionFollower_FollowedAt DEFAULT SYSUTCDATETIME(),
    CONSTRAINT PK_AuctionFollower PRIMARY KEY (AuctionId, MemberId)
);
GO

-- ============================================================================
-- TASK 3: ALTER - THE BUSINESS CHANGES

-- ============================================================================
-- 3.1 Connect everything: Add every FK with ALTER TABLE ... ADD CONSTRAINT.
-- Deleting an item deletes its photos; all other FKs: no action.

-- 1. City -> Country
ALTER TABLE Logistics.City
ADD CONSTRAINT FK_City_Country FOREIGN KEY (CountryCode)
    REFERENCES Logistics.Country (CountryCode);
GO

-- 2. Member -> City
ALTER TABLE Members.Member
ADD CONSTRAINT FK_Member_City FOREIGN KEY (CityId)
    REFERENCES Logistics.City (CityId);
GO

-- 3. Member -> Member (Referral / Recursive 1:N)
ALTER TABLE Members.Member
ADD CONSTRAINT FK_Member_Member_InvitedBy FOREIGN KEY (InvitedByMemberId)
    REFERENCES Members.Member (MemberId);
GO

-- 4. Wallet -> Member (1:1 Relationship)
ALTER TABLE Members.Wallet
ADD CONSTRAINT FK_Wallet_Member FOREIGN KEY (MemberId)
    REFERENCES Members.Member (MemberId);
GO

-- 5. Warehouse -> City
ALTER TABLE Logistics.Warehouse
ADD CONSTRAINT FK_Warehouse_City FOREIGN KEY (CityId)
    REFERENCES Logistics.City (CityId);
GO

-- 6. Employee -> Member
ALTER TABLE Logistics.Employee
ADD CONSTRAINT FK_Employee_Member FOREIGN KEY (MemberId)
    REFERENCES Members.Member (MemberId);
GO

-- 7. Employee -> Warehouse
ALTER TABLE Logistics.Employee
ADD CONSTRAINT FK_Employee_Warehouse FOREIGN KEY (WarehouseId)
    REFERENCES Logistics.Warehouse (WarehouseId);
GO

-- 8. Warehouse -> Employee (Manager / Circular 1:1)
ALTER TABLE Logistics.Warehouse
ADD CONSTRAINT FK_Warehouse_Employee_Manager FOREIGN KEY (ManagerEmployeeId)
    REFERENCES Logistics.Employee (EmployeeId);
GO

-- 9. Category -> Category (Tree / Recursive 1:N)
ALTER TABLE Catalogue.Category
ADD CONSTRAINT FK_Category_Category_Parent FOREIGN KEY (ParentCategoryId)
    REFERENCES Catalogue.Category (CategoryId);
GO

-- 10. Item -> Member (Seller)
ALTER TABLE Catalogue.Item
ADD CONSTRAINT FK_Item_Member_Seller FOREIGN KEY (SellerMemberId)
    REFERENCES Members.Member (MemberId);
GO

-- 11. Item -> Category
ALTER TABLE Catalogue.Item
ADD CONSTRAINT FK_Item_Category FOREIGN KEY (CategoryId)
    REFERENCES Catalogue.Category (CategoryId);
GO

-- 12. Item -> Warehouse
ALTER TABLE Catalogue.Item
ADD CONSTRAINT FK_Item_Warehouse FOREIGN KEY (WarehouseId)
    REFERENCES Logistics.Warehouse (WarehouseId);
GO

-- 13. Item -> Member (Inspector)
ALTER TABLE Catalogue.Item
ADD CONSTRAINT FK_Item_Member_Inspector FOREIGN KEY (InspectorMemberId)
    REFERENCES Members.Member (MemberId);
GO

-- 14. ItemPhoto -> Item (CASCADE DELETE as specified)
ALTER TABLE Catalogue.ItemPhoto
ADD CONSTRAINT FK_ItemPhoto_Item FOREIGN KEY (ItemId)
    REFERENCES Catalogue.Item (ItemId)
    ON DELETE CASCADE;
GO

-- 15. Auction -> Item
ALTER TABLE Sales.Auction
ADD CONSTRAINT FK_Auction_Item FOREIGN KEY (ItemId)
    REFERENCES Catalogue.Item (ItemId);
GO

-- 16. Bid -> Auction
ALTER TABLE Sales.Bid
ADD CONSTRAINT FK_Bid_Auction FOREIGN KEY (AuctionId)
    REFERENCES Sales.Auction (AuctionId);
GO

-- 17. Bid -> Member
ALTER TABLE Sales.Bid
ADD CONSTRAINT FK_Bid_Member FOREIGN KEY (MemberId)
    REFERENCES Members.Member (MemberId);
GO

-- 18. AuctionFollower -> Auction
ALTER TABLE Sales.AuctionFollower
ADD CONSTRAINT FK_AuctionFollower_Auction FOREIGN KEY (AuctionId)
    REFERENCES Sales.Auction (AuctionId);
GO

-- 19. AuctionFollower -> Member
ALTER TABLE Sales.AuctionFollower
ADD CONSTRAINT FK_AuctionFollower_Member FOREIGN KEY (MemberId)
    REFERENCES Members.Member (MemberId);
GO

-- ============================================================================


-- 3.2 Members choose an app language, ar or en. Add a NOT NULL column; existing members get ar. One statement.
ALTER TABLE Members.Member
ADD PreferredLanguage CHAR(2) NOT NULL
    CONSTRAINT DF_Member_PreferredLanguage DEFAULT 'ar'
    CONSTRAINT CK_Member_PreferredLanguage CHECK (PreferredLanguage IN ('ar', 'en'));
GO

-- ============================================================================


-- 3.3 Items can be "featured". Add a NOT NULL Yes/No column, default No.
ALTER TABLE Catalogue.Item
ADD IsFeatured BIT NOT NULL
    CONSTRAINT DF_Item_IsFeatured DEFAULT 0;
GO

-- ============================================================================

-- 3.4 Naming review: Rename bid IP column to DeviceIp and warehouse capacity to MaxItems (using sp_rename).
-- Note: In SQL Server, to rename a column participating in an enforced CHECK constraint,
-- the constraint must be dropped first, then sp_rename is executed, and re-added.
ALTER TABLE Logistics.Warehouse
DROP CONSTRAINT IF EXISTS CK_Warehouse_Capacity;
GO

EXEC sp_rename 'Sales.Bid.IpAddress', 'DeviceIp', 'COLUMN';
GO

EXEC sp_rename 'Logistics.Warehouse.Capacity', 'MaxItems', 'COLUMN';
GO

ALTER TABLE Logistics.Warehouse
ADD CONSTRAINT CK_Warehouse_MaxItems CHECK (MaxItems > 0);
GO

-- ============================================================================

-- 3.5 Some names are longer than 100 characters. ALTER COLUMN full name to 150 — it must still be NOT NULL.
ALTER TABLE Members.Member
ALTER COLUMN FullName NVARCHAR(150) NOT NULL;
GO

-- ============================================================================


-- 3.6 No warehouse will hold more than 30,000 items. Change MaxItems to the smallest type that fits (SMALLINT).
-- Note: Attempting to ALTER COLUMN on a column with a dependent CHECK constraint produces error Msg 5074.
-- Fix: Drop the dependent CHECK constraint, alter the column type to SMALLINT, and re-add constraint with > 0 and <= 30000.
ALTER TABLE Logistics.Warehouse
DROP CONSTRAINT CK_Warehouse_MaxItems;
GO

ALTER TABLE Logistics.Warehouse
ALTER COLUMN MaxItems SMALLINT NOT NULL;
GO

ALTER TABLE Logistics.Warehouse
ADD CONSTRAINT CK_Warehouse_MaxItems CHECK (MaxItems > 0 AND MaxItems <= 30000);
GO

-- ============================================================================


-- 3.7 Max commission is now 25 %. Replace the commission CHECK.
ALTER TABLE Catalogue.Category
DROP CONSTRAINT CK_Category_CommissionRate;
GO

ALTER TABLE Catalogue.Category
ADD CONSTRAINT CK_Category_CommissionRate CHECK (CommissionRate >= 0.00 AND CommissionRate <= 25.00);
GO

-- ============================================================================


-- 3.8 Auctions must be reviewed first. Allow status PendingReview and make it the new default.
ALTER TABLE Sales.Auction
DROP CONSTRAINT DF_Auction_Status;
GO

ALTER TABLE Sales.Auction
DROP CONSTRAINT CK_Auction_Status;
GO

ALTER TABLE Sales.Auction
ADD CONSTRAINT CK_Auction_Status CHECK (Status IN ('PendingReview', 'Draft', 'Live', 'Ended', 'Cancelled'));
GO

ALTER TABLE Sales.Auction
ADD CONSTRAINT DF_Auction_Status DEFAULT 'PendingReview' FOR Status;
GO

-- ============================================================================


-- 3.9 Optional "Buy Now" price. Add it + a named CHECK (greater than starting price).
ALTER TABLE Sales.Auction
ADD BuyNowPrice DECIMAL(12, 2) NULL;
GO

ALTER TABLE Sales.Auction WITH CHECK
ADD CONSTRAINT CK_Auction_BuyNowPrice CHECK (BuyNowPrice IS NULL OR BuyNowPrice > StartingPrice);
GO

-- ============================================================================


-- 3.10 Duplicate accounts were found. The member's mobile must now be unique.
ALTER TABLE Members.Member
ADD CONSTRAINT UQ_Member_Mobile UNIQUE (Mobile);
GO

-- ============================================================================


-- 3.11 We need when a member was verified. Add VerifiedAt (optional), then drop the old Yes/No column —
-- something is attached to it (the default constraint DF_Member_IsVerified must be dropped before dropping the column).
ALTER TABLE Members.Member
ADD VerifiedAt DATETIME2(3) NULL;
GO

ALTER TABLE Members.Member
DROP CONSTRAINT DF_Member_IsVerified;
GO

ALTER TABLE Members.Member
DROP COLUMN IsVerified;
GO

-- ============================================================================


-- 3.12 Marketing now owns engagement data. Create schema Marketing and move the "followed auctions" table
-- into it with ALTER SCHEMA ... TRANSFER.
CREATE SCHEMA Marketing;
GO

ALTER SCHEMA Marketing TRANSFER Sales.AuctionFollower;
GO
