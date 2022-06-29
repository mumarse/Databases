USE master
GO

CREATE DATABASE BikeStores
GO

USE BikeStores
GO

CREATE SCHEMA Sales
GO

-- Create a new table called '[customers]' in schema '[Sales]'
-- Drop the table if it already exists
IF OBJECT_ID('[Sales].[customers]', 'U') IS NOT NULL
DROP TABLE [Sales].[customers]
GO
-- Create the table in the specified schema
CREATE TABLE [Sales].[customers]
(
    [customer_id] INT NOT NULL,
    [first_name] NVARCHAR(50) NOT NULL ,
    [last_name] NVARCHAR(50) NOT NULL ,
    [phone] INT NOT NULL ,
    [email] NVARCHAR(50) NOT NULL ,
    [street] NVARCHAR(50) NOT NULL ,
    [city] NVARCHAR(50) NOT NULL ,
    [state] NVARCHAR(50) NOT NULL ,
    [zip_code] NVARCHAR(50) NOT NULL,
    CONSTRAINT PK_customer_Id PRIMARY KEY (customer_id)
    -- Specify more columns here
);
GO

ALTER TABLE Sales.customers
ALTER COLUMN phone NVARCHAR(15) NOT NULL
GO



-- Create a new table called '[stores]' in schema '[Sales]'
-- Drop the table if it already exists
IF OBJECT_ID('[Sales].[stores]', 'U') IS NOT NULL
DROP TABLE [Sales].[stores]
GO
-- Create the table in the specified schema
CREATE TABLE [Sales].[stores]
(
    [store_id] INT NOT NULL,
    [store_name] NVARCHAR(50) NOT NULL ,
    [phone] INT NOT NULL ,
    [email] NVARCHAR(50) NOT NULL ,
    [street] NVARCHAR(50) NOT NULL ,
    [city] NVARCHAR(50) NOT NULL ,
    [state] NVARCHAR(50) NOT NULL ,
    [zip_code] NVARCHAR(50) NOT NULL,
    CONSTRAINT PK_store_id PRIMARY KEY (store_id)
    -- Specify more columns here
);
GO

ALTER TABLE [Sales].[stores]
ALTER COLUMN phone NVARCHAR(15) NOT NULL
GO

-- Create a new table called '[staffs]' in schema '[Sales]'
-- Drop the table if it already exists
IF OBJECT_ID('[Sales].[staffs]', 'U') IS NOT NULL
DROP TABLE [Sales].[staffs]
GO
-- Create the table in the specified schema
CREATE TABLE [Sales].[staffs]
(
    [staff_id] INT NOT NULL,
    [first_name] NVARCHAR(50) NOT NULL ,
    [last_name] NVARCHAR(50) NOT NULL ,
    [email] NVARCHAR(50) NOT NULL ,
    [phone] INT NOT NULL ,
    [active] NVARCHAR(50) NOT NULL ,
    [store_id] INT NOT NULL,
    [manager_id] INT NULL,
    CONSTRAINT PK_staff_id PRIMARY KEY (staff_id),
    CONSTRAINT FK_store_id FOREIGN KEY (store_id) REFERENCES Sales.stores(store_id),
    CONSTRAINT FK_manager_id FOREIGN KEY (manager_id) REFERENCES Sales.staffs(staff_id)
    -- Specify more columns here
);
GO

ALTER TABLE [Sales].[staffs]
ALTER COLUMN phone NVARCHAR(15) NOT NULL
GO

-- Create a new table called '[orders]' in schema '[Sales]'
-- Drop the table if it already exists
IF OBJECT_ID('[Sales].[orders]', 'U') IS NOT NULL
DROP TABLE [Sales].[orders]
GO
-- Create the table in the specified schema
CREATE TABLE [Sales].[orders]
(
    [order_id] INT NOT NULL,
    [customer_id] INT NULL,
    [order_status] BIT NOT NULL ,
    [order_date] DATE NOT NULL ,
    [required_date] DATE NOT NULL ,
    [shipped_date] DATE NOT NULL ,
    [store_id] INT NULL,
    [staff_id] INT NULL,
    CONSTRAINT PK_order_id PRIMARY KEY (order_id),
    CONSTRAINT FK_customer_id FOREIGN KEY (customer_id) REFERENCES Sales.customers(customer_id),
    CONSTRAINT FK_order_store_id FOREIGN KEY (store_id) REFERENCES Sales.stores(store_id),
    CONSTRAINT FK_staff_id FOREIGN KEY (staff_id) REFERENCES Sales.staffs(staff_id)
    -- Specify more columns here
);
GO

