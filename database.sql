CREATE DATABASE ShoppingServiceMVC;
GO
USE ShoppingServiceMVC;
GO

CREATE TABLE Category(
                         cate_id INT IDENTITY(1,1) PRIMARY KEY,
                         cate_name NVARCHAR(255) NOT NULL,
                         icons NVARCHAR(255) NULL
);
GO

CREATE TABLE [User](
                       id INT IDENTITY(1,1) PRIMARY KEY,
    email VARCHAR(255) NULL,
    username VARCHAR(255) NOT NULL,
    fullname NVARCHAR(255) NULL,
    password VARCHAR(255) NOT NULL,
    avatar VARCHAR(255) NULL,
    roleid INT NULL,
    phone VARCHAR(50) NULL,
    createddate DATE NULL,
    is_active BIT NOT NULL CONSTRAINT DF_User_is_active DEFAULT 1,
    otp_code VARCHAR(6) NULL,
    otp_expiry DATETIME2 NULL
    );
GO

INSERT INTO [User](email, username, fullname, password, roleid, is_active)
VALUES ('admin@shop.com', 'admin', N'Chủ Shop (Administrator)', '123456', 1, 1);
GO