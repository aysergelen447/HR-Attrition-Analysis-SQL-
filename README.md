# HR Attrition Analysis SQL
Identified patterns behind employee attrition rates by department, job title, tenure tier, and salary benchmarks.
# Data Cleaning & Transformation
Standardized values, parsed data, handled null values, cleaned formatting 

# Feature Engineering
Created a new view, segmented employees by tenure status

# EDA
Attrition by Job Title 
Attrition distribution by department
Compensation Impact on Attrition

# Findings 
1)No relationship found between low averages and attrition, Attrition does not appear to be salary-driven — the majority of employees who left were earning above their departmental average.

2) Marketing Manager role has highest attrition
| Job Title                | Attrition Count | Attrition % |
|--------------------------|----------------|-------------|
| Marketing Manager        | 4              | 14.8%       |
| Analyst                  | 3              | 11.1%       |
| Support Specialist       | 3              | 11.1%       |

3) While Marketing Manager has the highest attrition, overall customer support department has the highest attrition rate
| Department       | Attrition Count | Attrition % |
|------------------|----------------|-------------|
| Customer Support | 7              | 30%         |
| Finance          | 5              | 20%         |
| Sales            | 4              | 10%         |

4) There's no early attrition but rather, 59% of attrition is Veteran Attrition
| Attrition Type      | Attrition % |
|---------------------|-------------|
| Veteran Attrition   | 59.3%       |
| Mid Term Attrition  | 40.7%       |
