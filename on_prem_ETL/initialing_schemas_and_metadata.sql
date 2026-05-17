USE Se7tekDWH;

GO

CREATE SCHEMA Bronze;

GO

CREATE SCHEMA Silver;

GO

CREATE SCHEMA DWH;

GO 

CREATE SCHEMA MetaData;

GO 

CREATE TABLE Se7tekDWH.MetaData.LastModified (
    TableName NVARCHAR(255),
    LastModifiedDate DATE
);

GO

-------------------------------------------
USE Se7tek;

GO 

INSERT INTO Se7tekDWH.MetaData.LastModified (TableName, LastModifiedDate)
SELECT 
    name AS TableName,
    CAST('2000-01-01' AS DATE) AS LastModifiedDate
FROM sys.tables
WHERE name NOT LIKE 'sys%';

GO
CREATE TABLE Se7tekDWH.MetaData.LastLoad (
    TableName NVARCHAR(255),
    LastLoadDate DATE
);

GO

-------------------------------------------
USE Se7tek;

GO 

INSERT INTO Se7tekDWH.MetaData.LastLoad (TableName, LastLoadDate)
SELECT 
    name AS TableName,
    CAST('2000-01-01' AS DATE) AS LastLoadDate
FROM sys.tables
WHERE name NOT LIKE 'sys%';

GO

-------------------------
-- Create trigers to track table updates: 

-- 1. TRIGGER FOR Alert
CREATE OR ALTER TRIGGER trg_Alert_UpdateModified
ON Se7tek.dbo.Alert
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;
    
    IF EXISTS (SELECT 1 FROM inserted)
    BEGIN
        INSERT INTO Se7tekDWH.MetaData.LastModified (TableName, RecordID, LastModifiedDate)
        SELECT 'Alert', CAST(alert_id AS NVARCHAR(100)), GETDATE() FROM inserted;
    END
    IF EXISTS (SELECT 1 FROM deleted) AND NOT EXISTS (SELECT 1 FROM inserted)
    BEGIN
        INSERT INTO Se7tekDWH.MetaData.LastModified (TableName, RecordID, LastModifiedDate)
        SELECT 'Alert', CAST(alert_id AS NVARCHAR(100)), GETDATE() FROM deleted;
    END
END;
GO

-- 2. TRIGGER FOR Appointment
CREATE OR ALTER TRIGGER trg_Appointment_UpdateModified
ON Se7tek.dbo.Appointment
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;
    
    IF EXISTS (SELECT 1 FROM inserted)
    BEGIN
        INSERT INTO Se7tekDWH.MetaData.LastModified (TableName, RecordID, LastModifiedDate)
        SELECT 'Appointment', CAST(appointment_id AS NVARCHAR(100)), GETDATE() FROM inserted;
    END
    IF EXISTS (SELECT 1 FROM deleted) AND NOT EXISTS (SELECT 1 FROM inserted)
    BEGIN
        INSERT INTO Se7tekDWH.MetaData.LastModified (TableName, RecordID, LastModifiedDate)
        SELECT 'Appointment', CAST(appointment_id AS NVARCHAR(100)), GETDATE() FROM deleted;
    END
END;
GO

-- 3. TRIGGER FOR Appointment_prep
CREATE OR ALTER TRIGGER trg_Appointment_prep_UpdateModified
ON Se7tek.dbo.Appointment_prep
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;
    
    IF EXISTS (SELECT 1 FROM inserted)
    BEGIN
        INSERT INTO Se7tekDWH.MetaData.LastModified (TableName, RecordID, LastModifiedDate)
        SELECT 'Appointment_prep', CAST(prep_id AS NVARCHAR(100)), GETDATE() FROM inserted;
    END
    IF EXISTS (SELECT 1 FROM deleted) AND NOT EXISTS (SELECT 1 FROM inserted)
    BEGIN
        INSERT INTO Se7tekDWH.MetaData.LastModified (TableName, RecordID, LastModifiedDate)
        SELECT 'Appointment_prep', CAST(prep_id AS NVARCHAR(100)), GETDATE() FROM deleted;
    END
END;
GO

-- 4. TRIGGER FOR Content
CREATE OR ALTER TRIGGER trg_Content_UpdateModified
ON Se7tek.dbo.Content
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;
    
    IF EXISTS (SELECT 1 FROM inserted)
    BEGIN
        INSERT INTO Se7tekDWH.MetaData.LastModified (TableName, RecordID, LastModifiedDate)
        SELECT 'Content', content_id , GETDATE() FROM inserted;
    END
    IF EXISTS (SELECT 1 FROM deleted) AND NOT EXISTS (SELECT 1 FROM inserted)
    BEGIN
        INSERT INTO Se7tekDWH.MetaData.LastModified (TableName, RecordID, LastModifiedDate)
        SELECT 'Content', content_id , GETDATE() FROM deleted;
    END
