USE [BidNile]
GO

-- 1. Country
INSERT [Logistics].[Country] ([CountryCode], [NameEn], [NameAr], [PhoneCode]) VALUES (N'AE', N'United Arab Emirates', N'الإمارات العربية المتحدة', N'+971')
INSERT [Logistics].[Country] ([CountryCode], [NameEn], [NameAr], [PhoneCode]) VALUES (N'EG', N'Egypt', N'مصر', N'+20')
INSERT [Logistics].[Country] ([CountryCode], [NameEn], [NameAr], [PhoneCode]) VALUES (N'SA', N'Saudi Arabia', N'المملكة العربية السعودية', N'+966')
GO

-- 2. City
SET IDENTITY_INSERT [Logistics].[City] ON 
INSERT [Logistics].[City] ([CityId], [Name], [CountryCode]) VALUES (7, N'Abu Dhabi', N'AE')
INSERT [Logistics].[City] ([CityId], [Name], [CountryCode]) VALUES (6, N'Dubai', N'AE')
INSERT [Logistics].[City] ([CityId], [Name], [CountryCode]) VALUES (2, N'Alexandria', N'EG')
INSERT [Logistics].[City] ([CityId], [Name], [CountryCode]) VALUES (1, N'Cairo', N'EG')
INSERT [Logistics].[City] ([CityId], [Name], [CountryCode]) VALUES (3, N'Giza', N'EG')
INSERT [Logistics].[City] ([CityId], [Name], [CountryCode]) VALUES (5, N'Jeddah', N'SA')
INSERT [Logistics].[City] ([CityId], [Name], [CountryCode]) VALUES (4, N'Riyadh', N'SA')
SET IDENTITY_INSERT [Logistics].[City] OFF
GO

-- 3. Member
-- Non-referred members first, then referred members to maintain self-referencing FK integrity
INSERT [Members].[Member] ([MemberId], [FullName], [Email], [Mobile], [NationalId], [BirthDate], [RegisteredAt], [CityId], [InvitedByMemberId], [PreferredLanguage], [VerifiedAt]) VALUES (N'11111111-1111-1111-1111-111111111111', N'Ahmed Mansour', N'ahmed.mansour@gmail.com', N'+201001112233', N'29001011234567', CAST(N'1990-01-15' AS Date), CAST(N'2024-01-10T10:00:00.000' AS DateTime2), 1, NULL, N'ar', CAST(N'2024-01-11T12:00:00.000' AS DateTime2))
INSERT [Members].[Member] ([MemberId], [FullName], [Email], [Mobile], [NationalId], [BirthDate], [RegisteredAt], [CityId], [InvitedByMemberId], [PreferredLanguage], [VerifiedAt]) VALUES (N'44444444-4444-4444-4444-444444444444', N'Khaled Al-Ghamdi', N'khaled.ghamdi@outlook.com', N'+966501234567', N'1089234567', CAST(N'1985-03-22' AS Date), CAST(N'2024-02-10T14:20:00.000' AS DateTime2), 4, NULL, N'ar', CAST(N'2024-02-11T16:00:00.000' AS DateTime2))
INSERT [Members].[Member] ([MemberId], [FullName], [Email], [Mobile], [NationalId], [BirthDate], [RegisteredAt], [CityId], [InvitedByMemberId], [PreferredLanguage], [VerifiedAt]) VALUES (N'77777777-7777-7777-7777-777777777777', N'Mahmoud Abdelaziz', N'mahmoud.aziz@bidnile.com', N'+201225556677', N'28712151234571', CAST(N'1987-12-15' AS Date), CAST(N'2024-03-01T13:00:00.000' AS DateTime2), 2, NULL, N'ar', CAST(N'2024-03-02T11:00:00.000' AS DateTime2))
INSERT [Members].[Member] ([MemberId], [FullName], [Email], [Mobile], [NationalId], [BirthDate], [RegisteredAt], [CityId], [InvitedByMemberId], [PreferredLanguage], [VerifiedAt]) VALUES (N'99999999-9999-9999-9999-999999999999', N'Rashid Al-Maktoum', N'rashid.maktoum@bidnile.com', N'+971501112233', N'784199112345671', CAST(N'1991-04-18' AS Date), CAST(N'2024-03-10T10:50:00.000' AS DateTime2), 6, NULL, N'en', CAST(N'2024-03-11T09:00:00.000' AS DateTime2))

