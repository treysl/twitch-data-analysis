-- Path: Twitch_data.sql
-- Tables for data
CREATE TABLE chat;
CREATE TABLE stream;

-- most popular games on Twitch
SELECT game, COUNT(game)
FROM stream
GROUP BY game
ORDER BY COUNT(game) DESC;

-- most popular viewership countries on Twitch
SELECT country, COUNT(country)
FROM stream
GROUP BY country
ORDER BY COUNT(country) DESC;

-- diving into League of Legends since it's the most popular game
SELECT country, COUNT(country)
FROM stream
WHERE game = 'League of Legends'
GROUP BY country
ORDER BY COUNT(country) DESC;

-- aggregating the source of viewership by device
SELECT player, COUNT(player)
FROM stream
GROUP BY 1
ORDER BY 2 DESC;

-- creating a grouping for the top five games' genre
SELECT game,
    CASE
        WHEN game = 'Dota 2'
            THEN 'MOBA'
        WHEN game = 'League of Legends' 
            THEN 'MOBA'
        WHEN game = 'Heroes of the Storm'
            THEN 'MOBA'
        WHEN game = 'Counter-Strike: Global Offensive'
            THEN 'FPS'
        WHEN game = 'DayZ'
            THEN 'Survival'
        WHEN game = 'ARK: Survival Evolved'
            THEN 'Survival'
        ELSE 'Other'
    END AS 'genre',
  COUNT(game)
FROM stream
GROUP BY game
ORDER BY COUNT(game) DESC;

-- for sqlite, using strftime function to determine what the best time of day for streaming is
SELECT strftime('%H', time), COUNT(1)
FROM stream
WHERE country = "US" -- remove this for global results
GROUP BY 1;

-- joining the two tables together
SELECT *
FROM stream
JOIN chat 
  ON stream.device_id = chat.device_id
LIMIT 20;