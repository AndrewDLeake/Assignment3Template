-- 30 MARKS TOTAL

-- TODO: Database
use master
go
drop database dbA3
go
create database dbA3
go
use dbA3
go

-- Complete these tables (3 marks), 
-- inserts (1 mark) 
-- stored procedures (20 marks total)
-- reports (6 marks)

CREATE TABLE tbCustomer -- AccessLevel is a BIT, 1 is admin, 0 is not an admin
(CustomerID int identity(1,1) primary key,
FirstName varchar(100),
LastName varchar(100),
Address varchar(100),
City varchar(100),
PhoneNumber int,
UserName varchar(100),
Password varchar(100),
AccessLevel bit
)
CREATE TABLE tbCategory
(CategoryID int identity(1,1) primary key,
Name varchar(100),
ImagePath varchar(100)
)
CREATE TABLE tbProduct -- there are many products in a single category
(ProductID int identity(1,1) primary key,
Name varchar(100),
Price decimal(10,2),
PrimaryImagePath varchar(100),
CategoryID int foreign key references tbCategory(CategoryID)
)
CREATE TABLE tbOrder -- an order happens on a date by a customer
(OrderID int identity(1,1) primary key,
OrderDate date,
CustomerID int foreign key references tbCustomer(CustomerID)
)
CREATE TABLE tbOrderDetail -- there can be many details in an order, each detail contains the product purchased, the price paid at the time for the product multiplied by the quantity
(OrderDetailID int identity(1,1) primary key,
Quantity int,
Subtotal float,
ProductID int foreign key references tbProduct(ProductID),
OrderID int foreign key references tbOrder(OrderID)
)
go

INSERT INTO tbCustomer -- 5, 1 admin, 4 non-admins
(FirstName, LastName, Address, City, PhoneNumber, UserName, Password, AccessLevel) values
('Andrew', 'Leake', '69 Loli Lane', 'Winnipeg', 9961783, 'Admin', 'Pass', 1),
('Kakashi', 'Hatake', '12 Sharingan Way', 'Konohagakure', 5555555, 'user1', 'pass', 0),
('Naruto', 'Uzumaki', '1 Hokage Street', 'Konohagakure', 5556969, 'user2', 'pass', 0),
('Sasuke', 'Uchiha', '48 Uchiha District', 'Konohagakure', 5551337, 'user3', 'pass', 0),
('Sakura', 'Haruno', '87 Tsunade Street', 'Konohagakure', 5559001, 'user4', 'pass', 0)

INSERT INTO tbCategory -- 4 categories
(Name, ImagePath) values
('Weapons','noimage.png'),('Jutsus','noimage.png'),('Scrolls','noimage.png'),('Chakra','noimage.png')

INSERT INTO tbProduct  -- 6 products in category one, 3 products in category two, 1 in category three
(Name, Price, PrimaryImagePath, CategoryID) values
('Shuriken', 4.99, 'noimage.png', 1),
('Katana', 24.99, 'noimage.png', 1),
('Kunai', 6.99, 'noimage.png', 1),
('Fuma Shuriken', 17.99, 'noimage.png', 1),
('Gunbai', 249.99, 'noimage.png', 1),
('Flying Raijin Kunai', 74.99, 'noimage.png', 1),
('Fireball', 34.99, 'noimage.png', 2),
('Chidori', 789.99, 'noimage.png', 2),
('Rasengan', 859.99, 'noimage.png', 2),
('Summoning Scroll', 12.99, 'noimage.png', 3)

INSERT INTO tbOrder    -- 3 example orders from the non-admins
(OrderDate, CustomerID) values
('2-29-2016', 2),('5-13-2015',3),('5-9-2015',4)
INSERT INTO tbOrderDetail -- one item on the first order, 3 items on the second order, 2 items on the third order
(Quantity, Subtotal, ProductID, OrderID) values 
(12, 83.88, 3, 1),
(1, 859.99, 9, 2),
(6, 41.94, 3, 2),
(1, 74.99, 6, 2),
(1, 789.99, 8, 3),
(24, 119.76, 1, 3)

-- NOTE: All Insert procs *MUST* return the new identity number of the primary key.
-- Example: if you use spInsertCategory after there are 4 categories, it should return the value 5.
-- If a procedure says: ByID, it means return ALL rows in the table if an ID is not supplied (ISNULL)
go

--Category CRUD Procedures
create procedure spGetCategoryByID
(@CategoryID int=null
)
as begin
	select tbCategory.CategoryID, tbCategory.Name, ImagePath
		from tbCategory where CategoryID=isnull(@CategoryID,CategoryID)
end
go

create procedure spInsertCategory
(@Name varchar(100),
@ImagePath varchar(100)
)
as begin
	insert into 
		tbCategory(Name, ImagePath)	
		values(@Name, @ImagePath)
end
go

create procedure spDeleteCategory
(@CategoryID int
)
as begin
	delete from tbCategory where @CategoryID = CategoryID
end
go

create procedure spUpdateCategory
(@CategoryID int,
@Name varchar(100),
@ImagePath varchar(100)
)
as begin
	update	tbCategory 
	set	Name = @Name,
		ImagePath = @ImagePath
		where CategoryID = @CategoryID			
