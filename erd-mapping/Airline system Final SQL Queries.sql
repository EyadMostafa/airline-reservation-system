use final_database;

-- 1. Define tables
CREATE TABLE `User` (
    UserID INT AUTO_INCREMENT PRIMARY KEY,
    Fname VARCHAR(50),
    Lname VARCHAR(50),
    Email VARCHAR(100),
    Password VARCHAR(50)
);

CREATE TABLE `Passenger` (
    PassengerID INT AUTO_INCREMENT PRIMARY KEY,
    PassportNum VARCHAR(20),
    Fname VARCHAR(50),
    Lname VARCHAR(50),
    DOB DATE,
    Gender CHAR(1),
    Nationality VARCHAR(50)
);

CREATE TABLE `Airline` ( 
  AirlineID INT AUTO_INCREMENT PRIMARY KEY,
  AirlineName VARCHAR(100) );

CREATE TABLE `Airport` (
    AirportCode VARCHAR(3) PRIMARY KEY,
    AirportName VARCHAR(100),
    City VARCHAR(50),
    Country VARCHAR(50),
    TimeZone VARCHAR(10)
);

CREATE TABLE `AircraftType` ( 
  AircraftTypeID INT AUTO_INCREMENT PRIMARY KEY,
  TypeName VARCHAR(50),
  Description TEXT 
);

CREATE TABLE `Crew` (
    CrewID INT AUTO_INCREMENT PRIMARY KEY,
    Fname VARCHAR(50),
    Lname VARCHAR(50),
    Role VARCHAR(50),
    LicenseNumber VARCHAR(50),
    YearsOfExperience INT,
    JoinDate DATE
);

CREATE TABLE `Shift` ( 
  ShiftID INT AUTO_INCREMENT PRIMARY KEY,
  StartDate DATE,
  EndDate DATE,
  StartTime TIME, 
  EndTime TIME,
  Type VARCHAR(20) 
);

CREATE TABLE `Qualification` (
  QualificationID INT AUTO_INCREMENT PRIMARY KEY,
  Title VARCHAR(100),
  IssuingBody VARCHAR(100), 
  ValidUntil DATE
);

CREATE TABLE `MealOption` (
  MealOptionID INT AUTO_INCREMENT PRIMARY KEY,
  Name VARCHAR(50),
  Type VARCHAR(20),
  Calories INT 
);

CREATE TABLE `InFlightEntertainment` ( 
  MediaID INT AUTO_INCREMENT PRIMARY KEY,
  Title VARCHAR(100),
  Type VARCHAR(50), 
  Duration TIME,
  Language VARCHAR(50)
);

CREATE TABLE `User_Phone` ( 
  UserID INT,
  Phone VARCHAR(20),
  PRIMARY KEY(UserID, Phone) 
);

CREATE TABLE `LoyaltyProgram` ( 
  UserID INT PRIMARY KEY,
  MilesBalance INT,
  TierLevel VARCHAR(20) );

CREATE TABLE `Terminal` (
  TerminalID INT AUTO_INCREMENT PRIMARY KEY,
  AirportCode VARCHAR(3),
  Name VARCHAR(50),
  Type VARCHAR(20) );

CREATE TABLE `Gate` (
  GateID INT AUTO_INCREMENT PRIMARY KEY,
  TerminalID INT,
  GateNumber VARCHAR(10) 
);

CREATE TABLE `Aircraft` (
  AircraftID INT AUTO_INCREMENT PRIMARY KEY,
  AircraftTypeID INT,
  TotalSeats INT 
);

CREATE TABLE `Seat` ( 
  SeatID INT AUTO_INCREMENT PRIMARY KEY,
  AircraftTypeID INT,
  SeatNumber VARCHAR(10),
  SeatClass VARCHAR(20) 
);

CREATE TABLE `AircraftType_Entertainment` (
  AircraftTypeID INT,
  MediaID INT,
  PRIMARY KEY(AircraftTypeID, MediaID)
);

CREATE TABLE `FlightRoute` ( 
  FlightRouteID INT AUTO_INCREMENT PRIMARY KEY,
  FlightNumber VARCHAR(10),
  OriginAirportCode VARCHAR(3),
  DestinationAirportCode VARCHAR(3),
  EstimatedDuration TIME 
);

CREATE TABLE `Flight` (
    FlightID INT AUTO_INCREMENT PRIMARY KEY,
    FlightRouteID INT,
    AircraftID INT,
    AirlineID INT,
    DepartureTime DATETIME,
    ArrivalTime DATETIME,
    FlightStatus VARCHAR(20)
);
CREATE TABLE `Flight_Gate` (
  FlightID INT,
  GateID INT,
  PRIMARY KEY(FlightID, GateID) 
);

CREATE TABLE `Flight_Crew` (
  FlightID INT, 
  CrewID INT, 
  PRIMARY KEY(FlightID, CrewID) 
);

CREATE TABLE `Booking` (
  BookingID INT AUTO_INCREMENT PRIMARY KEY,
  UserID INT,
  BookingStatus VARCHAR(20),
  TotalCost DECIMAL(10,2) 
);

CREATE TABLE `Payment` (
  PaymentID INT AUTO_INCREMENT PRIMARY KEY,
  BookingID INT,
  Amount DECIMAL(10,2),
  PaymentDate DATETIME,
  PaymentMethod VARCHAR(50),
  PaymentStatus VARCHAR(20), 
  TransactionID VARCHAR(50) 
);

CREATE TABLE `Ticket` ( 
  TicketID INT AUTO_INCREMENT PRIMARY KEY,
  TicketNumber VARCHAR(20),
  BookingID INT,
  PassengerID INT,
  FlightID INT, 
  SeatID INT, 
  Price DECIMAL(10,2),
  Status VARCHAR(20) 
);

CREATE TABLE `Baggage` ( 
  BaggageID INT AUTO_INCREMENT PRIMARY KEY,
  TicketID INT, 
  Weight DECIMAL(5,2),
  Type VARCHAR(20),
  Price DECIMAL(10,2) 
);

CREATE TABLE `Ticket_Meal` (
  TicketID INT,
  MealOptionID INT,
  PRIMARY KEY(TicketID, MealOptionID)
);

CREATE TABLE `Feedback` ( 
  FeedbackID INT AUTO_INCREMENT PRIMARY KEY,
  UserID INT,
  FlightID INT, 
  Rating INT,
  Comment TEXT 
);

CREATE TABLE `MaintenanceLog` ( 
  LogID INT AUTO_INCREMENT PRIMARY KEY,
  AircraftID INT,
  Description TEXT,
  StartDate DATETIME,
  EndDate DATETIME,
  MaintenanceStatus VARCHAR(20) 
);

