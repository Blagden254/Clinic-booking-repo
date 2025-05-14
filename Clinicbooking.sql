-- Create database
CREATE DATABASE IF NOT EXISTS ClinicBookingSystem;
USE ClinicBookingSystem;

-- Drop existing tables to avoid conflicts
DROP TABLE IF EXISTS Prescriptions, Appointments, Doctors, Patients, Specializations, Users;

-- Users Table
CREATE TABLE Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    role ENUM('Administrator', 'Doctor', 'Patient') NOT NULL
);

-- Patients Table
CREATE TABLE Patients (
    patient_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    name VARCHAR(100) NOT NULL,
    dob DATE NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- Specializations Table
CREATE TABLE Specializations (
    specialization_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) UNIQUE NOT NULL
);

-- Doctors Table
CREATE TABLE Doctors (
    doctor_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    name VARCHAR(100) NOT NULL,
    specialization_id INT,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (specialization_id) REFERENCES Specializations(specialization_id)
);

-- Appointments Table
CREATE TABLE Appointments (
    appointment_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT,
    doctor_id INT,
    appointment_date DATETIME NOT NULL,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
);

-- Prescriptions Table
CREATE TABLE Prescriptions (
    prescription_id INT PRIMARY KEY AUTO_INCREMENT,
    appointment_id INT UNIQUE,
    medication TEXT NOT NULL,
    FOREIGN KEY (appointment_id) REFERENCES Appointments(appointment_id)
);

-- Insert Users (Admins, Doctors, Patients)
INSERT INTO Users (username, password, role) VALUES
('admin1', 'adminpass', 'Administrator'),
('docjohn', 'docpass1', 'Doctor'),
('docjane', 'docpass2', 'Doctor'),
('patbob', 'patpass1', 'Patient'),
('patalice', 'patpass2', 'Patient'),
('patmark', 'patpass3', 'Patient'),
('patlucy', 'patpass4', 'Patient'),
('docsteve', 'docpass3', 'Doctor'),
('docann', 'docpass4', 'Doctor'),
('patmax', 'patpass5', 'Patient');

-- Insert Specializations
INSERT INTO Specializations (name) VALUES
('Cardiology'),
('Neurology'),
('Pediatrics'),
('Orthopedics'),
('Dermatology');

-- Insert Patients
INSERT INTO Patients (user_id, name, dob, email, phone) VALUES
(4, 'Bob Smith', '1990-01-01', 'bob@example.com', '0712345678'),
(5, 'Alice Johnson', '1985-02-02', 'alice@example.com', '0723456789'),
(6, 'Mark Lee', '1992-03-03', 'mark@example.com', '0734567890'),
(7, 'Lucy Kim', '1988-04-04', 'lucy@example.com', '0745678901'),
(10, 'Max Otieno', '1991-05-05', 'max@example.com', '0756789012');

-- Insert Doctors
INSERT INTO Doctors (user_id, name, specialization_id, email, phone) VALUES
(2, 'Dr. John Doe', 1, 'john.doe@example.com', '0711122233'),
(3, 'Dr. Jane Roe', 2, 'jane.roe@example.com', '0722233344'),
(8, 'Dr. Steve Hill', 3, 'steve.hill@example.com', '0733344455'),
(9, 'Dr. Ann Paul', 4, 'ann.paul@example.com', '0744455566');

-- Insert Appointments
INSERT INTO Appointments (patient_id, doctor_id, appointment_date) VALUES
(1, 1, '2025-05-15 10:00:00'),
(2, 1, '2025-05-15 11:00:00'),
(3, 2, '2025-05-16 09:30:00'),
(4, 3, '2025-05-17 14:00:00'),
(5, 4, '2025-05-18 15:30:00'),
(1, 2, '2025-05-19 16:00:00'),
(2, 3, '2025-05-20 10:30:00'),
(3, 4, '2025-05-21 11:30:00'),
(4, 1, '2025-05-22 13:00:00'),
(5, 2, '2025-05-23 09:00:00');

-- Insert Prescriptions
INSERT INTO Prescriptions (appointment_id, medication) VALUES
(1, 'Paracetamol 500mg twice a day'),
(2, 'Amoxicillin 250mg three times a day'),
(3, 'Ibuprofen 400mg as needed'),
(4, 'Vitamin D supplements daily'),
(5, 'Antihistamines for allergies'),
(6, 'Blood pressure medication'),
(7, 'Insulin for diabetes'),
(8, 'Topical cream for rash'),
(9, 'Painkillers for joint pain'),
(10, 'Cough syrup as directed');
