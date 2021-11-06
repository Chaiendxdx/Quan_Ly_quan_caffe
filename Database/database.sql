CREATE DATABASE QuanLyQuanCafe
GO

USE QuanLyQuanCafe
GO

-- Food
-- Table
-- Food Category
-- Account
-- Bill
-- Bill Info

CREATE TABLE TableFood
(
    id INT IDENTITY PRIMARY KEY,
    name NVARCHAR(100) NOT NULL DEFAULT N'Bàn chưa có tên',
    status NVARCHAR(100) NOT NULL DEFAULT N'Trống' -- Trống || Có người 
)
GO

CREATE TABLE Account
(
    UserName NVARCHAR(100) NOT NULL,
    DisplayName NVARCHAR(100) NOT NULL DEFAULT N'Vozer',
    PassWord NVARCHAR(1000) NOT NULL DEFAULT 0,
    Type INT NOT NULL DEFAULT 0 -- admin: 1 && staff: 0
)
GO

CREATE TABLE FoodCategory
(
    id INT IDENTITY PRIMARY KEY,
    name NVARCHAR(100) NOT NULL DEFAULT N'Chưa đặt tên' 
)
GO

CREATE TABLE Food 
(
    id INT IDENTITY PRIMARY KEY,
    name NVARCHAR(100) NOT NULL DEFAULT N'Chưa đặt tên',
    idCategory INT NOT NULL,
    price FLOAT NOT NULL DEFAULT 0

    FOREIGN KEY (idCategory) REFERENCES dbo.FoodCategory(id)
) 
GO

CREATE TABLE Bill
(
    id INT IDENTITY PRIMARY KEY,
    DateCheckIn DATE NOT NULL DEFAULT GETDATE(),
    DateCheckOut DATE,
    idTable INT NOT NULL,
    status INT NOT NULL DEFAULT 0 --1: đã thanh toán && 0: chưa thanh toán

    FOREIGN KEY (idTable) REFERENCES dbo.TableFood(id)
)
GO

CREATE TABLE BillInfo 
(
    id INT IDENTITY PRIMARY KEY,
    idBill INT NOT NULL,
    idFood INT NOT NULL,
    count INT NULL DEFAULT 0

    FOREIGN KEY (idBill) REFERENCES dbo.Bill(id),
    FOREIGN KEY (idFood) REFERENCES dbo.Food(id)
)
GO

INSERT INTO dbo.Account
(
    UserName,
    DisplayName,
    PassWord,
    Type
)
VALUES
(   N'Admin', -- UserName - nvarchar(100)
    N'Chủ Quán', -- DisplayName - nvarchar(100)
    N'1', -- PassWord - nvarchar(1000)
    1    -- Type - int
)

INSERT INTO dbo.Account
(
	    UserName,
	    DisplayName,
	    PassWord,
	    Type
)
VALUES
(   N'Staff', -- UserName - nvarchar(100)
	N'Nhân viên', -- DisplayName - nvarchar(100)
	N'1', -- PassWord - nvarchar(1000)
	0    -- Type - int
)
GO

CREATE PROC USP_GetAccountByUserName
@userName nvarchar(100)
AS
BEGIN
     SELECT *FROM dbo.Account WHERE UserName = @userName
END
GO

EXEC dbo.USP_GetAccountByUserName @userName = N'Admin' -- nvarchar(100)

GO

CREATE PROC USP_Login
@userName nvarchar(100), @passWord nvarchar(100)
AS
BEGIN
  SELECT *FROM dbo.Account WHERE UserName = @userName AND PassWord = @passWord 
END
GO

DECLARE @i INT = 1
while @i<=292
BEGIN 
 DELETE FROM dbo.TableFood where id=CAST(@i AS NVARCHAR(100))
 SET @i = @i+1
END
GO 
-- thêm bàn
DECLARE @i INT =1

