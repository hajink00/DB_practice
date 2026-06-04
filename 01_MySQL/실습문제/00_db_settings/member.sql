DROP TABLE IF EXISTS `MEMBER`;

CREATE TABLE `MEMBER` (
	`member_no`	int	NOT NULL	COMMENT '회원번호',
	`member_email`	VARCHAR(50)	NOT NULL	COMMENT '회원 이메일(아이디)',
	`member_pw`	VARCHAR(30)	NOT NULL	COMMENT '회원 비밀번호',
	`member_nick`	VARCHAR(30)	NOT NULL	COMMENT '회원 닉네임',
	`member_tel`	CHAR(11)	NULL	COMMENT '전화번호("-" 제외)',
	`member_addr`	VARCHAR(500)	NULL	COMMENT '회원 주소',
	`enroll_dt`	DATETIME	NOT NULL	DEFAULT CURRENT_TIMESTAMP	COMMENT '회원 가입일(DEFAULT CURRENT_TIMESTAMP)',
	`secession_f1`	CHAR(1)	NOT NULL	DEFAULT 'N'	COMMENT '탈퇴 여부(Y: 탈퇴, N: 미탈퇴, DEFAULT "N")'
);

ALTER TABLE `MEMBER` ADD CONSTRAINT `PK_MEMBER` PRIMARY KEY (
	`member_no`
);