CREATE TABLE `Refund` (
  RefundID INT AUTO_INCREMENT PRIMARY KEY, 
  TicketID INT, 
  Amount DECIMAL(10,2),
  Status VARCHAR(20),
  ProcessedAt DATETIME 
);

CREATE TABLE `Crew_Shift` (
  CrewID INT,
  ShiftID INT, 
  PRIMARY KEY(CrewID, ShiftID)
);

CREATE TABLE `Crew_Qualification` (
  CrewID INT,
  QualificationID INT,
  PRIMARY KEY(CrewID, QualificationID) 
);


-- 2. Data insertion

-- 1. Users
INSERT INTO `User` (`Fname`, `Lname`, `Email`, `Password`) VALUES
('Ahmed', 'Ali', 'ahmed.ali@example.com', 'pass123'),
('Sara', 'Mahmoud', 'sara.m@example.com', 'secure456'),
('John', 'Smith', 'john.smith@test.com', 'pass789'),
('Emily', 'Davis', 'emily.d@test.com', 'pass321'),
('Mohamed', 'Hassan', 'm.hassan@example.com', 'mo123'),
('Fatima', 'Yusuf', 'fatima.y@example.com', 'fati555'),
('Chris', 'Evans', 'c.evans@test.com', 'cap123'),
('Nour', 'Eldin', 'nour.e@example.com', 'nour999'),
('Jessica', 'Brown', 'j.brown@test.com', 'jess88'),
('Khaled', 'Amer', 'k.amer@example.com', 'khaled77');

-- 2. Passengers (Travelers)
INSERT INTO `Passenger` (`PassportNum`, `Fname`, `Lname`, `DOB`, `Gender`, `Nationality`) VALUES
('A12345678', 'Ahmed', 'Ali', '1990-05-15', 'M', 'Egyptian'),
('B98765432', 'Sara', 'Mahmoud', '1995-08-20', 'F', 'Egyptian'),
('C11223344', 'John', 'Smith', '1988-02-10', 'M', 'American'),
('D55667788', 'Emily', 'Davis', '1992-11-05', 'F', 'British'),
('E99887766', 'Mohamed', 'Hassan', '1985-03-25', 'M', 'Saudi'),
('F44332211', 'Fatima', 'Yusuf', '1998-07-12', 'F', 'Emirati'),
('G66554433', 'Chris', 'Evans', '1981-06-13', 'M', 'American'),
('H22334455', 'Nour', 'Eldin', '2000-01-01', 'F', 'Egyptian'),
('I77889900', 'Jessica', 'Brown', '1993-09-30', 'F', 'Canadian'),
('J00998877', 'Khaled', 'Amer', '1987-12-12', 'M', 'Jordanian');

-- 3. Airlines
INSERT INTO `Airline` (`AirlineName`) VALUES
('EgyptAir'), ('Emirates'), ('Qatar Airways'), ('Lufthansa'), ('British Airways'),
('Delta'), ('Air France'), ('Turkish Airlines'), ('Saudia'), ('Etihad');

-- 4. Airports
INSERT INTO `Airport` (`AirportCode`, `AirportName`, `City`, `Country`, `TimeZone`) VALUES
('CAI', 'Cairo International', 'Cairo', 'Egypt', 'GMT+2'),
('HBE', 'Borg El Arab', 'Alexandria', 'Egypt', 'GMT+2'),
('DXB', 'Dubai International', 'Dubai', 'UAE', 'GMT+4'),
('LHR', 'Heathrow', 'London', 'UK', 'GMT+0'),
('JFK', 'John F. Kennedy', 'New York', 'USA', 'GMT-5'),
('CDG', 'Charles de Gaulle', 'Paris', 'France', 'GMT+1'),
('IST', 'Istanbul Airport', 'Istanbul', 'Turkey', 'GMT+3'),
('JED', 'King Abdulaziz', 'Jeddah', 'Saudi Arabia', 'GMT+3'),
('FRA', 'Frankfurt Airport', 'Frankfurt', 'Germany', 'GMT+1'),
('HND', 'Haneda', 'Tokyo', 'Japan', 'GMT+9');

-- 5. Aircraft Types
INSERT INTO `AircraftType` (`TypeName`, `Description`) VALUES
('Boeing 737-800', 'Short to medium range narrow-body'),
('Boeing 777-300ER', 'Long range wide-body'),
('Airbus A320', 'Short to medium range narrow-body'),
('Airbus A380', 'Double-deck wide-body'),
('Boeing 787-9', 'Dreamliner, long haul'),
('Airbus A350-900', 'Long range wide-body'),
('Embraer E190', 'Regional jet'),
('Bombardier CRJ900', 'Regional airliner'),
('Airbus A330-300', 'Medium to long range wide-body'),
('Boeing 747-8', 'Jumbo jet');

-- 6. Crew
INSERT INTO `Crew` (`Fname`, `Lname`, `Role`, `LicenseNumber`, `YearsOfExperience`, `JoinDate`) VALUES
('Ali', 'Kamal', 'Pilot', 'LIC-1001', 15, '2010-01-01'),
('Mona', 'Said', 'Attendant', 'LIC-2001', 5, '2019-05-15'),
('Tarek', 'Omar', 'Pilot', 'LIC-1002', 10, '2015-03-10'),
('Heba', 'Fouad', 'Attendant', 'LIC-2002', 3, '2021-08-20'),
('James', 'Bond', 'Pilot', 'LIC-1003', 20, '2005-06-07'),
('Sarah', 'Connor', 'Co-Pilot', 'LIC-1004', 8, '2017-11-12'),
('Ellen', 'Ripley', 'Attendant', 'LIC-2003', 6, '2018-02-28'),
('Luke', 'Skywalker', 'Pilot', 'LIC-1005', 12, '2013-09-09'),
('Leia', 'Organa', 'Attendant', 'LIC-2004', 4, '2020-12-01'),
('Han', 'Solo', 'Co-Pilot', 'LIC-1006', 18, '2008-04-04');

-- 7. Shifts
INSERT INTO `Shift` (`StartDate`, `EndDate`, `StartTime`, `EndTime`, `Type`) VALUES
('2023-10-01', '2023-10-01', '06:00:00', '14:00:00', 'Morning'),
('2023-10-01', '2023-10-01', '14:00:00', '22:00:00', 'Afternoon'),
('2023-10-01', '2023-10-01', '22:00:00', '06:00:00', 'Night'),
('2023-10-02', '2023-10-02', '06:00:00', '14:00:00', 'Morning'),
('2023-10-02', '2023-10-02', '14:00:00', '22:00:00', 'Afternoon'),
('2023-10-03', '2023-10-03', '08:00:00', '16:00:00', 'Standard'),
('2023-10-03', '2023-10-03', '16:00:00', '00:00:00', 'Evening'),
('2023-10-04', '2023-10-04', '05:00:00', '13:00:00', 'Early'),
('2023-10-04', '2023-10-04', '13:00:00', '21:00:00', 'Late'),
('2023-10-05', '2023-10-05', '00:00:00', '08:00:00', 'RedEye');

