use tabledb;

CREATE table usertbl(
    userID CHAR(8) NOT NULL PRIMARY KEY,
    name VARCHAR(10) NOT NULL,
    birthyear INT NOT NULL,
    addr CHAR(2) NOT NULL,
    mobile1 CHAR(3) NULL,
    mobile2 CHAR(8) NULL,
    height SMALLINT NULL,
    mDate date NULL
);


CREATE table buytbl(
    num INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    userID CHAR(8) NOT NULL,
    prodName CHAR(6) NOT NULL,
    groupName CHAR(4) NULL,
    price INT NOT NULL,
    amount SMALLINT NOT NULL

);

INSERT INTO usertbl VALUES
                        ('LSG', '이승기', 1987, '서울', '011', '1111111', 182, '2008-08-08'),
                        ('KBS', '김범수', 1979, '경남', '011', '2222222', 173, '2012-04-04'),
                        ('KKH', '김경호', 1971, '전남', '019', '3333333', 177, '2007-07-07');