INSERT [Members].[Member] ([MemberId], [FullName], [Email], [Mobile], [NationalId], [BirthDate], [RegisteredAt], [CityId], [InvitedByMemberId], [PreferredLanguage], [VerifiedAt]) VALUES (N'22222222-2222-2222-2222-222222222222', N'Tarek El-Sayed', N'tarek.elsayed@bidnile.com', N'+201002223344', N'28805121234568', CAST(N'1988-05-12' AS Date), CAST(N'2024-01-15T11:30:00.000' AS DateTime2), 1, N'11111111-1111-1111-1111-111111111111', N'ar', CAST(N'2024-01-15T14:00:00.000' AS DateTime2))
INSERT [Members].[Member] ([MemberId], [FullName], [Email], [Mobile], [NationalId], [BirthDate], [RegisteredAt], [CityId], [InvitedByMemberId], [PreferredLanguage], [VerifiedAt]) VALUES (N'33333333-3333-3333-3333-333333333333', N'Nour Ibrahim', N'nour.ibrahim@yahoo.com', N'+201003334455', N'29509201234569', CAST(N'1995-09-20' AS Date), CAST(N'2024-02-01T09:15:00.000' AS DateTime2), 2, N'11111111-1111-1111-1111-111111111111', N'en', CAST(N'2024-02-02T10:00:00.000' AS DateTime2))
INSERT [Members].[Member] ([MemberId], [FullName], [Email], [Mobile], [NationalId], [BirthDate], [RegisteredAt], [CityId], [InvitedByMemberId], [PreferredLanguage], [VerifiedAt]) VALUES (N'55555555-5555-5555-5555-555555555555', N'Faisal Al-Otaibi', N'faisal.otaibi@gmail.com', N'+966559876543', N'1098765432', CAST(N'1992-11-05' AS Date), CAST(N'2024-02-18T16:45:00.000' AS DateTime2), 5, N'44444444-4444-4444-4444-444444444444', N'ar', CAST(N'2024-02-20T09:30:00.000' AS DateTime2))
INSERT [Members].[Member] ([MemberId], [FullName], [Email], [Mobile], [NationalId], [BirthDate], [RegisteredAt], [CityId], [InvitedByMemberId], [PreferredLanguage], [VerifiedAt]) VALUES (N'66666666-6666-6666-6666-666666666666', N'Mohamed Hassan', N'mohamed.hassan@bidnile.com', N'+201114445566', N'29207081234570', CAST(N'1992-07-08' AS Date), CAST(N'2024-02-22T08:30:00.000' AS DateTime2), 1, N'22222222-2222-2222-2222-222222222222', N'ar', CAST(N'2024-02-22T10:00:00.000' AS DateTime2))
INSERT [Members].[Member] ([MemberId], [FullName], [Email], [Mobile], [NationalId], [BirthDate], [RegisteredAt], [CityId], [InvitedByMemberId], [PreferredLanguage], [VerifiedAt]) VALUES (N'88888888-8888-8888-8888-888888888888', N'Saud Al-Qahtani', N'saud.qahtani@bidnile.com', N'+966542223344', N'1076543210', CAST(N'1989-08-30' AS Date), CAST(N'2024-03-05T15:10:00.000' AS DateTime2), 4, N'44444444-4444-4444-4444-444444444444', N'ar', CAST(N'2024-03-06T12:00:00.000' AS DateTime2))
INSERT [Members].[Member] ([MemberId], [FullName], [Email], [Mobile], [NationalId], [BirthDate], [RegisteredAt], [CityId], [InvitedByMemberId], [PreferredLanguage], [VerifiedAt]) VALUES (N'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', N'Mariam Khalil', N'mariam.khalil@gmail.com', N'+201009998877', N'29703251234572', CAST(N'1997-03-25' AS Date), CAST(N'2024-03-15T17:30:00.000' AS DateTime2), 3, N'33333333-3333-3333-3333-333333333333', N'ar', CAST(N'2024-03-16T14:00:00.000' AS DateTime2))
INSERT [Members].[Member] ([MemberId], [FullName], [Email], [Mobile], [NationalId], [BirthDate], [RegisteredAt], [CityId], [InvitedByMemberId], [PreferredLanguage], [VerifiedAt]) VALUES (N'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', N'Omar Farooq', N'omar.farooq@outlook.com', N'+971558887766', N'784199412345672', CAST(N'1994-06-14' AS Date), CAST(N'2024-03-20T11:25:00.000' AS DateTime2), 6, N'99999999-9999-9999-9999-999999999999', N'en', CAST(N'2024-03-21T15:00:00.000' AS DateTime2))
INSERT [Members].[Member] ([MemberId], [FullName], [Email], [Mobile], [NationalId], [BirthDate], [RegisteredAt], [CityId], [InvitedByMemberId], [PreferredLanguage], [VerifiedAt]) VALUES (N'cccccccc-cccc-cccc-cccc-cccccccccccc', N'Layla Youssef', N'layla.youssef@yahoo.com', N'+201118889900', N'29610101234573', CAST(N'1996-10-10' AS Date), CAST(N'2024-03-25T18:00:00.000' AS DateTime2), 1, N'11111111-1111-1111-1111-111111111111', N'ar', NULL)
GO

-- 4. Wallet
SET IDENTITY_INSERT [Members].[Wallet] ON 
INSERT [Members].[Wallet] ([WalletId], [MemberId], [Balance], [HeldAmount], [Currency], [LastUpdatedAt]) VALUES (1, N'11111111-1111-1111-1111-111111111111', CAST(550000.00 AS Decimal(12, 2)), CAST(50000.00 AS Decimal(12, 2)), N'EGP', CAST(N'2024-04-01T10:00:00.000' AS DateTime2))
INSERT [Members].[Wallet] ([WalletId], [MemberId], [Balance], [HeldAmount], [Currency], [LastUpdatedAt]) VALUES (2, N'22222222-2222-2222-2222-222222222222', CAST(45000.00 AS Decimal(12, 2)), CAST(0.00 AS Decimal(12, 2)), N'EGP', CAST(N'2024-04-01T10:00:00.000' AS DateTime2))
INSERT [Members].[Wallet] ([WalletId], [MemberId], [Balance], [HeldAmount], [Currency], [LastUpdatedAt]) VALUES (3, N'33333333-3333-3333-3333-333333333333', CAST(120000.00 AS Decimal(12, 2)), CAST(35000.00 AS Decimal(12, 2)), N'EGP', CAST(N'2024-04-01T10:00:00.000' AS DateTime2))
INSERT [Members].[Wallet] ([WalletId], [MemberId], [Balance], [HeldAmount], [Currency], [LastUpdatedAt]) VALUES (4, N'44444444-4444-4444-4444-444444444444', CAST(350000.00 AS Decimal(12, 2)), CAST(48000.00 AS Decimal(12, 2)), N'SAR', CAST(N'2024-04-01T10:00:00.000' AS DateTime2))
INSERT [Members].[Wallet] ([WalletId], [MemberId], [Balance], [HeldAmount], [Currency], [LastUpdatedAt]) VALUES (5, N'55555555-5555-5555-5555-555555555555', CAST(80000.00 AS Decimal(12, 2)), CAST(0.00 AS Decimal(12, 2)), N'SAR', CAST(N'2024-04-01T10:00:00.000' AS DateTime2))
INSERT [Members].[Wallet] ([WalletId], [MemberId], [Balance], [HeldAmount], [Currency], [LastUpdatedAt]) VALUES (6, N'66666666-6666-6666-6666-666666666666', CAST(30000.00 AS Decimal(12, 2)), CAST(0.00 AS Decimal(12, 2)), N'EGP', CAST(N'2024-04-01T10:00:00.000' AS DateTime2))
INSERT [Members].[Wallet] ([WalletId], [MemberId], [Balance], [HeldAmount], [Currency], [LastUpdatedAt]) VALUES (7, N'77777777-7777-7777-7777-777777777777', CAST(65000.00 AS Decimal(12, 2)), CAST(0.00 AS Decimal(12, 2)), N'EGP', CAST(N'2024-04-01T10:00:00.000' AS DateTime2))
INSERT [Members].[Wallet] ([WalletId], [MemberId], [Balance], [HeldAmount], [Currency], [LastUpdatedAt]) VALUES (8, N'88888888-8888-8888-8888-888888888888', CAST(90000.00 AS Decimal(12, 2)), CAST(0.00 AS Decimal(12, 2)), N'SAR', CAST(N'2024-04-01T10:00:00.000' AS DateTime2))
INSERT [Members].[Wallet] ([WalletId], [MemberId], [Balance], [HeldAmount], [Currency], [LastUpdatedAt]) VALUES (9, N'99999999-9999-9999-9999-999999999999', CAST(2500000.00 AS Decimal(12, 2)), CAST(2200000.00 AS Decimal(12, 2)), N'AED', CAST(N'2024-04-01T10:00:00.000' AS DateTime2))
INSERT [Members].[Wallet] ([WalletId], [MemberId], [Balance], [HeldAmount], [Currency], [LastUpdatedAt]) VALUES (10, N'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', CAST(40000.00 AS Decimal(12, 2)), CAST(0.00 AS Decimal(12, 2)), N'EGP', CAST(N'2024-04-01T10:00:00.000' AS DateTime2))
INSERT [Members].[Wallet] ([WalletId], [MemberId], [Balance], [HeldAmount], [Currency], [LastUpdatedAt]) VALUES (11, N'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', CAST(150000.00 AS Decimal(12, 2)), CAST(70000.00 AS Decimal(12, 2)), N'AED', CAST(N'2024-04-01T10:00:00.000' AS DateTime2))
INSERT [Members].[Wallet] ([WalletId], [MemberId], [Balance], [HeldAmount], [Currency], [LastUpdatedAt]) VALUES (12, N'cccccccc-cccc-cccc-cccc-cccccccccccc', CAST(100000.00 AS Decimal(12, 2)), CAST(0.00 AS Decimal(12, 2)), N'EGP', CAST(N'2024-04-01T10:00:00.000' AS DateTime2))
SET IDENTITY_INSERT [Members].[Wallet] OFF
GO

