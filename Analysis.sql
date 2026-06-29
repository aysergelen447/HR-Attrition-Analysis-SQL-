-- Attrition Percentage By Job Title
WITH attrition AS (
  SELECT 
    job_title,
    SUM(CASE WHEN attrition_flag = 'Yes' THEN 1 ELSE 0 END) AS attrition_count,
    SUM(SUM(CASE WHEN attrition_flag = 'Yes' THEN 1 ELSE 0 END)) OVER () AS total_attrition,
  FROM 
    `hr-project-495118.HR_churn11.cleaned_data_new_column`
  GROUP BY 
    job_title
)
SELECT 
  job_title, 
  ROUND(attrition_count / total_attrition * 100, 1) AS attrition_percentage
FROM attrition
WHERE attrition_count > 0 
ORDER BY attrition_percentage DESC

---- Attrition Percentage By Department ------
WITH attrition_by_department AS (
  SELECT  
      department,
      SUM(CASE WHEN attrition_flag = 'Yes' THEN 1 ELSE 0 END) AS attrition_count
  FROM `hr-project-495118.HR_churn11.cleaned_data_new_column`
  GROUP BY 
      department
  ORDER BY 
      attrition_count DESC
)
SELECT 
  department,
  ROUND(attrition_count / SUM(attrition_count)OVER()*100,1) AS percentage_attrition
FROM attrition_by_department;

--- Attrition Percentage By Attrition Types --- 
SELECT 
  Attrition_Time,
  ROUND(
    SUM(CASE WHEN attrition_flag = 'Yes' THEN 1 ELSE 0 END) 
    / SUM(SUM(CASE WHEN attrition_flag = 'Yes' THEN 1 ELSE 0 END)) OVER ()
    * 100, 1
  ) AS attrition_percentage
FROM `hr-project-495118.HR_churn11.cleaned_data_new_column`
WHERE attrition_flag = 'Yes'
GROUP BY Attrition_Time 
ORDER BY attrition_percentage DESC

--  % attrition below avg salary across departments -- 
WITH salary_average AS (
  SELECT 
    full_name,
    job_title,
    department,
    attrition_flag,
    salary,
    Attrition_Time,
    AVG(salary) OVER(PARTITION BY department) AS avg_department_salary
  FROM `hr-project-495118.HR_churn11.cleaned_data_new_column`
),

below_salary_average AS (
  SELECT 
    *,
    CASE 
      WHEN salary > avg_department_salary THEN 'Above Average'
      ELSE 'Below Average'
    END AS status
  FROM salary_average
  WHERE attrition_flag = 'Yes'
)

SELECT 
  department,
  ROUND(
    SUM(CASE WHEN status = 'Below Average' THEN 1 ELSE 0 END) 
    / COUNT(*) * 100, 
    1
  ) AS below_avg_salary_pct
FROM below_salary_average
GROUP BY department
HAVING COUNT(*) > 3
ORDER BY below_avg_salary_pct DESC;

--  % attrition below avg salary across job titles -- 
WITH salary_average AS (
  SELECT 
    full_name,
    job_title,
    department,
    attrition_flag,
    salary,
    Attrition_Time,
    AVG(salary) OVER(PARTITION BY department) AS avg_department_salary
    FROM `hr-project-495118.HR_churn11.cleaned_data_new_column`
), 
below_salary_average AS (
  SELECT 
    *,
    CASE 
      WHEN salary > avg_department_salary THEN 'Above Average'
      ELSE 'Below Average'
    END AS status
  FROM salary_average
  WHERE attrition_flag = 'Yes'
)
SELECT 
  job_title,
  ROUND(
    SUM(CASE WHEN status = 'Below Average' THEN 1 ELSE 0 END) 
    / COUNT(*) * 100, 
    1
  ) AS below_avg_salary_pct
FROM below_salary_average
GROUP BY job_title
HAVING COUNT(*) > 2
ORDER BY below_avg_salary_pct DESC;

