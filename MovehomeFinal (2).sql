CREATE TABLE ADDRESS (
A_ID Char(2) CONSTRAINT PK_ADDRESS PRIMARY KEY,
House_No Varchar(4),
Street_Name Varchar(25),
Area Varchar(25),
City Varchar(20),
Post_Code Varchar(10)
);

CREATE TABLE CUSTOMER (
  CuCode Char(4) CONSTRAINT PK_CUSTOMER PRIMARY KEY,
  Type Char(8) NOT NULL,
    Last_Name Varchar(20),
  First_Name Varchar(20),
  Gender Char(1) CONSTRAINT GENDER CHECK (GENDER IN ('F', 'M', 'O')),
  DOB Date,
  Email Varchar(60),
  Phone_No Char(11),
  Address_ID Char(2) CONSTRAINT FK_ADDRESS REFERENCES ADDRESS (A_ID)
);

CREATE TABLE PROPERTY (
  P_ID Char(3) CONSTRAINT PK_PROPERTY PRIMARY KEY,
  Type Varchar(20),
  Address_ID Char(2) CONSTRAINT FK_ADDRESS2 REFERENCES ADDRESS (A_ID),
  Location Varchar(60),
    No_of_Rooms Number(2),
    Size_in_sqft Number(6),
    Description Varchar(300),
    Registered_date Date NOT NULL,
  Price Number(15),
  Desc_of_Rooms Varchar(150),
LrCode Char(4) CONSTRAINT FK_LANDLORD REFERENCES CUSTOMER (CuCode)
);

CREATE TABLE ESTATE_AGENT (
  EACode Char(4) CONSTRAINT PK_EAGT PRIMARY KEY,
  Name Varchar(20),
  Reg_Address_ID Char(2) CONSTRAINT FK_ADDRESS3 REFERENCES ADDRESS (A_ID),
  Email Varchar(30),
  Phone_No Char(11),
    Headquarters Char(5),
    Website Varchar(30)
);

CREATE TABLE BRANCH (
  BCode Char(5) CONSTRAINT PK_BRANCH PRIMARY KEY,
  Address_ID Char(2) CONSTRAINT FK_ADDRESS4 REFERENCES ADDRESS (A_ID),
  Email Varchar(60),
  Phone_No Char(11),
  MgrID Char(4),
  EAgCode Char(4)
);

CREATE TABLE STAFF (
  S_ID Char(4) CONSTRAINT PK_STAFF PRIMARY KEY,
  LName Varchar(20),
  FName Varchar(20),
  Email Varchar(60),
  Phone_No Char(11),
  Address_ID Char(2) CONSTRAINT FK_ADDRESS5 REFERENCES ADDRESS (A_ID),
  Marital_Status Char(1) CONSTRAINT MAR_STATS CHECK (MARITAL_STATUS IN ('S', 'M', 'W', 'D')),
  Gender Char(1) CONSTRAINT GENDER2 CHECK (GENDER IN ('F', 'M', 'O')),
  BrCode Char(5) CONSTRAINT FK_BRANCH REFERENCES BRANCH (BCode)
);

CREATE TABLE VIEW_ (
  V_ID Char(4) CONSTRAINT PK_VIEW PRIMARY KEY,
    V_Time Char(5),
  V_Date Date,
  Comments Varchar(150),
  V_Status Char(1) CONSTRAINT V_STATUS CHECK (V_STATUS IN ('A', 'C', 'P')),
  PRCode Char(4) CONSTRAINT FK_VIEWPR REFERENCES CUSTOMER (CuCode),
  PrID Char(3) CONSTRAINT FK_VIEWPROP REFERENCES PROPERTY (P_ID)
);

CREATE TABLE PROPERTY_SALE (
  Selling_Price Number(15),
  Stamp_Duty Number(10),
  Commission Number(10),
    Date_Sold Date,
  Buyer_Code Char(4) CONSTRAINT FK_PSBUYER REFERENCES CUSTOMER (CuCode),
  PrID Char(3) CONSTRAINT FK_PSPROP REFERENCES PROPERTY (P_ID),
  CONSTRAINT PK_PS PRIMARY KEY (PrID, Buyer_Code)
);

CREATE TABLE PROPERTY_RENTAL (
  Rent_PM Number(8),
  Advance Number(6),
  Commission Number(6),
  T_StartDate Date,
  T_EndDate Date,
  PrID Char(3) CONSTRAINT FK_PRPROP REFERENCES PROPERTY (P_ID),
  LrCode Char(4)CONSTRAINT FK_PRLNDLRD REFERENCES CUSTOMER (CuCode),
  TntCode Char(4) CONSTRAINT FK_PRTENANT REFERENCES CUSTOMER (CuCode),
  CONSTRAINT PK_PR PRIMARY KEY (PrID, LrCode, TntCode)
);

CREATE TABLE MARKET (
  PrID Char(3) CONSTRAINT MARKET_PR REFERENCES PROPERTY (P_ID),
  EAgCode Char(4) CONSTRAINT MARKET_EAGT REFERENCES ESTATE_AGENT (EACode),
  CONSTRAINT PK_MKRT PRIMARY KEY (PrID, EAgCode)
);

