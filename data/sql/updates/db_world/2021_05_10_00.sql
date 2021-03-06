-- DB update 2021_05_09_05 -> 2021_05_10_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_05_09_05';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_05_09_05 2021_05_10_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1620411738725445836'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1620411738725445836');

UPDATE `gameobject` SET `spawntimesecs`= 7200 WHERE FIND_IN_SET (`id`,'2855,2857,4096,4149,153453,153454,153451,153468');
UPDATE `gameobject` SET `spawntimesecs`= 36000 WHERE FIND_IN_SET (`id`,'153464,153469');


--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