-- 8. Qualifications
INSERT INTO `Qualification` (`Title`, `IssuingBody`, `ValidUntil`) VALUES
('ATPL', 'FAA', '2030-01-01'),
('Cabin Safety', 'EASA', '2025-05-01'),
('First Aid', 'Red Cross', '2024-12-31'),
('B737 Rating', 'Boeing', '2028-06-15'),
('A320 Rating', 'Airbus', '2028-07-20'),
('Customer Service', 'IATA', '2026-01-01'),
('Fire Safety', 'Civil Defense', '2025-03-10'),
('Cargo Handling', 'IATA', '2027-09-09'),
('CRM', 'FAA', '2026-11-11'),
('Wet Drill', 'EASA', '2025-02-28');

-- 9. Meal Options
INSERT INTO `MealOption` (`Name`, `Type`, `Calories`) VALUES
('Chicken Pasta', 'Non-Veg', 600),
('Beef Stew', 'Non-Veg', 700),
('Grilled Vegetables', 'Vegan', 400),
('Cheese Sandwich', 'Veg', 350),
('Fruit Platter', 'Vegan', 200),
('Fish Fillet', 'Non-Veg', 550),
('Omelette', 'Veg', 450),
('Gluten Free Pasta', 'Vegan', 400),
('Kids Meal', 'Non-Veg', 500),
('Kosher Meal', 'Special', 600);

-- 10. InFlight Entertainment
INSERT INTO `InFlightEntertainment` (`Title`, `Type`, `Duration`, `Language`) VALUES
('The Lion King', 'Movie', '01:58:00', 'English'),
('Inception', 'Movie', '02:28:00', 'English'),
('Blue Planet', 'Documentary', '00:50:00', 'English'),
('Top Hits 2023', 'Music', '01:00:00', 'Various'),
('Tetris', 'Game', NULL, 'N/A'),
('El Lembi', 'Movie', '01:45:00', 'Arabic'),
('Parasite', 'Movie', '02:12:00', 'Korean'),
('Chess', 'Game', NULL, 'N/A'),
('Jazz Classics', 'Music', '02:00:00', 'English'),
('Friends Season 1', 'TV Show', '00:22:00', 'English');

-- 11. User Phones
INSERT INTO `User_Phone` (`UserID`, `Phone`) VALUES
(1, '01012345678'), (1, '01298765432'),
(2, '01122334455'), (3, '123-456-7890'),
(4, '44-7700-900'), (5, '966-50-123'),
(6, '971-50-987'), (7, '555-0199'),
(8, '01555667788'), (9, '01099887766');

-- 12. Loyalty Program
INSERT INTO `LoyaltyProgram` (`UserID`, `MilesBalance`, `TierLevel`) VALUES
(1, 5000, 'Blue'), (2, 12000, 'Silver'),
(3, 50000, 'Gold'), (4, 1000, 'Blue'),
(5, 75000, 'Platinum'), (6, 2500, 'Blue'),
(7, 30000, 'Silver'), (8, 0, 'Blue'),
(9, 60000, 'Gold'), (10, 15000, 'Silver');

-- 13. Terminals
INSERT INTO `Terminal` (`AirportCode`, `Name`, `Type`) VALUES
('CAI', 'Terminal 3', 'International'),
('CAI', 'Terminal 1', 'Domestic'),
('HBE', 'Terminal 1', 'Mixed'),
('DXB', 'Terminal 3', 'International'),
('LHR', 'Terminal 5', 'International'),
('JFK', 'Terminal 4', 'International'),
('CDG', 'Terminal 2E', 'International'),
('IST', 'Main Terminal', 'International'),
('FRA', 'Terminal 1', 'International'),
('HND', 'Terminal 3', 'International');

-- 14. Gates (Linked to Terminals 1-10)
INSERT INTO `Gate` (`TerminalID`, `GateNumber`) VALUES
(1, 'G1'), (1, 'G2'), (2, 'D1'), (3, 'A1'),
(4, 'B12'), (5, 'C10'), (6, 'A4'), (7, 'K20'),
(8, 'F5'), (9, 'Z1');

-- 15. Aircraft (Linked to AircraftTypes)
INSERT INTO `Aircraft` (`AircraftTypeID`, `TotalSeats`) VALUES
(1, 160), (1, 160), (2, 350), (3, 180), (3, 180),
(4, 500), (5, 250), (6, 300), (7, 100), (8, 90);

-- 16. Seats (Linked to AircraftType 1 - B737)
INSERT INTO `Seat` (`AircraftTypeID`, `SeatNumber`, `SeatClass`) VALUES
(1, '1A', 'Business'), (1, '1B', 'Business'), (1, '1C', 'Business'), (1, '1D', 'Business'),
(1, '10A', 'Economy'), (1, '10B', 'Economy'), (1, '10C', 'Economy'),
(1, '11A', 'Economy'), (1, '11B', 'Economy'), (1, '11C', 'Economy');

-- 17. AircraftType_Entertainment
INSERT INTO `AircraftType_Entertainment` (`AircraftTypeID`, `MediaID`) VALUES
(1, 1), (1, 4), (2, 1), (2, 2), (2, 3),
(3, 4), (4, 1), (4, 2), (4, 5), (5, 1);

-- 18. Flight Routes
INSERT INTO `FlightRoute` (`FlightNumber`, `OriginAirportCode`, `DestinationAirportCode`, `EstimatedDuration`) VALUES
('MS800', 'CAI', 'CDG', '04:30:00'),
('MS985', 'CAI', 'JFK', '11:00:00'),
('EK924', 'CAI', 'DXB', '03:30:00'),
('BA155', 'LHR', 'CAI', '05:00:00'),
('SV301', 'JED', 'CAI', '02:00:00'),
('LH580', 'FRA', 'CAI', '04:00:00'),
('MS777', 'CAI', 'LHR', '05:15:00'),
('QR1302', 'HBE', 'DXB', '03:45:00'),
('TK690', 'IST', 'CAI', '02:15:00'),
('MS101', 'CAI', 'HBE', '00:45:00');