ALTER TABLE ESTATE_AGENT ADD CONSTRAINT FK_BRANCH2 FOREIGN KEY (Headquarters) REFERENCES BRANCH (BCode);
ALTER TABLE BRANCH ADD CONSTRAINT FK_STAFF FOREIGN KEY (MgrID) REFERENCES STAFF (S_ID);
ALTER TABLE PROPERTY_SALE ADD CONSTRAINT PS_STAMPDUTY CHECK(Stamp_Duty = Selling_Price*0.02);
ALTER TABLE PROPERTY_SALE ADD CONSTRAINT PS_COMMISSION CHECK(COMMISSION = Selling_Price*0.0125);
ALTER TABLE PROPERTY_RENTAL ADD CONSTRAINT PR_COMMISSION CHECK(COMMISSION = Rent_PM*0.0125);
ALTER TABLE PROPERTY_RENTAL ADD CONSTRAINT PR_ADVANCE CHECK(ADVANCE = Rent_PM*0.5);


INSERT INTO ADDRESS
VALUES ('01', '12', 'Grange Road','Fenham', 'Newcastle Upon Tyne', 'NE15 8ND');
INSERT INTO ADDRESS
VALUES ('02', '2', 'Waterside', 'Longrigg', 'Newcastle Upon Tyne', 'NE16 3AW');
INSERT INTO ADDRESS
VALUES('03', '2', 'Hood Street', 'Monument', 'Newcastle Upon Tyne', 'NE16 3HS');
INSERT INTO ADDRESS
VALUES ('04', '64', 'St Andrews Street', 'Monument', 'Newcastle Upon Type', 'NE1 5SF');
INSERT INTO ADDRESS
VALUES ('05', '41', 'Cowdray Road', 'Castle', 'Sunderland', 'SR5 3PG');
INSERT INTO ADDRESS
VALUES ('06','6', 'Raby Drive', 'East Herrington', 'Sunderland', 'SR3 3QE');
INSERT INTO ADDRESS
VALUES ('07', '18', 'Westholme Terrace', 'Wearside', 'Sunderland', 'SR2 9QA');
INSERT INTO ADDRESS
VALUES ('08', '10', 'Davis Crescent', 'Langley Park', 'Durham', 'DH7 9UP');
INSERT INTO ADDRESS
VALUES ('09', '8A', 'Newhouse Road', 'Esh Winning', 'Durham', 'DH7 9JX');
INSERT INTO ADDRESS
VALUES ('10', '6', 'Claremont Road 39', 'Durham St', 'Durham', 'DH1 1BS');
INSERT INTO ADDRESS
VALUES ('11', '10', 'Newhouse Road', 'Esh Winning', 'Durham', 'DH7 9JX');
INSERT INTO ADDRESS
VALUES ('12', '4', 'Stonehills-Shields Road', 'Pelaw', 'Gateshead', 'NE10 0HW');
INSERT INTO ADDRESS
VALUES ('13', '21', 'Keir Hardie Avenue', 'Wardley', 'Gateshead', 'NE10 8EJ');
INSERT INTO ADDRESS
VALUES ('14', '11', 'Avenue South', 'Team Valley', 'Gateshead', 'NE11 0JY');
INSERT INTO ADDRESS
VALUES ('15', '14', 'Brinkburn Avenue','Saltwell', 'Gateshead', 'NE8 4JT');
INSERT INTO ADDRESS
VALUES ('16', '255', 'Kingsway North', 'Team Valley', 'Gateshead', 'NE11 0JH');
INSERT INTO ADDRESS
VALUES ('17', '39', 'Pilgrims Way', 'Gilesgate', 'Durham', 'DH1 1HB');
INSERT INTO ADDRESS
VALUES ('18', '20', 'Jesmond Dene Road', 'Jesmond', 'Newcastle Upon Tyne', 'NE2 2EY');
INSERT INTO ADDRESS
VALUES ('19', NULL, 'Brackendene Drive', 'Brackendene', 'Gateshead', 'NE9 6DP');
INSERT INTO ADDRESS
VALUES ('20', '15', 'Princess Mary Court', 'Jesmond', 'Newcastle Upon Tyne', 'NE2 3BG');
INSERT INTO ADDRESS
VALUES ('21', '171', 'Jennifer Avenue', 'Castletown', 'Sunderland', 'SR5 3BD');
INSERT INTO ADDRESS
VALUES ('22', '88', 'Broomside Lane', 'Belmont', 'Durham', 'DH1 2QW');
INSERT INTO ADDRESS
VALUES ('23', NULL, 'Mitchell Avenue', 'Jesmond', 'Newcastle Upon Tyne', 'NE2 3JY');
INSERT INTO ADDRESS
VALUES ('24', '26', 'Romford Street', 'Pallion', 'Sunderland', 'SR4 6LX');
INSERT INTO ADDRESS
VALUES ('25', '99', 'Elmwood Gardens', 'Lobley Hill', 'Gateshead', 'NE11 0BX');
INSERT INTO ADDRESS
VALUES ('26', '32', 'Montagu Court', 'Gosforth', 'Newcastle Upon Tyne', 'NE3 4JL');
INSERT INTO ADDRESS
VALUES ('27', NULL, 'Mayfair House', 'Westerhope', 'Newcastle Upon Tyne', 'NE5 1NB');
INSERT INTO ADDRESS
VALUES ('28', '309', 'Ryhope Road', 'Ashbrooke', 'Sunderland', 'SR2 9SS');
INSERT INTO ADDRESS
VALUES ('29', '22', 'Ushaw Villas', 'Ushaw Moor', 'Durham', 'DH7 7PU');
INSERT INTO ADDRESS
VALUES ('30', '16', 'Wynbury Road', 'Low Fell', 'Gateshead', 'NE9 6TS');
INSERT INTO ADDRESS
VALUES ('31', NULL, NULL, 'South Houghton Equestrian Centre', 'Newcastle Upon Tyne', 'NE15 0EZ');
INSERT INTO ADDRESS
VALUES ('32', '31', 'Silverstone', 'Killingsworth', 'Newcastle Upon Tyne', 'NE1 5SF');
INSERT INTO ADDRESS
VALUES ('33', '232', 'Jesmond Dene Road', 'Jesmond', 'Newcastle Upon Tyne', 'NE2 2JU');
INSERT INTO ADDRESS
VALUES ('34', '244', 'Fulwell Road', NULL, 'Sunderland', 'SR6 9EU');
INSERT INTO ADDRESS
VALUES ('35', '25', 'Brusselss Road', 'Pallion West Industrial Estate', 'Sunderland', 'SR4 6SJ');
INSERT INTO ADDRESS
VALUES ('36', 'N7e', NULL, 'Tursdale Business Park', 'Durham', 'DH6 5PG');
INSERT INTO ADDRESS
VALUES ('37', '3', 'Messenger Mews', 'Shotley Bridge', 'Durham', 'DH8 0HJ');
INSERT INTO ADDRESS
VALUES ('38', '340', 'Old Durham Road', 'Mount Pleasant', 'Gateshead', 'NE8 4BQ');
INSERT INTO ADDRESS
VALUES ('39', '4', 'McMillan Close', 'Saltwell Business Park', 'Gateshead', 'NE9 5BF');
INSERT INTO ADDRESS
VALUES ('40', '10', 'Orchard House', 'Jesmond Road', 'Newcastle Upon Tyne', 'NE1 4RZ');
INSERT INTO ADDRESS
VALUES ('41', '70', 'Jesmond Road West', 'Jesmond', 'Newcastle Upon Tyne', 'NE2 4PQ');
INSERT INTO ADDRESS
VALUES ('42', '171', 'Croydon Road', 'Fenham', 'Newcastle Upon Tyne', 'NE4 5LQ');
INSERT INTO ADDRESS
VALUES ('43', '101', 'Sidney Grove', 'Fenham', 'Newcastle Upon Tyne', 'NE$ 5PE');
INSERT INTO ADDRESS
VALUES ('44', '16', 'Castlewood Close', 'West Denton', 'Newcastle Upon Tyne', 'NE5 2PH');
INSERT INTO ADDRESS
VALUES ('45', '12', 'High Street', 'Claypath', 'Durham', 'DH1 3UJ');
INSERT INTO ADDRESS
VALUES ('46', '10', 'Planesway', 'Whitehills', 'Gateshead', 'NE10 8LG');
INSERT INTO ADDRESS
VALUES ('47', '521', 'Hylton Road', 'Ford Estate', 'Sunderland', 'SR4 8DS');
INSERT INTO ADDRESS
VALUES ('48', '48', 'Campus Martius', 'Heddon on the wall', 'Newcastle Upon Tyne', 'NE15 0BP');
INSERT INTO ADDRESS
VALUES ('49', '266', 'Durham Road', NULL, 'Gateshead', 'NE8 4JR');
INSERT INTO ADDRESS
VALUES ('50', '25', 'Brusselss Road', 'Pallion West Industrial Estate', 'Sunderland', 'SR4 6SJ');
INSERT INTO ADDRESS
VALUES ('51', '200', 'Park Road', 'Sherburn Village', 'Durham', 'DH6 4HA');



