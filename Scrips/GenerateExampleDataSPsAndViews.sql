-- This script generates example data, stored procedures, and views for the database
-- Create example users
INSERT INTO GatchaImpact.UserCredentials
VALUES ('Potteplante', 'Test123'),
       ('Space_Cat', 'BingusBangus');

-- Create example items
INSERT INTO GatchaImpact.Items(Name, Type, Damage, Value)
VALUES ('Stick', 'One-handed', 5, 1),
       ('Torch', 'One-handed', 10, 5),
       ('Longsword', 'Versatile', 50, 45);

-- Create example Players
INSERT INTO GatchaImpact.player(PlayerName, UserName, Score, Money, Mana, QuestCompleteness)
VALUES ('Darth Waker', 'Potteplante', 0, 15000, 100, 52),
       ('Mark Blader', 'Space_Cat', 1, 150, 20, 1),
       ('Park Ranger', 'Potteplante', 2, 4200, 1000, 75),
       ('Mark Sukkerberg', 'Potteplante', 15, 1, 1, 1);

-- Create example non-player characters
INSERT INTO gatchaimpact.npc(Name, Type, Health, Mana, Difficulity)
VALUES ('Arne Hole', 'Mathmagician', 1000, 9001, 9),
       ('Harry Hole', 'Proffesional Alcohol drinker', 50, 24, 1),
       ('Georg', 'King of jungle', 80, 15, 5),
       ('John Arne Riise', 'Football-player', 43, 10, 6),
       ('Amouranth', 'Water', 116, 45, 15),
       ('Bell Delphine', 'Water', 114, 77, 10)
;

-- Create example inventories
INSERT INTO gatchaimpact.inventory(IsPlayer, EntityID, ItemID, Quantity, MainHand, OffHand, Armor)
VALUES (1, 1, 1, 10, 0, 0, 0),
       (1, 2, 3, 4, 1, 0, 1);

-- Create example Quests
INSERT INTO gatchaimpact.quests(NPCID, PreviousQuest, NextQuest, QuestDescription, QuestRewardItemID,
                                QuestRewardMoneyAmount)
VALUES (1, NULL, 1, 'Potion Seller:
Traveller i require you help to make my strongest potions!', 2, 500),
       (2, NULL, 1, 'Mankar Camoran:
So, the cat''s-paw of the Septims arrives at last. You didn''t think me unawares? Here of all places, in the paradise that I created? Look now, upon my paradise, Gaiar Alata, in the old tongue, a vision of the past... and the future.',
        2, 500),
       (1, NULL, 2, 'Emperor Uriel Septim VII:
Find him... and close shut the jaws of Oblivion.', 2, 500),
       (2, NULL, 3, 'Emperor Uriel Septim VII:
I can go no further. You alone must stand against the Prince of Destruction and his Mortal Servants. He must not have the Amulet of Kings!',
        2, 500),
       (2, NULL, 3, 'En pog fysiker:
''Peker på en pose med Jasmin ris'', Jaaaaas.. min ris!!!', 2, 500),
       (2, NULL, 3, 'keanu  Reeves:
In 2077, what makes someone a criminal? Getting caught.', 2, 500),
       (3, NULL, 4, 'Dalinar Kholin:
The most important step a man can take. It''s not the first one, is it? It''s the next one. Always the next step.', 2,
        500),
       (4, NULL, 5, 'Potion Seller:
You cannot handle my strongest Potions', 2, 500);

-- Create example ActiveQuests
INSERT INTO GatchaImpact.ActiveQuests(PlayerID, QuestID)
VALUES (1, 1), -- p1
       (1, 2),
       (2, 1), -- p2
       (2, 4),
       (3, 5), -- p3
       (3, 6),
       (4, 7), -- p4
       (4, 8);

-- Populate boss table:
Insert into gatchaimpact.boss(NPCID)
value (1),
    (1),
    (6),
    (4);

-- Below: creation of stored procedures and views
-- SP to create user:
DROP PROCEDURE IF EXISTS createUser;
CREATE PROCEDURE createUser(IN NewUserName VARCHAR(50), IN userPWD VARCHAR(50))
BEGIN
    INSERT INTO gatchaimpact.usercredentials(UserName, Password) VALUES (NewUserName, userPWD);
END;

-- Change Username Procedure
DROP PROCEDURE IF EXISTS ChangeUsername;
CREATE PROCEDURE ChangeUsername(
    IN OldUserName VARCHAR(50),
    IN NewUsername VARCHAR(50),
    IN CurrentPassword VARCHAR(50)
)
BEGIN
    IF (SELECT Password FROM GatchaImpact.usercredentials WHERE UserName = OldUserName) = CurrentPassword
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
            SET MESSAGE_TEXT = 'Provided password or username is incorrect';
    END IF;
END;

-- Change password of existing user
DROP PROCEDURE IF EXISTS ChangePassword;
CREATE PROCEDURE ChangePassword(
    IN SomeUserName VARCHAR(50),
    IN OldPassword VARCHAR(50),
    IN NewPassword VARCHAR(50)
)
BEGIN
    -- Check if provided old password is correct:
    IF (SELECT Password
        FROM GatchaImpact.UserCredentials
        WHERE UserCredentials.UserName = SomeUserName) = OldPassword
    THEN
        -- update password:
        UPDATE GatchaImpact.UserCredentials
        SET UserCredentials.Password = NewPassword
        WHERE UserCredentials.UserName = SomeUserName;
    ELSE
        -- Signal error if old password didn't match existing user
        SIGNAL SQLSTATE '42000'
            SET MESSAGE_TEXT = 'Provided invalid value for username or old password in ChangePassword procedure.';
    END IF;
END;

-- SP to display inventory
DROP PROCEDURE IF EXISTS displayNPCInventory;
CREATE PROCEDURE displayNPCInventory(IN playerID INT)
BEGIN
    SELECT * FROM inventory WHERE playerID = EntityID AND IsPlayer = 1;
END;

-- Create new player for existing user:
CREATE PROCEDURE CreatePlayer(
    IN OwnerName VARCHAR(50),
    IN CharacterName VARCHAR(50)
)
BEGIN
    INSERT INTO GatchaImpact.Player(UserName, PlayerName, Score, Money, Mana, QuestCompleteness)
        VALUE (OwnerName, CharacterName, 0, 100, 100, 0);
END;

-- Create new NPCs
DROP PROCEDURE IF EXISTS createNPC;
CREATE PROCEDURE createNPC(IN NewName VARCHAR(50), IN NewType VARCHAR(45), IN NewHealth INT, IN NewMana INT,
                           IN NewDifficulty INT)
BEGIN
    INSERT INTO gatchaimpact.npc(Name, Type, Health, Mana, Difficulity)
    VALUES (NewName, NewType, NewHealth, NewMana, NewDifficulty);
END;


-- View players
CREATE OR REPLACE VIEW DisplayGamers AS
SELECT u.UserName, player.PlayerName, PlayerID
FROM player
         JOIN usercredentials u ON player.UserName = u.UserName;