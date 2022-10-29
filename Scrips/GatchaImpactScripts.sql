
-- Create example users
INSERT INTO gatchaimpact.usercredentials
VALUES ('Potteplante', 'Test123'),
       ('Space_Cat', 'BingusBangus');

-- Check userCredentials table
SELECT * FROM gatchaimpact.usercredentials;


Insert into gatchaimpact.player(PlayerID, UserName, PlayerName, ScoreBoardID,Money, Mana,QuestCompleteness)
VALUES (0, 'Potteplante', 'Mark Sukkerberg', 15, 1,1 , 1);

Insert into gatchaimpact.player(PlayerName, UserName, ScoreBoardID,Money, Mana,QuestCompleteness)
VALUES ('Darth Waker', 'Potteplante', 0,  15000, 100, 52),
       ('Mark Blader','Space_Cat', 1, 150, 20, 1),
       ('Park Ranger', 'Potteplante', 2, 4200, 1000, 75),
       ('Ainz Flager', 'Space_Cat', 3, 100000, 1500, 99);

 -- INSERT INTO gatchaimpact.items(Type, Damage, Value)
 -- VALUES ('Stick', 5, )