END;
GO


-- 6. TRIGGER FOR Doctor
CREATE OR ALTER TRIGGER trg_Doctor_UpdateModified
ON Se7tek.dbo.Doctor
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;
    
    IF EXISTS (SELECT 1 FROM inserted)
    BEGIN
        INSERT INTO Se7tekDWH.MetaData.LastModified (TableName, RecordID, LastModifiedDate)
        SELECT 'Doctor', doctor_id , GETDATE() FROM inserted;
    END
    IF EXISTS (SELECT 1 FROM deleted) AND NOT EXISTS (SELECT 1 FROM inserted)
    BEGIN
        INSERT INTO Se7tekDWH.MetaData.LastModified (TableName, RecordID, LastModifiedDate)
        SELECT 'Doctor', doctor_id , GETDATE() FROM deleted;
    END
END;
GO

-- 7. TRIGGER FOR Medical_analysis
CREATE OR ALTER TRIGGER trg_Medical_analysis_UpdateModified
ON Se7tek.dbo.Medical_analysis
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;
    
    IF EXISTS (SELECT 1 FROM inserted)
    BEGIN
        INSERT INTO Se7tekDWH.MetaData.LastModified (TableName, RecordID, LastModifiedDate)
        SELECT 'Medical_analysis', analysis_id , GETDATE() FROM inserted;
    END
    IF EXISTS (SELECT 1 FROM deleted) AND NOT EXISTS (SELECT 1 FROM inserted)
    BEGIN
        INSERT INTO Se7tekDWH.MetaData.LastModified (TableName, RecordID, LastModifiedDate)
        SELECT 'Medical_analysis', analysis_id , GETDATE() FROM deleted;
    END
END;
GO

-- 8. TRIGGER FOR Medication
CREATE OR ALTER TRIGGER trg_Medication_UpdateModified
ON Se7tek.dbo.Medication
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;
    
    IF EXISTS (SELECT 1 FROM inserted)
    BEGIN
        INSERT INTO Se7tekDWH.MetaData.LastModified (TableName, RecordID, LastModifiedDate)
        SELECT 'Medication', medication_id, GETDATE() FROM inserted;
    END
    IF EXISTS (SELECT 1 FROM deleted) AND NOT EXISTS (SELECT 1 FROM inserted)
    BEGIN
        INSERT INTO Se7tekDWH.MetaData.LastModified (TableName, RecordID, LastModifiedDate)
        SELECT 'Medication', medication_id , GETDATE() FROM deleted;
    END
END;
GO

-- 9. TRIGGER FOR Medication_intake
CREATE OR ALTER TRIGGER trg_Medication_intake_UpdateModified
ON Se7tek.dbo.Medication_intake
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;
    
    IF EXISTS (SELECT 1 FROM inserted)
    BEGIN
        INSERT INTO Se7tekDWH.MetaData.LastModified (TableName, RecordID, LastModifiedDate)
        SELECT 'Medication_intake', intake_id , GETDATE() FROM inserted;
    END
    IF EXISTS (SELECT 1 FROM deleted) AND NOT EXISTS (SELECT 1 FROM inserted)
    BEGIN
        INSERT INTO Se7tekDWH.MetaData.LastModified (TableName, RecordID, LastModifiedDate)
        SELECT 'Medication_intake', intake_id , GETDATE() FROM deleted;
    END
END;
GO

-- 10. TRIGGER FOR Medication_schedule
CREATE OR ALTER TRIGGER trg_Medication_schedule_UpdateModified
ON Se7tek.dbo.Medication_schedule
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;
    
    IF EXISTS (SELECT 1 FROM inserted)
    BEGIN
        INSERT INTO Se7tekDWH.MetaData.LastModified (TableName, RecordID, LastModifiedDate)
        SELECT 'Medication_schedule', schedule_id, GETDATE() FROM inserted;
    END
    IF EXISTS (SELECT 1 FROM deleted) AND NOT EXISTS (SELECT 1 FROM inserted)
    BEGIN
        INSERT INTO Se7tekDWH.MetaData.LastModified (TableName, RecordID, LastModifiedDate)
        SELECT 'Medication_schedule', schedule_id , GETDATE() FROM deleted;
    END
END;
GO