CREATE SCHEMA Production
GO

-- Create a new table called '[categories]' in schema '[Production]'
-- Drop the table if it already exists
IF OBJECT_ID('[Production].[categories]', 'U') IS NOT NULL
DROP TABLE [Production].[categories]
GO
-- Create the table in the specified schema
CREATE TABLE [Production].[categories]
(
    [category_id] INT NOT NULL,
    [category_name] NVARCHAR(50) NOT NULL,
    CONSTRAINT PK_category_id PRIMARY KEY (category_id)
    -- Specify more columns here
);
GO

-- Create a new table called '[brands]' in schema '[Production]'
-- Drop the table if it already exists
IF OBJECT_ID('[Production].[brands]', 'U') IS NOT NULL
DROP TABLE [Production].[brands]
GO
-- Create the table in the specified schema
CREATE TABLE [Production].[brands]
(
    [brand_id] INT NOT NULL,
    [brand_name] NVARCHAR(50) NOT NULL,
    CONSTRAINT PK_brand_id PRIMARY KEY (brand_id)
    -- Specify more columns here
);
GO


-- Create a new table called '[products]' in schema '[Production]'
-- Drop the table if it already exists
IF OBJECT_ID('[Production].[products]', 'U') IS NOT NULL
DROP TABLE [Production].[products]
GO
-- Create the table in the specified schema
CREATE TABLE [Production].[products]
(
    [product_id] INT NOT NULL,
    [product_name] NVARCHAR(50) NOT NULL,
    [brand_id] INT NULL,
    [category_id] INT NULL,
    [model_year] INT NOT NULL,
    [list_price] FLOAT(53) NOT NULL,
    CONSTRAINT PK_product_id PRIMARY KEY (product_id),
    CONSTRAINT FK_brand_id FOREIGN KEY (brand_id) REFERENCES Production.brands(brand_id),
    CONSTRAINT FK_category_id FOREIGN KEY (category_id) REFERENCES Production.categories (category_id)
    -- Specify more columns here
);
GO

-- Create a new table called '[stocks]' in schema '[Production]'
-- Drop the table if it already exists
IF OBJECT_ID('[Production].[stocks]', 'U') IS NOT NULL
DROP TABLE [Production].[stocks]
GO
-- Create the table in the specified schema
CREATE TABLE [Production].[stocks]
(
    [store_id] INT NOT NULL,
    [product_id] INT NOT NULL,
    [quantity] INT NOT NULL,
    CONSTRAINT Composite_PK_store_id_product_id PRIMARY KEY(store_id, product_id),
    CONSTRAINT FK_store_id FOREIGN KEY (store_id) REFERENCES Sales.stores(store_id),
    CONSTRAINT FK_product_id FOREIGN KEY (product_id) REFERENCES Production.products(product_id)
    -- Specify more columns here
);
GO

-- Create a new table called '[order_items]' in schema '[Sales]'
-- Drop the table if it already exists
IF OBJECT_ID('[Sales].[order_items]', 'U') IS NOT NULL
DROP TABLE [Sales].[order_items]
GO
-- Create the table in the specified schema
CREATE TABLE [Sales].[order_items]
(
    [order_id] INT NOT NULL,
    [item_id] INT NOT NULL,
    [product_id] INT NULL,
    [quantity] INT NOT NULL,
    [list_price] FLOAT NOT NULL ,
    [discount] FLOAT NOT NULL ,
    CONSTRAINT Composite_PK_order_id_item_id PRIMARY KEY (order_id, item_id),
    CONSTRAINT FK_order_id FOREIGN KEY (order_id) REFERENCES Sales.orders(order_id),
    CONSTRAINT FK_product_id FOREIGN KEY (product_id) REFERENCES Production.products(product_id)

    -- Specify more columns here  
);
GO

-- Insert value query

-- Insert rows into table 'stores' in schema '[Sales]'
INSERT INTO [Sales].[stores]
( -- Columns to insert data into
    [store_id], [store_name], [phone], [email], [street], [city], [state], [zip_code]
)
VALUES
( -- First row: values for the columns in the list above
    101, 'Utility store', 030012, 'Utility@gmail.com', 'street No 49', 'LAHORE', 'Good', 'ua123'
),
( -- Second row: values for the columns in the list above
    201, 'Limited store', 92304, 'Limited@gmail.com', 'street No 59', 'Karachi', 'Good', 'li123'
)
-- Add more rows here
GO

-- SELECT * FROM Sales.stores
-- GO

