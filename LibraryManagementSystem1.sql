-- Step 1: Create the database
CREATE DATABASE LibraryManagementSystem;

-- Step 2: Use the newly created database
USE LibraryManagementSystem;

-----Members
CREATE TABLE Members (
MemberID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
FirstName VARCHAR(50) NOT NULL,
LastName VARCHAR(50)NOT NULL,
EstablishDate DATE
);
EXEC sp_rename 'Members.ID', 'MemberID', 'COLUMN';
----Libraries
CREATE TABLE Libraries (
    LibraryID INT IDENTITY(1,1) PRIMARY KEY,  
    Names VARCHAR(100) NOT NULL,               
    Locations VARCHAR(100),                    
    EstYear INT CHECK (EstYear >= 1800),      
    ConNum VARCHAR(20) UNIQUE,                
    Statu VARCHAR(50) DEFAULT 'Open'
           CHECK (Statu IN ('Open', 'Closed', 'Under Maintenance')) 
);
----Book
CREATE TABLE Book (
    BID INT IDENTITY(1,1) PRIMARY KEY,
    Title VARCHAR(100) NOT NULL,
    ISBN VARCHAR(20) UNIQUE NOT NULL,
    Genre VARCHAR(50) CHECK (Genre IN ('Fiction', 'Non-fiction', 'Reference', 'Children')),
    Statu VARCHAR(20) DEFAULT 'Issued'
        CHECK (Statu IN ('Issued', 'Returned', 'Overdue')),
    Price DECIMAL(10,2) CHECK (Price > 0),
    Locations VARCHAR(100),
    MemberID INT,
    LibraryID INT );

	

		alter table book
       ADD FOREIGN KEY (LibraryID) REFERENCES Libraries(LibraryID)
        ON DELETE CASCADE ON UPDATE CASCADE ;

		alter table Book 
	add  FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
        ON DELETE CASCADE ON UPDATE CASCADE ;
    

----Review
CREATE TABLE Review (
    RID INT,
    BID INT,
    MemberID INT,
    RDate DATE NOT NULL,
    Rating INT CHECK (Rating BETWEEN 1 AND 5),
    Comments VARCHAR(500),
    PRIMARY KEY (RID, BID, MemberID),
    FOREIGN KEY (BID) REFERENCES Book(BID)
	);

	alter table Review
    add FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
        ON DELETE CASCADE ON UPDATE CASCADE ;


---staff
CREATE TABLE Staff (
    SID INT IDENTITY(1,1) PRIMARY KEY,            
    FName VARCHAR(50) NOT NULL,                     
    LName VARCHAR(50) NOT NULL,                    
    Position VARCHAR(50),                           
    PhoneN VARCHAR(20),                           
    LibraryID INT
	);

	alter table Staff 
    add FOREIGN KEY (LibraryID) REFERENCES Libraries(LibraryID)
    ON DELETE CASCADE
    ON UPDATE CASCADE ;


-------payment1 
CREATE TABLE Payment1 (
    ID INT IDENTITY(1,1) PRIMARY KEY,            
    Method VARCHAR(50) NOT NULL,                 
    Amount DECIMAL(10,2) CHECK (Amount > 0), 
    PDate DATE NOT NULL                        
);

-------payment2
CREATE TABLE Payment2 (
    LID INT PRIMARY KEY,                             
    bID INT NOT NULL,                               
    MemberID INT NOT NULL 
	);
	 alter table Payment2
    add FOREIGN KEY (bID) REFERENCES Book(bID)           
        ON DELETE CASCADE
        ON UPDATE CASCADE ;

alter table Payment2 
	add  FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
        ON DELETE NO ACTION ON UPDATE NO ACTION ;


-------payment3
CREATE TABLE Payment3 (
    LID INT NOT NULL,       
    ID INT NOT NULL,  
);
alter table Payment3
  add  PRIMARY KEY (LID, ID) ;   

  alter table Payment3
    add FOREIGN KEY (ID) REFERENCES Payment1(ID)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION ;
	alter table payment3 
	drop constraint [FK__Payment3__ID__7B5B524B];

alter table Payment3
   add FOREIGN KEY (LID) REFERENCES Payment2(LID)
        ON DELETE CASCADE
        ON UPDATE CASCADE ; 
	alter table payment3 
	drop constraint [FK__Payment3__LID__7A672E12];


---loans
CREATE TABLE Loans (
    LID INT,                                
    bID INT,                                
    MemberID INT,                           
    
    LDate DATE NOT NULL,                   
    DuDate DATE NOT NULL,                  
    returnes DATE,                           
    Statu VARCHAR(20) DEFAULT 'Issued'
           CHECK (Statu IN ('Issued', 'Returned', 'Overdue')), 

    PRIMARY KEY (LID, bID, MemberID) 
	);

	alter table Loans 
    add FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
    ON DELETE CASCADE
    ON UPDATE CASCADE ;

	alter table Loans 
  add FOREIGN KEY (bID) REFERENCES Book(bID)
    ON DELETE CASCADE
    ON UPDATE CASCADE ; 


