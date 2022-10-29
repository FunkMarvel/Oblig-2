
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
       -- ('Ainz Flager', 'Space_Cat', 3, 100000, 1500, 99),
       ('Mark Sukkerberg', 'Potteplante', 15, 1,1 , 1);


-- Create example Quests
INSERT INTO gatchaimpact.quests(NPCID, PreviousQuest, NextQuest, QuestDescription, QuestRewardItemID, QuestRewardMoneyAmount)
VALUES (0, NULL, 1, 'You cannot handle my strongest Potions', 2, 500),
(0, NULL, 1, 'Mankar Camoran:
So, the cat''s-paw of the Septims arrives at last. You didn''t think me unawares? Here of all places, in the paradise that I created? Look now, upon my paradise, Gaiar Alata, in the old tongue, a vision of the past... and the future.', 2, 500),
(1, NULL, 2, 'Emperor Uriel Septim VII:
Find him... and close shut the jaws of Oblivion.', 2, 500),
(2, NULL, 3, 'Emperor Uriel Septim VII:
I can go no further. You alone must stand against the Prince of Destruction and his Mortal Servants. He must not have the Amulet of Kings!', 2, 500),
(3, NULL, 4, 'Dalinar:
The most important step a man can take. It''s not the first one, is it?It''s the next one. Always the next step.', 2, 500),
(4, NULL, 5, 'You cannot handle my strongest Potions', 2, 500);


-- Create example ActiveQuests

INSERT INTO gatchaimpact.`active quests`(PlayerID, QuestID)
VALUES (0,0), -- p1
       (0,1),
       (1,1), -- p2
       (1,2),
       (2,2), -- p3
       (2,3),
       (3,3), -- p4
       (3,4);