WHILE @i <= 10
BEGIN 
IF @i = 10
BREAK;
    INSERT dbo.TableFood (name)  VALUES(   N'Bàn '+ CAST(@i AS nvarchar(100))  )
	SET @i= @i + 1
END

GO

CREATE PROC USP_GetTableList
AS SELECT * FROM dbo.TableFood
GO



EXEC dbo.USP_GetTableList
GO

-- thêm category
INSERT dbo.FoodCategory
(name)
VALUES
(N'Ăn vặt' )

INSERT dbo.FoodCategory
(  name)
VALUES
(N'Cafe' )

INSERT dbo.FoodCategory
( name)
VALUES
(N'Trà')

INSERT dbo.FoodCategory
( name)
VALUES
(N'Sinh tố')

INSERT dbo.FoodCategory
( name)
VALUES
(N'Trà sữa' )


INSERT dbo.FoodCategory
( name)
VALUES
(N'Thức uống khác' )

	--thêm món ăn
INSERT dbo.Food
( name,idCategory, price)
VALUES
(   N'Hướng dương', 1, 10000 )

	INSERT dbo.Food
( name, idCategory,price)
VALUES
(   N'Khô gà', 1, 20000 )

	INSERT dbo.Food
( name,idCategory,price)
VALUES
(   N'Khoai tây chiên', 1, 20000 )

INSERT dbo.Food
( name,idCategory, price)
VALUES
(   N'Nem chua rán',  1,   5000 )

	INSERT dbo.Food
( name, idCategory, price)
VALUES
(   N'Viên chiên', 1,  3000  )

	INSERT dbo.Food
( name, idCategory, price)
VALUES
(   N'Combo mẹt đồ ăn vặt (nem + khoai tây + viên chiên)', 1,  70000 )

INSERT dbo.Food
 ( name,idCategory,price )
VALUES
(   N'Cafe đen', 2,   10000  )

INSERT dbo.Food
 ( name,idCategory,price )
VALUES
(   N'Cafe sữa', 2,   10000  )

INSERT dbo.Food
 ( name,idCategory,price )
VALUES
(   N'Cafe sữa đá Sài Gòn', 2,   12000  )

INSERT dbo.Food
 ( name,idCategory,price )
VALUES
(   N'Bạc xỉu' ,2,   15000  )

INSERT dbo.Food
 ( name,idCategory,price )
VALUES
(   N'Cacao đá/nóng', 2,   15000  )

INSERT dbo.Food
 ( name,idCategory,price )
VALUES
(   N'Cacao sữa', 2,   20000  )

INSERT dbo.Food
 ( name,idCategory,price )
VALUES
(   N'Cafe latte', 2,   30000  )

INSERT dbo.Food
 ( name,idCategory,price )
VALUES
(   N'Cafe Cappuccino', 2,   35000  )

INSERT dbo.Food
 ( name,idCategory,price )
VALUES
(   N'Cafe Espresso', 2,   30000  )

INSERT dbo.Food
 ( name,idCategory,price )
VALUES
(   N'Cafe Mocha ', 2,   35000  )

INSERT dbo.Food
 ( name,idCategory,price )
VALUES
(   N'Trà vải', 3,   20000  )

INSERT dbo.Food
 ( name,idCategory,price )
VALUES
(   N'Trà đào', 3,   20000  )

INSERT dbo.Food
 ( name,idCategory,price )
VALUES
(   N'Trà chanh', 3,   10000  )

INSERT dbo.Food
 ( name,idCategory,price )
VALUES
(   N'Trà tắc', 3,   10000  )

INSERT dbo.Food
 ( name,idCategory,price )
VALUES
(   N'Sinh tố dâu', 4,   20000  )

INSERT dbo.Food
 ( name,idCategory,price )
VALUES
(   N'Sinh tố dưa hấu', 4,   20000  )

INSERT dbo.Food
 ( name,idCategory,price )
VALUES
(   N'Sinh tố xoài', 4,   20000  )