-- 19. Flights
-- (FlightRouteID 1-10, AircraftID 1-10, AirlineID 1-10)
INSERT INTO `Flight` (`FlightRouteID`, `AircraftID`, `AirlineID`, `DepartureTime`, `ArrivalTime`, `FlightStatus`) VALUES
(1, 1, 1, '2025-05-01 10:00:00', '2025-05-01 14:30:00', 'Scheduled'),
(2, 2, 1, '2025-05-02 08:00:00', '2025-05-02 19:00:00', 'Scheduled'),
(3, 3, 2, '2025-05-03 12:00:00', '2025-05-03 15:30:00', 'Delayed'),
(4, 4, 5, '2025-05-04 14:00:00', '2025-05-04 19:00:00', 'Scheduled'),
(5, 5, 9, '2025-05-05 09:00:00', '2025-05-05 11:00:00', 'Canceled'),
(6, 6, 4, '2025-05-06 16:00:00', '2025-05-06 20:00:00', 'Scheduled'),
(7, 1, 1, '2025-05-07 10:00:00', '2025-05-07 15:15:00', 'Scheduled'),
(8, 7, 3, '2025-05-08 05:00:00', '2025-05-08 08:45:00', 'Scheduled'),
(9, 8, 8, '2025-05-09 22:00:00', '2025-05-10 00:15:00', 'Scheduled'),
(10, 9, 1, '2025-05-10 07:00:00', '2025-05-10 07:45:00', 'Landed');

-- 20. Flight Gates (Associating Flights with Gates)
INSERT INTO `Flight_Gate` (`FlightID`, `GateID`) VALUES
(1, 1), (2, 1), (3, 4), (4, 5), (6, 9),
(7, 2), (8, 3), (9, 8), (10, 1), (5, 10);

-- 21. Flight Crew (Associating Flights with Crew)
INSERT INTO `Flight_Crew` (`FlightID`, `CrewID`) VALUES
(1, 1), (1, 2), (1, 6),
(2, 3), (2, 4),
(3, 5), (3, 7),
(4, 8), (4, 9),
(5, 10);

-- 22. Bookings
INSERT INTO `Booking` (`UserID`, `BookingStatus`, `TotalCost`) VALUES
(1, 'Confirmed', 500.00),
(1, 'Confirmed', 1200.00),
(2, 'Pending', 300.00),
(3, 'Confirmed', 800.00),
(4, 'Cancelled', 150.00),
(5, 'Confirmed', 450.00),
(6, 'Confirmed', 600.00),
(7, 'Confirmed', 200.00),
(8, 'Confirmed', 900.00),
(9, 'Confirmed', 1100.00);

-- 23. Payments
INSERT INTO `Payment` (`BookingID`, `Amount`, `PaymentDate`, `PaymentMethod`, `PaymentStatus`, `TransactionID`) VALUES
(1, 500.00, '2025-04-20 10:00:00', 'Credit Card', 'Completed', 'TXN1001'),
(2, 1200.00, '2025-04-21 11:00:00', 'Credit Card', 'Completed', 'TXN1002'),
(3, 300.00, '2025-04-22 12:00:00', 'PayPal', 'Pending', 'TXN1003'),
(4, 800.00, '2025-04-23 09:00:00', 'Debit Card', 'Completed', 'TXN1004'),
(5, 150.00, '2025-04-24 08:00:00', 'Credit Card', 'Refunded', 'TXN1005'),
(6, 450.00, '2025-04-25 14:00:00', 'Cash', 'Completed', 'TXN1006'),
(7, 600.00, '2025-04-26 15:00:00', 'Credit Card', 'Completed', 'TXN1007'),
(8, 200.00, '2025-04-27 16:00:00', 'Apple Pay', 'Completed', 'TXN1008'),
(9, 900.00, '2025-04-28 17:00:00', 'Credit Card', 'Completed', 'TXN1009'),
(10, 1100.00, '2025-04-29 18:00:00', 'PayPal', 'Completed', 'TXN1010');

-- 24. Tickets
INSERT INTO `Ticket` (`TicketNumber`, `BookingID`, `PassengerID`, `FlightID`, `SeatID`, `Price`, `Status`) VALUES
('TKT-001', 1, 1, 1, 1, 500.00, 'Active'),
('TKT-002', 2, 2, 2, 2, 1200.00, 'Active'),
('TKT-003', 3, 3, 3, 5, 300.00, 'Hold'),
('TKT-004', 4, 4, 4, 6, 800.00, 'Active'),
('TKT-005', 5, 5, 5, NULL, 150.00, 'Cancelled'),
('TKT-006', 6, 6, 6, 7, 450.00, 'Active'),
('TKT-007', 7, 7, 7, 8, 200.00, 'Active'),
('TKT-008', 8, 8, 8, NULL, 900.00, 'Active'),
('TKT-009', 9, 9, 9, NULL, 1100.00, 'Active'),
('TKT-010', 10, 10, 10, NULL, 150.00, 'Active');

-- 25. Baggage
INSERT INTO `Baggage` (`TicketID`, `Weight`, `Type`, `Price`) VALUES
(1, 23.00, 'Checked', 0.00),
(2, 30.00, 'Checked', 50.00),
(3, 15.00, 'Carry-on', 0.00),
(4, 23.00, 'Checked', 0.00),
(6, 20.00, 'Checked', 0.00),
(7, 10.00, 'Carry-on', 0.00),
(8, 25.00, 'Checked', 30.00),
(9, 32.00, 'Checked', 100.00),
(10, 8.00, 'Carry-on', 0.00),
(1, 23.00, 'Checked', 40.00); -- Extra bag for Ticket 1

-- 26. Ticket Meals (Junction)
INSERT INTO `Ticket_Meal` (`TicketID`, `MealOptionID`) VALUES
(1, 1), (2, 2), (3, 3), (4, 4),
(6, 6), (7, 7), (8, 9), (9, 10),
(1, 5), (2, 5);

-- 27. Feedback
INSERT INTO `Feedback` (`UserID`, `FlightID`, `Rating`, `Comment`) VALUES
(1, 1, 5, 'Great flight!'),
(2, 2, 4, 'Good service but food was cold'),
(3, 3, 2, 'Flight delayed too long'),
(4, 4, 5, 'Smooth landing'),
(6, 6, 3, 'Average experience'),
(7, 7, 5, 'Excellent crew'),
(8, 8, 4, 'Nice aircraft'),
(9, 9, 1, 'Lost my baggage'),
(10, 10, 5, 'Quick flight'),
(1, 7, 4, 'Return trip was good too');

