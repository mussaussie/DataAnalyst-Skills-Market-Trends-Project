SELECT 
     skills,
     COUNT (skills_job_dim.job_id) AS demanded_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Analyst' 
  AND job_location = 'Anywhere' 
GROUP BY skills
ORDER BY denmaded_count DESC
LIMIT 5;

/*SQL is the most in-demand skill for data analyst roles in 2023, followed by Excel, Python, Tableau, and Power BI. 
 -These are the core tools employers are consistently seeking, so prioritizing them in your skillset would be highly beneficial. 