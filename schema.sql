-- In this SQL file, write (and comment!) the schema of your database, including
-- the CREATE TABLE, CREATE INDEX, CREATE VIEW, etc. statements that compose it

-- Represents all accounts in the system.
CREATE TABLE `accounts` (
    `account_id` INT PRIMARY KEY UNSIGNED AUTOINCREMENT,
    `username` VARCHAR(32) UNIQUE NOT NULL,
    `email` VARCHAR(64) UNIQUE NOT NULL, 
    `password` BINARY(20) NOT NULL, -- SHA-1
    `type` ENUM('user', 'composer', 'company') NOT NULL,
    `join_date` DATE DEFAULT CURRENT_TIMESTAMP
);

-- Biography entries take up a lot of space, and not everyone would probably
-- have an entry, so they're separate from the `accounts` table.
CREATE TABLE `bio` (
    `account_id` INT UNSIGNED,
    `bio` VARCHAR(2048) NOT NULL,
    FOREIGN KEY (`account_id`) REFERENCES `accounts` (`account_id`)
);

-- Unlike users, composers can provide additional information about themselves.
CREATE TABLE `composers` (
    `composer_id` INT PRIMARY KEY UNSIGNED AUTOINCREMENT
    `last_name` VARCHAR(64) NOT NULL,
    `middle_initial` VARCHAR(1), -- Not every name has a middle initial
    `first_name` VARCHAR(64) NOT NULL
);

-- Companies, like composers, can provide additional information.
CREATE TABLE `companies` (
    `company_id` INT PRIMARY KEY UNSIGNED AUTOINCREMENT,
    `name` VARCHAR(64) NOT NULL UNIQUE
);

-- Represents video games, where VGM can appear in.
CREATE TABLE `games` (
    `game_id` INT PRIMARY KEY UNSIGNED AUTOINCREMENT,
    `company_id` INT UNSIGNED,
    `name` VARCHAR(64) NOT NULL UNIQUE,
    FOREIGN KEY `company_id` REFERENCES `companies` (`company_id`)
);

-- Represents a series of related video games.
CREATE TABLE `series` (
    `series_id` INT PRIMARY KEY UNSIGNED AUTOINCREMENT,
    `company_id` INT UNSIGNED,
    `name` VARCHAR(64) NOT NULL UNIQUE,
    FOREIGN KEY `company_id` REFERENCES `companies` (`company_id`)
);

-- Represents a video game console.
CREATE TABLE `consoles` (
    `console_id` INT PRIMARY KEY UNSIGNED AUTOINCREMENT,
    `company_id` INT UNSIGNED,
    `name` VARCHAR(64) NOT NULL UNIQUE
    FOREIGN KEY `company_id` REFERENCES `companies` (`company_id`)
);

-- Associates games to series. Games can be part of many series,
-- e.g., Mario Kart 8 is in the Mario Kart series and in the wider Mario series.
CREATE TABLE `games_series` (
    `game_id` INT UNSIGNED,
    `series_id` INT UNSIGNED,
    FOREIGN KEY `game_id` REFERENCES `games` (`game_id`),
    FOREIGN KEY `series_id` REFERENCES `series` (`series_id`)
);

-- Associates games to consoles. Games can be released in many consoles, such as
-- Minecraft, which has been released for the PC, mobile phones, etc.
CREATE TABLE `games_consoles` (
    `game_id` INT UNSIGNED,
    `series_id` INT UNSIGNED,
    FOREIGN KEY `game_id` REFERENCES `games` (`game_id`),
    FOREIGN KEY `series_id` REFERENCES `series` (`series_id`)
);

-- Represents VGM.
CREATE TABLE `music` (
    `music_id` INT PRIMARY KEY UNSIGNED AUTOINCREMENT,
    `title` VARCHAR(64) NOT NULL,
    `path` VARCHAR(128), -- file path
    `upload_date` DATE DEFAULT CURRENT_TIMESTAMP
);

-- Tracks the credits of a certain song.
-- A composer may not always be in the same company, so a company must also
-- be provided.
CREATE TABLE `credits` (
    `music_id` INT UNSIGNED NOT NULL,
    `company_id` INT UNSIGNED NOT NULL,
    `composer_id` INT UNSIGNED NOT NULL,
    FOREIGN KEY (`music_id`) REFERENCES `music` (`music_id`),
    FOREIGN KEY (`company_id`) REFERENCES `company` (`company_id`),
    FOREIGN KEY (`composer_id`) REFERENCES `composer` (`composer_id`)
);

-- VGM can appear in multiple games; this tracks each game appearance of a VGM.
CREATE TABLE `appearances` (
    `music_id` INT UNSIGNED NOT NULL,
    `game_id` INT UNSIGNED NOT NULL,
);