-- 28. Maintenance Logs
INSERT INTO `MaintenanceLog` (`AircraftID`, `Description`, `StartDate`, `EndDate`, `MaintenanceStatus`) VALUES
(1, 'Routine Check A', '2025-01-01 00:00:00', '2025-01-01 04:00:00', 'Completed'),
(2, 'Engine Inspection', '2025-02-10 08:00:00', '2025-02-12 18:00:00', 'Completed'),
(3, 'Seat Repair', '2025-03-05 09:00:00', '2025-03-05 12:00:00', 'Completed'),
(4, 'Software Update', '2025-03-20 02:00:00', '2025-03-20 03:00:00', 'Completed'),
(5, 'Landing Gear Check', '2025-04-01 06:00:00', NULL, 'In Progress'),
(6, 'Cleaning', '2025-04-02 01:00:00', '2025-04-02 02:00:00', 'Completed'),
(7, 'Routine Check B', '2025-04-05 10:00:00', '2025-04-06 10:00:00', 'Completed'),
(8, 'Paint Touchup', '2025-04-10 08:00:00', '2025-04-10 16:00:00', 'Completed'),
(9, 'Sensor Replacement', '2025-04-15 12:00:00', '2025-04-15 14:00:00', 'Completed'),
(10, 'Tire Change', '2025-04-18 05:00:00', '2025-04-18 07:00:00', 'Completed');

-- 29. Refunds
INSERT INTO `Refund` (`TicketID`, `Amount`, `Status`, `ProcessedAt`) VALUES
(5, 150.00, 'Processed', '2025-04-24 10:00:00'),
(4, 50.00, 'Pending', NULL), -- Partial refund example
(3, 300.00, 'Rejected', '2025-04-22 14:00:00'),
(6, 20.00, 'Processed', '2025-04-26 09:00:00'),
(5, 10.00, 'Processed', '2025-04-24 11:00:00'),
(1, 0.00, 'Initiated', NULL),
(2, 1200.00, 'Pending', NULL),
(7, 200.00, 'Processed', '2025-04-27 10:00:00'),
(8, 50.00, 'Processed', '2025-04-28 11:00:00'),
(9, 100.00, 'Initiated', NULL);

-- 30. Crew_Shift (Junction)
INSERT INTO `Crew_Shift` (`CrewID`, `ShiftID`) VALUES
(1, 1), (2, 1), (3, 2), (4, 2), (5, 3),
(6, 3), (7, 4), (8, 4), (9, 5), (10, 5);

-- 31. Crew_Qualification (Junction)
INSERT INTO `Crew_Qualification` (`CrewID`, `QualificationID`) VALUES
(1, 1), (1, 4), (2, 2), (2, 3), (3, 1),
(4, 2), (5, 1), (5, 9), (6, 1), (7, 2);

-- 3. QUERIES

-- 1. Retrieve the full name and phone numbers of all users
SELECT u.Fname, u.Lname, up.Phone
FROM User u
JOIN User_Phone up ON u.UserID = up.UserID;

-- 2. Find all airports located in 'Egypt'
SELECT AirportName, City 
FROM Airport 
WHERE Country = 'Egypt';

-- 3. List the names of passengers who are 'American' or 'British'
SELECT Fname, Lname, Nationality 
FROM Passenger 
WHERE Nationality IN ('American', 'British');

-- 4. Count how many flights are operated by each Airline name
SELECT a.AirlineName, COUNT(f.FlightID) as FlightCount
FROM Airline a
LEFT JOIN Flight f ON a.AirlineID = f.AirlineID
GROUP BY a.AirlineName;

-- 5. Calculate the total revenue generated from 'Confirmed' bookings
SELECT SUM(TotalCost) as TotalConfirmedRevenue
FROM Booking
WHERE BookingStatus = 'Confirmed';

-- 6. Find the names of pilots who have more than 10 years of experience
SELECT Fname, Lname 
FROM Crew 
WHERE Role = 'Pilot' AND YearsOfExperience > 10;

-- 7. Retrieve all flights that are currently 'Delayed'
SELECT FlightRouteID, DepartureTime, FlightStatus 
FROM Flight 
WHERE FlightStatus = 'Delayed';

-- 8. List the average seat capacity for each Aircraft Type
SELECT at.TypeName, AVG(a.TotalSeats) as AvgCapacity
FROM AircraftType at
JOIN Aircraft a ON at.AircraftTypeID = a.AircraftTypeID
GROUP BY at.TypeName;

-- 9. Get the total number of tickets sold for the flight route 'MS800'
SELECT COUNT(t.TicketID) as TotalTickets
FROM Ticket t
JOIN Flight f ON t.FlightID = f.FlightID
JOIN FlightRoute fr ON f.FlightRouteID = fr.FlightRouteID
WHERE fr.FlightNumber = 'MS800';

-- 10. Find the top 3 users with the highest MilesBalance in the Loyalty Program
SELECT u.Fname, u.Lname, lp.MilesBalance
FROM User u
JOIN LoyaltyProgram lp ON u.UserID = lp.UserID
ORDER BY lp.MilesBalance DESC
LIMIT 3;

-- 11. List all meal options that are 'Vegan' and have less than 500 calories
SELECT Name, Calories 
FROM MealOption 
WHERE Type = 'Vegan' AND Calories < 500;

-- 12. Retrieve the names of crew members and the type of shift they are assigned to
SELECT c.Fname, c.Lname, s.Type as ShiftType
FROM Crew c
JOIN Crew_Shift cs ON c.CrewID = cs.CrewID
JOIN Shift s ON cs.ShiftID = s.ShiftID;

-- 13. Find the total weight of baggage carried for Ticket ID 1
SELECT SUM(Weight) as TotalWeight
FROM Baggage
WHERE TicketID = 1;

-- 14. Identify which payment method is most frequently used
SELECT PaymentMethod, COUNT(*) as UsageCount
FROM Payment
GROUP BY PaymentMethod
ORDER BY UsageCount DESC
LIMIT 1;

-- 15. List all aircraft IDs that have maintenance logs with an 'In Progress' status
SELECT DISTINCT AircraftID 
FROM MaintenanceLog 
WHERE MaintenanceStatus = 'In Progress';


-- 16. Rank passengers within each nationality by their ticket price
SELECT Nationality, Fname, Lname, Price,
       RANK() OVER (PARTITION BY Nationality ORDER BY Price DESC) as PriceRank
FROM Passenger p
JOIN Ticket t ON p.PassengerID = t.PassengerID;

-- 17. Use a CTE to find users whose total booking spend is higher than the average spend of all users
WITH UserSpend AS (
    SELECT UserID, SUM(TotalCost) as TotalAmount
    FROM Booking
    GROUP BY UserID
)
SELECT u.Fname, u.Lname, us.TotalAmount
FROM User u
JOIN UserSpend us ON u.UserID = us.UserID
WHERE us.TotalAmount > (SELECT AVG(TotalAmount) FROM UserSpend);

-- 18. Calculate the actual flight duration in hours/minutes for all 'Landed' flights
SELECT f.FlightID, fr.FlightNumber,
       TIMEDIFF(f.ArrivalTime, f.DepartureTime) as ActualDuration
