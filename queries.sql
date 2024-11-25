-- In this SQL file, write (and comment!) the typical SQL queries users will run
-- on your database

-- I. Listening-related queries

-- Simple query for music from some application:
SELECT `title` FROM `music` ORDER BY `title` LIMIT 20;

-- Simple query with pagination -- get the "next page" of results:
-- OFFSET 20 means "start on the 20th result"
SELECT `title` FROM `music` ORDER BY `title` LIMIT 20 OFFSET 20;

-- Filter by company: TODO
SELECT `title` FROM `music` ORDER BY `title` LIMIT 20;

-- Filter by composer: TODO
SELECT `title` FROM `music` ORDER BY `title` LIMIT 20;

-- Filter by game: TODO
SELECT `title` FROM `music` ORDER BY `title` LIMIT 20;

-- Filter by game series: TODO
SELECT `title` FROM `music` ORDER BY `title` LIMIT 20;

-- Filter by console: TODO
SELECT `title` FROM `music` ORDER BY `title` LIMIT 20;

-- Filter by everything but game: TODO
SELECT `title` FROM `music` ORDER BY `title` LIMIT 20;

-- II. Account-related queries

-- Sign-up

-- Composer sign-up

-- Company sign-up


-- III. Games, series, and consoles management

-- Adding

-- Editing

-- Removing

-- IV. Music management