CREATE TABLE hospital_data(
Hospital_Name VARCHAR(100) NOT NULL,
Hospital_Location VARCHAR(100) NOT NULL,
Department VARCHAR(100) NOT NULL,
Doctors_Count SMALLINT,
Patients_Count SMALLINT,
Admission_Date TEXT,
Discharge_Date TEXT,
Medical_Expenses NUMERIC(10,2) NOT NULL
);

ALTER TABLE hospital_data
ALTER COLUMN Admission_Date TYPE DATE
USING TO_DATE(Admission_Date,'DD-MM-YYYY'),
ALTER COLUMN Discharge_Date TYPE DATE
USING TO_DATE(Discharge_Date,'DD-MM-YYYY');

-- 1. Total Number of Patients
-- Write an SQL query to find the total number of patients across all hospitals.
SELECT SUM(patients_count) AS total_patients
FROM hospital_data ;

-- 2. Average Number of Doctors per Hospital
--  Retrieve the average count of doctors available in each hospital.
SELECT hospital_name AVG(doctors_count) AS avg_doctors_count
FROM hospital_data 
GROUP BY hospital_name;

-- 3. Top 3 Departments with the Highest Number of Patients
--  Find the top 3 hospital departments that have the highest number of patients.
SELECT department , SUM(patients_count) AS total_patients
FROM hospital_data
GROUP BY department 
ORDER BY SUM(patients_count) DESC
LIMIT 3	;

-- 4. Hospital with the Maximum Medical Expenses
--  Identify the hospital that recorded the highest medical expenses.
SELECT hospital_name , medical_expenses
FROM hospital_data
ORDER BY medical_expenses DESC
LIMIT 1;

-- 5. Daily Average Medical Expenses
--  Calculate the average medical expenses per day for each hospital.
SELECT admission_date ,AVG(medical_expenses)
FROM hospital_data
GROUP BY admission_date;

-- 6. Longest Hospital Stay
--  Find the patient with the longest stay by calculating the difference between
-- Discharge Date and Admission Date.
SELECT admission_date, discharge_date , discharge_date - admission_date AS days_in_hospital
FROM hospital_data
ORDER BY discharge_date - admission_date  DESC
LIMIT 1;

-- 7. Total Patients Treated Per City
--  Count the total number of patients treated in each city.
SELECT hospital_location , SUM(patients_count) AS total_patients_treated
FROM hospital_data
GROUP BY hospital_location;

-- 8. Average Length of Stay Per Department
--  Calculate the average number of days patients spend in each department.
SELECT department, AVG(discharge_date - admission_date) AS avg_days_in_hospital
FROM hospital_data
GROUP BY department;

-- 9. Identify the Department with the Lowest Number of Patients
--  Find the department with the least number of patients.
SELECT department, SUM(patients_count) AS total_patients
FROM hospital_data
GROUP BY department
ORDER BY SUM(patients_count)
LIMIT 1;

-- 10. Monthly Medical Expenses Report
--  Group the data by month and calculate the total medical expenses for each month.
SELECT EXTRACT(MONTH FROM admission_date) AS month,
       SUM(medical_expenses) AS total_expenses
FROM hospital_data
GROUP BY EXTRACT(MONTH FROM admission_date)
ORDER BY month;