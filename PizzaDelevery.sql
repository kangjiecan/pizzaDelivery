-- MS SQL Server version
-- Create Customer table
CREATE TABLE Customer (
    CustomerID INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    VerifiedEmail NVARCHAR(100) NOT NULL UNIQUE,
    Phone NVARCHAR(20)
);

-- Create Address table
CREATE TABLE Address (
    AddressID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT,
    Street NVARCHAR(100) NOT NULL,
    AddressNumber NVARCHAR(20) NOT NULL,
    CONSTRAINT FK_Address_Customer FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

-- Create DoughType table
CREATE TABLE DoughType (
    DoughTypeID INT IDENTITY(1,1) PRIMARY KEY,
    DoughType NVARCHAR(50) NOT NULL
);

-- Create Sauce table
CREATE TABLE Sauce (
    SauceID INT IDENTITY(1,1) PRIMARY KEY,
    SauceType NVARCHAR(50) NOT NULL
);

-- Create PizzaSize table
CREATE TABLE PizzaSize (
    SizeID INT IDENTITY(1,1) PRIMARY KEY,
    PizzaSize NVARCHAR(20) NOT NULL,
    PizzaBasePrice DECIMAL(10,2) NOT NULL,
    Date DATE NOT NULL
);

-- Create Pizza table
CREATE TABLE Pizza (
    PizzaID INT IDENTITY(1,1) PRIMARY KEY,
    PizzaName NVARCHAR(100) NOT NULL,
    DoughTypeID INT,
    SauceID INT,
    SizeID INT,
    PortionID INT,
    CONSTRAINT FK_Pizza_DoughType FOREIGN KEY (DoughTypeID) REFERENCES DoughType(DoughTypeID),
    CONSTRAINT FK_Pizza_Sauce FOREIGN KEY (SauceID) REFERENCES Sauce(SauceID),
    CONSTRAINT FK_Pizza_Size FOREIGN KEY (SizeID) REFERENCES PizzaSize(SizeID)
);

-- Create Employee table
CREATE TABLE Employee (
    EmployeeID INT IDENTITY(1,1) PRIMARY KEY,
    StartDate DATE NOT NULL,
    EndDate DATE,
    DailyWage DECIMAL(10,2) NOT NULL
);

-- Create Drivers table
CREATE TABLE Drivers (
    DriverID INT IDENTITY(1,1) PRIMARY KEY,
    EmployeeID INT,
    DriverLicenseNumber NVARCHAR(50) NOT NULL UNIQUE,
    ExpiredDate DATE NOT NULL,
    CONSTRAINT FK_Drivers_Employee FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
);

-- Create Cooks table
CREATE TABLE Cooks (
    CookID INT IDENTITY(1,1) PRIMARY KEY,
    EmployeeID INT,
    CONSTRAINT FK_Cooks_Employee FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
);

-- Create Cars table
CREATE TABLE Cars (
    CarID INT IDENTITY(1,1) PRIMARY KEY,
    Maker NVARCHAR(50) NOT NULL,
    Model NVARCHAR(50) NOT NULL,
    StartYear INT NOT NULL,
    Color NVARCHAR(30) NOT NULL,
    LicensePlate NVARCHAR(20) NOT NULL
);

-- Create Orders table
CREATE TABLE Orders (
    OrderID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT,
    StartTime DATETIME2 NOT NULL,
    EndTime DATETIME2,
    PaymentMade BIT,
    CONSTRAINT FK_Orders_Customer FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

-- Create LineItem table
CREATE TABLE LineItem (
    LineItemID INT IDENTITY(1,1) PRIMARY KEY,
    OrderID INT,
    PizzaID INT,
    LineItemPrice DECIMAL(10,2) NOT NULL,
    Quantity INT NOT NULL,
    DateAndTime DATETIME2 NOT NULL,
    CONSTRAINT FK_LineItem_Order FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    CONSTRAINT FK_LineItem_Pizza FOREIGN KEY (PizzaID) REFERENCES Pizza(PizzaID)
);

-- Create Delivery table
CREATE TABLE Delivery (
    DeliveryID INT IDENTITY(1,1) PRIMARY KEY,
    OrderID INT,
    Start DATETIME2 NOT NULL,
    Finish DATETIME2,
    DriverID INT,
    AddressID INT,
    CarID INT,
    CONSTRAINT FK_Delivery_Order FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    CONSTRAINT FK_Delivery_Driver FOREIGN KEY (DriverID) REFERENCES Drivers(DriverID),
    CONSTRAINT FK_Delivery_Address FOREIGN KEY (AddressID) REFERENCES Address(AddressID),
    CONSTRAINT FK_Delivery_Car FOREIGN KEY (CarID) REFERENCES Cars(CarID)
);

-- Create Insurance table
CREATE TABLE Insurance (
    InsuranceID INT IDENTITY(1,1) PRIMARY KEY,
    StartDate DATE NOT NULL,
    FinishDate DATE NOT NULL,
    DriverID INT,
    CarID INT,
    InsurancePolicyNumber NVARCHAR(50) NOT NULL,
    CONSTRAINT FK_Insurance_Driver FOREIGN KEY (DriverID) REFERENCES Drivers(DriverID),
    CONSTRAINT FK_Insurance_Car FOREIGN KEY (CarID) REFERENCES Cars(CarID)
);

-- Create Rating table
CREATE TABLE Rating (
    RatingID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT,
    DeliveryID INT,
    OrderID INT,
    Rating INT,
    Comments NVARCHAR(MAX),
    CONSTRAINT FK_Rating_Customer FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    CONSTRAINT FK_Rating_Delivery FOREIGN KEY (DeliveryID) REFERENCES Delivery(DeliveryID),
    CONSTRAINT FK_Rating_Order FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Create CookingTable for tracking cooking assignments
CREATE TABLE CookingTable (
    CookingID INT IDENTITY(1,1) PRIMARY KEY,
    CookID INT,
    PizzaID INT,
    StartTime DATETIME2 NOT NULL,
    EndTime DATETIME2 NOT NULL,
    CONSTRAINT FK_CookingTable_Cook FOREIGN KEY (CookID) REFERENCES Cooks(CookID),
    CONSTRAINT FK_CookingTable_Pizza FOREIGN KEY (PizzaID) REFERENCES Pizza(PizzaID)
);

-- Create AttendanceOfWork table
CREATE TABLE AttendanceOfWork (
    AttendanceID INT IDENTITY(1,1) PRIMARY KEY,
    DriverID INT,
    CookID INT,
    StartTimeDate DATETIME2 NOT NULL,
    EndTimeDate DATETIME2 NOT NULL,
    DailyWage DECIMAL(10,2) NOT NULL,
    CONSTRAINT FK_Attendance_Driver FOREIGN KEY (DriverID) REFERENCES Drivers(DriverID),
    CONSTRAINT FK_Attendance_Cook FOREIGN KEY (CookID) REFERENCES Cooks(CookID)
);