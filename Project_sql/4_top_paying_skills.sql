SELECT 
     skills,
     ROUND(AVG(salary_year_avg), 2) AS average_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Analyst' 
    AND job_location = 'Anywhere' 
    AND salary_year_avg IS NOT NULL
GROUP BY skills
ORDER BY average_salary DESC
LIMIT 25;

/*Highest Paying Skills:

Specialized tools such as PySpark, Bitbucket, and Couchbase command the highest average salaries—over $150K, with PySpark topping at $208K+.

These are more niche but indicate high value in big data, ML, and DevOps-integrated roles.