-- 11. TRIGGER FOR Notification
CREATE OR ALTER TRIGGER trg_Notification_UpdateModified
ON Se7tek.dbo.Notification
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;
    
    IF EXISTS (SELECT 1 FROM inserted)
    BEGIN
        INSERT INTO Se7tekDWH.MetaData.LastModified (TableName, RecordID, LastModifiedDate)
        SELECT 'Notification', notification_id , GETDATE() FROM inserted;
    END
    IF EXISTS (SELECT 1 FROM deleted) AND NOT EXISTS (SELECT 1 FROM inserted)
    BEGIN
        INSERT INTO Se7tekDWH.MetaData.LastModified (TableName, RecordID, LastModifiedDate)
        SELECT 'Notification', notification_id, GETDATE() FROM deleted;
    END
END;
GO

-- 12. TRIGGER FOR Patient_profile
CREATE OR ALTER TRIGGER trg_Patient_profile_UpdateModified
ON Se7tek.dbo.Patient_profile
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;
    
    IF EXISTS (SELECT 1 FROM inserted)
    BEGIN
        INSERT INTO Se7tekDWH.MetaData.LastModified (TableName, RecordID, LastModifiedDate)
        SELECT 'Patient_profile', CAST(patient_id AS NVARCHAR(100)), GETDATE() FROM inserted;
    END
    IF EXISTS (SELECT 1 FROM deleted) AND NOT EXISTS (SELECT 1 FROM inserted)
    BEGIN
        INSERT INTO Se7tekDWH.MetaData.LastModified (TableName, RecordID, LastModifiedDate)
        SELECT 'Patient_profile', CAST(patient_id AS NVARCHAR(100)), GETDATE() FROM deleted;
    END
END;
GO

-- 14. TRIGGER FOR Pregnancy_hist
CREATE OR ALTER TRIGGER trg_Pregnancy_hist_UpdateModified
ON Se7tek.dbo.Pregnancy_hist
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;
    
    IF EXISTS (SELECT 1 FROM inserted)
    BEGIN
        INSERT INTO Se7tekDWH.MetaData.LastModified (TableName, RecordID, LastModifiedDate)
        SELECT 'Pregnancy_hist', CAST(pregnancy_id AS NVARCHAR(100)), GETDATE() FROM inserted;
    END
    IF EXISTS (SELECT 1 FROM deleted) AND NOT EXISTS (SELECT 1 FROM inserted)
    BEGIN
        INSERT INTO Se7tekDWH.MetaData.LastModified (TableName, RecordID, LastModifiedDate)
        SELECT 'Pregnancy_hist', CAST(pregnancy_id AS NVARCHAR(100)), GETDATE() FROM deleted;
    END
END;
GO


ALTER TABLE Se7tekDWH.MetaData.LastModified
ALTER COLUMN RecordID NVARCHAR(100);

GO




----------------

CREATE PROCEDURE dbo.GetTablePKExpressions
AS
BEGIN
    SET NOCOUNT ON;  -- Critical for SSIS to prevent row count interference[citation:2][citation:6]
    
    SELECT 
        t.name AS TableName,
        SCHEMA_NAME(t.schema_id) AS SchemaName,
        ISNULL(MAX(l.LastLoadDate), '1900-01-01') AS NewLowerBoundary,
        ISNULL(
            STUFF(
                (
                    SELECT ' + ''|'' + ' + 'CAST(t.' + QUOTENAME(col.name) + ' AS NVARCHAR(100))'
                    FROM sys.index_columns ic
                    JOIN sys.columns col ON ic.object_id = col.object_id AND ic.column_id = col.column_id
                    JOIN sys.indexes idx ON ic.object_id = idx.object_id AND ic.index_id = idx.index_id
                    WHERE ic.object_id = t.object_id AND idx.is_primary_key = 1
                    ORDER BY ic.key_ordinal
                    FOR XML PATH(''), TYPE
                ).value('.', 'NVARCHAR(MAX)'), 1, 9, ''
            ), 
            'CAST(t.[id] AS NVARCHAR(100))'
        ) AS PK_Expression
    FROM sys.tables t
    LEFT JOIN Se7tekDWH.MetaData.LastLoad l ON t.name = l.TableName AND l.Status = 'Success'
    WHERE t.name IN ('Alert','Appointment','Appointment_prep','Content','doc_preg_alert','Doctor','Medical_analysis','Medication','Medication_intake','Medication_schedule','Notification','Patient_profile','preg_content','Pregnancy_hist','adminstration')
    GROUP BY t.name, t.schema_id, t.object_id;
END;

GO 

