


-- NPC VALUES

SELECT * FROM gatchaimpact.npc;
SELECT * FROM gatchaimpact.player;

INSERT INTO gatchaimpact.npc(Name, Type, Health, Mana, Difficulity) VALUES
('Arne Hole', 'Mathmagician', 1000, 9001, 9),
('Harry Hole', 'Proffesional Alcohol drinker', 50, 24, 1),
('Georg', 'King of jungle', 80, 15, 5),
('John Arne Riise', 'Football-player', 43, 10, 6),
('Amouranth', 'Water', 116, 45, 15),
('Bell Delphine', 'Water', 114, 77, 10)
;


-- Inventory Values

INSERT INTO gatchaimpact.inventory(IsPlayer, EntityID, ItemID, Quantity, MainHand, OffHand, Armor) VALUES
(1,1,1,10,0,0,0),
(1,2,3,4,1,0,1)
;

SELECT * FROM gatchaimpact.inventory;

-- Active Quests Values
/*
INSERT INTO gatchaimpact.`active quests`(PlayerID,QuestID) VALUES
(1,1),
(2,1),
(3,1),
(4,2);
SELECT * FROM gatchaimpact.`active quests`;
 */


CREATE PROCEDURE createUser(IN userName VARCHAR(50) , IN userPWD VARCHAR(50))
BEGIN
    INSERT INTO gatchaimpact.usercredentials(UserName, Password) VALUES (userName, userPWD);
END;


CAll gatchaimpact.createUser('Trond Halvorsen', 'SekstiNi');



/* -- scrap this shit
CREATE VIEW viewUsers AS
SELECT ALL UserName from usercredentials
INNER RIGHT JOIN PlayerID from gatcha.playerID;
;*/

/*
CREATE VIEW viewUsersAndPlayers
SELECT UserName FROM usercredentials
UNION
Select PlayerID From player;
 */

/* -- funker ikke :(
CREATE VIEW viewUsers AS
SELECT PlayerName, UserName
FROM gatchaimpact.player, gatchaimpact.usercredentials
WHERE  gatchaimpact.usercredentials.UserName = gatchaimpact.player.PlayerName;
 */


CREATE VIEW rumpe AS
SELECT gatchaimpact.usercredentials.UserName, gatchaimpact.player.PlayerName

FROM gatchaimpact.usercredentials, gatchaimpact.player
WHERE gatchaimpact.usercredentials.UserName NOT LIKE gatchaimpact.player.PlayerName;
DROP VIEW rumpe;

CREATE VIEW viewUsers AS
    SELECT gatchaimpact.player.PlayerID AS spillerID, gatchaimpact.player.PlayerName AS SpillerNavn, gatchaimpact.usercredentials.UserName AS Brukernavn
FROM gatchaimpact.player, gatchaimpact.usercredentials

;


DROP VIEW viewUsers;
SELECT * FROM gatchaimpact.viewusers;


select * from gatchaimpact.rumpe;