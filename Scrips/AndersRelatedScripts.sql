-- Create example users
SELECT *
FROM GatchaImpact.UserCredentialschangelog;

INSERT INTO GatchaImpact.UserCredentials
VALUES ('Potteplante', 'Test123'),
       ('Space_Cat', 'BingusBangus');

SELECT *
FROM GatchaImpact.UserCredentials;

-- Create example items
INSERT INTO GatchaImpact.Items(Name, Type, Damage, Value)
VALUES ('Stick', 'One-handed', 5, 1),
       ('Torch', 'One-handed', 10, 5),
       ('Longsword', 'Versatile', 50, 45);

SELECT *
FROM GatchaImpact.Items;

-- Create new player for existing user:
CREATE PROCEDURE CreatePlayer(
    IN UserName VARCHAR(50),
    IN PlayerName VARCHAR(50)
)
BEGIN
    INSERT INTO GatchaImpact.Player(UserName, PlayerName, Score, Money, Mana, QuestCompleteness)
        VALUE (UserName, PlayerName, 0, 100, 100, 0);
END;

CALL CreatePlayer('Potteplante', 'Goldfish');

SELECT *
FROM GatchaImpact.Player;

-- Change password of existing user
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

CALL ChangePassword('Potteplante', 'Test123', 'SchmakerGodt');

DELETE
FROM UserCredentials
WHERE UserName = 'Potteplante';

SELECT *
FROM UserCredentials;