INSERT INTO CUSTOMER 
VALUES ('LR01', 'LANDLORD', 'Croydon', 'Mark', 'M', '06-MAY-1978', 'croymark@gmail.com', '07875243569', '01');
INSERT INTO CUSTOMER 
VALUES ('PR01', 'PROSPECT', 'Daniel', 'Elizabeth', 'F', '22-AUG-1996', 'elizabethd@outlook.com', '07966501689', '02');
INSERT INTO CUSTOMER 
VALUES ('LR02', 'LANDLORD', 'John', 'Foster', 'O', '09-JUN-1988', 'j-foster@yahoo.com', '07914885262', '03');
INSERT INTO CUSTOMER  
VALUES ('PR02', 'PROSPECT', 'Lowes', 'Pine', 'M','22-JUN-1998', 'pine.lowes@northumbria.ac.uk', '07312220748', '04');
INSERT INTO CUSTOMER 
VALUES ('LR03', 'LANDLORD', 'Smith', 'Joseph', 'M', '01-NOV-1974', 'josephsmith@gmail.com', '07774030355', '05');
INSERT INTO CUSTOMER 
VALUES ('PR03', 'PROSPECT', 'Lewis', 'Carol', 'O', '20-OCT-1960', 'Carlewis@gmail.com', '07947587136', '06');
INSERT INTO CUSTOMER 
VALUES ('PR04', 'PROSPECT', 'Ada', 'Georgia', 'F', '12-AUG-1984', 'adageorgia@outlook.com', '07915655577', '07');
INSERT INTO CUSTOMER 
VALUES ('LR04', 'LANDLORD', 'Christopher', 'Thompson', 'O', '11-MAR-1980', 'christophertom@outlook.com', '07960975167', '08');
INSERT INTO CUSTOMER 
VALUES ('PR05', 'PROSPECT', 'David', 'Kurt', 'M', '20-APR-1979', 'kurt.david@gmail.com', '07963792156','09');
INSERT INTO CUSTOMER 
VALUES ('LR05', 'LANDLORD', 'Ellman', 'Jennifer', 'F', '28-FEB-1960', 'elljen@yahoo.com', '07414277272', '10');
INSERT INTO CUSTOMER 
VALUES ('PR06', 'PROSPECT', 'Ali', 'Zeynab', 'F', '08-JUL-1987', 'zeynabali@gmail.com', '07413734348', '11');
INSERT INTO CUSTOMER 
VALUES ('LR06', 'LANDLORD', 'Nicol', 'James', 'M', '16-SEP-1994', 'nicoljames@outlook.com', '07710306751', '12');
INSERT INTO CUSTOMER 
VALUES ('PR07', 'PROSPECT', 'Koye', 'Susaanna',  'F', '26-DEC-1970', 'susankoye@yahoo.com', '07914696697', '13');
INSERT INTO CUSTOMER 
VALUES ('PR08', 'PROSPECT', 'Musa', 'Safiya', 'F', '15-JAN-1960', 'musaf@gmail.com', '07814878484', '14');
INSERT INTO CUSTOMER 
VALUES ('PR09', 'PROSPECT', 'Rushil', 'Panwar', 'M', '06-APR-1994', 'rushpar@yahoo.com', '07807311210', '15');
INSERT INTO CUSTOMER 
VALUES ('PR10', 'PROSPECT', 'Poonur', 'Sreesh', 'M', '14-FEB-2000', NULL, '02079460383', '16');



