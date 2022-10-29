
-- Create example Players
Insert into GatchaImpact.player(PlayerName, UserName, Score,Money, Mana,QuestCompleteness)
VALUES ('Darth Waker', 'Potteplante', 0,  15000, 100, 52),
       ('Mark Blader','Space_Cat', 1, 150, 20, 1),
       ('Park Ranger', 'Potteplante', 2, 4200, 1000, 75),
       -- ('Ainz Flager', 'Space_Cat', 3, 100000, 1500, 99),
       ('Mark Sukkerberg', 'Potteplante', 15, 1,1 , 1);



-- Create example Quests
INSERT INTO gatchaimpact.quests(NPCID, PreviousQuest, NextQuest, QuestDescription, QuestRewardItemID, QuestRewardMoneyAmount)
VALUES (1, NULL, 1, 'Potion Seller:
Traveller i require you help to make my strongest potions!', 2, 500),
       (2, NULL, 1, 'Mankar Camoran:
So, the cat''s-paw of the Septims arrives at last. You didn''t think me unawares? Here of all places, in the paradise that I created? Look now, upon my paradise, Gaiar Alata, in the old tongue, a vision of the past... and the future.', 2, 500),
       (1, NULL, 2, 'Emperor Uriel Septim VII:
Find him... and close shut the jaws of Oblivion.', 2, 500),
       (2, NULL, 3, 'Emperor Uriel Septim VII:
I can go no further. You alone must stand against the Prince of Destruction and his Mortal Servants. He must not have the Amulet of Kings!', 2, 500),
       (2, NULL, 3, 'En pog fysiker:
''Peker på en pose med Jasmin ris'', Jaaaaas.. min ris!!!', 2, 500),
       (2, NULL, 3, 'keanu  Reeves:
In 2077, what makes someone a criminal? Getting caught.', 2, 500),
       (3, NULL, 4, 'Dalinar Kholin:
The most important step a man can take. It''s not the first one, is it? It''s the next one. Always the next step.', 2, 500),
       (4, NULL, 5, 'Potion Seller:
You cannot handle my strongest Potions', 2, 500);



-- Create example ActiveQuests

INSERT INTO GatchaImpact.ActiveQuests(PlayerID, QuestID)
VALUES (1,1), -- p1
       (1,2),
       (2,1), -- p2
       (2,4),
       (3,5), -- p3
       (3,6),
       (4,7), -- p4
       (4,8);



-- Find all ActiveQuests to all players'
-- Hensikt: en administrator / eller utvikler for spillet kan se alle spilleres quests
SELECT p.UserName, QuestID FROM ActiveQuests
JOIN player p ON p.PlayerID = ActiveQuests.PlayerID
ORDER BY p.UserName;


-- How many players has a quest?
-- Hensikt: Administrator / uvikler kan se hvor mange som har samme quest
SELECT COUNT(*) as Instances, `ActiveQuests`.QuestID FROM `ActiveQuests`
JOIN player p ON p.PlayerID = `ActiveQuests`.PlayerID
GROUP BY `ActiveQuests`.QuestID;

-- Find all ActiveQuests for a player
-- Hennsikt: en spiller kan kunne se alle sine ActiveQuests i en ingame menu
SELECT p.PlayerName, p.PlayerID as PID, `ActiveQuests`.QuestID FROM `ActiveQuests`
    JOIN player p ON p.PlayerID = `ActiveQuests`.PlayerID
WHERE p.PlayerName = 'Darth Waker';


-- Insert new quest
-- Hensikt: Legg til en ny quest
INSERT INTO quests (NPCID, PreviousQuest, NextQuest, QuestDescription, QuestRewardItemID, QuestRewardMoneyAmount)
VALUES
    (2, NULL, NULL, 'Some Grandpa:
It''s dangerus to go alone, take this!.. After you complete this quest!!', 2, 40);



DROP PROCEDURE IF EXISTS ChangeUsername;
-- Change Username Procedure
CREATE PROCEDURE ChangeUsername(
    In OldUserName VARCHAR(50),
    IN NewUsername VARCHAR(50),
    IN CurrentPassword VARCHAR(50)
)
BEGIN
    IF(SELECT Password FROM GatchaImpact.usercredentials WHERE UserName = OldUserName) = CurrentPassword
    THEN
        SET FOREIGN_KEY_CHECKS = 0;
        UPDATE GatchaImpact.usercredentials
        SET GatchaImpact.usercredentials.UserName = NewUsername
        WHERE UserName = OldUserName;

        UPDATE GatchaImpact.player
        SET player.UserName = NewUsername
        WHERE player.UserName = OldUserName;

        SET FOREIGN_KEY_CHECKS = 1;
    ELSE
        -- signal error
        SIGNAL SQLSTATE '42000'
        SET MESSAGE_TEXT = 'Provided password or username is inncorrect';
    END IF;
END;

CALL ChangeUsername('Space_Cat', 'math_moe', 'BingusBangus')


--
# SELECT *
# FROM player
# JOIN usercredentials u ON u.UserName = player.UserName;

# INSERT INTO player(PlayerName, UserName, ScoreBoardID,Money, Mana,QuestCompleteness)
# SELECT 'Joe The Student', id_teacher
# FROM usercredentials
# WHERE name_teacher = 'Professor Jack'
# LIMIT 1
