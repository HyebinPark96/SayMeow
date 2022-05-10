DROP TABLE IF EXISTS product;

create table product(
 pnum int primary key AUTO_INCREMENT NOT null,
 pname varchar(20) NOT null,
 mclass varchar(20) NOT null,
 sclass varchar(20) NOT NULL,
 price1 int,
 price2 int,
 price3 int,
 image varchar(20) DEFAULT "ready.png",
 detail varchar(20),
 pstat tinyint DEFAULT 1,
 stock int DEFAULT 0
);

INSERT INTO product (pname, mclass, sclass, price1) 
VALUES ("건식사료1", "food", "dry", 10000);
INSERT INTO product (pname, mclass, sclass, price1) 
VALUES ("건식사료2", "food", "dry", 20000);
INSERT INTO product (pname, mclass, sclass, price1) 
VALUES ("습식사료1", "food", "wet", 30000);
INSERT INTO product (pname, mclass, sclass, price1) 
VALUES ("습식사료2", "food", "wet", 40000);
INSERT INTO product (pname, mclass, sclass, price1) 
VALUES ("스낵1", "treat", "snack", 5000);
INSERT INTO product (pname, mclass, sclass, price1) 
VALUES ("스낵2", "treat", "snack", 3000);
INSERT INTO product (pname, mclass, sclass, price1) 
VALUES ("스틱1", "treat", "stick", 6000);
INSERT INTO product (pname, mclass, sclass, price1) 
VALUES ("스틱2", "treat", "stick", 9000);
INSERT INTO product (pname, mclass, sclass, price1) 
VALUES ("카샤카샤1", "toy", "pole", 12000);
INSERT INTO product (pname, mclass, sclass, price1) 
VALUES ("카샤카샤2", "toy", "pole", 14000);
INSERT INTO product (pname, mclass, sclass, price1) 
VALUES ("인형1", "toy", "plush", 4000);
INSERT INTO product (pname, mclass, sclass, price1) 
VALUES ("인형2", "toy", "plush", 3000);
INSERT INTO product (pname, mclass, sclass, price1) 
VALUES ("모래1", "litter", "sand", 50000);
INSERT INTO product (pname, mclass, sclass, price1) 
VALUES ("모래2", "litter", "sand", 60000);
INSERT INTO product (pname, mclass, sclass, price1) 
VALUES ("화장실1", "litter", "box", 70000);
INSERT INTO product (pname, mclass, sclass, price1) 
VALUES ("화장실2", "litter", "box", 100000);