-- 5. Warehouse (inserted with NULL manager to break circular dependency)
SET IDENTITY_INSERT [Logistics].[Warehouse] ON 
INSERT [Logistics].[Warehouse] ([WarehouseId], [Name], [MaxItems], [CityId], [Latitude], [Longitude], [ManagerEmployeeId], [ManagerStartDate]) VALUES (1, N'Cairo Central Warehouse', 25000, 1, 30.0444196, 31.2357116, NULL, CAST(N'2024-01-15' AS Date))
INSERT [Logistics].[Warehouse] ([WarehouseId], [Name], [MaxItems], [CityId], [Latitude], [Longitude], [ManagerEmployeeId], [ManagerStartDate]) VALUES (2, N'Alexandria Logistics Hub', 18000, 2, 31.2000924, 29.9187387, NULL, CAST(N'2024-03-01' AS Date))
INSERT [Logistics].[Warehouse] ([WarehouseId], [Name], [MaxItems], [CityId], [Latitude], [Longitude], [ManagerEmployeeId], [ManagerStartDate]) VALUES (3, N'Giza Distribution Center', 12000, 3, 30.0130557, 31.2088526, NULL, NULL)
INSERT [Logistics].[Warehouse] ([WarehouseId], [Name], [MaxItems], [CityId], [Latitude], [Longitude], [ManagerEmployeeId], [ManagerStartDate]) VALUES (4, N'Riyadh East Hub', 28000, 4, 24.7135517, 46.6752957, NULL, CAST(N'2024-03-05' AS Date))
INSERT [Logistics].[Warehouse] ([WarehouseId], [Name], [MaxItems], [CityId], [Latitude], [Longitude], [ManagerEmployeeId], [ManagerStartDate]) VALUES (5, N'Dubai South Terminal', 30000, 6, 25.2048493, 55.2707828, NULL, CAST(N'2024-03-10' AS Date))
SET IDENTITY_INSERT [Logistics].[Warehouse] OFF
GO

-- 6. Employee
SET IDENTITY_INSERT [Logistics].[Employee] ON 
INSERT [Logistics].[Employee] ([EmployeeId], [MemberId], [WarehouseId], [HireDate]) VALUES (1, N'22222222-2222-2222-2222-222222222222', 1, CAST(N'2024-01-15' AS Date))
INSERT [Logistics].[Employee] ([EmployeeId], [MemberId], [WarehouseId], [HireDate]) VALUES (2, N'66666666-6666-6666-6666-666666666666', 1, CAST(N'2024-02-22' AS Date))
INSERT [Logistics].[Employee] ([EmployeeId], [MemberId], [WarehouseId], [HireDate]) VALUES (3, N'77777777-7777-7777-7777-777777777777', 2, CAST(N'2024-03-01' AS Date))
INSERT [Logistics].[Employee] ([EmployeeId], [MemberId], [WarehouseId], [HireDate]) VALUES (4, N'88888888-8888-8888-8888-888888888888', 4, CAST(N'2024-03-05' AS Date))
INSERT [Logistics].[Employee] ([EmployeeId], [MemberId], [WarehouseId], [HireDate]) VALUES (5, N'99999999-9999-9999-9999-999999999999', 5, CAST(N'2024-03-10' AS Date))
SET IDENTITY_INSERT [Logistics].[Employee] OFF
GO

-- Update Warehouse managers to complete circular relationship
UPDATE [Logistics].[Warehouse] SET [ManagerEmployeeId] = 1 WHERE [WarehouseId] = 1;
UPDATE [Logistics].[Warehouse] SET [ManagerEmployeeId] = 3 WHERE [WarehouseId] = 2;
UPDATE [Logistics].[Warehouse] SET [ManagerEmployeeId] = 4 WHERE [WarehouseId] = 4;
UPDATE [Logistics].[Warehouse] SET [ManagerEmployeeId] = 5 WHERE [WarehouseId] = 5;
GO

-- 7. Category
INSERT [Catalogue].[Category] ([CategoryId], [ParentCategoryId], [NameEn], [NameAr], [CommissionRate]) VALUES (100, NULL, N'Vehicles', N'مركبات وسيارات', CAST(7.50 AS Decimal(5, 2)))
INSERT [Catalogue].[Category] ([CategoryId], [ParentCategoryId], [NameEn], [NameAr], [CommissionRate]) VALUES (200, NULL, N'Electronics', N'أجهزة إلكترونية', CAST(8.00 AS Decimal(5, 2)))
INSERT [Catalogue].[Category] ([CategoryId], [ParentCategoryId], [NameEn], [NameAr], [CommissionRate]) VALUES (300, NULL, N'Antiques', N'تحف ومقتنيات نادرة', CAST(12.50 AS Decimal(5, 2)))
INSERT [Catalogue].[Category] ([CategoryId], [ParentCategoryId], [NameEn], [NameAr], [CommissionRate]) VALUES (110, 100, N'Cars', N'سيارات ملاكي', CAST(6.00 AS Decimal(5, 2)))
INSERT [Catalogue].[Category] ([CategoryId], [ParentCategoryId], [NameEn], [NameAr], [CommissionRate]) VALUES (210, 200, N'Mobiles', N'هواتف ذكية', CAST(5.00 AS Decimal(5, 2)))
INSERT [Catalogue].[Category] ([CategoryId], [ParentCategoryId], [NameEn], [NameAr], [CommissionRate]) VALUES (220, 200, N'Laptops', N'أجهزة حاسوب محمولة', CAST(5.00 AS Decimal(5, 2)))
GO

