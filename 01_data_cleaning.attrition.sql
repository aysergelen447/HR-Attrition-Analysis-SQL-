CREATE OR REPLACE VIEW `hr-project-495118.HR_churn11.cleaned_data` AS

SELECT emp_id,full_name,review_year,job_title,promotion_date,
  CASE  
   WHEN INITCAP(department) = 'Eng' THEN 'Engineering'
   WHEN INITCAP(department) = 'Hr'  THEN 'Human Resources'
   ELSE INITCAP(department)
   END AS department,

   CASE
    WHEN LOWER(TRIM(hire_date)) LIKE '____-__-__' THEN PARSE_DATE('%Y-%m-%d', hire_date)
    WHEN LOWER(TRIM(hire_date)) LIKE '____/__/__' THEN PARSE_DATE('%Y/%m/%d', hire_date)
    WHEN LOWER(TRIM(hire_date)) LIKE '__/__/____' THEN PARSE_DATE('%m/%d/%Y', hire_date)
    ELSE NULL
  END AS hire_date,

   CASE
    WHEN LOWER(TRIM(exit_date)) LIKE '____-__-__' THEN PARSE_DATE('%Y-%m-%d', exit_date)
    WHEN LOWER(TRIM(exit_date)) LIKE '____/__/__' THEN PARSE_DATE('%Y/%m/%d', exit_date)
    WHEN LOWER(TRIM(exit_date)) LIKE '__/__/____' THEN PARSE_DATE('%m/%d/%Y', exit_date)
    ELSE NULL
  END AS exit_date,

REPLACE (REPLACE(REPLACE(LOWER(TRIM(salary)), '$',''),'k','000'),',','') AS salary,

  CASE 
    WHEN location = 'ATX' THEN 'Austin'
    WHEN location = 'NY' THEN 'New York'
    WHEN location = 'SEA' THEN 'Seattle'
    WHEN location = 'SF' THEN 'San Francisco'
  ELSE location
END AS location,

  CASE
    WHEN LOWER(TRIM(attrition_flag)) IN ('no', 'n', 'false','0') THEN 'No'
    WHEN LOWER(TRIM(attrition_flag)) IN ('yes', 'y', 'true','1') THEN 'Yes'
    WHEN attrition_flag IS NULL THEN 'No'
    ELSE NULL
END AS attrition_flag
FROM `hr-project-495118.HR_churn11.hr_Churn` ; 

CREATE OR REPLACE VIEW `hr-project-495118.HR_churn11.cleaned_data_new_column` AS
SELECT *,
  CASE 
    WHEN DATE_DIFF(exit_date, hire_date, DAY) < 90 THEN 'New Hire Churn'
    WHEN DATE_DIFF(exit_date, hire_date, DAY) BETWEEN 90 AND 365 THEN 'Early Attrition'
    WHEN DATE_DIFF(exit_date, hire_date, DAY) BETWEEN 365 AND 1095 THEN 'Mid Term Attrition'
    WHEN DATE_DIFF(exit_date, hire_date, DAY) > 1095 THEN 'Veteran Attrition'
    ELSE 'Current Employee'
  END AS Attrition_Time
FROM `hr-project-495118.HR_churn11.cleaned_data`;


--- Upon running this, went back and edited null values to be no in attrition_flag ---
SELECT *,
FROM `hr-project-495118.HR_churn11.cleaned_data_new_column`
WHERE attrition_flag IS NULL;

SELECT *,
FROM `hr-project-495118.HR_churn11.cleaned_data_new_column` 
WHERE attrition_flag = 'Yes'; 

-- left the null values in the department column because all the rows where department was nnull was also attrition flag = no --