SELECT * 
INTO Se7tekDWH.Bronze.content
FROM Se7tek.dbo.Content
WHERE 1 = -1;



---------------------

CREATE OR ALTER TRIGGER trg_Appointment_prep_UpdateModified
ON Se7tek.dbo.Appointment_prep
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;
    
    IF EXISTS (SELECT 1 FROM inserted)
    BEGIN
        INSERT INTO Se7tekDWH.MetaData.LastModified (TableName, RecordID, LastModifiedDate)
        -- Concatenate composite keys using a pipe delimiter
        SELECT 'Appointment_prep', CAST(appointment_id AS NVARCHAR(100)) + '|' + CAST(prep_id AS NVARCHAR(100)), GETDATE() FROM inserted;
    END
    IF EXISTS (SELECT 1 FROM deleted) AND NOT EXISTS (SELECT 1 FROM inserted)
    BEGIN
        INSERT INTO Se7tekDWH.MetaData.LastModified (TableName, RecordID, LastModifiedDate)
        SELECT 'Appointment_prep', CAST(appointment_id AS NVARCHAR(100)) + '|' + CAST(prep_id AS NVARCHAR(100)), GETDATE() FROM deleted;
    END
END;
GO


-----------------

CREATE OR ALTER TRIGGER trg_adminstration_UpdateModified
ON Se7tek.dbo.adminstration
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;
    
    IF EXISTS (SELECT 1 FROM inserted)
    BEGIN
        INSERT INTO Se7tekDWH.MetaData.LastModified (TableName, RecordID, LastModifiedDate)
        -- Concatenate composite keys using a pipe delimiter
        SELECT 'Appointment_prep', CAST(schedule_id AS NVARCHAR(100)) + '|' + CAST(taken_at AS NVARCHAR(100)), GETDATE() FROM inserted;
    END
    IF EXISTS (SELECT 1 FROM deleted) AND NOT EXISTS (SELECT 1 FROM inserted)
    BEGIN
        INSERT INTO Se7tekDWH.MetaData.LastModified (TableName, RecordID, LastModifiedDate)
        SELECT 'Appointment_prep', CAST(schedule_id AS NVARCHAR(100)) + '|' + CAST(taken_at AS NVARCHAR(100)), GETDATE() FROM deleted;
    END
END;
GO

--------------------------------

CREATE OR ALTER TRIGGER trg_doc_preg_alert_UpdateModified
ON Se7tek.dbo.doc_preg_alert
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;
    
    IF EXISTS (SELECT 1 FROM inserted)
    BEGIN
        INSERT INTO Se7tekDWH.MetaData.LastModified (TableName, RecordID, LastModifiedDate)
        -- Concatenate composite keys using a pipe delimiter
        SELECT 'Appointment_prep', CAST(doctor_id AS NVARCHAR(100)) + '|' + CAST(pregnancy_id AS NVARCHAR(100))+ '|' + CAST(alert_id AS NVARCHAR(100)), GETDATE() FROM inserted;
    END
    IF EXISTS (SELECT 1 FROM deleted) AND NOT EXISTS (SELECT 1 FROM inserted)
    BEGIN
        INSERT INTO Se7tekDWH.MetaData.LastModified (TableName, RecordID, LastModifiedDate)
        SELECT 'Appointment_prep', CAST(doctor_id AS NVARCHAR(100)) + '|' + CAST(pregnancy_id AS NVARCHAR(100))+ '|' + CAST(alert_id AS NVARCHAR(100)), GETDATE() FROM deleted;
    END
END;
GO
---------

CREATE OR ALTER TRIGGER trg_preg_content_UpdateModified
ON Se7tek.dbo.preg_content
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;
    
    IF EXISTS (SELECT 1 FROM inserted)
    BEGIN
        INSERT INTO Se7tekDWH.MetaData.LastModified (TableName, RecordID, LastModifiedDate)
        -- Concatenate composite keys using a pipe delimiter
        SELECT 'Appointment_prep', CAST(pregnancy_id AS NVARCHAR(100)) + '|' + CAST(content_id AS NVARCHAR(100)), GETDATE() FROM inserted;
    END
    IF EXISTS (SELECT 1 FROM deleted) AND NOT EXISTS (SELECT 1 FROM inserted)
    BEGIN
        INSERT INTO Se7tekDWH.MetaData.LastModified (TableName, RecordID, LastModifiedDate)
        SELECT 'Appointment_prep', CAST(pregnancy_id AS NVARCHAR(100)) + '|' + CAST(content_id AS NVARCHAR(100)), GETDATE() FROM deleted;
    END
END;
GO