INSERT INTO PROPERTY 
VALUES ('P01', 'Flat', '17', '0.2 miles from Gilesgate Primary School', 1, 500, 'Fully Furnished studio flat for rent', '15-MAR-2019', 487, 'Double room', 'LR04');
INSERT INTO PROPERTY 
VALUES ('P02', 'Semi-detached', '18', 'Situated in the heart of Jesmond Dene', 4, 3000, 'Unfurnished home with gas central heating', '10-JUN-2020', 159000, 'A master bedroom and three double rooms', 'LR01');
INSERT INTO PROPERTY 
VALUES ('P03', 'Detached', '19', 'Centre of the city', 6, 6534, 'Partly Furnished house with a lovely garden, fenced by cast iron fence', '15-JUN-2020', 250000, 'Five ensuite bedrooms', 'LR06');
INSERT INTO PROPERTY 
VALUES ('P04', 'Semi-detached', '20', 'Within the heart of Brandling Village Conservation Area', 3, 4000, 'Partly Furnished three bed house with a front lawn perfect for a family', '15-JUN-2020', 175600, 'Remodelled and refurbished rooms with bespoke cabinetry, handmade carpets and beautiful lighting', 'LR02');
INSERT INTO PROPERTY 
VALUES ('P05', 'End of Terrace', '21', '1.8 miles from Sunderland City Centre', 3, 2300, 'Fully Furnished terraced house for rent situated in the calms of Sunderland', '10-JUL-2019',  1275, 'All rooms have fitted wardrobes, double glazed window to the front, radiator and coved cornicing to ceiling', 'LR03');
INSERT INTO PROPERTY 
VALUES ('P06', 'Terraced', '22', '3 miles away from Durham City Centre', 3, 2500, 'Externally the property is accessed via a private road and has a drive offering off-street parking for multiple vehicles, along with wrap around gardens; making it ideal for entertaining during those warm summer nights.', '09-AUG-2020', 130000, 'Main bedroom is an ensuite shower room and others are double rooms with a shared bathroom', 'LR05');
INSERT INTO PROPERTY 
VALUES ('P07', 'Semi-detached', '23', '0.2 miles from West Jesmond Metro Station', 3, 3500, 'The most impressive detached period family home enjoys a corner site within mature gardens and will make a wonderful home with both regional and national buyers', '30-MAR-2019', 188999, 'Master Bedroom and two single rooms.', 'LR01');
INSERT INTO PROPERTY 
VALUES ('P08', 'Cottage', '24', 'Close to Romford Nursery School', 2, 1200, 'The Cottage has beautiful interior decoration, with lovely lighting and the carpets and furnishings all having been replaced in recent times.', '06-JAN-2019', 74950, 'Double rooms', 'LR03');
INSERT INTO PROPERTY 
VALUES ('P09', 'Bungalow', '25', 'Centered around Watergate Park', 3, 1990, 'This bespoke self-build, family home occupies a generous garden site, with parking for several vehicles and also offers an integral double garage with electric door.', '09-SEP-2019', 2669, 'Double glazed and gas heated double rooms', 'LR06');
INSERT INTO PROPERTY 
VALUES ('P10', 'Flat', '26', '3 miles away from Wyndham Primary School', 2, 3000, 'The accommodation comprises of an entrance hallway with stairs leading to first floor landing with useful storage cupboard, lounge, kitchen, two double bedrooms and bathroom. Externally there are gardens to front and rear.', '05-NOV-2018', 3300, NULL, 'LR03');



