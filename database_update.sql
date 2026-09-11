USE ShoppingServiceMVC;
GO

-- Chạy file này nếu database cũ của project đã tồn tại.
IF COL_LENGTH('[User]', 'is_active') IS NULL
    ALTER TABLE [User] ADD is_active BIT NOT NULL CONSTRAINT DF_User_is_active DEFAULT 0;
GO
IF COL_LENGTH('[User]', 'otp_code') IS NULL
    ALTER TABLE [User] ADD otp_code VARCHAR(6) NULL;
GO
IF COL_LENGTH('[User]', 'otp_expiry') IS NULL
    ALTER TABLE [User] ADD otp_expiry DATETIME2 NULL;
GO

-- Cho tài khoản cũ được đăng nhập bình thường sau khi migrate.
UPDATE [User] SET is_active = 1 WHERE is_active = 0 AND otp_code IS NULL;
GO

IF OBJECT_ID('Products', 'U') IS NULL
BEGIN
    CREATE TABLE Products(
        product_id INT IDENTITY(1,1) PRIMARY KEY,
        product_name NVARCHAR(255) NOT NULL,
        description NVARCHAR(MAX) NULL,
        price DECIMAL(18,2) NOT NULL CHECK (price >= 0),
        image NVARCHAR(255) NULL,
        category_id INT NOT NULL,
        created_date DATETIME2 NOT NULL CONSTRAINT DF_Products_created_date DEFAULT GETDATE(),
        CONSTRAINT FK_Products_Category FOREIGN KEY(category_id) REFERENCES Category(cate_id)
    );
END
GO