INSERT dbo.Food
 ( name,idCategory,price )
VALUES
(   N'Sinh tố dừa', 4,   20000  )

INSERT dbo.Food
 ( name,idCategory,price )
VALUES
(   N'Sinh tố bơ', 4,   20000  )

INSERT dbo.Food
 ( name,idCategory,price )
VALUES
(   N'Trà sữa chân trâu đường đen', 5,   30000  )

INSERT dbo.Food
 ( name,idCategory,price )
VALUES
(   N'Trà sữa matcha', 5,   25000  )

INSERT dbo.Food
 ( name,idCategory,price )
VALUES
(   N'Trà sữa socola, đào, dâu, bạc hà,...', 5,   20000  )

INSERT dbo.Food
 ( name,idCategory,price )
VALUES
(   N'Nước Lavie', 6,   10000  )

INSERT dbo.Food
 ( name,idCategory,price )
VALUES
(   N'Sữa dâu', 6,   20000  )

INSERT dbo.Food
 ( name,idCategory,price )
VALUES
(   N'Sữa đào', 6,   20000  )

SELECT *FROM dbo.TableFood
-- thêm bill
INSERT dbo.Bill
(
    DateCheckIn,
    DateCheckOut,
    idTable,
    status
)
VALUES
(   GETDATE(), -- DateCheckIn - date
    NULL, -- DateCheckOut - date
    293,         -- idTable - int
    0          -- status - int
    )

	INSERT dbo.Bill
(
    DateCheckIn,
    DateCheckOut,
    idTable,
    status
)
VALUES
(   GETDATE(), -- DateCheckIn - date
    NULL, -- DateCheckOut - date
    295,         -- idTable - int
    0          -- status - int
    )

INSERT dbo.Bill
(
    DateCheckIn,
    DateCheckOut,
    idTable,
    status
)
VALUES
(   GETDATE(), -- DateCheckIn - date
    GETDATE(), -- DateCheckOut - date
    296,         -- idTable - int
    0          -- status - int
    )


	--thêm bill info
INSERT dbo.BillInfo
( idBill,  idFood,   count)
VALUES
(   4, -- idBill - int
    1, -- idFood - int
    2  -- count - int
    )

INSERT dbo.BillInfo
(idBill,idFood,count)
VALUES
(   4, -- idBill - int
    3, -- idFood - int
    4  -- count - int
)

INSERT dbo.BillInfo
(idBill,idFood,count)
VALUES
(   4, -- idBill - int
    5, -- idFood - int
    1  -- count - int
)

INSERT dbo.BillInfo
(idBill,idFood,count)
VALUES
(   5, -- idBill - int
    1, -- idFood - int
    2  -- count - int
)

INSERT dbo.BillInfo
(idBill,idFood,count)
VALUES
(   5, -- idBill - int
    6, -- idFood - int
    2  -- count - int
)

INSERT dbo.BillInfo
(idBill,idFood,count)
VALUES
(   6, -- idBill - int
    5, -- idFood - int
    2  -- count - int
)

GO
ALTER TABLE dbo.Bill
ADD discount INT

CREATE  PROC USP_InsertBill
@idTable INT 

AS
BEGIN
    INSERT dbo.Bill
    (
        DateCheckIn,
        DateCheckOut,
        idTable,
        status,
		discount
    )
    VALUES
    (   GETDATE(), -- DateCheckIn - date
        NULL, -- DateCheckOut - date
        @idTable,         -- idTable - int
        0,          -- status - int
		0
        )
END
Go


CREATE PROC USP_InsertBillInfo
@idBill INT, @idFood INT, @count INT

