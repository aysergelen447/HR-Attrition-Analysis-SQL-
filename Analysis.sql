-- Attrition Percentage by Job Title -- 

WITH attrition AS (
  SELECT 
    job_title,
    SUM(CASE WHEN attrition_flag = 'Yes' THEN 1 ELSE 0 END) AS attrition_count,
    SUM(SUM(CASE WHEN attrition_flag = 'Yes' THEN 1 ELSE 0 END)) OVER () AS total_attrition,
  FROM 
    `hr-project-495118.HR_churn11.cleaned_data_new_column`
  GROUP BY  job_title
)
SELECT 
  job_title, 
  ROUND(attrition_count / total_attrition * 100, 1) AS attrition_percentage
FROM attrition
WHERE attrition_count > 0 
ORDER BY attrition_percentage DESC

-- Attrition Percentage by Department --

WITH attrition_by_department AS (
  SELECT  
      department,
      SUM(CASE WHEN attrition_flag = 'Yes' THEN 1 ELSE 0 END) AS attrition_count
  FROM `hr-project-495118.HR_churn11.cleaned_data_new_column`
  GROUP BY department
  ORDER BY attrition_count DESC
)
SELECT department,
ROUND(attrition_count / SUM(attrition_count)OVER()*100,1) AS attrition_percentage
FROM attrition_by_department;

-- Attrition Percentage by Attrition Types --

SELECT 
Attrition_Time,
 ROUND(
    SUM(CASE WHEN attrition_flag = 'Yes' THEN 1 ELSE 0 END) 
    / SUM(SUM(CASE WHEN attrition_flag = 'Yes' THEN 1 ELSE 0 END)) OVER () * 100, 1) AS attrition_percentage
FROM `hr-project-495118.HR_churn11.cleaned_data_new_column`
WHERE attrition_flag = 'Yes'
GROUP BY Attrition_Time 
ORDER BY attrition_percentage DESC

--  % Attrition Below Avg Department Salary for Each Department -- 

WITH below_salary_average AS (
  SELECT 
    full_name,
    job_title,
    department,
    attrition_flag,
    salary,
    CASE WHEN CAST(salary AS INT64) > AVG(CAST(salary AS INT64)) OVER(PARTITION BY department) THEN 'Above Average' ELSE 'Below Average' END AS status,
    COUNT(*) OVER (PARTITION BY department) AS total_attrition_in_department,
    Attrition_Time
  FROM `hr-project-495118.HR_churn11.cleaned_data_new_column`
  WHERE attrition_flag = 'Yes' 
)
SELECT 
  department,
  ROUND(COUNT(status) / MAX(total_attrition_in_department) * 100, 1) AS below_avg_salary_pct,
FROM below_salary_average
WHERE status = 'Below Average' AND total_attrition_in_department > 3
GROUP BY department
ORDER BY below_avg_salary_pct DESC

--  % Attrition Below Avg Department Salary for Each Department -- 

WITH below_salary_average AS (
  SELECT 
    full_name,
    job_title,
    department,
    attrition_flag,
    salary,
    CASE WHEN CAST(salary AS INT64) > AVG(CAST(salary AS INT64)) OVER(PARTITION BY job_title) THEN 'Above Average' ELSE 'Below Average' END AS status,
    COUNT(*) OVER (PARTITION BY job_title) AS total_attrition_in_job_title,
    Attrition_Time
  FROM `hr-project-495118.HR_churn11.cleaned_data_new_column`
  WHERE attrition_flag = 'Yes' 
)
SELECT 
  job_title,
  ROUND(COUNT(status) / MAX(total_attrition_in_job_title) * 100, 1) AS below_avg_salary_pct,
FROM below_salary_average
WHERE status = 'Below Average' AND total_attrition_in_job_title >2
GROUP BY job_title
ORDER BY below_avg_salary_pct DESC