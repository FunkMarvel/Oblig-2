
-- Create example users
INSERT INTO gatchaimpact.usercredentials
VALUES ('Potteplante', 'Test123'),
       ('Space_Cat', 'BingusBangus');

-- Check userCredentials table
SELECT * FROM gatchaimpact.usercredentials;

-- Create example Players
Insert into gatchaimpact.player(PlayerName, UserName, ScoreBoardID,Money, Mana,QuestCompleteness)
VALUES ('Darth Waker', 'Potteplante', 0,  15000, 100, 52),
       ('Mark Blader','Space_Cat', 1, 150, 20, 1),
       ('Park Ranger', 'Potteplante', 2, 4200, 1000, 75),
       ('Ainz Flager', 'Space_Cat', 3, 100000, 1500, 99),
       ('Potteplante', 'Mark Sukkerberg', 15, 1,1 , 1);


-- Create example Quests
INSERT INTO gatchaimpact.quests(NPCID, PreviousQuest, NextQuest, QuestDescription, QuestRewardItemID, QuestRewardMoneyAmount)
VALUES ()


-- Create exampke ActiveQuests