AS
BEGIN

    DECLARE @isExitsBillInfo INT
	DECLARE @foodCount INT = 1

	SELECT @isExitsBillInfo = id, @foodCount = count FROM dbo.BillInfo WHERE idBill = @idBill AND idFood = @idFood

	IF(@isExitsBillInfo > 0)
	BEGIN
	    DECLARE @newCount INT = @foodCount + @count
		IF (@newCount > 0)
	         UPDATE dbo.BillInfo SET count = @foodCount + @count WHERE idBill = @idBill AND idFood= @idFood
        ELSE 
		     DELETE dbo.BillInfo WHERE idBill = @idBill AND idFood =@idFood
	END
	ELSE
	BEGIN   
    INSERT dbo.BillInfo
    (
        idBill,
        idFood,
        count
    )
    VALUES
    (   @idBill, -- idBill - int
        @idFood, -- idFood - int
        @count  -- count - int
        )
    END
	
END
GO




CREATE TRIGGER UTG_UpdateBillInfo
ON dbo.BillInfo FOR INSERT, UPDATE
AS
BEGIN
    DECLARE @idBill INT 

	SELECT @idBill= idBill FROM Inserted

	DECLARE @idTable INT

	SELECT @idTable = idTable FROM dbo.Bill WHERE id = @idBill AND status =0
	DECLARE @count INT
	SELECT @count =Count (*) FROM dbo.BillInfo WHERE idBill = @idBill

	IF(@count > 0 )
	   UPDATE dbo.TableFood SET status = N'Có người' WHERE id = @idTable 
    ELSE 
	   UPDATE dbo.TableFood SET status = N'Trống' WHERE id = @idTable 
	   
END
GO



CREATE TRIGGER UTG_UpdateBill
ON dbo.Bill FOR UPDATE
AS
BEGIN
    DECLARE @idBill INT 
	
	SELECT @idBill = id FROM Inserted

	DECLARE @idTable INT

	SELECT @idTable = idTable FROM dbo.Bill WHERE id = @idBill

	DECLARE @count INT = 0 
	
	SELECT @count  = COUNT (*) FROM dbo.Bill WHERE idTable = @idTable AND status =0

	IF(@count = 0)
	      UPDATE dbo.TableFood SET status = N'Trống' WHERE id = @idTable
END
GO


UPDATE dbo.Bill SET discount = 0
GO

create PROC USP_SwitchTable 
@idTable1 INT, @idTable2 INT  
AS
BEGIN
    DECLARE @idFirstBill INT

	DECLARE @idSecondBill INT

	DECLARE @isFirstTableEmpty INT = 1 
	DECLARE @isSecondTableEmpty INT = 1 

	SELECT @idSecondBill = id FROM dbo.Bill WHERE idTable = @idTable2 AND status = 0

	SELECT @idFirstBill =id FROM dbo.Bill WHERE idTable = @idTable1 AND status = 0

	IF (@idFirstBill IS NULL )
	BEGIN
	    INSERT INTO dbo.Bill
	    (
	        DateCheckIn,
	        DateCheckOut,
	        idTable,
	        status
	    )
	    VALUES
	    (   GETDATE(), -- DateCheckIn - date
	        NULL, -- DateCheckOut - date
	        @idTable1,         -- idTable - int
	        0          -- status - int
	        )

      SELECT @idFirstBill = Max (id) FROM dbo.Bill WHERE idTable = @idTable1 AND status=0

	  
	END

	SELECT @isFirstTableEmpty  = Count (*) FROM dbo.BillInfo WHERE idBill = @idFirstBill

	IF (@idSecondBill IS NULL )
	BEGIN
	    INSERT INTO dbo.Bill
	    (
	        DateCheckIn,
	        DateCheckOut,
	        idTable,
	        status
	    )
	    VALUES
	    (   GETDATE(), -- DateCheckIn - date
	        NULL , -- DateCheckOut - date
	        @idTable2 ,         -- idTable - int
	        0          -- status - int
	        )

      SELECT @idSecondBill = Max (id) FROM dbo.Bill WHERE idTable = @idTable2 AND status=0

	  
	END

	SELECT @isSecondTableEmpty = Count (*) FROM BillInfo WHERE idBill = @idSecondBill
  
    SELECT id INTO IDBillInfoTable FROM dbo.BillInfo WHERE idBill = @idSecondBill 

	UPDATE dbo.BillInfo SET idBill = @idSecondBill WHERE idBill = @idFirstBill

	UPDATE dbo.BillInfo SET idBill = @idFirstBill WHERE id IN (SELECT *FROM dbo.IDBillInfoTable)

	DROP TABLE dbo.IDBillInfoTable

	IF (@isFirstTableEmpty = 0)
	      UPDATE dbo.TableFood SET status = N'Trống' WHERE id = @idTable2

    IF (@isSecondTableEmpty = 0)
	      UPDATE dbo.TableFood SET status = N'Trống' WHERE id = @idTable1