-- Insert rows into table 'staffs' in schema '[Sales]'
INSERT INTO [Sales].[staffs]
( -- Columns to insert data into
    [staff_id], [first_name], [last_name], [email], [phone], [active], [store_id],[manager_id]
)
VALUES
( -- First row: values for the columns in the list above
    1001, 'Umer', 'Shakeel', 'Umer12@gmail.com', 03000, 'ON', 101, null
),
( -- Second row: values for the columns in the list above
    1002, 'Ahmed', 'Shayzad', 'Ahmed@gmail.com', 0340, 'OFF', 101, 1002
),
( -- First row: values for the columns in the list above
    2001, 'Usman', 'Ahmad', 'Usman@gmail.com', 0323, 'OFF', 201, 2001
),
( -- Second row: values for the columns in the list above
    2002, 'Rizwan', 'Tanveer', 'Rizwan@gmail.com', 0345, 'ON', 201, null
)
-- Add more rows here
GO

-- Insert rows into table 'customers' in schema '[Sales]'
INSERT INTO [Sales].[customers]
( -- Columns to insert data into
    [customer_id], [first_name], [last_name], [phone] ,[email], [street], [city], [state], [zip_code]
)
VALUES
( -- First row: values for the columns in the list above
    1, 'Ali', 'Hadier', 03044, 'ali@gmail.com', 'street No 60', 'Lahore', 'Pakistan', 'sc1'
),
( -- Second row: values for the columns in the list above
    2, 'Zishan', 'Nadeem', 030404, 'Zishan@gmail.com', 'street No 70', 'Lahore', 'Pakistan', 'sc2'

)
-- Add more rows here
GO

-- Insert rows into table 'orders' in schema '[Sales]'
INSERT INTO [Sales].[orders]
( -- Columns to insert data into
    [order_id], [customer_id], [order_status], [order_date], [required_date], [shipped_date], [store_id],[staff_id]
)
VALUES
( -- First row: values for the columns in the list above
    11, 1, 1, '2021-12-24', '2022-01-24', '2022-02-01', 101, Null
),
( -- Second row: values for the columns in the list above
    12, 2, 1, '2021-12-29', '2022-01-29', '2022-02-10', 201, 2002
)
-- Add more rows here
GO

-- Insert rows into table 'brands' in schema '[Production]'
INSERT INTO [Production].[brands]
( -- Columns to insert data into
    [brand_id], [brand_name]
)
VALUES
( -- First row: values for the columns in the list above
    3001, 'Apple'
),
( -- Second row: values for the columns in the list above
    3002, 'Dell'
)
-- Add more rows here
GO

-- Insert rows into table 'categories' in schema '[Production]'
INSERT INTO [Production].[categories]
( -- Columns to insert data into
    [category_id], [category_name]
)
VALUES
( -- First row: values for the columns in the list above
    4001, 'Mobiles'
),
( -- Second row: values for the columns in the list above
    4002, 'Laptops'
)
-- Add more rows here
GO

-- Insert rows into table 'products' in schema '[Production]'
INSERT INTO [Production].[products]
( -- Columns to insert data into
    [product_id], [product_name], [brand_id], [category_id], [model_year], [list_price]
)
VALUES
( -- First row: values for the columns in the list above
    5001, 'I_Phone 12', Null, Null, 2021, 90000.00
),
( -- Second row: values for the columns in the list above
    5002, 'I_Phone 13', Null, 4001, 2022, 100000.00
),
( -- First row: values for the columns in the list above
    5003, 'Core i5', Null, 4002, 2021, 20000.00
),
( -- Second row: values for the columns in the list above
    5004, 'Core i7', Null, Null, 2022, 40000.00
)
-- Add more rows here
GO

-- Insert rows into table 'stocks' in schema '[Production]'
INSERT INTO [Production].[stocks]
( -- Columns to insert data into
    [store_id], [product_id],[quantity]
)
VALUES
( -- First row: values for the columns in the list above
    101,5001, 5
),
( -- Second row: values for the columns in the list above
    201,5002, 7
)
-- Add more rows here
GO

-- Insert rows into table 'order_items' in schema '[Sales]'
INSERT INTO [Sales].[order_items]
( -- Columns to insert data into
    [order_id], [item_id], [product_id],[quantity], [list_price], [discount]
)
VALUES
( -- First row: values for the columns in the list above
    11, 6001, 5001, 3, 90000, 80000
),
( -- Second row: values for the columns in the list above
    12, 6002, 5002, 4, 100000, 90000
)
-- Add more rows here
GO