INSERT INTO ESTATE_AGENT 
VALUES ('EA1', 'Broydon', '27', 'info@broydon.co.uk', '01914877787', 'B01', 'www.broydon.co.uk');
INSERT INTO ESTATE_AGENT 
VALUES ('EA2', 'Surelets', '28', 'info@surelets.co.uk', '01915103573', 'B04', 'www.surelets.co.uk');
INSERT INTO ESTATE_AGENT 
VALUES ('EA3', 'Righthomes', '29', 'info@righthomes.co.uk', '01913007776', 'BO6', 'www.righthomes.com');
INSERT INTO ESTATE_AGENT 
VALUES ('EA4', 'Reina', '30', 'info@reina.co.uk', '01914878245', 'B07', 'www.reina.co.uk');
INSERT INTO ESTATE_AGENT 
VALUES ('EA5', 'Mortar', '31', 'info@mortar.co.uk', '01661853110', 'B10', 'www.mortar.co.uk');



INSERT INTO BRANCH
VALUES ('B01', '32', 'branch_a@broydon.co.uk', '01632960384', NULL, 'EA1');
INSERT INTO BRANCH
VALUES ('B04', '33', 'branch_b@surelets.co.uk', '03069990728', 'S003', 'EA2');
INSERT INTO BRANCH
VALUES ('B06', '34', 'branch_b@righthomes.co.uk', '01314960168', 'S005', 'EA3');
INSERT INTO BRANCH
VALUES ('B07', '35', 'branch_a@reina.co.uk', '01414960675', 'S008', 'EA4');
INSERT INTO BRANCH
VALUES ('B10', '36', 'branch_b@mortar.co.uk', '01174960309', 'S010', 'EA5');
INSERT INTO BRANCH
VALUES ('B02', '37', 'branch_b@broydon.co.uk', '01414960220', 'S002', 'EA1');
INSERT INTO BRANCH
VALUES ('B03', '38', 'branch_a@surelets.co.uk', '01174960287', 'S004', 'EA2');
INSERT INTO BRANCH
VALUES ('B05', '39', 'branch_a@righthomes.co.uk', '01314960258', 'S007', 'EA3');
INSERT INTO BRANCH
VALUES ('B08', '40', 'branch_b@reina.co.uk', '01414960166', NULL, 'EA4');
INSERT INTO BRANCH
VALUES ('B09', '41', 'branch_a@mortar.co.uk', '01914980944', 'S006', 'EA5');



INSERT INTO STAFF
VALUES ('S001', 'Francis', 'Paige', 'paigef@broydon.co.uk', '07700900715', '42', 'M', 'F', 'B01');
INSERT INTO STAFF
VALUES ('S009', 'Bridge', 'Bob', 'bobbridge@reina.co.uk', '07700900473', '43', 'D', 'O', 'B08');
INSERT INTO STAFF
VALUES ('S003', 'Zain', 'Austin', 'zaustin@surelets.co.uk', '07700900222', '44', 'S', 'M', 'B04');
INSERT INTO STAFF
VALUES ('S002', 'Asher', 'Ene', 'eneash@broydon.co.uk', '07300900915', '45', 'W', 'F', 'B02');
INSERT INTO STAFF
VALUES ('S004', 'Yunus', 'Babatunde', 'yunus_baba@surelets.co.uk', '07807900813', '46', 'S', 'M', 'B03');
INSERT INTO STAFF
VALUES ('S005', 'Sean', 'Kingston', 's_kingston@righthomes.co.uk', '07700900559', '47', 'D', 'M', 'B06');
INSERT INTO STAFF
VALUES ('S006', 'Deon', 'Lena', 'deonlina@mortar.co.uk', '07700900417', '48', 'M', 'F', 'B09');
INSERT INTO STAFF
VALUES ('S007', 'Shane', 'Mercy', 'mercyshane@righthomes.co.uk', '07700900680', '49', 'S', 'O', 'B05');
INSERT INTO STAFF
VALUES ('S008', 'Ryan', 'Destiny', 'rd@reina.co.uk', '01134960250', '50', 'W', 'F', 'B07');
INSERT INTO STAFF
VALUES ('S010', 'Gabriel', 'Brown', 'browngabriel@mortar.co.uk', '07700900639', '51', 'S', 'M', 'B10');



