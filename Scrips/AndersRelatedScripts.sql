
-- Create example users
INSERT INTO gatchaimpact.usercredentials
VALUES ('Potteplante', 'Test123'),
       ('Space_Cat', 'BingusBangus');

SELECT * FROM gatchaimpact.usercredentials;

-- Create example items
INSERT INTO gatchaimpact.items(Name, Type, Damage, Value)
VALUES ('Stick', 'One-handed', 5, 1),
       ('Torch', 'One-handed', 10, 5),
       ('Longsword', 'Versatile', 50, 45);

SELECT * FROM gatchaimpact.items;

-- Create new player for existing user:
CREATE PROCEDURE CreatePlayer(
    IN UserName VARCHAR(50),
    IN PlayerName VARCHAR(50)
)
BEGIN
    INSERT INTO gatchaimpact.player(UserName, PlayerName, Score, Money, Mana, QuestCompleteness)
        VALUE (UserName, PlayerName, 0, 100, 100, 0);
END;

CALL CreatePlayer('Potteplante', 'Goldfish');

SELECT * FROM gatchaimpact.player;

-- Change password of existing user
CREATE PROCEDURE ChangePassword(
    IN SomeUserName VARCHAR(50),
    IN OldPassword VARCHAR(50),
    IN NewPassword VARCHAR(50)
)
BEGIN
    -- Check if provided old password is correct:
    IF (SELECT Password FROM gatchaimpact.usercredentials
        WHERE usercredentials.UserName = SomeUserName) = OldPassword
    THEN
        -- update password:
        UPDATE gatchaimpact.usercredentials
        SET usercredentials.Password = NewPassword
        WHERE usercredentials.UserName = SomeUserName;
    ELSE
        -- Signal error if old password didn't match existing user
        SIGNAL SQLSTATE '42000'
        SET MESSAGE_TEXT = 'Provided invalid value for username or old password in ChangePassword procedure.';
    END IF;
END;

CALL ChangePassword('Potteplante', 'Test123', 'SchmakerGodt');

SELECT * FROM usercredentials;