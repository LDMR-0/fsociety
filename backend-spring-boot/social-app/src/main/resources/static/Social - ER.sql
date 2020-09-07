CREATE DATABASE FSOCIETY;

CREATE TABLE USERS (
    USER_ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    USER_NAME VARCHAR(50) ,
    USER_NICKNAME VARCHAR(50) NOT NULL,
    USER_MAIL VARCHAR(80) NOT NULL,
    USER_PASSWORD VARCHAR(255) NOT NULL,
    USER_IMAGE_PATH VARCHAR(255) ,
    USER_BIRTHDATE DATE,
    USER_GENDER VARCHAR(2),
    USER_ROLE VARCHAR(10) DEFAULT 'SOCIAL' NOT NULL,
    USER_CREATED_AT TIMESTAMP  NOT NULL,
    USER_STATUS VARCHAR(10) DEFAULT 'ONLINE' NOT NULL COMMENT 'BANEANDO, ONLINE, OFFLINE'
);

CREATE TABLE POST (
    POST_ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    POST_CONTENT VARCHAR(500) NOT NULL,
    POST_IMAGE_PATH VARCHAR(255),
    POST_CREATED_AT TIMESTAMP NOT NULL,
    USER_ID INT NOT NULL,
    POST_COMMENT INT,
    FOREIGN KEY (USER_ID) REFERENCES USERS (USER_ID) ON DELETE  CASCADE,
    FOREIGN KEY (POST_COMMENT) REFERENCES POST (POST_ID)  ON DELETE  CASCADE 
);

CREATE TABLE REACTION (
    USER_ID INT NOT NULL,
    TYPE_REACTION VARCHAR(10) NOT NULL COMMENT 'LIKE, DISLIKE',
    POST_ID INT NOT NULL,
    FOREIGN KEY (USER_ID) REFERENCES USERS (USER_ID),
    FOREIGN KEY (POST_ID) REFERENCES POST (POST_ID) 
);

CREATE TABLE CHAT (
    USER_ONE INT NOT NULL,
    USER_TWO INT NOT NULL,
    CHAT_STATUS VARCHAR(10) NOT NULL COMMENT 'REQUEST, ACEPTED, CLOSED'
);

CREATE TABLE VISIT (
    USER_ID INT NOT NULL,
    VISIT_DATE DATETIME NOT NULL,
    FOREIGN KEY (USER_ID) REFERENCES USERS (USER_ID) 
);

--PRODEDURES USER

--CREATE
DELIMITER $$

CREATE PROCEDURE create_user(PUSER_NICKNAME VARCHAR(50), PUSER_MAIL VARCHAR(80), PUSER_PASSWORD VARCHAR(20))

BEGIN
	INSERT INTO USERS (USER_NICKNAME,USER_MAIL,USER_PASSWORD,USER_CREATED_AT) VALUES (PUSER_NICKNAME,PUSER_MAIL,PUSER_PASSWORD,NOW());
END$$

DELIMITER ;

CALL create_user('Celso','Celso_ROJAS@GMAIL','TITITI');


--UPDATE
SET @@SESSION.sql_mode='NO_ZERO_DATE,NO_ZERO_IN_DATE';

DELIMITER $$

CREATE PROCEDURE update_user(PUSER_NAME VARCHAR(50),PUSER_NICKNAME VARCHAR(50), PUSER_MAIL VARCHAR(80), PUSER_PASSWORD VARCHAR(20),PUSER_BIRTHDATE DATE,PUSER_GENDER VARCHAR(2),PUSER_ID INT)

BEGIN
    UPDATE USERS
    SET USER_NAME = PUSER_NAME, USER_NICKNAME= PUSER_NICKNAME, USER_MAIL = PUSER_MAIL, USER_PASSWORD = PUSER_PASSWORD, USER_BIRTHDATE = PUSER_BIRTHDATE, USER_GENDER = PUSER_GENDER
	WHERE USER_ID = PUSER_ID;

END$$

DELIMITER ;

CALL update_user('PAPS','PAN','Celso_ROJAS@GMAIL','TITITI',STR_TO_DATE('24-05-2020', '%d-%M-%Y'),'MALE',1);

--DELETE

DELIMITER $$

CREATE PROCEDURE delete_user(PUSER_ID INT)

BEGIN
    DELETE FROM USERS
	WHERE USER_ID = PUSER_ID;

END$$

DELIMITER ;

CALL delete_user(1);



