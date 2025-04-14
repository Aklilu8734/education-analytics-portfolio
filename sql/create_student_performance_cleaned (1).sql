
-- -----------------------------------------------------------------------------------
-- File: create_student_performance_cleaned.sql
-- Description: Creates a cleaned and transformed version of the student performance data.
-- -----------------------------------------------------------------------------------

CREATE OR REPLACE TABLE `asgedom-practice.Edu_datav1.Student_performance_cleaned` AS
SELECT
  StudentID,
  Age,

  -- Gender decoding
  CASE Gender
    WHEN 0 THEN 'Male'
    WHEN 1 THEN 'Female'
    ELSE 'Unknown'
  END AS Gender,

  -- Ethnicity decoding
  CASE Ethnicity
    WHEN 0 THEN 'Caucasian'
    WHEN 1 THEN 'African American'
    WHEN 2 THEN 'Asian'
    WHEN 3 THEN 'Other'
    ELSE 'Unknown'
  END AS Ethnicity,

  -- Parental Education decoding
  CASE ParentalEducation
    WHEN 0 THEN 'None'
    WHEN 1 THEN 'High School'
    WHEN 2 THEN 'Some College'
    WHEN 3 THEN 'Bachelor''s'
    WHEN 4 THEN 'Higher'
    ELSE 'Unknown'
  END AS ParentalEducation,

  -- Raw numeric fields
  StudyTimeWeekly,
  Absences,

  -- Binary categorical decoding
  CASE Tutoring WHEN 1 THEN 'Yes' ELSE 'No' END AS Tutoring,
  CASE Extracurricular WHEN 1 THEN 'Yes' ELSE 'No' END AS Extracurricular,
  CASE Sports WHEN 1 THEN 'Yes' ELSE 'No' END AS Sports,
  CASE Music WHEN 1 THEN 'Yes' ELSE 'No' END AS Music,
  CASE Volunteering WHEN 1 THEN 'Yes' ELSE 'No' END AS Volunteering,

  -- Parental Support decoding
  CASE ParentalSupport
    WHEN 0 THEN 'None'
    WHEN 1 THEN 'Low'
    WHEN 2 THEN 'Moderate'
    WHEN 3 THEN 'High'
    WHEN 4 THEN 'Very High'
    ELSE 'Unknown'
  END AS ParentalSupport,

  GPA,

  -- GradeClass decoding based on GPA mapping
  CASE GradeClass
    WHEN 0 THEN 'A'  -- GPA >= 3.5
    WHEN 1 THEN 'B'  -- 3.0 <= GPA < 3.5
    WHEN 2 THEN 'C'  -- 2.5 <= GPA < 3.0
    WHEN 3 THEN 'D'  -- 2.0 <= GPA < 2.5
    WHEN 4 THEN 'F'  -- GPA < 2.0
    ELSE 'Unknown'
  END AS GradeLetter,

  -- Derived Fields
  CASE 
    WHEN Age < 16 THEN '14-15'
    WHEN Age < 18 THEN '16-17'
    ELSE '18+'
  END AS AgeGroup,

  -- Combined engagement score from activities
  Sports + Music + Volunteering AS ActivityScore

FROM `asgedom-practice.Edu_datav1.Student_performance_datav1`;