INSERT INTO VIEW_
VALUES ('V001', '14:00', '09-JUN-2020', 'The second room is a little too small', 'A', 'PR04', 'P05');
INSERT INTO VIEW_
VALUES ('V002', '09:30', '30-JAN-2019', 'The price for the flat is outrageous', 'A', 'PR09', 'P10');
INSERT INTO VIEW_
VALUES ('V003', '16:00', '15-JUN-2020', NULL, 'C', 'PR05', 'P02');
INSERT INTO VIEW_
VALUES ('V004', '13:45', '08-JUL-2020', NULL, 'P', 'PR06', 'P04');
INSERT INTO VIEW_
VALUES ('V005', '10:00', '17-JUN-2019', 'Perfect for me as a student', 'A', 'PR01', 'P01');
INSERT INTO VIEW_
VALUES ('V006', '11:30', '20-JUN-2020', 'I wish the house was fully furnished', 'A', 'PR07', 'P03');
INSERT INTO VIEW_
VALUES ('V007', '09:00', '06-MAR-2020', 'Lovely cottage, cannot wait to move in', 'A', 'PR02', 'P08');
INSERT INTO VIEW_
VALUES ('V008', '17:30', '08-AUG-2019', 'Its not what we expected, we will not be taking the place', 'A', 'PR10', 'P07');
INSERT INTO VIEW_
VALUES ('V009', '14:45', '09-JUL-2020', NULL, 'C', 'PR06', 'P04');
INSERT INTO VIEW_
VALUES ('V010', '09:00', '10-DEC-2019', NULL, 'P', 'PR10','PO9');



INSERT INTO PROPERTY_SALE
VALUES ('188999', '3779', '2362', '04-SEP-2021', 'PR02', 'P07');
INSERT INTO PROPERTY_SALE
VALUES ('159000', '3180', '1987', '15-JUL-2019', 'PR01', 'P02');
INSERT INTO PROPERTY_SALE
VALUES ('250000', '5000', '3125', '23-FEB-2020', 'PR05', 'P03');
INSERT INTO PROPERTY_SALE
VALUES ('175600', '3512', '2915', '13-MAY-2019', 'PR07', 'P04');
INSERT INTO PROPERTY_SALE
VALUES ('130000', '2600', '1625', '18-JUN-2018', 'PR06', 'P06');



INSERT INTO PROPERTY_RENTAL
VALUES ('74950', '37475', '936', '14-FEB-2019', '14-FEB-2021', 'P08', 'LR03', 'PR03');
INSERT INTO PROPERTY_RENTAL
VALUES ('3300', '1650', '41', '30-AUG-2019', '30-JUL-2021', 'P10', 'LR03', 'PR04');
INSERT INTO PROPERTY_RENTAL
VALUES ('2669', '1334', '33', '06-MAR-2020', '06-SEP-2020', 'P09', 'LR06', 'PR06');
INSERT INTO PROPERTY_RENTAL
VALUES ('1275', '637.5', '16', '05-JAN-2018', '05-OCT-2021', 'P05', 'LR02', 'PR08');
INSERT INTO PROPERTY_RENTAL
VALUES ('487', '244', '6', '20-OCT-2021', '20-SEP-2022', 'P01', 'LR04', 'PR10');



INSERT INTO MARKETS
VALUES ('P01', 'EA2');
INSERT INTO MARKETS
VALUES ('P02', 'EA4');
INSERT INTO MARKETS
VALUES ('P03', 'EA1');
INSERT INTO MARKETS
VALUES ('P04', 'EA2');
INSERT INTO MARKETS
VALUES ('P05', 'EA5');
INSERT INTO MARKETS
VALUES ('P06', 'EA5');
INSERT INTO MARKETS
VALUES ('P08', 'EA1');
INSERT INTO MARKETS
VALUES ('P10', 'EA1');



SELECT * FROM PROPERTY
  INNER JOIN ADDRESS ON PROPERTY.ADDRESS_ID = ADDRESS.A_ID
  WHERE (PROPERTY.REGISTERED_DATE BETWEEN '09-JUN-2020' AND '23-JUN-2020')
  AND (PROPERTY.TYPE = 'Semi-detached')
  AND (PROPERTY.NO_OF_ROOMS >= '3')
  AND (ADDRESS.AREA = 'Jesmond');
  
  
  
  SELECT PROPERTY.P_ID as ID, PROPERTY.Type, PROPERTY.Price, PROPERTY.No_of_Rooms as Rooms, Address.Area, PROPERTY.LrCode as Landlord, Property.Registered_date as RDate FROM PROPERTY, ADDRESS
  WHERE PROPERTY.ADDRESS_ID = ADDRESS.A_ID
  AND (PROPERTY.REGISTERED_DATE BETWEEN '09-JUN-2020' AND '23-JUN-2020')
  AND (PROPERTY.TYPE = 'Semi-detached')
  AND (PROPERTY.NO_OF_ROOMS >= '3')
  AND (ADDRESS.AREA = 'Jesmond');
  
  
  