---email
CREATE TABLE Email (
    Email VARCHAR(100) NOT NULL UNIQUE,           
    MemberID INT NOT NULL,                         

    PRIMARY KEY (Email, MemberID)
	);
	
	alter table Email
    add FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
    ON DELETE CASCADE 
    ON UPDATE CASCADE ; 



---phone
CREATE TABLE Phone (
    Phone VARCHAR(20) NOT NULL,               
    MemberID INT NOT NULL,
	PRIMARY KEY (Phone, MemberID)
	);

	alter table phone           
   add FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
    ON DELETE CASCADE
    ON UPDATE CASCADE ;



------------------------------------------------------------------------------


INSERT INTO Libraries (Names, Locations, EstYear, ConNum, Statu) VALUES ('Central Library', 'Downtown', 1950, '100001', 'Open');
INSERT INTO Libraries (Names, Locations, EstYear, ConNum, Statu) VALUES ('Eastside Branch', 'East City', 1975, '100002', 'Open');
INSERT INTO Libraries (Names, Locations, EstYear, ConNum, Statu) VALUES ('Northside Library', 'North End', 1990, '100003', 'Under Maintenance');

INSERT INTO Members (FirstName, LastName, EstablishDate) VALUES ('Ali', 'Hassan', '2020-01-01');
INSERT INTO Members (FirstName, LastName, EstablishDate) VALUES ('Sara', 'Omar', '2019-05-10');
INSERT INTO Members (FirstName, LastName, EstablishDate) VALUES ('John', 'Doe', '2021-03-15');
INSERT INTO Members (FirstName, LastName, EstablishDate) VALUES ('Mona', 'Ali', '2022-07-18');
INSERT INTO Members (FirstName, LastName, EstablishDate) VALUES ('Khalid', 'Yusuf', '2018-11-22');
INSERT INTO Members (FirstName, LastName, EstablishDate) VALUES ('Aisha', 'Saleh', '2023-02-05');

INSERT INTO Book (Title, ISBN, Genre, Statu, Price, Locations, MemberID, LibraryID) VALUES ('SQL Basics', '9781111111111', 'Reference', 'Issued', 60.00, 'Shelf A1', 1, 1);
INSERT INTO Book (Title, ISBN, Genre, Statu, Price, Locations, MemberID, LibraryID) VALUES ('Data Science 101', '9782222222222', 'Non-fiction', 'Issued', 70.00, 'Shelf A2', 2, 1);
INSERT INTO Book (Title, ISBN, Genre, Statu, Price, Locations, MemberID, LibraryID) VALUES ('Children Stories', '9783333333333', 'Children', 'Returned', 30.00, 'Shelf B1', 3, 2);
INSERT INTO Book (Title, ISBN, Genre, Statu, Price, Locations, MemberID, LibraryID) VALUES ('Python Programming', '9784444444444', 'Reference', 'Issued', 80.00, 'Shelf A3', 4, 1);
INSERT INTO Book (Title, ISBN, Genre, Statu, Price, Locations, MemberID, LibraryID) VALUES ('Machine Learning', '9785555555555', 'Non-fiction', 'Issued', 90.00, 'Shelf A4', 5, 3);
INSERT INTO Book (Title, ISBN, Genre, Statu, Price, Locations, MemberID, LibraryID) VALUES ('Fictional World', '9786666666666', 'Fiction', 'Returned', 50.00, 'Shelf C1', 6, 2);
INSERT INTO Book (Title, ISBN, Genre, Statu, Price, Locations, MemberID, LibraryID) VALUES ('Big Data', '9787777777777', 'Non-fiction', 'Overdue', 100.00, 'Shelf A5', 1, 3);
INSERT INTO Book (Title, ISBN, Genre, Statu, Price, Locations, MemberID, LibraryID) VALUES ('Kids ABC', '9788888888888', 'Children', 'Issued', 25.00, 'Shelf B2', 2, 2);
INSERT INTO Book (Title, ISBN, Genre, Statu, Price, Locations, MemberID, LibraryID) VALUES ('Networking Essentials', '9789999999999', 'Reference', 'Returned', 65.00, 'Shelf D1', 3, 1);
INSERT INTO Book (Title, ISBN, Genre, Statu, Price, Locations, MemberID, LibraryID) VALUES ('AI for Beginners', '9781010101010', 'Non-fiction', 'Issued', 95.00, 'Shelf A6', 4, 3);