END
GO

ALTER TABLE dbo.Bill ADD totalPrice FLOAT 


create PROC USP_GetListBillByDate
@checkIn date, @checkOut date 
AS
BEGIN
  SELECT t.name AS [Tên bàn] , b.totalPrice AS [Tổng tiền] , DateCheckIn As [Ngày vào] , DateCheckOut AS [Ngày ra], discount As [Giảm giá]
  FROM dbo.Bill AS b , dbo.TableFood AS t 
  WHERE DateCheckIn >=@checkIn AND DateCheckOut <=@checkOut AND b.status = 1
  AND t.id = b.idTable 
    
END
GO

CREATE PROC USP_UpdateAccount
@userName NVARCHAR(100), @displayName NVARCHAR(100), @password NVARCHAR(100), @newPassword NVARCHAR(100)
AS
BEGIN
    DECLARE @isRightPass INT

	SELECT @isRightPass = Count (*) FROM dbo.Account WHERE UserName = @userName AND PassWord = @password

	IF(@isRightPass = 1)
	BEGIN
	    IF(@newPassword = NULL OR @newPassword ='')
		BEGIN
		    UPDATE dbo.Account SET DisplayName = @displayName WHERE UserName = @userName
		END
		ELSE
		   UPDATE dbo.Account SET DisplayName = @displayName, PassWord=@newPassword WHERE UserName = @userName
	END
END
GO

CREATE TRIGGER UTG_DeleteBillInfo
ON dbo.BillInfo FOR DELETE
AS
BEGIN
  DECLARE @idBillInfo INT
  DECLARE @idBill   INT
  SELECT @idBillInfo= id, @idBill = Deleted.idBill FROM Deleted
  
  DECLARE @idTable   INT  
  SELECT @idTable = idTable FROM dbo.Bill WHERE id = @idBill 

  DECLARE @count INT =0 

  SELECT @count = COUNT(*) FROM dbo.BillInfo AS bi, dbo.Bill AS b WHERE b.id = bi.idBill AND b.id = @idBill AND status =0

  IF(@count=0)
     UPDATE dbo.TableFood SET status = N'Trống' WHERE id=@idTable
END
GO

