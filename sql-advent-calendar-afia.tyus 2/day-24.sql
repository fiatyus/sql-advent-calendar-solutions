-- SQL Advent Calendar - Day 24
-- Title: New Year Goals - User Type Analysis
-- Difficulty: hard
--
-- Question:
-- As the New Year begins, the goals tracker team wants to understand how user types differ. How many completed goals does the average user have in each user_type?
--
-- As the New Year begins, the goals tracker team wants to understand how user types differ. How many completed goals does the average user have in each user_type?
--

-- Table Schema:
-- Table: user_goals
--   user_id: INT
--   user_type: VARCHAR
--   goal_id: INT
--   goal_status: VARCHAR
--

-- My Solution:

select user_type, avg(completed_goals) as avg_completed_goals
from
  (select user_id, user_type, 
  sum(case when goal_status = 'Completed' THEN 1 ELSE 0 END) AS completed_goals
  from user_goals
  group by user_id, user_type)
group by user_type
