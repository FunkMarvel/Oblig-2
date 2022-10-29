
-- Create example users
INSERT INTO gatchaimpact.usercredentials
VALUES ('Potteplante', 'Test123'),
       ('Space_Cat', 'BingusBangus');

-- Check userCredentials table
SELECT * FROM gatchaimpact.usercredentials;


Insert into gatchaimpact.player(PlayerID, UserName, ScoreBoardID,Money, Mana,QuestCompleteness)
VALUES (0, 'Binugs', 15, 1,1 , 1);

Insert into gatchaimpact.player(UserName, ScoreBoardID,Money, Mana,QuestCompleteness)
VALUES ('Darth Waker', 0, 15000, 100, 52),
       ('Mark Blader', 1, 150, 20, 1, 21),
       ('Park Ranger', 2, 4200, 1000, 75),
       ('Ainz Flager', 3, 100000, 1500, 99);





