 Create DATABASE PregnancySystem;
 USE PregnancySystem
 Create Table Medication(
    ID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100),
    Dose NVARCHAR(50),
    s_date DATE,
    e_date DATE
 );
 CREATE TABLE Schedule (
    ID INT PRIMARY KEY IDENTITY(1,1),
    Time TIME,
    Pattern NVARCHAR(50), 
    Status NVARCHAR(50)
);
CREATE TABLE Medication_Intake (
    ID INT PRIMARY KEY IDENTITY(1,1),
    Intake_DateTime DATETIME,
    Intake_Status NVARCHAR(50), 
    Recorded_At DATETIME DEFAULT GETDATE(),
    Schedule_ID INT,

    FOREIGN KEY (Schedule_ID) REFERENCES Schedule(ID)
);
go
CREATE TABLE Medication_Schedule (
    Medication_ID INT,
    Schedule_ID INT,

    PRIMARY KEY (Medication_ID, Schedule_ID),

    FOREIGN KEY (Medication_ID) REFERENCES Medication(ID),
    FOREIGN KEY (Schedule_ID) REFERENCES Schedule(ID)
);
CREATE TABLE ChronicDiseases (
    disease_id INT PRIMARY KEY IDENTITY(1,1),
    disease_name NVARCHAR(100) NOT NULL,
    diagnosis_date DATE,
    status NVARCHAR(50),
    notes NVARCHAR(MAX)
);