FROM Flight f
JOIN FlightRoute fr ON f.FlightRouteID = fr.FlightRouteID
WHERE f.FlightStatus = 'Landed';

-- 19. Retrieve Passenger Name, Flight Number, Airline, and Gate Number for all 'Active' tickets
SELECT p.Fname, p.Lname, fr.FlightNumber, al.AirlineName, g.GateNumber
FROM Ticket t
JOIN Passenger p ON t.PassengerID = p.PassengerID
JOIN Flight f ON t.FlightID = f.FlightID
JOIN Airline al ON f.AirlineID = al.AirlineID
JOIN FlightRoute fr ON f.FlightRouteID = fr.FlightRouteID
JOIN Flight_Gate fg ON f.FlightID = fg.FlightID
JOIN Gate g ON fg.GateID = g.GateID
WHERE t.Status = 'Active';

-- 20. Show the number of 'Confirmed', 'Pending', and 'Cancelled' bookings for each User
SELECT UserID,
       SUM(CASE WHEN BookingStatus = 'Confirmed' THEN 1 ELSE 0 END) as ConfirmedCount,
       SUM(CASE WHEN BookingStatus = 'Pending' THEN 1 ELSE 0 END) as PendingCount,
       SUM(CASE WHEN BookingStatus = 'Cancelled' THEN 1 ELSE 0 END) as CancelledCount
FROM Booking
GROUP BY UserID;

-- 21. Calculate the running total of payment amounts ordered by the PaymentDate
SELECT PaymentDate, Amount,
       SUM(Amount) OVER (ORDER BY PaymentDate) as RunningTotal
FROM Payment;

-- 22. Find the names of crew members who possess the 'ATPL' qualification
SELECT Fname, Lname
FROM Crew
WHERE CrewID IN (
    SELECT CrewID FROM Crew_Qualification cq
    JOIN Qualification q ON cq.QualificationID = q.QualificationID
    WHERE q.Title = 'ATPL'
);

-- 23. Find the most popular destination city based on the total number of tickets sold
SELECT a.City, COUNT(t.TicketID) as TicketsSold
FROM FlightRoute fr
JOIN Airport a ON fr.DestinationAirportCode = a.AirportCode
JOIN Flight f ON fr.FlightRouteID = f.FlightRouteID
JOIN Ticket t ON f.FlightID = t.FlightID
GROUP BY a.City
ORDER BY TicketsSold DESC
LIMIT 1;

-- 24. Find all users who use a 'test.com' email domain
SELECT Fname, Lname, Email 
FROM User 
WHERE Email LIKE '%@test.com';

-- 25. Identify airlines that have zero 'Canceled' flights
SELECT AirlineName 
FROM Airline 
WHERE AirlineID NOT IN (
    SELECT AirlineID FROM Flight WHERE FlightStatus = 'Canceled'
);

-- 26. List all tickets that do not have an assigned seat ID
SELECT TicketNumber, PassengerID 
FROM Ticket 
WHERE SeatID IS NULL;

-- 27. Find the average rating for each Airline based on user feedback
SELECT al.AirlineName, AVG(fb.Rating) as AvgRating
FROM Feedback fb
JOIN Flight f ON fb.FlightID = f.FlightID
JOIN Airline al ON f.AirlineID = al.AirlineID
GROUP BY al.AirlineName;

-- 28. List all entertainment titles available specifically on 'Boeing 777-300ER' aircraft types
SELECT e.Title, e.Type
FROM InFlightEntertainment e
JOIN AircraftType_Entertainment ate ON e.MediaID = ate.MediaID
JOIN AircraftType at ON ate.AircraftTypeID = at.AircraftTypeID
WHERE at.TypeName = 'Boeing 777-300ER';

-- 29. Identify pairs of crew members who are assigned to the same Shift ID
SELECT a.CrewID as Crew1, b.CrewID as Crew2, a.ShiftID
FROM Crew_Shift a
JOIN Crew_Shift b ON a.ShiftID = b.ShiftID AND a.CrewID < b.CrewID;

-- 30. Find the most expensive ticket ever sold and the passenger who bought it
SELECT p.Fname, p.Lname, t.Price
FROM Ticket t
JOIN Passenger p ON t.PassengerID = p.PassengerID
WHERE t.Price = (SELECT MAX(Price) FROM Ticket);


-- 31. Calculate a 3-payment moving average of payment amounts
SELECT PaymentID, Amount,
       AVG(Amount) OVER (ORDER BY PaymentDate ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) as MovingAvg
FROM Payment;

-- 32. Identify users who are 'Blue' tier but have more miles than the average 'Silver' tier user
SELECT u.Fname, u.Lname, lp.MilesBalance
FROM User u
JOIN LoyaltyProgram lp ON u.UserID = lp.UserID
WHERE lp.TierLevel = 'Blue'
AND lp.MilesBalance > (
    SELECT AVG(MilesBalance) FROM LoyaltyProgram WHERE TierLevel = 'Silver'
);

-- 33. Calculate the percentage of total company revenue contributed by each Aircraft Type
SELECT at.TypeName, 
       SUM(t.Price) as TypeRevenue,
       (SUM(t.Price) / (SELECT SUM(Price) FROM Ticket) * 100) as RevenueContributionPercent
FROM AircraftType at
JOIN Aircraft a ON at.AircraftTypeID = a.AircraftTypeID
JOIN Flight f ON a.AircraftID = f.AircraftID
JOIN Ticket t ON f.FlightID = t.FlightID
GROUP BY at.TypeName;

-- 34. Identify the 'Busiest Hub': The origin airport that serves the most distinct airlines
SELECT OriginAirportCode, COUNT(DISTINCT AirlineID) as AirlineCount
FROM Flight f
JOIN FlightRoute fr ON f.FlightRouteID = fr.FlightRouteID
GROUP BY OriginAirportCode
ORDER BY AirlineCount DESC
LIMIT 1;

-- 35. Find Pilots assigned to a flight using an aircraft type they are NOT rated for
SELECT c.Fname, c.Lname, fr.FlightNumber, at.TypeName
FROM Crew c
JOIN Flight_Crew fc ON c.CrewID = fc.CrewID
JOIN Flight f ON fc.FlightID = f.FlightID
JOIN Aircraft a ON f.AircraftID = a.AircraftID
JOIN AircraftType at ON a.AircraftTypeID = at.AircraftTypeID
JOIN FlightRoute fr ON f.FlightRouteID = fr.FlightRouteID
WHERE c.Role = 'Pilot'
AND NOT EXISTS (
    SELECT 1 FROM Crew_Qualification cq
    JOIN Qualification q ON cq.QualificationID = q.QualificationID
    WHERE cq.CrewID = c.CrewID AND q.Title LIKE CONCAT('%', LEFT(at.TypeName, 4), '%')
);

