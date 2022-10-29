
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

