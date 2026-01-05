-- SQL Advent Calendar - Day 12
-- Title: North Pole Network Most Active Users
-- Difficulty: hard
--
-- Question:
-- The North Pole Network wants to see who's the most active in the holiday chat each day. Write a query to count how many messages each user sent, then find the most active user(s) each day. If multiple users tie for first place, return all of them.
--
-- The North Pole Network wants to see who's the most active in the holiday chat each day. Write a query to count how many messages each user sent, then find the most active user(s) each day. If multiple users tie for first place, return all of them.
--

-- Table Schema:
-- Table: npn_users
--   user_id: INT
--   user_name: VARCHAR
--
-- Table: npn_messages
--   message_id: INT
--   sender_id: INT
--   sent_at: TIMESTAMP
--

-- My Solution:

select chat_day, user_name as most_active_user, total_messages
from
  (select 
      STRFTIME('%Y-%m-%d', m.sent_at) as chat_day,
      count(*) as total_messages,
      u.user_name,
      RANK() OVER (
        PARTITION BY STRFTIME('%Y-%m-%d', m.sent_at)
        ORDER BY COUNT(*) DESC
      ) AS rnk
    from npn_messages m
    join npn_users u 
      on m.sender_id = u.user_id
    group by chat_day, m.sender_id)
where rnk = 1
order by chat_day
;