-- 8. Item
SET IDENTITY_INSERT [Catalogue].[Item] ON 
INSERT [Catalogue].[Item] ([ItemId], [Title], [Description], [ConditionScore], [Specifications], [SellerMemberId], [CategoryId], [WarehouseId], [InspectorMemberId], [ListedAt], [IsFeatured]) VALUES (1, N'Toyota Corolla 2021 Mint Condition', N'Single owner, fully maintained at dealership, original paint.', 9, N'{"brand":"Toyota","model":"Corolla","year":2021,"mileageKm":45000,"transmission":"Automatic","fuel":"Petrol"}', N'11111111-1111-1111-1111-111111111111', 110, 1, N'22222222-2222-2222-2222-222222222222', CAST(N'2024-03-01T10:00:00.000' AS DateTime2), 1)
INSERT [Catalogue].[Item] ([ItemId], [Title], [Description], [ConditionScore], [Specifications], [SellerMemberId], [CategoryId], [WarehouseId], [InspectorMemberId], [ListedAt], [IsFeatured]) VALUES (2, N'Apple iPhone 14 Pro Max 256GB Deep Purple', N'Battery health 93%, with original box and cable, spotless screen.', 9, N'{"brand":"Apple","model":"iPhone 14 Pro Max","storageGb":256,"color":"Deep Purple","batteryHealth":93}', N'33333333-3333-3333-3333-333333333333', 210, 1, N'66666666-6666-6666-6666-666666666666', CAST(N'2024-03-05T11:30:00.000' AS DateTime2), 1)
INSERT [Catalogue].[Item] ([ItemId], [Title], [Description], [ConditionScore], [Specifications], [SellerMemberId], [CategoryId], [WarehouseId], [InspectorMemberId], [ListedAt], [IsFeatured]) VALUES (3, N'Dell XPS 15 9520 OLED Laptop', N'Intel i7 12th gen, 32GB RAM, 1TB SSD, 3.5K OLED touchscreen display.', 8, N'{"brand":"Dell","model":"XPS 15 9520","processor":"Intel Core i7-12700H","ramGb":32,"ssdGb":1024,"screen":"3.5K OLED"}', N'44444444-4444-4444-4444-444444444444', 220, 2, N'77777777-7777-7777-7777-777777777777', CAST(N'2024-03-08T14:00:00.000' AS DateTime2), 0)
INSERT [Catalogue].[Item] ([ItemId], [Title], [Description], [ConditionScore], [Specifications], [SellerMemberId], [CategoryId], [WarehouseId], [InspectorMemberId], [ListedAt], [IsFeatured]) VALUES (4, N'Antique Ottoman Handcrafted Brass Mosque Lamp', N'Authentic late 19th-century handcrafted brass mosque lamp with engraved calligraphy.', 7, N'{"origin":"Ottoman Empire","period":"Late 19th Century","material":"Hand-carved Brass","heightCm":65,"certified":true}', N'55555555-5555-5555-5555-555555555555', 300, 4, N'88888888-8888-8888-8888-888888888888', CAST(N'2024-03-12T16:15:00.000' AS DateTime2), 1)
INSERT [Catalogue].[Item] ([ItemId], [Title], [Description], [ConditionScore], [Specifications], [SellerMemberId], [CategoryId], [WarehouseId], [InspectorMemberId], [ListedAt], [IsFeatured]) VALUES (5, N'Mercedes-Benz C200 AMG 2023', N'Showroom condition, panoramic sunroof, AMG styling package, 18k km.', 10, N'{"brand":"Mercedes-Benz","model":"C200 AMG","year":2023,"mileageKm":18000,"sunroof":true,"transmission":"9G-Tronic"}', N'11111111-1111-1111-1111-111111111111', 110, 5, N'99999999-9999-9999-9999-999999999999', CAST(N'2024-03-15T09:45:00.000' AS DateTime2), 1)
INSERT [Catalogue].[Item] ([ItemId], [Title], [Description], [ConditionScore], [Specifications], [SellerMemberId], [CategoryId], [WarehouseId], [InspectorMemberId], [ListedAt], [IsFeatured]) VALUES (6, N'Samsung Galaxy S23 Ultra 512GB Phantom Black', N'Like new condition, includes S-Pen and original 45W super fast charger.', 9, N'{"brand":"Samsung","model":"Galaxy S23 Ultra","storageGb":512,"ramGb":12,"color":"Phantom Black","spen":true}', N'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 210, 1, N'22222222-2222-2222-2222-222222222222', CAST(N'2024-03-18T12:00:00.000' AS DateTime2), 0)
INSERT [Catalogue].[Item] ([ItemId], [Title], [Description], [ConditionScore], [Specifications], [SellerMemberId], [CategoryId], [WarehouseId], [InspectorMemberId], [ListedAt], [IsFeatured]) VALUES (7, N'Apple MacBook Pro 16 M2 Max 32GB 1TB', N'Space Gray, AppleCare+ active, only 42 battery charge cycles.', 10, N'{"brand":"Apple","model":"MacBook Pro 16","chip":"Apple M2 Max","ramGb":32,"ssdGb":1000,"batteryCycles":42}', N'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 220, 2, N'77777777-7777-7777-7777-777777777777', CAST(N'2024-03-20T15:30:00.000' AS DateTime2), 0)
INSERT [Catalogue].[Item] ([ItemId], [Title], [Description], [ConditionScore], [Specifications], [SellerMemberId], [CategoryId], [WarehouseId], [InspectorMemberId], [ListedAt], [IsFeatured]) VALUES (8, N'Rare Antique Persian Silk Rug Isfahan', N'Museum grade 100% fine silk weave, intricate floral medallion pattern.', 8, N'{"origin":"Isfahan, Iran","dimensionCm":"200x300","material":"100% Pure Silk","weaveDensity":"800 KPSI"}', N'cccccccc-cccc-cccc-cccc-cccccccccccc', 300, 4, N'88888888-8888-8888-8888-888888888888', CAST(N'2024-03-22T17:00:00.000' AS DateTime2), 0)
SET IDENTITY_INSERT [Catalogue].[Item] OFF
GO

-- 9. ItemPhoto
INSERT [Catalogue].[ItemPhoto] ([ItemId], [Position], [PhotoUrl], [IsMain]) VALUES (1, 1, N'https://storage.bidnile.com/items/item1_main.jpg', 1)
INSERT [Catalogue].[ItemPhoto] ([ItemId], [Position], [PhotoUrl], [IsMain]) VALUES (1, 2, N'https://storage.bidnile.com/items/item1_rear.jpg', 0)
INSERT [Catalogue].[ItemPhoto] ([ItemId], [Position], [PhotoUrl], [IsMain]) VALUES (2, 1, N'https://storage.bidnile.com/items/item2_front.jpg', 1)
INSERT [Catalogue].[ItemPhoto] ([ItemId], [Position], [PhotoUrl], [IsMain]) VALUES (2, 2, N'https://storage.bidnile.com/items/item2_back.jpg', 0)
INSERT [Catalogue].[ItemPhoto] ([ItemId], [Position], [PhotoUrl], [IsMain]) VALUES (3, 1, N'https://storage.bidnile.com/items/item3_open.jpg', 1)
INSERT [Catalogue].[ItemPhoto] ([ItemId], [Position], [PhotoUrl], [IsMain]) VALUES (3, 2, N'https://storage.bidnile.com/items/item3_ports.jpg', 0)
INSERT [Catalogue].[ItemPhoto] ([ItemId], [Position], [PhotoUrl], [IsMain]) VALUES (4, 1, N'https://storage.bidnile.com/items/item4_lit.jpg', 1)
INSERT [Catalogue].[ItemPhoto] ([ItemId], [Position], [PhotoUrl], [IsMain]) VALUES (4, 2, N'https://storage.bidnile.com/items/item4_detail.jpg', 0)
INSERT [Catalogue].[ItemPhoto] ([ItemId], [Position], [PhotoUrl], [IsMain]) VALUES (5, 1, N'https://storage.bidnile.com/items/item5_front.jpg', 1)
INSERT [Catalogue].[ItemPhoto] ([ItemId], [Position], [PhotoUrl], [IsMain]) VALUES (5, 2, N'https://storage.bidnile.com/items/item5_interior.jpg', 0)
INSERT [Catalogue].[ItemPhoto] ([ItemId], [Position], [PhotoUrl], [IsMain]) VALUES (6, 1, N'https://storage.bidnile.com/items/item6_display.jpg', 1)
INSERT [Catalogue].[ItemPhoto] ([ItemId], [Position], [PhotoUrl], [IsMain]) VALUES (6, 2, N'https://storage.bidnile.com/items/item6_camera.jpg', 0)
INSERT [Catalogue].[ItemPhoto] ([ItemId], [Position], [PhotoUrl], [IsMain]) VALUES (7, 1, N'https://storage.bidnile.com/items/item7_lid.jpg', 1)
INSERT [Catalogue].[ItemPhoto] ([ItemId], [Position], [PhotoUrl], [IsMain]) VALUES (7, 2, N'https://storage.bidnile.com/items/item7_keyboard.jpg', 0)
INSERT [Catalogue].[ItemPhoto] ([ItemId], [Position], [PhotoUrl], [IsMain]) VALUES (8, 1, N'https://storage.bidnile.com/items/item8_full.jpg', 1)
INSERT [Catalogue].[ItemPhoto] ([ItemId], [Position], [PhotoUrl], [IsMain]) VALUES (8, 2, N'https://storage.bidnile.com/items/item8_weave.jpg', 0)
GO

-- 10. Auction
SET IDENTITY_INSERT [Sales].[Auction] ON 
INSERT [Sales].[Auction] ([AuctionId], [ItemId], [StartingPrice], [ReservePrice], [BidIncrement], [StartsAt], [EndsAt], [Status], [BuyNowPrice]) VALUES (1, 1, CAST(450000.00 AS Decimal(12, 2)), CAST(500000.00 AS Decimal(12, 2)), CAST(5000.00 AS Decimal(12, 2)), CAST(N'2024-04-01T10:00:00.000+02:00' AS DateTimeOffset), CAST(N'2024-04-10T20:00:00.000+02:00' AS DateTimeOffset), N'Live', CAST(580000.00 AS Decimal(12, 2)))
INSERT [Sales].[Auction] ([AuctionId], [ItemId], [StartingPrice], [ReservePrice], [BidIncrement], [StartsAt], [EndsAt], [Status], [BuyNowPrice]) VALUES (2, 2, CAST(30000.00 AS Decimal(12, 2)), CAST(34000.00 AS Decimal(12, 2)), CAST(500.00 AS Decimal(12, 2)), CAST(N'2024-04-02T12:00:00.000+02:00' AS DateTimeOffset), CAST(N'2024-04-08T22:00:00.000+02:00' AS DateTimeOffset), N'Live', CAST(42000.00 AS Decimal(12, 2)))
INSERT [Sales].[Auction] ([AuctionId], [ItemId], [StartingPrice], [ReservePrice], [BidIncrement], [StartsAt], [EndsAt], [Status], [BuyNowPrice]) VALUES (3, 3, CAST(42000.00 AS Decimal(12, 2)), CAST(46000.00 AS Decimal(12, 2)), CAST(1000.00 AS Decimal(12, 2)), CAST(N'2024-03-10T09:00:00.000+03:00' AS DateTimeOffset), CAST(N'2024-03-17T18:00:00.000+03:00' AS DateTimeOffset), N'Ended', NULL)
INSERT [Sales].[Auction] ([AuctionId], [ItemId], [StartingPrice], [ReservePrice], [BidIncrement], [StartsAt], [EndsAt], [Status], [BuyNowPrice]) VALUES (4, 4, CAST(14000.00 AS Decimal(12, 2)), CAST(16000.00 AS Decimal(12, 2)), CAST(500.00 AS Decimal(12, 2)), CAST(N'2024-03-15T14:00:00.000+04:00' AS DateTimeOffset), CAST(N'2024-03-22T21:00:00.000+04:00' AS DateTimeOffset), N'Ended', CAST(22000.00 AS Decimal(12, 2)))
INSERT [Sales].[Auction] ([AuctionId], [ItemId], [StartingPrice], [ReservePrice], [BidIncrement], [StartsAt], [EndsAt], [Status], [BuyNowPrice]) VALUES (5, 5, CAST(2100000.00 AS Decimal(12, 2)), CAST(2300000.00 AS Decimal(12, 2)), CAST(25000.00 AS Decimal(12, 2)), CAST(N'2024-04-05T18:00:00.000+04:00' AS DateTimeOffset), CAST(N'2024-04-15T23:00:00.000+04:00' AS DateTimeOffset), N'Live', CAST(2600000.00 AS Decimal(12, 2)))
INSERT [Sales].[Auction] ([AuctionId], [ItemId], [StartingPrice], [ReservePrice], [BidIncrement], [StartsAt], [EndsAt], [Status], [BuyNowPrice]) VALUES (6, 6, CAST(26000.00 AS Decimal(12, 2)), CAST(29000.00 AS Decimal(12, 2)), CAST(500.00 AS Decimal(12, 2)), CAST(N'2024-04-20T12:00:00.000+02:00' AS DateTimeOffset), CAST(N'2024-04-27T22:00:00.000+02:00' AS DateTimeOffset), N'Draft', CAST(35000.00 AS Decimal(12, 2)))
INSERT [Sales].[Auction] ([AuctionId], [ItemId], [StartingPrice], [ReservePrice], [BidIncrement], [StartsAt], [EndsAt], [Status], [BuyNowPrice]) VALUES (7, 7, CAST(60000.00 AS Decimal(12, 2)), CAST(65000.00 AS Decimal(12, 2)), CAST(1000.00 AS Decimal(12, 2)), CAST(N'2024-03-25T10:00:00.000+03:00' AS DateTimeOffset), CAST(N'2024-03-28T10:00:00.000+03:00' AS DateTimeOffset), N'Cancelled', CAST(80000.00 AS Decimal(12, 2)))
INSERT [Sales].[Auction] ([AuctionId], [ItemId], [StartingPrice], [ReservePrice], [BidIncrement], [StartsAt], [EndsAt], [Status], [BuyNowPrice]) VALUES (8, 8, CAST(75000.00 AS Decimal(12, 2)), CAST(85000.00 AS Decimal(12, 2)), CAST(2000.00 AS Decimal(12, 2)), CAST(N'2024-05-01T11:00:00.000+04:00' AS DateTimeOffset), CAST(N'2024-05-10T20:00:00.000+04:00' AS DateTimeOffset), N'PendingReview', NULL)
SET IDENTITY_INSERT [Sales].[Auction] OFF
GO

-- 11. Bid
SET IDENTITY_INSERT [Sales].[Bid] ON 
INSERT [Sales].[Bid] ([BidId], [AuctionId], [MemberId], [Amount], [PlacedAt], [DeviceIp]) VALUES (1, 1, N'33333333-3333-3333-3333-333333333333', CAST(455000.00 AS Decimal(12, 2)), CAST(N'2024-04-01T10:30:00.000' AS DateTime2), N'197.34.12.5')
INSERT [Sales].[Bid] ([BidId], [AuctionId], [MemberId], [Amount], [PlacedAt], [DeviceIp]) VALUES (2, 1, N'44444444-4444-4444-4444-444444444444', CAST(460000.00 AS Decimal(12, 2)), CAST(N'2024-04-01T11:15:00.000' AS DateTime2), N'212.118.140.2')
INSERT [Sales].[Bid] ([BidId], [AuctionId], [MemberId], [Amount], [PlacedAt], [DeviceIp]) VALUES (3, 1, N'55555555-5555-5555-5555-555555555555', CAST(465000.00 AS Decimal(12, 2)), CAST(N'2024-04-01T12:00:00.000' AS DateTime2), N'212.118.140.9')
INSERT [Sales].[Bid] ([BidId], [AuctionId], [MemberId], [Amount], [PlacedAt], [DeviceIp]) VALUES (4, 1, N'33333333-3333-3333-3333-333333333333', CAST(470000.00 AS Decimal(12, 2)), CAST(N'2024-04-01T14:45:00.000' AS DateTime2), N'197.34.12.5')
INSERT [Sales].[Bid] ([BidId], [AuctionId], [MemberId], [Amount], [PlacedAt], [DeviceIp]) VALUES (5, 1, N'44444444-4444-4444-4444-444444444444', CAST(480000.00 AS Decimal(12, 2)), CAST(N'2024-04-01T16:20:00.000' AS DateTime2), N'212.118.140.2')
INSERT [Sales].[Bid] ([BidId], [AuctionId], [MemberId], [Amount], [PlacedAt], [DeviceIp]) VALUES (6, 1, N'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', CAST(485000.00 AS Decimal(12, 2)), CAST(N'2024-04-02T09:10:00.000' AS DateTime2), N'156.204.88.90')
INSERT [Sales].[Bid] ([BidId], [AuctionId], [MemberId], [Amount], [PlacedAt], [DeviceIp]) VALUES (7, 1, N'55555555-5555-5555-5555-555555555555', CAST(490000.00 AS Decimal(12, 2)), CAST(N'2024-04-02T11:05:00.000' AS DateTime2), N'212.118.140.9')
INSERT [Sales].[Bid] ([BidId], [AuctionId], [MemberId], [Amount], [PlacedAt], [DeviceIp]) VALUES (8, 1, N'33333333-3333-3333-3333-333333333333', CAST(495000.00 AS Decimal(12, 2)), CAST(N'2024-04-02T15:30:00.000' AS DateTime2), N'197.34.12.5')
INSERT [Sales].[Bid] ([BidId], [AuctionId], [MemberId], [Amount], [PlacedAt], [DeviceIp]) VALUES (9, 1, N'44444444-4444-4444-4444-444444444444', CAST(500000.00 AS Decimal(12, 2)), CAST(N'2024-04-03T10:00:00.000' AS DateTime2), N'212.118.140.2')
INSERT [Sales].[Bid] ([BidId], [AuctionId], [MemberId], [Amount], [PlacedAt], [DeviceIp]) VALUES (10, 1, N'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', CAST(510000.00 AS Decimal(12, 2)), CAST(N'2024-04-03T13:40:00.000' AS DateTime2), N'156.204.88.90')

INSERT [Sales].[Bid] ([BidId], [AuctionId], [MemberId], [Amount], [PlacedAt], [DeviceIp]) VALUES (11, 2, N'11111111-1111-1111-1111-111111111111', CAST(30500.00 AS Decimal(12, 2)), CAST(N'2024-04-02T12:15:00.000' AS DateTime2), N'105.198.44.12')
INSERT [Sales].[Bid] ([BidId], [AuctionId], [MemberId], [Amount], [PlacedAt], [DeviceIp]) VALUES (12, 2, N'44444444-4444-4444-4444-444444444444', CAST(31000.00 AS Decimal(12, 2)), CAST(N'2024-04-02T13:00:00.000' AS DateTime2), N'212.118.140.2')
INSERT [Sales].[Bid] ([BidId], [AuctionId], [MemberId], [Amount], [PlacedAt], [DeviceIp]) VALUES (13, 2, N'55555555-5555-5555-5555-555555555555', CAST(31500.00 AS Decimal(12, 2)), CAST(N'2024-04-02T14:20:00.000' AS DateTime2), N'212.118.140.9')
INSERT [Sales].[Bid] ([BidId], [AuctionId], [MemberId], [Amount], [PlacedAt], [DeviceIp]) VALUES (14, 2, N'11111111-1111-1111-1111-111111111111', CAST(32000.00 AS Decimal(12, 2)), CAST(N'2024-04-02T15:00:00.000' AS DateTime2), N'105.198.44.12')
INSERT [Sales].[Bid] ([BidId], [AuctionId], [MemberId], [Amount], [PlacedAt], [DeviceIp]) VALUES (15, 2, N'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', CAST(32500.00 AS Decimal(12, 2)), CAST(N'2024-04-02T16:45:00.000' AS DateTime2), N'156.204.88.90')
INSERT [Sales].[Bid] ([BidId], [AuctionId], [MemberId], [Amount], [PlacedAt], [DeviceIp]) VALUES (16, 2, N'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', CAST(33000.00 AS Decimal(12, 2)), CAST(N'2024-04-03T09:30:00.000' AS DateTime2), N'94.200.15.6')
INSERT [Sales].[Bid] ([BidId], [AuctionId], [MemberId], [Amount], [PlacedAt], [DeviceIp]) VALUES (17, 2, N'11111111-1111-1111-1111-111111111111', CAST(33500.00 AS Decimal(12, 2)), CAST(N'2024-04-03T11:15:00.000' AS DateTime2), N'105.198.44.12')
INSERT [Sales].[Bid] ([BidId], [AuctionId], [MemberId], [Amount], [PlacedAt], [DeviceIp]) VALUES (18, 2, N'44444444-4444-4444-4444-444444444444', CAST(34000.00 AS Decimal(12, 2)), CAST(N'2024-04-03T14:00:00.000' AS DateTime2), N'212.118.140.2')
INSERT [Sales].[Bid] ([BidId], [AuctionId], [MemberId], [Amount], [PlacedAt], [DeviceIp]) VALUES (19, 2, N'55555555-5555-5555-5555-555555555555', CAST(34500.00 AS Decimal(12, 2)), CAST(N'2024-04-03T16:30:00.000' AS DateTime2), N'212.118.140.9')
INSERT [Sales].[Bid] ([BidId], [AuctionId], [MemberId], [Amount], [PlacedAt], [DeviceIp]) VALUES (20, 2, N'11111111-1111-1111-1111-111111111111', CAST(35000.00 AS Decimal(12, 2)), CAST(N'2024-04-04T10:00:00.000' AS DateTime2), N'105.198.44.12')

INSERT [Sales].[Bid] ([BidId], [AuctionId], [MemberId], [Amount], [PlacedAt], [DeviceIp]) VALUES (21, 3, N'11111111-1111-1111-1111-111111111111', CAST(43000.00 AS Decimal(12, 2)), CAST(N'2024-03-10T10:00:00.000' AS DateTime2), N'105.198.44.12')
INSERT [Sales].[Bid] ([BidId], [AuctionId], [MemberId], [Amount], [PlacedAt], [DeviceIp]) VALUES (22, 3, N'33333333-3333-3333-3333-333333333333', CAST(44000.00 AS Decimal(12, 2)), CAST(N'2024-03-10T12:00:00.000' AS DateTime2), N'197.34.12.5')
INSERT [Sales].[Bid] ([BidId], [AuctionId], [MemberId], [Amount], [PlacedAt], [DeviceIp]) VALUES (23, 3, N'55555555-5555-5555-5555-555555555555', CAST(45000.00 AS Decimal(12, 2)), CAST(N'2024-03-11T09:30:00.000' AS DateTime2), N'212.118.140.9')
INSERT [Sales].[Bid] ([BidId], [AuctionId], [MemberId], [Amount], [PlacedAt], [DeviceIp]) VALUES (24, 3, N'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', CAST(46000.00 AS Decimal(12, 2)), CAST(N'2024-03-11T14:15:00.000' AS DateTime2), N'156.204.88.90')
INSERT [Sales].[Bid] ([BidId], [AuctionId], [MemberId], [Amount], [PlacedAt], [DeviceIp]) VALUES (25, 3, N'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', CAST(47000.00 AS Decimal(12, 2)), CAST(N'2024-03-12T11:00:00.000' AS DateTime2), N'94.200.15.6')
INSERT [Sales].[Bid] ([BidId], [AuctionId], [MemberId], [Amount], [PlacedAt], [DeviceIp]) VALUES (26, 3, N'11111111-1111-1111-1111-111111111111', CAST(48000.00 AS Decimal(12, 2)), CAST(N'2024-03-12T15:45:00.000' AS DateTime2), N'105.198.44.12')
INSERT [Sales].[Bid] ([BidId], [AuctionId], [MemberId], [Amount], [PlacedAt], [DeviceIp]) VALUES (27, 3, N'33333333-3333-3333-3333-333333333333', CAST(49000.00 AS Decimal(12, 2)), CAST(N'2024-03-13T10:20:00.000' AS DateTime2), N'197.34.12.5')
INSERT [Sales].[Bid] ([BidId], [AuctionId], [MemberId], [Amount], [PlacedAt], [DeviceIp]) VALUES (28, 3, N'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', CAST(50000.00 AS Decimal(12, 2)), CAST(N'2024-03-13T16:00:00.000' AS DateTime2), N'94.200.15.6')
INSERT [Sales].[Bid] ([BidId], [AuctionId], [MemberId], [Amount], [PlacedAt], [DeviceIp]) VALUES (29, 3, N'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', CAST(51000.00 AS Decimal(12, 2)), CAST(N'2024-03-14T09:00:00.000' AS DateTime2), N'156.204.88.90')
INSERT [Sales].[Bid] ([BidId], [AuctionId], [MemberId], [Amount], [PlacedAt], [DeviceIp]) VALUES (30, 3, N'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', CAST(52000.00 AS Decimal(12, 2)), CAST(N'2024-03-14T14:30:00.000' AS DateTime2), N'2001:0db8:85a3:0000:0000:8a2e:0370:7334')

INSERT [Sales].[Bid] ([BidId], [AuctionId], [MemberId], [Amount], [PlacedAt], [DeviceIp]) VALUES (31, 4, N'33333333-3333-3333-3333-333333333333', CAST(14500.00 AS Decimal(12, 2)), CAST(N'2024-03-15T15:00:00.000' AS DateTime2), N'197.34.12.5')
INSERT [Sales].[Bid] ([BidId], [AuctionId], [MemberId], [Amount], [PlacedAt], [DeviceIp]) VALUES (32, 4, N'44444444-4444-4444-4444-444444444444', CAST(15000.00 AS Decimal(12, 2)), CAST(N'2024-03-15T18:30:00.000' AS DateTime2), N'212.118.140.2')
INSERT [Sales].[Bid] ([BidId], [AuctionId], [MemberId], [Amount], [PlacedAt], [DeviceIp]) VALUES (33, 4, N'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', CAST(15500.00 AS Decimal(12, 2)), CAST(N'2024-03-16T11:00:00.000' AS DateTime2), N'156.204.88.90')
INSERT [Sales].[Bid] ([BidId], [AuctionId], [MemberId], [Amount], [PlacedAt], [DeviceIp]) VALUES (34, 4, N'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', CAST(16000.00 AS Decimal(12, 2)), CAST(N'2024-03-16T17:15:00.000' AS DateTime2), N'94.200.15.6')
INSERT [Sales].[Bid] ([BidId], [AuctionId], [MemberId], [Amount], [PlacedAt], [DeviceIp]) VALUES (35, 4, N'cccccccc-cccc-cccc-cccc-cccccccccccc', CAST(16500.00 AS Decimal(12, 2)), CAST(N'2024-03-17T10:45:00.000' AS DateTime2), N'197.34.12.9')
INSERT [Sales].[Bid] ([BidId], [AuctionId], [MemberId], [Amount], [PlacedAt], [DeviceIp]) VALUES (36, 4, N'33333333-3333-3333-3333-333333333333', CAST(17000.00 AS Decimal(12, 2)), CAST(N'2024-03-17T16:20:00.000' AS DateTime2), N'197.34.12.5')
INSERT [Sales].[Bid] ([BidId], [AuctionId], [MemberId], [Amount], [PlacedAt], [DeviceIp]) VALUES (37, 4, N'44444444-4444-4444-4444-444444444444', CAST(17500.00 AS Decimal(12, 2)), CAST(N'2024-03-18T13:10:00.000' AS DateTime2), N'212.118.140.2')
INSERT [Sales].[Bid] ([BidId], [AuctionId], [MemberId], [Amount], [PlacedAt], [DeviceIp]) VALUES (38, 4, N'cccccccc-cccc-cccc-cccc-cccccccccccc', CAST(18000.00 AS Decimal(12, 2)), CAST(N'2024-03-18T19:00:00.000' AS DateTime2), N'197.34.12.9')

INSERT [Sales].[Bid] ([BidId], [AuctionId], [MemberId], [Amount], [PlacedAt], [DeviceIp]) VALUES (39, 5, N'44444444-4444-4444-4444-444444444444', CAST(2125000.00 AS Decimal(12, 2)), CAST(N'2024-04-05T19:00:00.000' AS DateTime2), N'212.118.140.2')
INSERT [Sales].[Bid] ([BidId], [AuctionId], [MemberId], [Amount], [PlacedAt], [DeviceIp]) VALUES (40, 5, N'55555555-5555-5555-5555-555555555555', CAST(2150000.00 AS Decimal(12, 2)), CAST(N'2024-04-05T21:30:00.000' AS DateTime2), N'212.118.140.9')
INSERT [Sales].[Bid] ([BidId], [AuctionId], [MemberId], [Amount], [PlacedAt], [DeviceIp]) VALUES (41, 5, N'99999999-9999-9999-9999-999999999999', CAST(2175000.00 AS Decimal(12, 2)), CAST(N'2024-04-06T10:15:00.000' AS DateTime2), N'2a02:cb80:10:4321::1')
INSERT [Sales].[Bid] ([BidId], [AuctionId], [MemberId], [Amount], [PlacedAt], [DeviceIp]) VALUES (42, 5, N'44444444-4444-4444-4444-444444444444', CAST(2200000.00 AS Decimal(12, 2)), CAST(N'2024-04-06T14:40:00.000' AS DateTime2), N'212.118.140.2')
INSERT [Sales].[Bid] ([BidId], [AuctionId], [MemberId], [Amount], [PlacedAt], [DeviceIp]) VALUES (43, 5, N'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', CAST(2225000.00 AS Decimal(12, 2)), CAST(N'2024-04-06T18:00:00.000' AS DateTime2), N'94.200.15.6')
INSERT [Sales].[Bid] ([BidId], [AuctionId], [MemberId], [Amount], [PlacedAt], [DeviceIp]) VALUES (44, 5, N'55555555-5555-5555-5555-555555555555', CAST(2250000.00 AS Decimal(12, 2)), CAST(N'2024-04-07T11:20:00.000' AS DateTime2), N'212.118.140.9')
INSERT [Sales].[Bid] ([BidId], [AuctionId], [MemberId], [Amount], [PlacedAt], [DeviceIp]) VALUES (45, 5, N'99999999-9999-9999-9999-999999999999', CAST(2275000.00 AS Decimal(12, 2)), CAST(N'2024-04-07T16:50:00.000' AS DateTime2), N'2a02:cb80:10:4321::1')
SET IDENTITY_INSERT [Sales].[Bid] OFF
GO

-- 12. AuctionFollower
INSERT [Marketing].[AuctionFollower] ([AuctionId], [MemberId], [FollowedAt]) VALUES (1, N'33333333-3333-3333-3333-333333333333', CAST(N'2024-04-01T10:15:00.000' AS DateTime2))
INSERT [Marketing].[AuctionFollower] ([AuctionId], [MemberId], [FollowedAt]) VALUES (1, N'44444444-4444-4444-4444-444444444444', CAST(N'2024-04-01T10:20:00.000' AS DateTime2))
INSERT [Marketing].[AuctionFollower] ([AuctionId], [MemberId], [FollowedAt]) VALUES (1, N'55555555-5555-5555-5555-555555555555', CAST(N'2024-04-01T10:45:00.000' AS DateTime2))
INSERT [Marketing].[AuctionFollower] ([AuctionId], [MemberId], [FollowedAt]) VALUES (1, N'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', CAST(N'2024-04-01T11:00:00.000' AS DateTime2))
INSERT [Marketing].[AuctionFollower] ([AuctionId], [MemberId], [FollowedAt]) VALUES (2, N'11111111-1111-1111-1111-111111111111', CAST(N'2024-04-02T12:05:00.000' AS DateTime2))
INSERT [Marketing].[AuctionFollower] ([AuctionId], [MemberId], [FollowedAt]) VALUES (2, N'44444444-4444-4444-4444-444444444444', CAST(N'2024-04-02T12:10:00.000' AS DateTime2))
INSERT [Marketing].[AuctionFollower] ([AuctionId], [MemberId], [FollowedAt]) VALUES (2, N'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', CAST(N'2024-04-02T12:30:00.000' AS DateTime2))
INSERT [Marketing].[AuctionFollower] ([AuctionId], [MemberId], [FollowedAt]) VALUES (3, N'11111111-1111-1111-1111-111111111111', CAST(N'2024-03-10T09:15:00.000' AS DateTime2))
INSERT [Marketing].[AuctionFollower] ([AuctionId], [MemberId], [FollowedAt]) VALUES (3, N'33333333-3333-3333-3333-333333333333', CAST(N'2024-03-10T09:20:00.000' AS DateTime2))
INSERT [Marketing].[AuctionFollower] ([AuctionId], [MemberId], [FollowedAt]) VALUES (3, N'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', CAST(N'2024-03-10T09:40:00.000' AS DateTime2))
INSERT [Marketing].[AuctionFollower] ([AuctionId], [MemberId], [FollowedAt]) VALUES (4, N'33333333-3333-3333-3333-333333333333', CAST(N'2024-03-15T14:10:00.000' AS DateTime2))
INSERT [Marketing].[AuctionFollower] ([AuctionId], [MemberId], [FollowedAt]) VALUES (4, N'cccccccc-cccc-cccc-cccc-cccccccccccc', CAST(N'2024-03-15T14:30:00.000' AS DateTime2))
INSERT [Marketing].[AuctionFollower] ([AuctionId], [MemberId], [FollowedAt]) VALUES (5, N'44444444-4444-4444-4444-444444444444', CAST(N'2024-04-05T18:10:00.000' AS DateTime2))
INSERT [Marketing].[AuctionFollower] ([AuctionId], [MemberId], [FollowedAt]) VALUES (5, N'55555555-5555-5555-5555-555555555555', CAST(N'2024-04-05T18:15:00.000' AS DateTime2))
INSERT [Marketing].[AuctionFollower] ([AuctionId], [MemberId], [FollowedAt]) VALUES (5, N'99999999-9999-9999-9999-999999999999', CAST(N'2024-04-05T18:25:00.000' AS DateTime2))
INSERT [Marketing].[AuctionFollower] ([AuctionId], [MemberId], [FollowedAt]) VALUES (8, N'11111111-1111-1111-1111-111111111111', CAST(N'2024-05-01T11:15:00.000' AS DateTime2))
GO
