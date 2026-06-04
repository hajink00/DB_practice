-- ====================================
-- DDL
-- ====================================
-- 데이터 정의 언어 Data Definition Language
-- 데이터베이스 객체(Object)를 만들고 (CREATE), 수정하고(ALTER), 삭제(DROP)하는 구문
-- ROLLBACK, COMMIT등 TCL을 사용하지 않고, 자동커밋된다. DML과 혼용시 주의해야한다.



create table product (
    # 컬럼명 자료형 제약조건 기본값 주석
    id int primary key auto_increment comment '상품식별코드',
    name varchar(100) not null comment '상품명',
    price int not null default 0 comment '상품가격',
    created_at datetime default (current_timestamp) comment '상품정보 등록일시'
) comment '상품 테이블';

-- 생성한 ddl문 확인
show create table product;

-- 데이터딕셔너리 (DD)에서 주석 확인
-- - db객체에 대한 메타정보를 관리하는 읽기전용 테이블(뷰)
select
    *
from
    information_schema.tables
where
    table_schema = 'menudb' and table_name = 'product';

# 행추가





# 제약조건 Constraint
-- 테이블 작성 시 각 컬럼에 값 기록에 대한 제약조건을 설정할 수 있다.
-- 데이터 무결성 보장을 목적으로 함
-- 입력/수정하는 데이터에 문제가 없는지 자동으로 검사해 주게 하기 위한 목적
-- PRIMARY KEY, NOT NULL, UNIQUE, CHECK, FOREIGN KEY

# 테이블별 제약조건 조회

-- drop table if exists user
create table if not exists user (
    id int primary key auto_increment,
    username varchar(100) not null unique,
    password varchar(100) not null,
    name varchar(100) not null,
    email varchar(255) unique,
    gender char(1) check(gender in ('M', 'F'))
);

insert into user
values(null, 'honggd', '1234', '홍길동', 'honggd@naver.com', 'M');


# primary key
# - 테이블에서 정확히 하나의 행을 구분해 내기위한 컬럼
# - not null, unique처럼 작동하며, 테이블당 하나의 PK컬럼을 허용
# - 여러 컬럼을 묶어서 복합컬럼pk를 사용할 수 있다. --> 복합키

# 어느 회원이 어떤 상품을 몇개 언제 구매한다.
create table order_composite_pk (
    user_id int,
    prod_id int,
    count int default 1,
    ordered_at datetime default (current_timestamp),
    primary key(user_id, prod_id, ordered_at)
);

insert into order_composite_pk values (1, 1, 10, now());
insert into order_composite_pk values (2, 1, 10, now());
insert into order_composite_pk values (3, 1, default, now());
-- > 단점 : PK가 길고, 다른 테이블에서 해당 주문을 참조하는 경우 FK도 3개 컬럼이 필요함

# 추천
create table order_composite_pk2 (
    user_id int primary key ,
    prod_id int,
    count int default 1,
    ordered_at datetime default (current_timestamp),
    unique(user_id, prod_id, ordered_at)
);


-- 외래키 foreign key
-- - 참조(REFERENCES)된 다른 테이블에서 제공하는 값만 사용할 수 있음
-- - 참조 무결성을 위배하지 않기 위해 사용
-- - FOREIGN KEY 제약조건에 의해서 테이블 간의 관계(RELATIONSHIP)가 형성 됨
-- - 제공되는 값 외에는 NULL을 사용할 수 있음

-- 배송지 address 테이블
-- user.id를 참조하는 user_id fk컬럼을 생성

drop table if exists address;
create table if not exists address (
    id int primary key auto_increment,
    user_id int,
    address_line text not null,
    created_at datetime default (current_timestamp),
    FOREIGN KEY(user_id) references user(id)
                                    -- (기본값)
                                    # on delete restrict
                                    # on update restrict

                                    -- 부모행 삭제/수정 시 자식 fk컬럼값 null
                                    # on delete set null
                                    # on update set null

                                    -- 부모행 삭제/수정 시 자식행도 연쇄적으로 삭제
                                    on delete cascade
                                    on update cascade
);

insert into address
values (null, 1, '서울시',  default);

insert into address
values (null, 2, '서울시',  default);
-- [23000][1452] Cannot add or update a child row: a foreign key constraint fails

-- 부모행(user) 삭제
set autocommit = 0;
delete from user where id = 1;
-- [23000][1451] Cannot delete or update a parent row: a foreign key constraint fails

-- 자식행 - 부모행 순으로 삭제
delete from address where user_id = 1;
delete from user where id = 1;

select  * from address;


# alter 테이블 수정
-- alter table 테이블명 [서브명령어] ....
-- - add 컬럼/제약조건 추가
-- - drop 컬럼/제약조건 삭제
-- - modify 컬럼 자료형/not null/기본값 변경
-- - change 컬럼명 변경
-- - rename 테이블명 변경

drop table if exists product;
create table if not exists product(
    id int,
    name varchar(100),
    created_at datetime
);

-- 컬럼추가
-- price 정수타입(int), 기본값 0, 코멘트는 '가격', null 허용 불가
ALTER table product
    add column price int default 0 comment '가격' not null after name; -- 순서 [first] [after 기존컬럼]

select * from product;

-- 제약조건 추가
-- id에 PK 추가
alter table product
add primary key(id);


-- 컬럼삭제
alter table product
drop column price;


-- 제약조건 삭제
-- pk 삭제
alter table product
drop primary key;

desc product;
-- name not null 제약조건 변경
-- not null은 modify로 변경
alter table product
modify name varchar(100) not null;

-- 컬럼명 변경
-- name을 prod_name으로 변경
alter table product
change name prod_name varchar(100) not null;

desc product;