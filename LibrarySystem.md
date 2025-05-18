# **Library Management System DB**

## Description of database:

 **The Library Management System** is designed to manage books, members, staff, 
loans, and transactions efficiently. The system includes libraries where each library 
has a unique ID, name, location, contact number, and established year. Each library 
must manage books, where each book is identified by a unique ID, ISBN, title, genre, 
price, availability status, and shelf location. A book belongs to exactly one library, 
and a library may own many books. 
Members can register with personal information such as ID, full name, email, phone 
number, and membership start date. A member can borrow zero or more books. 
Each loan links one member with one book and includes loan date, due date, return 
date, and status. 
Each loan may have zero or more fine payments, where a payment is uniquely 
identified and includes payment date, amount, and method. Payment always 
corresponds to one specific loan. 
Staff work at a specific library, identified by staff ID, full name, position, and contact 
number. Each library must have at least one staff member, but each member of staff 
works at only one library. 
Members may also review books, where a review includes a rating, comments, and 
review date. Each review is linked to a specific book and a specific member. A 
member can provide multiple reviews, and a book may receive many reviews. 

## Draw the ERD Diagram:
  
   1. Include entities, attributes, keys, relationships, cardinality, and participation. 
   2. Use clear notation and include weak entities and M: N relationships. 

**1. library:**
- Attributes:
  - ID (Primary Key)
  - Name
  - Location
  - ConNum 
  - estYear
    
**2. Book:**
- Attributes:
   - bID (Primary Key)
   - ISBN
   - Title
   - Genre
   - Price
   - Status
   - Location

**3. Member:**
- Attributes:
   - ID (Primary Key)
   - FullName (multivalued)
   - Email
   - Phone
   - Membership_Start_Date

**4. Loan:**
- Attributes:
  - LID
 

**5. Payment:**
- Attributes:
  - ID (Partial key)
  - PDate
  - Amount
  - Method

**6. Staff:**
- Attributes:
  - SID (Primary Key)
  - Name (multivalued)
  - Position
  - phoneN

**7. Review:**
- Attributes:
  - RID
  - RDAATE

![ERD Diagram](image/1.png)

## Map the ERD to Relational Schema:
- Convert the ERD into relational tables with PKs and FKs defined. 

![Mapping Diagram](./image/2.png)

## Normalization Practice 
- Choose 2–3 tables to normalize. 
- Show step-by-step conversion to 1NF ? 2NF ? 3NF. 
- Justify each normalization step. 