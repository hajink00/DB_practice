-- 현재 MySQL 서버에 존재하는 모든 데이터베이스(DB) 목록 조회
show databases;
show schemas;

-- mysql DB : MySQL 설치 시 기본으로 자동 생성되는 시스템 데이터베이스
use mysql;
select user, host from user;

# sql문 대소문자를 구분하지 않는다. (실제 데이터의 대소문자는 구분함)
SELECT USER, HOST FROM USER;

# (root 관리자계정) 새로운 계정 user 생성
-- user
-- host : % = 모든 ip를 의미 --> 모든 ip에서 사용 가능하다
-- identified by 비밀번호(대소분자 구분)
create user 'khj'@'%' identified by 'khj';

# (root 관리자계정) 새로운 database(schema) 생성
create database khjdb;
# create schema khjdb;

# 새로 생성한 계정에게 db 사용권한을 부여
grant all privileges on khjdb.* to 'khj'@'%';

# 권한 적용
flush privileges;
