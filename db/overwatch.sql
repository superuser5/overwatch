CREATE DATABASE overwatch;

mysql> show tables;
+--------------------------+
| Tables_in_overwatch      |
+--------------------------+
| banner                   |
| ipaddr                   |
| link                     |
| master                   |
| master_holding_4m_to_8m  |
| master_holding_8m_to_12m |
| master_holding_first_4m  |
| mastertesting            |
| masterunique             |
| portnumbers              |
| webviewer                |
+--------------------------+
11 rows in set (0.00 sec)


CREATE TABLE portnumbers (
id INT AUTO_INCREMENT NOT NULL,
portnum VARCHAR(50) NOT NULL,
primary key (id)
);

mysql> describe portnumbers;
+---------+-------------+------+-----+---------+-------+
| Field   | Type        | Null | Key | Default | Extra |
+---------+-------------+------+-----+---------+-------+
| id      | int(11)     | NO   | PRI | NULL    |       |
| portnum | varchar(50) | NO   |     | NULL    |       |
+---------+-------------+------+-----+---------+-------+
2 rows in set (0.00 sec)

CREATE TABLE banner (
id INT AUTO_INCREMENT NOT NULL,
banner VARCHAR(10000) NOT NULL,
primary key (id)
);

mysql> describe banner;
+--------+----------------+------+-----+---------+-------+
| Field  | Type           | Null | Key | Default | Extra |
+--------+----------------+------+-----+---------+-------+
| id     | int(11)        | NO   | PRI | NULL    |       |
| banner | varchar(10000) | NO   |     | NULL    |       |
+--------+----------------+------+-----+---------+-------+
2 rows in set (0.00 sec)

CREATE TABLE ipaddr (
id INT AUTO_INCREMENT NOT NULL,
ipaddr VARCHAR(50) NOT NULL,
primary key (id)
);

mysql> describe ipaddr;
+--------+-------------+------+-----+---------+-------+
| Field  | Type        | Null | Key | Default | Extra |
+--------+-------------+------+-----+---------+-------+
| id     | int(11)     | NO   | PRI | NULL    |       |
| ipaddr | varchar(50) | NO   |     | NULL    |       |
+--------+-------------+------+-----+---------+-------+
2 rows in set (0.00 sec)

CREATE TABLE master (
id INT AUTO_INCREMENT NOT NULL,
banner VARCHAR(10000) NOT NULL,
ipaddr VARCHAR(50) NOT NULL,
portnum VARCHAR(50) NOT NULL,
primary key (id)
);

mysql> describe master;
+---------+----------------+------+-----+---------+-------+
| Field   | Type           | Null | Key | Default | Extra |
+---------+----------------+------+-----+---------+-------+
| id      | int(11)        | NO   | PRI | NULL    |       |
| banner  | varchar(10000) | YES  |     | NULL    |       |
| ipaddr  | varchar(50)    | YES  |     | NULL    |       |
| portnum | varchar(50)    | YES  |     | NULL    |       |
+---------+----------------+------+-----+---------+-------+
4 rows in set (0.00 sec)
