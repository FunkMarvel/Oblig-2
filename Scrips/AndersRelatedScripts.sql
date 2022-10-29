
-- Create example users
INSERT INTO gatchaimpact.usercredentials
VALUES ('Potteplante', 'Test123'),
       ('Space_Cat', 'BingusBangus');

-- Check userCredentials table
SELECT * FROM gatchaimpact.usercredentials;

-- Create example items
INSERT INTO gatchaimpact.items(Type, Damage, Value)
VALUES ('Stick', 5, 1),
       ('Torch', 10, 5);



