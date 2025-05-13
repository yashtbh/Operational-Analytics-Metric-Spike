CREATE DATABASE IF NOT EXISTS metrix;
USE metrix;

#[Case Study 2: Investigating Metric Spike]
#Weekly User Engagement:
SELECT DATE_SUB(occurred_at, INTERVAL (DAYOFWEEK(occurred_at) - 1) DAY) AS week_start,
    COUNT(*) AS event_count
FROM events
GROUP BY DATE_SUB(occurred_at, INTERVAL (DAYOFWEEK(occurred_at) - 1) DAY)
ORDER BY week_start;



#User Growth Analysis
SELECT DATE(created_at) AS date,
    COUNT(DISTINCT user_id) AS new_users
FROM users
GROUP BY DATE(created_at)
ORDER BY date;



#Weekly Retention Analysis:
SELECT DATE(u.created_at) AS sign_up_week,
    DATEDIFF(DATE(e.occurred_at), DATE(u.created_at)) / 7 AS retention_week,
    COUNT(DISTINCT e.user_id) AS retained_users
FROM users u
LEFT JOIN events e ON u.user_id = e.user_id
GROUP BY DATE(u.created_at), DATEDIFF(DATE(e.occurred_at), DATE(u.created_at)) / 7
ORDER BY sign_up_week, retention_week;



#Weekly Engagement Per Device
SELECT DATE(occurred_at) AS engagement_week,
    device,
    COUNT(*) AS event_count
FROM events
GROUP BY DATE(occurred_at), device
ORDER BY engagement_week, device;



#Email Engagement Analysis
SELECT DATE(occurred_at) AS engagement_date,
    action,
    COUNT(*) AS total_actions,
    COUNT(DISTINCT user_id) AS unique_users
FROM email_events
GROUP BY DATE(occurred_at), action
ORDER BY engagement_date, action;






