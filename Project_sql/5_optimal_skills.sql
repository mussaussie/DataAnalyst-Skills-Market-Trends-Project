WITH skills_demand AS (
     SELECT 
     skills_dim.skill_id,
     skills_dim.skills,
     COUNT (skills_job_dim.job_id) AS demanded_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Analyst' 
  AND job_location = 'Anywhere' 
    AND salary_year_avg IS NOT NULL
GROUP BY skills_dim.skill_id, skills_dim.skills
), average_salary AS ( SELECT 
     skills_job_dim.skill_id,
     ROUND(AVG(salary_year_avg), 2) AS average_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Analyst' 
    AND job_location = 'Anywhere' 
    AND salary_year_avg IS NOT NULL
GROUP BY skills_job_dim.skill_id
)
SELECT skills_demand.skill_id,
       skills_demand.skills,
       skills_demand.demanded_count,
       average_salary.average_salary

FROM skills_demand
INNER JOIN average_salary ON skills_demand.skill_id = average_salary.skill_id
WHERE demanded_count > 10 
ORDER BY skills_demand.demanded_count DESC, average_salary.average_salary DESC
LIMIT 20;

/* Key Insights from the "Optimal Skills" Dataset (2023)
SQL, Excel, and Python are the most in-demand skills, with SQL topping the list at 398 job postings.
-a strong indication that foundational data handling is critical in the field.
-Python and R offer higher average salaries (over $100K), suggesting that roles requiring programming and statistical analysis are better compensated.
-Skills like SQL and Excel have high demand but modest salaries.
-Skills like Python, R, and Tableau balance both moderate-to-high demand and higher salary, making them strategic for career growth.*/