end
go

--Login Procedure
create procedure spLogin
(@UserName varchar(100),
@Password varchar(100)
)
as begin
	select * from tbCustomer 
		where UserName=@UserName and Password=@Password
end
go

--Customer CRUD Procedures
create procedure spGetCustomerByID
(@CustomerID int
)
as begin
	select * from tbCustomer where CustomerID=ISNULL(@CustomerID,CustomerID)
end
go

create procedure spInsertCustomer
(@FirstName varchar(100),
@LastName varchar(100),
@Address varchar(100),
@City varchar(100),
@PhoneNumber int,
@UserName varchar(100),
@Password varchar(100),
@AccessLevel bit
)
as begin 
	insert into tbCustomer(FirstName,LastName,Address,City,PhoneNumber,UserName,Password,AccessLevel) values
		(@FirstName,@LastName,@Address,@City,@PhoneNumber,@UserName,@Password,@AccessLevel)	
end
go

create procedure spDeleteCustomer
(@CustomerID int
)
as begin
	delete from tbCustomer where CustomerID = @CustomerID
end
go

create procedure spUpdateCustomer
(@CustomerID int,
@FirstName varchar(100),
@LastName varchar(100),
@Address varchar(100),
@City varchar(100),
@PhoneNumber int,
@UserName varchar(100),
@Password varchar(100),
@AccessLevel bit
)
as begin
	update tbCustomer
	set		FirstName = @FirstName,
			LastName = @LastName,
			Address = @Address,
			City = @City,
			PhoneNumber = @PhoneNumber,
			UserName = @UserName,
			Password = @Password,
			AccessLevel = @AccessLevel
end
go

--Product CRUD procedures
create procedure spGetProductsByCategoryID
(@CategoryID int=null
)
as begin
	select Name, Price, PrimaryImagePath, CategoryID
	 from tbProduct where CategoryID=ISNULL(@CategoryID,CategoryID)
end
go

create procedure spGetProductByID
(@ProductID int=null
)
as begin
	select * from tbProduct where ProductID=ISNULL(@ProductID,ProductID)
end
go

create procedure spInsertProduct
(@Name varchar(100),
@Price float,
@PrimaryImagePath varchar(100),
@CategoryID int
)
as begin
	insert into tbProduct(Name,Price,PrimaryImagePath,CategoryID) values
		(@Name,@Price,@PrimaryImagePath,@CategoryID)
end
go

create procedure spDeleteProduct
(@ProductID int
)
as begin
	delete from tbProduct where ProductID = @ProductID
end
go

create procedure spUpdateProduct
(@ProductID int,
@Name varchar(100),
@Price float,
@PrimaryImagePath varchar(100),
@CategoryID int
)
as begin
	update tbProduct
	set		Name = @Name,
			Price = @Price,
			PrimaryImagePath = @PrimaryImagePath,
			CategoryID = @CategoryID
			where ProductID = @ProductID
end
go

--Order CRUD Procedures
create procedure spGetOrderByID
(@OrderID int
)
as begin
	select * from tbOrder where OrderID=ISNULL(@OrderID,OrderID)
end
go

create procedure spInsertOrder
(@OrderID int,
@OrderDate date,
@CustomerID int
)
as begin
	insert into tbOrder (OrderDate,CustomerID) values 
		(@OrderDate,@CustomerID)
end
go

create procedure spDeleteOrder
(@OrderID int
)
as begin
	delete from tbOrder where OrderID = @OrderID
end
go

create procedure spUpdateOrder
(@OrderID int,
@OrderDate date,
@CustomerID int
)
as begin
	update tbOrder
	set		OrderDate = @OrderDate,
			CustomerID = @CustomerID
			where OrderID = @OrderID
end
go

--Order Details CRUD procedures
create procedure spGetOrderDetailByID
(@OrderDetailID int
)
as begin
	select * from tbOrderDetail where OrderDetailID=ISNULL(@OrderDetailID,OrderDetailID)
end
go

create procedure spInsertOrderDetail
(@Quantity int,
@Subtotal float,
@ProductID int,
@OrderID int
)
as begin
	insert into tbOrderDetail(Quantity,Subtotal,ProductID,OrderID) values
		(@Quantity,@Subtotal,@ProductID,@OrderID)
end
go

create procedure spDeleteOrderDetail
(@OrderDetailID int
)
as begin
	delete from tbOrderDetail where OrderDetailID = @OrderDetailID
end
go

create procedure spUpdateOrderDetail
(@OrderDetailID int,
@Quantity int,
@Subtotal float,
@ProductID int,
@OrderID int
)
as begin 
	update tbOrderDetail 
	set		Quantity = @Quantity,
			Subtotal = @Subtotal,
			ProductID = @ProductID,
			OrderID = @OrderID
end
go

create procedure spGetOrderAndDetailsByOrderID -- Show all Details based on the OrderID
(@OrderID int
)
as begin
	select * from tbOrderDetail where OrderID=ISNULL(@OrderID,OrderID)
end
go

-- Create these reports:
--1. Top 3 Customers for TOTAL spent among all orders
--2. Show each category and how many products are available in each
--3. Show the products listed by total amount paid (take into consideration quantity & price)