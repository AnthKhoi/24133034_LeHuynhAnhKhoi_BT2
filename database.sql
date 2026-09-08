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
    createddate DATE NULL
    );
GO

INSERT INTO [User](email, username, fullname, password, roleid)
VALUES ('admin@admin.com', 'admin', N'Administrator', '123', 1);
GO