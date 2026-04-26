-- =====================================
-- Author: Reem
-- Tables: Doctor, Appointment, Alert
-- =====================================

-- =========================
-- 1. Doctor
-- =========================
CREATE TABLE doctor (
    doctor_id INT NOT NULL IDENTITY(1,1),
    name NVARCHAR(100) NOT NULL,
    phone NVARCHAR(20),
    password NVARCHAR(100),
    zone NVARCHAR(50),
    status NVARCHAR(50) DEFAULT 'Active',

    CONSTRAINT pk_doctor PRIMARY KEY (doctor_id)
);
GO

-- =========================
-- 2. Appointment
-- =========================
CREATE TABLE appointment (
    appointment_id INT NOT NULL IDENTITY(1,1),
    doctor_id INT NOT NULL,
    preg_id INT NOT NULL,
    appointment_datetime DATETIME2 NOT NULL,
    appointment_status NVARCHAR(50) DEFAULT 'Scheduled',
    created_at DATETIME2 DEFAULT GETDATE(),

    CONSTRAINT pk_appointment PRIMARY KEY (appointment_id),

    CONSTRAINT fk_appointment_doctor FOREIGN KEY (doctor_id)
        REFERENCES doctor(doctor_id)
        ON DELETE NO ACTION
        ON UPDATE CASCADE,

    --CONSTRAINT fk_appointment_profile FOREIGN KEY (preg_id)
       -- REFERENCES pregnancy_profile(preg_id)
        --ON DELETE CASCADE
        --ON UPDATE CASCADE
);
GO

-- =========================
-- 3. Alert
-- =========================
CREATE TABLE alert (
    alert_id INT NOT NULL IDENTITY(1,1),
    appointment_id INT NOT NULL,
    preg_id INT NOT NULL,
    alert_type NVARCHAR(100),
    alert_status NVARCHAR(50) DEFAULT 'Active',
    message NVARCHAR(255),
    created_at DATETIME2 DEFAULT GETDATE(),

    CONSTRAINT pk_alert PRIMARY KEY (alert_id),

    CONSTRAINT fk_alert_appointment FOREIGN KEY (appointment_id)
        REFERENCES appointment(appointment_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

   -- CONSTRAINT fk_alert_profile FOREIGN KEY (preg_id)
       -- REFERENCES pregnancy_profile(preg_id)
       -- ON DELETE CASCADE
        --ON UPDATE CASCADE
);
GO
