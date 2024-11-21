-- Modal Age of Diabetic vs Non-Diabetic Patients
SELECT
    diabetes,
    MODE(age_group) AS modal_age
FROM
    DATATHON.PUBLIC.DIABETES_CLEANED
GROUP BY
    diabetes;

-- Distribution of BMI Categories Among Diabetic Patients
-- This query counts the number of diabetic patients within each BMI category.
SELECT
    CASE
        WHEN bmi < 18.5 THEN 'Underweight'
        WHEN bmi BETWEEN 18.5 AND 24.9 THEN 'Normal Weight'
        WHEN bmi BETWEEN 25 AND 29.9 THEN 'Overweight'
        WHEN bmi BETWEEN 30 AND 39.9 THEN 'Obesity'
        ELSE 'Severe Obesity'
    END AS bmi_category,
    COUNT(*) AS patient_count
FROM
    DATATHON.PUBLIC.DIABETES_CLEANED
WHERE
    diabetes = 1
GROUP BY
    bmi_category
ORDER BY CASE 
    WHEN bmi_category = 'Severe Obesity' THEN 1
    WHEN bmi_category = 'Obesity' THEN 2
    WHEN bmi_category = 'Overweight' THEN 3
    WHEN bmi_category = 'Normal Weight' THEN 4
    WHEN bmi_category = 'Underweight' THEN 5
END;


-- Same as above but outputs % split also (ChatGPT)
WITH BmiCategories AS (
    SELECT
        *,
        CASE
        WHEN bmi < 18.5 THEN 'Underweight'
        WHEN bmi BETWEEN 18.5 AND 24.9 THEN 'Normal Weight'
        WHEN bmi BETWEEN 25 AND 29.9 THEN 'Overweight'
        WHEN bmi BETWEEN 30 AND 39.9 THEN 'Obesity'
        ELSE 'Severe Obesity'
    END AS bmi_category
    FROM
        DATATHON.PUBLIC.DIABETES_CLEANED
    WHERE
        diabetes = 1
),
CategoryCounts AS (
    SELECT
        bmi_category,
        COUNT(*) AS category_count
    FROM
        BmiCategories
    GROUP BY
        bmi_category
),
TotalCount AS (
    SELECT
        COUNT(*) AS total_count
    FROM
        BmiCategories
)
SELECT
    c.bmi_category,
    c.category_count,
    ROUND((c.category_count * 100.0 / t.total_count), 2) AS percentage
FROM
    CategoryCounts AS c
CROSS JOIN
    TotalCount AS t
ORDER BY CASE 
    WHEN bmi_category = 'Severe Obesity' THEN 1
    WHEN bmi_category = 'Obesity' THEN 2
    WHEN bmi_category = 'Overweight' THEN 3
    WHEN bmi_category = 'Normal Weight' THEN 4
    WHEN bmi_category = 'Underweight' THEN 5
END;


-- This query calculates diabetes prevalence across different BMI categories.
SELECT
    CASE
        WHEN bmi < 18.5 THEN 'Underweight'
        WHEN bmi BETWEEN 18.5 AND 24.9 THEN 'Normal Weight'
        WHEN bmi BETWEEN 25 AND 29.9 THEN 'Overweight'
        WHEN bmi BETWEEN 30 AND 39.9 THEN 'Obesity'
        ELSE 'Severe Obesity'
    END AS bmi_category,
    COUNT(*) AS patient_count,
    SUM(diabetes) AS diabetic_patients,
    ROUND(SUM(diabetes) * 100.0 / COUNT(*), 2) AS diabetes_prevalence_percentage
FROM
    DATATHON.PUBLIC.DIABETES_CLEANED
GROUP BY
    bmi_category
ORDER BY CASE 
    WHEN bmi_category = 'Severe Obesity' THEN 1
    WHEN bmi_category = 'Obesity' THEN 2
    WHEN bmi_category = 'Overweight' THEN 3
    WHEN bmi_category = 'Normal Weight' THEN 4
    WHEN bmi_category = 'Underweight' THEN 5
END;


-- Correlation between Physical Activity and Diabetes
SELECT
    physical_activity_level,
    COUNT(*) AS patient_count,
    SUM(diabetes) AS diabetic_count,
    ROUND((SUM(diabetes) * 100.0 / COUNT(*)), 2) AS diabetes_percentage
FROM
    DATATHON.PUBLIC.DIABETES_CLEANED
-- WHERE
--    physical_activity_level != 'Unknown'
GROUP BY
    physical_activity_level
ORDER BY
    diabetes_percentage DESC;


-- Gender Analysis
SELECT
    gender,
    COUNT(*) AS patient_count,
    SUM(diabetes) AS diabetic_count,
    ROUND((SUM(diabetes) * 100.0 / COUNT(*)), 2) AS diabetes_percentage
FROM
    DATATHON.PUBLIC.DIABETES_CLEANED
GROUP BY
    gender
ORDER BY
    diabetes_percentage DESC;


-- Physical Activity Levels Across Age Groups
-- This query examines the distribution of physical activity levels across different age groups.
SELECT
    age_group,
    physical_activity_level,
    COUNT(*) AS patient_count
FROM
    DATATHON.PUBLIC.DIABETES_CLEANED
GROUP BY
    age_group, physical_activity_level
ORDER BY
    age_group,
    CASE 
        WHEN physical_activity_level = 'Sedentary' THEN 1
        WHEN physical_activity_level = 'Lightly Active' THEN 2
        WHEN physical_activity_level = 'Very Active' THEN 3
        WHEN physical_activity_level = 'Extremely Active' THEN 4
        WHEN physical_activity_level = 'Unknown' THEN 5
END;

    
-- Hypertension Prevalence Among Diabetic Patients
-- This query determines the prevalence of hypertension among diabetic patients.
SELECT
    hypertension,
    COUNT(*) AS patient_count,
    SUM(diabetes) AS diabetic_count,
    ROUND((SUM(diabetes) * 100.0 / COUNT(*)), 2) AS diabetes_percentage
FROM
    DATATHON.PUBLIC.DIABETES_CLEANED
GROUP BY
    hypertension
ORDER BY
    diabetes_percentage DESC;


-- Average BMI by Gender and Diabetes Status
-- This query calculates the average BMI for each gender, segmented by diabetes status.
SELECT
    gender,
    diabetes,
    AVG(bmi) AS avg_bmi
FROM
    DATATHON.PUBLIC.DIABETES_CLEANED
WHERE
    gender != 'Unknown'
GROUP BY
    gender, diabetes
ORDER BY
    gender, diabetes;


-- This query calculates the prevalence of diabetes among patients with and without a family history of diabetes.
SELECT
    family_diabetes_history,
    COUNT(*) AS total_patients,
    SUM(CASE WHEN diabetes = 1 THEN 1 ELSE 0 END) AS diabetic_patients,
    ROUND(SUM(CASE WHEN diabetes = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS diabetes_prevalence_percentage
FROM
    DATATHON.PUBLIC.DIABETES_CLEANED
GROUP BY
    family_diabetes_history
ORDER BY
    diabetes_prevalence_percentage DESC;


-- This query calculates diabetes prevalence across different age groups.
SELECT
    age_group,
    COUNT(*) AS total_patients,
    SUM(diabetes) AS diabetic_patients,
    ROUND(SUM(diabetes) * 100.0 / COUNT(*), 2) AS diabetes_prevalence_percentage
FROM
    DATATHON.PUBLIC.DIABETES_CLEANED
GROUP BY
    age_group
ORDER BY
    diabetes_prevalence_percentage DESC;
    
