DROP TABLE slots;

DROP TABLE avail;

CREATE TABLE slots (slot serial, sunday text[12],monday text[12],tuesday text[12],wednesday text[12],thursday text[12],friday text[12],saturday text[12]);

CREATE TABLE avail (slot serial , sunday  SMALLINT DEFAULT 0,monday  SMALLINT DEFAULT 0,tuesday  SMALLINT DEFAULT 0,wednesday  SMALLINT DEFAULT 0,
thur sday SMALLINT DEFAULT 0,friday  SMALLINT DEFAULT 0,saturday  SMALLINT DEFAULT 0);

                                                                                                                                                     
CREATE TABLE count (id SMALLINT DEFAULT 0,number SMALLINT DEFAULT 0,violations SMALLINT DEFAULT 0);  
                                                                                                                                                     
                                                                                                                                                     
INSERT INTO count(id) values (1)                                                                                                                                     
INSERT INTO slots(slot) values (9),(10),(11),(12),(13),(14),(15),(16),(17),(18),(19),(20),(21);
INSERT INTO avail(slot) values (9),(10),(11),(12),(13),(14),(15),(16),(17),(18),(19),(20),(21);


