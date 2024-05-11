USE master;  
GO
IF DB_ID ( N'StocksDB' ) IS NOT NULL
DROP DATABASE StocksDB;
GO
CREATE DATABASE StocksDB;
GO
use StocksDB;
IF OBJECT_ID(N'dbo.Products', N'U') IS NOT NULL  
   DROP TABLE [dbo].[Products];  
GO
IF OBJECT_ID(N'dbo.Sells', N'U') IS NOT NULL  
   DROP TABLE [dbo].[Sells];  
GO
IF OBJECT_ID(N'dbo.Stock', N'U') IS NOT NULL  
   DROP TABLE [dbo].[Stock];  
GO
CREATE TABLE Products (Product_Id INT PRIMARY KEY IDENTITY (1, 1),Product_Name nchar(150) , Product_Price numeric(18,2), Product_Category nchar(150));
Create Table Sells(Sell_Id INT PRIMARY KEY IDENTITY (1, 1), Product_Id INT FOREIGN KEY REFERENCES Products(Product_Id), Sell_Date datetime, Sell_Quantity numeric(1,0));
CREATE TABLE Stock (Id INT PRIMARY KEY IDENTITY (1, 1),Product_Id INT FOREIGN KEY REFERENCES Products(Product_Id), Quantity numeric(2,0));



INSERT INTO Products(Product_Name,Product_Price,Product_Category) VALUES('SSD 1 To',250.50,'Hard Drives');
INSERT INTO Products(Product_Name,Product_Price,Product_Category) VALUES('SSD 3 To',500.50,'Hard Drives');
INSERT INTO Products(Product_Name,Product_Price,Product_Category) VALUES('SATA 1 To',150.50,'Hard Drives');
INSERT INTO Products(Product_Name,Product_Price,Product_Category) VALUES('SSDRAM 8 Go',250.50,'Memory');
INSERT INTO Products(Product_Name,Product_Price,Product_Category) VALUES('SSDRAM 16 Go',550.50,'Memory');
INSERT INTO Products(Product_Name,Product_Price,Product_Category) VALUES('DDRAM 8 Go',250.50,'Memory');
INSERT INTO Products(Product_Name,Product_Price,Product_Category) VALUES('Keyboard Elantech',25.50,'Accessories');
INSERT INTO Products(Product_Name,Product_Price,Product_Category) VALUES('USB Mouse',20.50,'Accessories');
INSERT INTO Products(Product_Name,Product_Price,Product_Category) VALUES('NVIDIA GTM980',2500.50,'Graphic Cards');

INSERT INTO Sells(Product_Id,Sell_Date,Sell_Quantity) VALUES(1,GETDATE(),4);
INSERT INTO Sells(Product_Id,Sell_Date,Sell_Quantity) VALUES(2,GETDATE(),1);
INSERT INTO Sells(Product_Id,Sell_Date,Sell_Quantity) VALUES(3,GETDATE(),2);
INSERT INTO Sells(Product_Id,Sell_Date,Sell_Quantity) VALUES(4,GETDATE(),1);
INSERT INTO Sells(Product_Id,Sell_Date,Sell_Quantity) VALUES(5,GETDATE(),3);
INSERT INTO Sells(Product_Id,Sell_Date,Sell_Quantity) VALUES(6,GETDATE(),2);
INSERT INTO Sells(Product_Id,Sell_Date,Sell_Quantity) VALUES(7,GETDATE(),1);
INSERT INTO Sells(Product_Id,Sell_Date,Sell_Quantity) VALUES(8,GETDATE(),4);
INSERT INTO Sells(Product_Id,Sell_Date,Sell_Quantity) VALUES(9,GETDATE(),1);
INSERT INTO Sells(Product_Id,Sell_Date,Sell_Quantity) VALUES(1,GETDATE(),1);
INSERT INTO Sells(Product_Id,Sell_Date,Sell_Quantity) VALUES(2,GETDATE(),1);
INSERT INTO Sells(Product_Id,Sell_Date,Sell_Quantity) VALUES(3,GETDATE(),1);
INSERT INTO Sells(Product_Id,Sell_Date,Sell_Quantity) VALUES(4,GETDATE(),1);
INSERT INTO Sells(Product_Id,Sell_Date,Sell_Quantity) VALUES(5,GETDATE(),2);
INSERT INTO Sells(Product_Id,Sell_Date,Sell_Quantity) VALUES(6,GETDATE(),3);
INSERT INTO Sells(Product_Id,Sell_Date,Sell_Quantity) VALUES(7,GETDATE(),1);
INSERT INTO Sells(Product_Id,Sell_Date,Sell_Quantity) VALUES(8,GETDATE(),2);
INSERT INTO Sells(Product_Id,Sell_Date,Sell_Quantity) VALUES(9,GETDATE(),1);

INSERT INTO Stock (Product_Id,Quantity) VALUES (1,10);
INSERT INTO Stock (Product_Id,Quantity) VALUES (2,10);
INSERT INTO Stock (Product_Id,Quantity) VALUES (3,10);
INSERT INTO Stock (Product_Id,Quantity) VALUES (4,10);
INSERT INTO Stock (Product_Id,Quantity) VALUES (5,10);
INSERT INTO Stock (Product_Id,Quantity) VALUES (6,10);
INSERT INTO Stock (Product_Id,Quantity) VALUES (7,10);
INSERT INTO Stock (Product_Id,Quantity) VALUES (8,10);
INSERT INTO Stock (Product_Id,Quantity) VALUES (9,10);

(SELECT Products.Product_Id, Stock.Quantity - SUM(Sell_Quantity) as Remaining, Products.Product_Category, Products.Product_Name
  FROM Products JOIN Sells ON Products.Product_Id = Sells.Product_Id 
  JOIN Stock ON Stock.Product_Id=Products.Product_Id WHERE Product_Category='Memory' GROUP BY Products.Product_Id,Products.Product_Category,Products.Product_Name,Stock.Quantity)  