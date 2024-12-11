-- I. Listening-related queries
-- Simple query for music from some application:
SELECT
    `title`
FROM
    `music`
ORDER BY
    `title`
LIMIT
    20;

-- Simple query with pagination -- get the "next page" of results:
-- OFFSET 20 means "start on the 20th result"
SELECT
    `title`
FROM
    `music`
ORDER BY
    `title`
LIMIT
    20
OFFSET
    20;

-- Filter by company
SELECT
    `title`,
    CONCAT (`composers`.`first_name`, `composers`.`last_name`) AS `composer`
FROM
    `music`
    JOIN `credits` ON `music_id` = `credits_music_id`
    JOIN `companies` ON `credits`.`company_id` = `companies`.`company_id`
WHERE
    `companies`.`name` LIKE "%Composer%"
ORDER BY
    `title`
LIMIT
    20;

-- Filter by composer
SELECT
    `title`,
    CONCAT (`composers`.`first_name`, `composers`.`last_name`) AS `composer`
FROM
    `music`
    JOIN `credits` ON `music_id` = `credits_music_id`
    JOIN `composers` ON `credits`.`composer_id` = `composers`.`composer_id`
WHERE
    `composers`.`first_name` LIKE "%Composer%"
    OR `composers`.`last_name` LIKE "%Composer%"
ORDER BY
    `title`
LIMIT
    20;

-- Filter by game
SELECT
    `title`
FROM
    `music`
    JOIN `appearances` ON `music`.`music_id` = `appearances`.`music_id`
    JOIN `games` ON `appearances`.`game_id` = `games`.`game_id`
WHERE
    `games`.`name` LIKE "%Game Title%"
ORDER BY
    `title`
LIMIT
    20;

-- Filter by game series
SELECT
    `title`
FROM
    `music`
    JOIN `appearances` ON `music`.`music_id` = `appearances`.`music_id`
    JOIN `games_series` ON `appearances`.`game_id` = `games_series`.`game_id`
    JOIN `series` ON `games_series`.`series_id` = `series`.`series_id`
WHERE
    `series`.`name` LIKE "%Series Title%"
ORDER BY
    `title`
LIMIT
    20;

-- Filter by console
SELECT
    `title`
FROM
    `music`
    JOIN `appearances` ON `music`.`music_id` = `appearances`.`music_id`
    JOIN `games_consoles` ON `appearances`.`game_id` = `games_consoles`.`game_id`
    JOIN `consoles` ON `games_consoles`.`console_id` = `consoles`.`console_id`
WHERE
    "%Console Name%" LIKE `consoles`.`name`
ORDER BY
    `title`
LIMIT
    20;

-- II. Account-related queries
-- Sign-up
INSERT INTO
    `accounts` (`username`, `email`, `password`, `type`)
VALUES
    (
        "jrgo7",
        "test_email@email.service.com",
        SHA1 ("password1234"),
        "user"
    );

-- Composer sign-up
START TRANSACTION;

INSERT INTO
    `accounts` (`username`, `email`, `password`, `type`)
VALUES
    (
        "yuzoko",
        "yuzoko@test.com",
        SHA1 ("actRaiser"),
        "composer"
    );

INSERT INTO
    `composers` (`account_id`, `last_name`, `first_name`)
VALUES
    (
        SELECT
            MAX(`account_id`)
        FROM
            `accounts`,
            "Koshiro",
            "Yuzo"
    );

COMMIT;

-- Company sign-up
START TRANSACTION;

INSERT INTO
    `accounts` (`username`, `email`, `password`, `type`)
VALUES
    (
        "pretendo",
        "pretendo@pretendo.com",
        SHA1 ("its-a-you"),
        "company"
    );

INSERT INTO
    `companies` (`account_id`, `name`)
VALUES
    (
        SELECT
            MAX(`account_id`)
        FROM
            `accounts`,
            "Pretendo"
    );

COMMIT;

-- III. Games management
-- Adding
START TRANSACTION;

INSERT INTO
    `games` (`company_id`, `name`)
VALUES
    (1, "The Great Miasma");

COMMIT;

-- Editing
START TRANSACTION;

UPDATE `games`
SET
    `name` = "The Greatest Miasma"
WHERE
    `name` = "The Great Miasma";

COMMIT;

-- Removing
START TRANSACTION;

DELETE FROM `games`
WHERE
    `name` = "The Greatest Miasma";

COMMIT;

-- IV. Series management
-- Adding
START TRANSACTION;

INSERT INTO
    `series` (`company_id`, `name`)
VALUES
    (1, "Miasma");

COMMIT;

-- Editing
START TRANSACTION;

UPDATE `series`
SET
    `name` = "The Miasmas"
WHERE
    `name` = "Miasma";

COMMIT;

-- Removing
START TRANSACTION;

DELETE FROM `series`
WHERE
    `name` = "The Miasmas";

COMMIT;

-- V. Consoles management
-- Adding
START TRANSACTION;

INSERT INTO
    `consoles` (`company_id`, `name`)
VALUES
    (1, "Super Moontendo");

COMMIT;

-- Editing
START TRANSACTION;

UPDATE `consoles`
SET
    `name` = "Super Moontendo Entertainment System"
WHERE
    `name` = "Super Moontendo";

COMMIT;

-- Removing
START TRANSACTION;

DELETE FROM `consoles`
WHERE
    `name` = "Super Moontendo Entertainment System";

COMMIT;

-- VI. Music management
-- Adding
START TRANSACTION;

INSERT INTO
    `music` (`title`, `path`)
VALUES
    ("Intro Stage", "mmx/snes/intro-stage.mp3");

COMMIT;

-- Editing
START TRANSACTION;

UPDATE `music`
SET
    `name` = "Intro Stage (SNES)"
WHERE
    `music_id` = 1;

COMMIT;

-- Removing
START TRANSACTION;

DELETE FROM `music`
WHERE
    `music_id` = 1;

COMMIT;

-- VII. Playlists management
-- Creating a playlist and adding music
START TRANSACTION;

INSERT INTO
    `playlists` (`account_id`, `name`)
VALUES
    (1, "Best of Miasma");

INSERT INTO
    `playlist_entries` (`playlist_id`, `music_id`)
VALUES
    (1, 1);

COMMIT;