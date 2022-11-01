-- Important select statements:

-- Find all ActiveQuests to all players'
-- Hensikt: en administrator / eller utvikler for spillet kan se alle spilleres quests
SELECT p.UserName, QuestID
FROM ActiveQuests
         JOIN player p ON p.PlayerID = ActiveQuests.PlayerID
ORDER BY p.UserName;

-- How many players has a quest?
-- Hensikt: Administrator / utvikler kan se hvor mange som har samme quest
SELECT COUNT(*) AS Instances, `ActiveQuests`.QuestID
FROM `ActiveQuests`
         JOIN player p ON p.PlayerID = `ActiveQuests`.PlayerID
GROUP BY `ActiveQuests`.QuestID;

-- Find all ActiveQuests for a player
-- Hennsikt: en spiller kan kunne se alle sine ActiveQuests i en ingame menu
SELECT p.PlayerName, p.PlayerID AS PID, `ActiveQuests`.QuestID
FROM `ActiveQuests`
         JOIN player p ON p.PlayerID = `ActiveQuests`.PlayerID
WHERE p.PlayerName = 'Darth Waker';

-- Insert new quest
-- Hensikt: Legg til en ny quest
INSERT INTO quests (NPCID, PreviousQuest, NextQuest, QuestDescription, QuestRewardItemID, QuestRewardMoneyAmount)
VALUES (2, NULL, NULL, 'Some Grandpa:
It\'s dangerous to go alone, take this!.. After you complete this quest!!', 2, 40);

-- Usage of SPs and Views (NB!! GenerateExampleDataSPsAndViews.sql must be run before the below statements):
-- Creates new player for user Potteplante:
CALL CreatePlayer('Potteplante', 'Goldfish');

-- Changes password for user Potteplante:
CALL ChangePassword('Potteplante', 'Test123', 'SchmakerGodt');

-- Changes username for user Space_Cat:
CALL ChangeUsername('Space_Cat', 'math_moe', 'BingusBangus');

-- Creates new npc:
CALL createNPC('Einar', 'Datamaskin', 27, 11, 13);

-- View changelog for players:
SELECT Action, ActionTime, OldUsername, NewUsername, OldPassword, NewPassword
FROM GatchaImpact.UserCredentialsChangelog;