CREATE FUNCTION [dbo].[fuConvertToUnsign2]
(
 @strInput NVARCHAR(4000)
) 
RETURNS NVARCHAR(4000)
AS
Begin
 Set @strInput=rtrim(ltrim(lower(@strInput)))
 IF @strInput IS NULL RETURN @strInput
 IF @strInput = '' RETURN @strInput
 Declare @text nvarchar(50), @i int
 Set @text='-''`~!@#$%^&*()?><:|}{,./\"''='';–'
 Select @i= PATINDEX('%['+@text+']%',@strInput ) 
 while @i > 0
 begin
 set @strInput = replace(@strInput, substring(@strInput, @i, 1), '')
 set @i = patindex('%['+@text+']%', @strInput)
 End
 Set @strInput =replace(@strInput,' ',' ')
 
 DECLARE @RT NVARCHAR(4000)
 DECLARE @SIGN_CHARS NCHAR(136)
 DECLARE @UNSIGN_CHARS NCHAR (136)
 SET @SIGN_CHARS = N'ăâđêôơưàảãạáằẳẵặắầẩẫậấèẻẽẹéềểễệế
 ìỉĩịíòỏõọóồổỗộốờởỡợớùủũụúừửữựứỳỷỹỵý'
 +NCHAR(272)+ NCHAR(208)
 SET @UNSIGN_CHARS = N'aadeoouaaaaaaaaaaaaaaaeeeeeeeeee
 iiiiiooooooooooooooouuuuuuuuuuyyyyy'
 DECLARE @COUNTER int
 DECLARE @COUNTER1 int
 SET @COUNTER = 1
 WHILE (@COUNTER <=LEN(@strInput))
 BEGIN 
 SET @COUNTER1 = 1
 WHILE (@COUNTER1 <=LEN(@SIGN_CHARS)+1)
 BEGIN
 IF UNICODE(SUBSTRING(@SIGN_CHARS, @COUNTER1,1)) 
 = UNICODE(SUBSTRING(@strInput,@COUNTER ,1) )
 BEGIN 
 IF @COUNTER=1
 SET @strInput = SUBSTRING(@UNSIGN_CHARS, @COUNTER1,1) 
 + SUBSTRING(@strInput, @COUNTER+1,LEN(@strInput)-1) 
 ELSE
 SET @strInput = SUBSTRING(@strInput, 1, @COUNTER-1) 
 +SUBSTRING(@UNSIGN_CHARS, @COUNTER1,1) 
 + SUBSTRING(@strInput, @COUNTER+1,LEN(@strInput)- @COUNTER)
 BREAK
 END
 SET @COUNTER1 = @COUNTER1 +1
 END
 SET @COUNTER = @COUNTER +1
 End
 SET @strInput = replace(@strInput,' ','-')
 RETURN lower(@strInput)
End
GO 

CREATE PROC USP_GetListBillByDateAndPage
@checkIn date, @checkOut date , @page INT 

AS
BEGIN
  DECLARE @pageRows  INT  = 14

  DECLARE @selectRows INT = @pageRows 

  DECLARE @exceptRows INT = (@page -1)*@pageRows

  ; WITH BillShow AS( SELECT b.ID, t.name AS [Tên bàn] , b.totalPrice AS [Tổng tiền] , DateCheckIn As [Ngày vào] , DateCheckOut AS [Ngày ra], discount As [Giảm giá]
  FROM dbo.Bill AS b , dbo.TableFood AS t 
  WHERE DateCheckIn >=@checkIn AND DateCheckOut <=@checkOut AND b.status = 1
  AND t.id = b.idTable)
  
    SELECT TOP (@selectRows) *FROM BillShow WHERE id NOT IN (SELECT TOP (@exceptRows) id FROM BillShow)
	
	
END
GO



Create PROC USP_GetNumBillByDate
@checkIn date, @checkOut date 
AS
BEGIN
  SELECT Count (*)
  FROM dbo.Bill AS b , dbo.TableFood AS t 
  WHERE DateCheckIn >=@checkIn AND DateCheckOut <=@checkOut AND b.status = 1
  AND t.id = b.idTable 
    
END
GO


CREATE  PROC USP_GetListBillByDateForReport
@checkIn date, @checkOut DATE 
AS
BEGIN
  SELECT t.name AS [Tên bàn]  , DateCheckIn As [Ngày vào] , DateCheckOut AS [Ngày ra],  f.name AS [Tên món] , bi.count AS [Số lượng],discount As [Giảm giá], b.totalPrice AS [Tổng tiền] 
  FROM dbo.Bill AS b , dbo.TableFood AS t , dbo.BillInfo AS bi , dbo.Food AS f
  WHERE DateCheckIn >=@checkIn AND DateCheckOut <=@checkOut AND b.status = 1
  AND t.id = b.idTable AND f.id = bi.idFood
    
END
GO
