INSERT INTO Loans (LID, bID, MemberID, LDate, DuDate, returnes, Statu) VALUES (1, 1, 1, '2024-04-01', '2024-04-15', NULL, 'Issued');
INSERT INTO Loans (LID, bID, MemberID, LDate, DuDate, returnes, Statu) VALUES (2, 2, 2, '2024-03-01', '2024-03-15', '2024-03-14', 'Returned');
INSERT INTO Loans (LID, bID, MemberID, LDate, DuDate, returnes, Statu) VALUES (3, 3, 3, '2024-02-01', '2024-02-10', '2024-02-09', 'Returned');
INSERT INTO Loans (LID, bID, MemberID, LDate, DuDate, returnes, Statu) VALUES (4, 4, 4, '2024-05-01', '2024-05-15', NULL, 'Issued');
INSERT INTO Loans (LID, bID, MemberID, LDate, DuDate, returnes, Statu) VALUES (5, 5, 5, '2024-01-01', '2024-01-10', NULL, 'Overdue');
INSERT INTO Loans (LID, bID, MemberID, LDate, DuDate, returnes, Statu) VALUES (6, 6, 6, '2024-03-10', '2024-03-20', '2024-03-19', 'Returned');
INSERT INTO Loans (LID, bID, MemberID, LDate, DuDate, returnes, Statu) VALUES (7, 7, 1, '2024-05-01', '2024-05-10', NULL, 'Overdue');
INSERT INTO Loans (LID, bID, MemberID, LDate, DuDate, returnes, Statu) VALUES (8, 8, 2, '2024-04-10', '2024-04-20', NULL, 'Issued');

INSERT INTO Payment1 (Method, Amount, PDate) VALUES ('Cash', 60.00, '2024-04-02');
INSERT INTO Payment1 (Method, Amount, PDate) VALUES ('Credit Card', 75.00, '2024-03-05');
INSERT INTO Payment1 (Method, Amount, PDate) VALUES ('Online', 90.00, '2024-01-02');
INSERT INTO Payment1 (Method, Amount, PDate) VALUES ('Cash', 30.00, '2024-05-01');

INSERT INTO Payment2 (LID, bID, MemberID)
VALUES (1, 1, 1),(3, 3, 3); 




INSERT INTO Payment3 (LID, ID)
VALUES (1, 1),(3, 3);   


INSERT INTO Staff (FName, LName, Position, PhoneN, LibraryID) VALUES ('Ahmed', 'Nour', 'Librarian', '0501234567', 1);
INSERT INTO Staff (FName, LName, Position, PhoneN, LibraryID) VALUES ('Laila', 'Mohsen', 'Assistant', '0502345678', 2);
INSERT INTO Staff (FName, LName, Position, PhoneN, LibraryID) VALUES ('Sami', 'Yahya', 'Manager', '0503456789', 3);
INSERT INTO Staff (FName, LName, Position, PhoneN, LibraryID) VALUES ('Nora', 'Adel', 'Technician', '0504567890', 1);

INSERT INTO Review (RID, BID, MemberID, RDate, Rating, Comments) VALUES (1, 1, 1, '2024-04-05', 5, 'Excellent resource.');
INSERT INTO Review (RID, BID, MemberID, RDate, Rating, Comments) VALUES (2, 2, 2, '2024-03-06', 4, 'Very informative.');
INSERT INTO Review (RID, BID, MemberID, RDate, Rating, Comments) VALUES (3, 3, 3, '2024-02-08', 3, 'Good for beginners.');
INSERT INTO Review (RID, BID, MemberID, RDate, Rating, Comments) VALUES (4, 4, 4, '2024-05-04', 5, 'Loved it.');
INSERT INTO Review (RID, BID, MemberID, RDate, Rating, Comments) VALUES (5, 5, 5, '2024-01-06', 2, 'Needs improvement.');
INSERT INTO Review (RID, BID, MemberID, RDate, Rating, Comments) VALUES (6, 6, 6, '2024-03-12', 4, 'Well written.');

insert into Email (email , MemberID) values 
('aaa@gmail.com' , 1), 
('www@gmail.com' , 2), 
('sss@gmail.com' , 3), 
('fff@gmail.com' , 4) ,
('ggg@gmail.com' , 5) ,
('bbb@gmail.com' , 6) ,
('ooo@gmail.com' , 7) ,
('mmm@gmail.com' , 8) ,
('zzz@gmail.com' , 9) ,
('vvv@gmail.com' , 10) ,
('nnn@gmail.com' , 11) ,
('uuu@gmail.com' , 12) ;


insert into Phone(phone , MemberID) values 
('91111111' , 1), 
('91111112' , 2), 
('91111113' , 3), 
('91111114' , 4) ,
('91111115' , 5) ,
('91111116' , 6) ,
('91111117' , 7) ,
('91111118' , 8) ,
('91111119' , 9) ,
('91111110' , 10) ,
('91111121' , 11) ,
('91119111' , 12) ;



UPDATE Book SET Statu = 'Returned' WHERE BID = 1;
UPDATE Loans SET Statu = 'Returned', returnes = '2024-05-15' WHERE LID = 1;

DELETE FROM Review WHERE RID = 5 AND BID = 5 AND MemberID = 5;
DELETE FROM Payment1 WHERE ID = 2;





--------select
SELECT * FROM Members;

SELECT * FROM Libraries;

SELECT * FROM Book;

SELECT * FROM Loans;

SELECT * FROM Payment1;

SELECT * FROM Payment2;

SELECT * FROM Payment3;

SELECT * FROM Staff;

SELECT * FROM Review;

select * from Email;

select * from Phone;