SELECT * FROM PROPERTY_SALE
INNER JOIN PROPERTY ON PROPERTY.P_ID = PROPERTY_SALE.PRID
INNER JOIN ADDRESS ON PROPERTY.ADDRESS_ID = ADDRESS.A_ID
WHERE (PROPERTY_SALE.DATE_SOLD BETWEEN '01-JAN-2019' AND '31-DEC-2020')
  AND (PROPERTY_SALE.SELLING_PRICE between 157000 and 279000)
  AND (ADDRESS.CITY IN ('Newcastle Upon Tyne', 'Sunderland', 'Gateshead', 'Durham'));


SELECT PROPERTY_SALE.PRID as Property, ADDRESS.City, PROPERTY_SALE.Date_Sold, PROPERTY_SALE.Selling_Price as Price, PROPERTY_SALE.Stamp_Duty as SD, PROPERTY_SALE.Commission,  PROPERTY_SALE.Buyer_Code as Buyer FROM PROPERTY_SALE, Property, Address
Where PROPERTY.P_ID = PROPERTY_SALE.PRID
AND PROPERTY.ADDRESS_ID = ADDRESS.A_ID
AND (PROPERTY_SALE.DATE_SOLD BETWEEN '01-JAN-2019' AND '31-DEC-2020')
AND (PROPERTY_SALE.SELLING_PRICE between 157000 and 279000)
AND (ADDRESS.CITY IN ('Newcastle Upon Tyne', 'Sunderland', 'Gateshead', 'Durham'));
  
  

CREATE TYPE Address_t as Object (
House_No Varchar(4),
Street_Name Varchar(25),
Area Varchar(25),
City Varchar(20),
Post_Code Varchar(10));
/


CREATE TYPE Properties as Object (
P_ID Char(3),
Type Varchar(20),
Address Address_t,
Location Varchar(60),
No_of_Rooms Number(2),
Size_in_sqft Number(6),
Description Varchar(300),
Registered_date Date,
Price Number(15),
Desc_of_Rooms Varchar(150),
LrCode Char(4))
/

CREATE TYPE Properties_ref_t as Object (PropertiesRef REF Properties) 
/

CREATE TYPE Properties_set_t as Table of Properties_ref_t
/

CREATE TABLE Properties_tab of Properties (Primary key (P_ID))
/

CREATE TYPE EA_Markets_t as Object (
Name Varchar(20),
Reg_Address_ID Address_t,
Email Varchar(30),
Phone_No Char(11),
Headquarters Char(5),
Website Varchar(30),
Properties Properties_set_t);
/

CREATE TABLE EA_Markets of EA_Markets_t (Primary Key (Name))
Nested Table Properties store as EA_Markets_Properties
/



INSERT INTO Properties_tab
VALUES ('P01', 'Flat', Address_t('39', 'Pilgrims Way', 'Gilesgate', 'Durham', 'DH1 1HB'), '0.2 miles from Gilesgate Primary School', 1, 500, 'Fully Furnished studio flat for rent', '15-MAR-2019', 487, 'Double room', 'LR04');
INSERT INTO Properties_tab
VALUES ('P04', 'Semi-detached', Address_t('15', 'Princess Mary Court', 'Jesmond', 'Newcastle Upon Tyne', 'NE2 3BG'), 'Within the heart of Brandling Village Conservation Area', 3, 4000, 'Partly Furnished three bed house with a front lawn perfect for a family', '15-JUN-2020', 175600, 'Remodelled and refurbished rooms with bespoke cabinetry, handmade carpets and beautiful lighting', 'LR02');
INSERT INTO Properties_tab
VALUES ('P05', 'End of Terrace', Address_t('171', 'Jennifer Avenue', 'Castletown', 'Sunderland', 'SR5 3BD'), '1.8 miles from Sunderland City Centre', 3, 2300, 'Fully Furnished terraced house for rent situated in the calms of Sunderland', '10-JUL-2019',  1275, 'All rooms have fitted wardrobes, double glazed window to the front, radiator and coved cornicing to ceiling', 'LR03');
INSERT INTO Properties_tab
VALUES('P09', 'Bungalow', Address_t('99', 'Elmwood Gardens', 'Lobley Hill', 'Gateshead', 'NE11 0BX'), 'Centered around Watergate Park', 3, 1990, 'This bespoke self-build, family home occupies a generous garden site, with parking for several vehicles and also offers an integral double garage with electric door.', '09-SEP-2019', 2669, 'Double glazed and gas heated double rooms', 'LR06');
INSERT INTO Properties_tab
VALUES ('P10', 'Flat', Address_t('32', 'Montagu Court', 'Gosforth', 'Newcastle Upon Tyne', 'NE3 4JL'), '3 miles away from Wyndham Primary School', 2, 3000, 'The accommodation comprises of an entrance hallway with stairs leading to first floor landing with useful storage cupboard, lounge, kitchen, two double bedrooms and bathroom. Externally there are gardens to front and rear.', '05-NOV-2018', 3300, NULL, 'LR03');


