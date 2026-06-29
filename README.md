## HR Attrition Analysis SQL
Identified patterns behind employee attrition rates by department, job title, tenure tier, and salary benchmarks.
## Data Cleaning & Transformation
Standardized values, parsed data, handled null values, cleaned formatting 

## Feature Engineering
Created a new view, segmented employees by tenure status

## EDA
Attrition by Job Title 
Attrition distribution by department
Compensation Impact on Attrition

## Main Findings 
Salary was not the main driver of attrition across departments.
Most employees who left earned above their department's average salary, suggesting lower pay alone did not explain turnover.
   
Lower pay was linked to attrition in two support roles. Employees in the Support Lead and Support Specialist roles were more likely to leave when earning below their departmental average.

Marketing Managers had the highest attrition among job titles.
| Job Title                | Attrition Count | Attrition % |
|--------------------------|----------------|-------------|
| Marketing Manager        | 4              | 14.8%       |
| Analyst                  | 3              | 11.1%       |
| Support Specialist       | 3              | 11.1%       |

Customer Support had the highest departmental attrition.
| Department       | Attrition Count | Attrition % |
|------------------|----------------|-------------|
| Customer Support | 7              | 30%         |
| Finance          | 5              | 20%         |
| Sales            | 4              | 10%         |

There's no early attrition but rather, 59% of attrition is Veteran Attrition
| Attrition Type      | Attrition % |
|---------------------|-------------|
| Veteran Attrition   | 59.3%       |
| Mid Term Attrition  | 40.7%       |
