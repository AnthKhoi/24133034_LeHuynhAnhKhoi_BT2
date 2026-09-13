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

-- Cập nhật mật khẩu tài khoản Chủ Shop (Admin) thành 123456 và kích hoạt tài khoản
IF EXISTS (SELECT 1 FROM [User] WHERE username = 'admin')
BEGIN
    UPDATE [User] SET password = '123456', roleid = 1, is_active = 1, fullname = N'Chủ Shop (Administrator)' WHERE username = 'admin';
END
ELSE
BEGIN
    INSERT INTO [User](email, username, fullname, password, roleid, is_active)
    VALUES ('admin@shop.com', 'admin', N'Chủ Shop (Administrator)', '123456', 1, 1);
END
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

-- Thêm Category mẫu nếu chưa có
IF NOT EXISTS (SELECT 1 FROM Category)
BEGIN
    INSERT INTO Category(cate_name, icons) VALUES
    (N'Điện thoại & Tablet', 'category/phone.png'),
    (N'Laptop & Máy tính', 'category/laptop.png'),
    (N'Phụ kiện công nghệ', 'category/accessory.png'),
    (N'Thiết bị âm thanh', 'category/audio.png');
END
GO

-- Thêm Products mẫu nếu chưa có (12 sản phẩm để test phân trang 6sp/trang và 10sp trang chủ)
IF NOT EXISTS (SELECT 1 FROM Products)
BEGIN
    DECLARE @c1 INT = (SELECT TOP 1 cate_id FROM Category ORDER BY cate_id ASC);
    DECLARE @c2 INT = (SELECT TOP 1 cate_id FROM Category WHERE cate_id > @c1 ORDER BY cate_id ASC);
    IF @c2 IS NULL SET @c2 = @c1;

    INSERT INTO Products(product_name, description, price, image, category_id, created_date) VALUES
    (N'iPhone 15 Pro Max 256GB', N'Titan tự nhiên sang trọng, chip Apple A17 Pro mạnh mẽ, camera zoom 5x ấn tượng.', 29990000, 'products/iphone15.jpg', @c1, DATEADD(minute, 1, GETDATE())),
    (N'Samsung Galaxy S24 Ultra', N'Khung titan cao cấp, tích hợp Galaxy AI đột phá, bút S-Pen thông minh.', 28490000, 'products/s24ultra.jpg', @c1, DATEADD(minute, 2, GETDATE())),
    (N'MacBook Pro 14 M3 Pro', N'Hiệu năng đồ họa đỉnh cao, màn hình Liquid Retina XDR 120Hz mượt mà.', 49990000, 'products/macbookpro.jpg', @c2, DATEADD(minute, 3, GETDATE())),
    (N'Dell XPS 13 Plus 9320', N'Thiết kế tương lai siêu mỏng nhẹ, màn hình OLED 3.5K cảm ứng tuyệt đẹp.', 38990000, 'products/dellxps.jpg', @c2, DATEADD(minute, 4, GETDATE())),
    (N'iPad Pro 11 M4 256GB', N'Màn hình Ultra Retina Tandem OLED siêu sáng, mỏng nhẹ nhất từng có.', 26990000, 'products/ipadpro.jpg', @c1, DATEADD(minute, 5, GETDATE())),
    (N'Tai nghe Sony WH-1000XM5', N'Chống ồn chủ động hàng đầu thị trường, âm thanh Hi-Res chất lượng cao.', 7490000, 'products/sonyxm5.jpg', @c1, DATEADD(minute, 6, GETDATE())),
    (N'Apple Watch Ultra 2 49mm', N'Đồng hồ thể thao chuyên nghiệp vỏ titan, GPS băng tần kép chính xác.', 21490000, 'products/watchultra.jpg', @c1, DATEADD(minute, 7, GETDATE())),
    (N'Bàn phím cơ Keychron K3 Pro', N'Bàn phím cơ siêu mỏng low-profile, kết nối Bluetooth 5.1 và có dây.', 2290000, 'products/keychron.jpg', @c2, DATEADD(minute, 8, GETDATE())),
    (N'Chuột Logitech MX Master 3S', N'Cuộn siêu tốc MagSpeed, cảm biến 8000 DPI trên mọi bề mặt kể cả kính.', 2190000, 'products/mxmaster3s.jpg', @c2, DATEADD(minute, 9, GETDATE())),
    (N'Tai nghe AirPods Pro 2 USB-C', N'Chống ồn thông minh thích ứng, âm thanh không gian cá nhân hóa.', 5490000, 'products/airpodspro.jpg', @c1, DATEADD(minute, 10, GETDATE())),
    (N'Màn hình LG UltraFine 27 inch 4K', N'Tấm nền IPS chuẩn màu đồ họa 99% sRGB, kết nối USB-C sạc 60W tiện lợi.', 9890000, 'products/lg4k.jpg', @c2, DATEADD(minute, 11, GETDATE())),
    (N'Loa Bluetooth Marshall Stanmore III', N'Âm thanh cổ điển ấm áp, âm trường rộng, kết nối Bluetooth 5.2 hiện đại.', 8990000, 'products/marshall.jpg', @c1, DATEADD(minute, 12, GETDATE()));
END
GO
