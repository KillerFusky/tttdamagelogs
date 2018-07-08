CREATE TABLE IF NOT EXISTS `damagelogs_players`
(
  `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `steamid` VARCHAR(25) NOT NULL UNIQUE,
  `name` VARCHAR(40) NOT NULL
);

CREATE TABLE IF NOT EXISTS `damagelogs_punish`
(
  `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `date` BIGINT NOT NULL,
  `punishmentid` INT NOT NULL,
  `player` INT NOT NULL,
  `count` INT NOT NULL,
  `reason` VARCHAR(255) NOT NULL,
  FOREIGN KEY (`player`) REFERENCES damagelogs_players (id),
  KEY (`player`)
);

CREATE TABLE IF NOT EXISTS `damagelogs_logs`
(
  `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `datetime` DATETIME NOT NULL,
  `encodedlogs` MEDIUMTEXT,
  KEY (`datetime`)
);

DROP PROCEDURE IF EXISTS add_old_logs;
CREATE PROCEDURE add_old_logs
  (IN in_encodedlogs MEDIUMTEXT)
  BEGIN
    INSERT INTO damagelogs_logs(datetime, encodedlogs) VALUES (NOW(), in_encodedlogs);
  END;

DROP PROCEDURE IF EXISTS on_player_join;
CREATE PROCEDURE on_player_join
  (IN in_steamid VARCHAR(25), IN in_name VARCHAR(40))
  BEGIN
    DECLARE playerExists BOOL;
    SET playerExists = (SELECT EXISTS(SELECT 1
                                      FROM damagelogs_players
                                      WHERE steamid = in_steamid
                                      LIMIT 1));
    IF (NOT playerExists)
    THEN
      BEGIN
        INSERT INTO damagelogs_players (steamid, name) VALUES (in_steamid, in_name);
      END;
    ELSE
      BEGIN
        UPDATE damagelogs_players
        SET name = in_name
        WHERE steamid = in_steamid;
      END;
    END IF;
  END;