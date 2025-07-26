/* 
 Questopn : What skill are required for the top-paying jobs in the Data Analyst field? 
 -Use the top 10 10 highest paying Data Anlyst jobs from fiorst query 
- Add specific skills required for these roles.
*/

WITH top_paying_jobs AS (
    SELECT   job_id,
         job_title,
         salary_year_avg,
         name as company_name
FROM job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE 
     job_title_short = 'Data Analyst' AND 
     job_location = 'Anywhere' AND
     salary_year_avg IS NOt NULL 
ORDER BY salary_year_avg DESC
LIMIT 10   
)
SELECT top_paying_jobs.*,
       skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY top_paying_jobs.salary_year_avg DESC;

/*Key Observations
SQL and Python are by far the most requested skills, appearing in nearly every job.

Tableau stands out as the top visualization/BI tool, while Power BI also appears in several postings.

Statistical/programming languages like R and Python are prioritized alongside database and cloud technologies (e.g., Snowflake, Azure).

Excel and pandas remain popular for hands-on data wrangling and analysis.

A few roles request less common or role-specific tools like Go, Crystal, Flow, Jenkins, and Gitlab.*/