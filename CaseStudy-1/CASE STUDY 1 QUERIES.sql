CREATE DATABASE IF NOT EXISTS operational_analytics;
USE operational_analytics;

SElECT * From job_data;


-- CASE STUDY 1 ---- TASK A --- JOBS REVIEWED OVER TIME
-- Calculate the number of jobs reviewed per hour for each day in Nov 2020

SELECT ds AS Date,
    COUNT(job_id) AS Joint_Job_Id,
    ROUND((SUM(time_spent) / 3600), 2) AS Total_Time_Sp_Hr,
    ROUND((COUNT(job_id) / (SUM(time_spent) / 3600)), 2) AS Job_Rview_PHr_PDay
FROM job_data
WHERE STR_TO_DATE(ds, '%m/%d/%Y') BETWEEN '2020-11-01' AND '2020-11-30'
GROUP BY ds
ORDER BY STR_TO_DATE(ds, '%m/%d/%Y');


#B Weekly Average Throughput (Overall)
SELECT ROUND(COUNT(event) / SUM(time_spent), 2) AS weekly_avg_throughput
FROM job_data;

-- Daily Average Throughput (Per Day)
SELECT ds AS Dates,
    ROUND(COUNT(event) / SUM(time_spent), 2) AS daily_avg_throughput
FROM job_data
GROUP BY ds
ORDER BY STR_TO_DATE(ds, '%m/%d/%Y');

#C Language Share Percentage
SELECT language,
    ROUND(100 * COUNT(*) / total, 2) AS Percentage,
    jd.total
FROM job_data
CROSS JOIN (
    SELECT COUNT(*) AS total
    FROM job_data
) AS jd
GROUP BY language, jd.total;

#D Duplicate Rows Detection:

SELECT actor_id, COUNT(*) AS Duplicate
FROM job_data
GROUP BY actor_id
HAVING COUNT(*) > 1;

