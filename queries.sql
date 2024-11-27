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

-- Filter by game: TODO
SELECT
    `title`
FROM
    `music`
ORDER BY
    `title`
LIMIT
    20;

-- Filter by game series: TODO
SELECT
    `title`
FROM
    `music`
ORDER BY
    `title`
LIMIT
    20;

-- Filter by console: TODO
SELECT
    `title`
FROM
    `music`
ORDER BY
    `title`
LIMIT
    20;

-- Filter by everything but game: TODO
SELECT
    `title`
FROM
    `music`
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

-- III. Games, series, and consoles management
-- Adding
-- Editing
-- Removing
-- IV. Music management