INSERT INTO EA_Markets
VALUES ('Broydon', Address_t(NULL, 'Mayfair House', 'Westerhope', 'Newcastle Upon Tyne', 'NE5 1NB'), 'info@broydon.co.uk', '01914877787', 'B01', 'www.broydon.co.uk', Properties_set_t());
INSERT INTO EA_Markets
VALUES ('Surelets', Address_t('309', 'Ryhope Road', 'Ashbrooke', 'Sunderland', 'SR2 9SS'), 'info@surelets.co.uk', '01915103573', 'B04', 'www.surelets.co.uk', Properties_set_t());
INSERT INTO EA_Markets
VALUES ('Righthomes', Address_t('22', 'Ushaw Villas', 'Ushaw Moor', 'Durham', 'DH7 7PU'), 'info@righthomes.co.uk', '01913007776', 'BO6', 'www.righthomes.com', Properties_set_t());
INSERT INTO EA_Markets
VALUES ('Reina', Address_t('16', 'Wynbury Road', 'Low Fell', 'Gateshead', 'NE9 6TS'), 'info@reina.co.uk', '01914878245', 'B07', 'www.reina.co.uk', Properties_set_t());
INSERT INTO EA_Markets
VALUES ('Mortar', Address_t(NULL, NULL, 'South Houghton', 'Newcastle Upon Tyne', 'NE15 0EZ'), 'info@mortar.co.uk', '01661853110', 'B10', 'www.mortar.co.uk', Properties_set_t());


INSERT INTO TABLE (SELECT E.Properties FROM EA_Markets E WHERE E.Name='Broydon')
SELECT REF(p) FROM Properties_tab p WHERE p.P_ID in ('P10', 'P04');
INSERT INTO TABLE (SELECT E.Properties FROM EA_Markets E WHERE E.Name='Surelets')
SELECT REF(p) FROM Properties_tab p WHERE p.P_ID in ('P01', 'P04', 'P09');
INSERT INTO TABLE (SELECT E.Properties FROM EA_Markets E WHERE E.Name='Righthomes')
SELECT REF(p) FROM Properties_tab p WHERE p.P_ID in ('P09', 'P05');
INSERT INTO TABLE (SELECT E.Properties FROM EA_Markets E WHERE E.Name='Reina')
SELECT REF(p) FROM Properties_tab p WHERE p.P_ID in ('P10', 'P05', 'P10');
INSERT INTO TABLE (SELECT E.Properties FROM EA_Markets E WHERE E.Name='Mortar')
SELECT REF(p) FROM Properties_tab p WHERE p.P_ID in ('P01', 'P05');



SELECT E.Name, DEREF(P.PropertiesRef)
FROM EA_Markets E, TABLE (E.Properties) P
WHERE E.Name = 'Reina'
/

1.
SELECT P.P_ID as ID, P.Type, P.Registered_Date as R_Date, P.LrCode as Landlord, E.Name as Marketed_by, E.Website
FROM EA_Markets E, TABLE (E.Properties) P
WHERE P.P_ID = 'P04'
/

SELECT P.PropertiesRef.P_ID "ID", P.PropertiesRef.Type "Type", P.PropertiesRef.Registered_Date "R_Date", P.PropertiesRef.LrCode "Landlord", E.Name "Marketed_by", E.Website
FROM EA_Markets E, TABLE (E.Properties) P
WHERE P.PropertiesRef.P_ID IN ('P04', 'P05')
/

SELECT E.Name, E.Website, P.PropertiesRef.P_ID "ID", P.PropertiesRef.Type "Type", P.PropertiesRef.Registered_Date "R_Date", P.PropertiesRef.LrCode "Landlord"
FROM EA_Markets E, TABLE (E.Properties) P
WHERE P.PropertiesRef.P_ID IN ('P04', 'P05')
/

SELECT E.Name, 
CURSOR( SELECT DEREF(PropertiesRef) FROM TABLE (E.Properties) )
FROM EA_Markets E
WHERE E.Name IN ('Mortar', 'Righthomes')
/

SELECT E.Name, E.Website
CURSOR( SELECT DEREF(PropertiesRef) FROM TABLE (E.Properties) )
FROM EA_Markets E
WHERE E.Name IN ('Mortar', 'Righthomes')
/

SELECT E.Name, E.Website, P.PropertiesRef.P_ID "Property", P.PropertiesRef.Type "Type", P.PropertiesRef.Address "Address" 
FROM EA_Markets E, TABLE (E.Properties) P
WHERE P.PropertiesRef.Type IN ('Flat', 'Semi-detached') 
/