-- 36. Find passengers who have flown with 'EgyptAir' more than once
SELECT p.Fname, p.Lname, COUNT(t.TicketID) as FlightCount
FROM Passenger p
JOIN Ticket t ON p.PassengerID = t.PassengerID
JOIN Flight f ON t.FlightID = f.FlightID
JOIN Airline al ON f.AirlineID = al.AirlineID
WHERE al.AirlineName = 'EgyptAir'
GROUP BY p.PassengerID, p.Fname, p.Lname
HAVING FlightCount > 1;

-- 37. Refund Ratio: For each airline, calculate (Total Refunded Amount / Total Ticket Sales
SELECT al.AirlineName,
       COALESCE(SUM(r.Amount), 0) / SUM(t.Price) as RefundToSalesRatio
FROM Airline al
JOIN Flight f ON al.AirlineID = f.AirlineID
JOIN Ticket t ON f.FlightID = t.FlightID
LEFT JOIN Refund r ON t.TicketID = r.TicketID
GROUP BY al.AirlineName;

-- 38. Load Factor: Calculate capacity utilization (Tickets Sold / Total Seats) for every flight
SELECT f.FlightID, fr.FlightNumber, 
       (COUNT(t.TicketID) * 100.0 / a.TotalSeats) as LoadFactorPercentage
FROM Flight f
JOIN FlightRoute fr ON f.FlightRouteID = fr.FlightRouteID
JOIN Aircraft a ON f.AircraftID = a.AircraftID
LEFT JOIN Ticket t ON f.FlightID = t.FlightID
GROUP BY f.FlightID, fr.FlightNumber, a.TotalSeats;

-- 39. Missing Shift Detection: Identify dates in the Shift table where a 'Night' shift is missing but other shifts exist
SELECT StartDate 
FROM Shift 
GROUP BY StartDate 
HAVING SUM(CASE WHEN Type = 'Night' THEN 1 ELSE 0 END) = 0;

-- 40. VIP Trigger: Find the specific FlightID that caused a user's Lifetime Spend to cross the 1000 threshold
WITH RunningSpend AS (
    SELECT b.UserID, t.FlightID, t.Price,
           SUM(t.Price) OVER (PARTITION BY b.UserID ORDER BY t.TicketID) as CumulativeSpend
    FROM Booking b
    JOIN Ticket t ON b.BookingID = t.BookingID
)
SELECT UserID, FlightID, CumulativeSpend
FROM (
    SELECT *, ROW_NUMBER() OVER (PARTITION BY UserID ORDER BY CumulativeSpend ASC) as rn
    FROM RunningSpend
    WHERE CumulativeSpend >= 1000
) t
WHERE rn = 1;


-- 41. This query identifies which flight routes generate the most money (Ticket Price + Baggage Fees) for each airline.
SELECT 
    a.AirlineName,
    CONCAT(fr.OriginAirportCode, ' -> ', fr.DestinationAirportCode) AS Route,
    COUNT(t.TicketID) AS TotalPassengers,
    SUM(t.Price) + COALESCE(SUM(b.Price), 0) AS TotalRevenue
FROM Airline a
JOIN Flight f ON a.AirlineID = f.AirlineID
JOIN FlightRoute fr ON f.FlightRouteID = fr.FlightRouteID
JOIN Ticket t ON f.FlightID = t.FlightID
LEFT JOIN Baggage b ON t.TicketID = b.TicketID
GROUP BY a.AirlineName, fr.OriginAirportCode, fr.DestinationAirportCode
ORDER BY TotalRevenue DESC;

-- 42. Rank passengers within each loyalty tier based on their miles balance.
SELECT 
    u.UserID,
    CONCAT(u.Fname, ' ', u.Lname) AS UserName,
    lp.TierLevel,
    lp.MilesBalance,
    -- Rank users 1, 2, 3... within their specific Tier
    DENSE_RANK() OVER (PARTITION BY lp.TierLevel ORDER BY lp.MilesBalance DESC) AS RankInTier
FROM User u
JOIN LoyaltyProgram lp ON u.UserID = lp.UserID
ORDER BY lp.TierLevel, RankInTier;

-- 43. Analyze which meal types are most popular on specific routes (e.g., Cairo to Paris) to optimize loading and reduce food waste.
SELECT 
    CONCAT(fr.OriginAirportCode, ' -> ', fr.DestinationAirportCode) AS Route,
    mo.Type AS MealType, -- e.g., Vegan, Non-Veg
    mo.Name AS MealName,
    COUNT(tm.TicketID) AS QuantityOrdered
FROM FlightRoute fr
JOIN Flight f ON fr.FlightRouteID = f.FlightRouteID
JOIN Ticket t ON f.FlightID = t.FlightID
JOIN Ticket_Meal tm ON t.TicketID = tm.TicketID
JOIN MealOption mo ON tm.MealOptionID = mo.MealOptionID
GROUP BY Route, mo.Type, mo.Name
ORDER BY Route, QuantityOrdered DESC;
-- 44. Revenue Efficiency by Aircraft Type
SELECT 
    act.TypeName,
    COUNT(DISTINCT f.FlightID) AS TotalFlightsFlown,
    SUM(t.Price) AS TotalRevenue,
    ROUND(SUM(t.Price) / COUNT(DISTINCT f.FlightID), 2) AS AvgRevenuePerFlight
FROM AircraftType act
JOIN Aircraft a ON act.AircraftTypeID = a.AircraftTypeID
JOIN Flight f ON a.AircraftID = f.AircraftID
JOIN Ticket t ON f.FlightID = t.FlightID
GROUP BY act.TypeName
ORDER BY AvgRevenuePerFlight DESC;

-- 45. Nationality Distribution by Destination
SELECT 
    fr.DestinationAirportCode AS Destination,
    p.Nationality,
    COUNT(p.PassengerID) AS PassengerCount,
    -- Calculate percentage share for that destination
    ROUND(
        COUNT(p.PassengerID) * 100.0 / 
        SUM(COUNT(p.PassengerID)) OVER (PARTITION BY fr.DestinationAirportCode), 
    2) AS PercentageShare
FROM FlightRoute fr
JOIN Flight f ON fr.FlightRouteID = f.FlightRouteID
JOIN Ticket t ON f.FlightID = t.FlightID
JOIN Passenger p ON t.PassengerID = p.PassengerID
GROUP BY fr.DestinationAirportCode, p.Nationality
ORDER BY Destination, PassengerCount DESC;

-- 46. Total Cargo & Baggage Weight Load
SELECT 
    fr.FlightNumber, -- Corrected column source
    f.DepartureTime,
    ac.TotalSeats,
    -- Calculate Baggage Weight
    COALESCE(SUM(b.Weight), 0) AS TotalBaggageWeight,
    -- Estimate Passenger Weight (Count * 75kg avg)
    (COUNT(DISTINCT t.TicketID) * 75) AS EstPassengerWeight,
    -- Grand Total
    (COALESCE(SUM(b.Weight), 0) + (COUNT(DISTINCT t.TicketID) * 75)) AS TotalPayloadKG
FROM Flight f
JOIN FlightRoute fr ON f.FlightRouteID = fr.FlightRouteID -- Added Join
JOIN Aircraft ac ON f.AircraftID = ac.AircraftID
JOIN Ticket t ON f.FlightID = t.FlightID
LEFT JOIN Baggage b ON t.TicketID = b.TicketID
WHERE b.Type = 'Checked' OR b.Type IS NULL -- Fixed logic to include passengers without bags if needed
GROUP BY f.FlightID, fr.FlightNumber, f.DepartureTime, ac.TotalSeats
ORDER BY TotalPayloadKG DESC;

-- 47. List crew members whose licenses or qualifications are expiring within the current year
SELECT 
    c.CrewID,
    CONCAT(c.Fname, ' ', c.Lname) AS CrewName,
    q.Title AS Qualification,
    q.ValidUntil,
    DATEDIFF(q.ValidUntil, CURDATE()) AS DaysRemaining
FROM Crew c
JOIN Crew_Qualification cq ON c.CrewID = cq.CrewID
JOIN Qualification q ON cq.QualificationID = q.QualificationID
WHERE YEAR(q.ValidUntil) = 2025 -- or YEAR(CURDATE())
ORDER BY q.ValidUntil ASC;

-- 48. Determine the percentage of special meals (Vegan, Veg, etc.) ordered versus standard meals.
SELECT 
    mo.Type AS DietType,
    COUNT(tm.TicketID) AS TotalOrdered,
    ROUND(
        COUNT(tm.TicketID) * 100.0 / (SELECT COUNT(*) FROM Ticket_Meal), 
    2) AS PercentageShare
FROM MealOption mo
JOIN Ticket_Meal tm ON mo.MealOptionID = tm.MealOptionID
GROUP BY mo.Type
ORDER BY TotalOrdered DESC;

-- 49. Most Profitable Routes per Hour
SELECT 
    fr.FlightNumber,
    CONCAT(fr.OriginAirportCode, ' - ', fr.DestinationAirportCode) AS Route,
    TIME_FORMAT(fr.EstimatedDuration, '%H:%i') AS Duration,
    SUM(t.Price) AS TotalRevenue,
    -- Formula: Revenue / (Duration in Hours * Flight Count)
    ROUND(
        SUM(t.Price) / 
        (COUNT(DISTINCT f.FlightID) * (HOUR(fr.EstimatedDuration) + MINUTE(fr.EstimatedDuration)/60.0)), 
    2) AS RevenuePerHour
FROM FlightRoute fr
JOIN Flight f ON fr.FlightRouteID = f.FlightRouteID
JOIN Ticket t ON f.FlightID = t.FlightID
GROUP BY fr.FlightNumber, Route, fr.EstimatedDuration;

-- Target Person: The Customer/User.
CREATE OR REPLACE VIEW View_Passenger_Dashboard AS
SELECT 
    u.UserID,
    CONCAT(u.Fname, ' ', u.Lname) AS PassengerName,
    b.BookingStatus,
    fr.FlightNumber,
    CONCAT(fr.OriginAirportCode, ' -> ', fr.DestinationAirportCode) AS Route,
    f.DepartureTime,
    f.FlightStatus,
    t.TicketNumber,
    s.SeatNumber,
    lp.TierLevel AS LoyaltyStatus
FROM User u
JOIN Booking b ON u.UserID = b.UserID
JOIN Ticket t ON b.BookingID = t.BookingID
JOIN Flight f ON t.FlightID = f.FlightID
JOIN FlightRoute fr ON f.FlightRouteID = fr.FlightRouteID
LEFT JOIN Seat s ON t.SeatID = s.SeatID
LEFT JOIN LoyaltyProgram lp ON u.UserID = lp.UserID;

SELECT * FROM View_Passenger_Dashboard;

-- Target Person: Pilots and Flight Attendants ( Crew ).
CREATE OR REPLACE VIEW View_Crew_Schedule AS
SELECT 
    c.CrewID,
    CONCAT(c.Fname, ' ', c.Lname) AS CrewMember,
    c.Role,
    f.DepartureTime,
    fr.FlightNumber,
    CONCAT(fr.OriginAirportCode, ' -> ', fr.DestinationAirportCode) AS Route,
    act.TypeName AS Aircraft,
    f.FlightStatus
FROM Crew c
JOIN Flight_Crew fc ON c.CrewID = fc.CrewID
JOIN Flight f ON fc.FlightID = f.FlightID
JOIN FlightRoute fr ON f.FlightRouteID = fr.FlightRouteID
JOIN Aircraft a ON f.AircraftID = a.AircraftID
JOIN AircraftType act ON a.AircraftTypeID = act.AircraftTypeID;

SELECT * FROM View_Crew_Schedule;
-- Target Person: Check-in Agents and Gate Agents
CREATE OR Replace VIEW View_Flight_Manifest AS
SELECT 
    f.FlightID,
    fr.FlightNumber,
    t.TicketNumber,
    p.PassportNum,
    CONCAT(p.Fname, ' ', p.Lname) AS PassengerName,
    p.Nationality,
    s.SeatNumber,
    s.SeatClass,
    COALESCE(mo.Name, 'Standard') AS MealPreference,
    COUNT(bg.BaggageID) AS BagsChecked,
    COALESCE(SUM(bg.Weight), 0) AS TotalBagWeight
FROM Flight f
JOIN FlightRoute fr ON f.FlightRouteID = fr.FlightRouteID
JOIN Ticket t ON f.FlightID = t.FlightID
JOIN Passenger p ON t.PassengerID = p.PassengerID
LEFT JOIN Seat s ON t.SeatID = s.SeatID
LEFT JOIN Ticket_Meal tm ON t.TicketID = tm.TicketID
LEFT JOIN MealOption mo ON tm.MealOptionID = mo.MealOptionID
LEFT JOIN Baggage bg ON t.TicketID = bg.TicketID
GROUP BY f.FlightID, fr.FlightNumber, t.TicketNumber, p.PassportNum, PassengerName, p.Nationality, s.SeatNumber, s.SeatClass, MealPreference;

SELECT * FROM View_Flight_Manifest;

