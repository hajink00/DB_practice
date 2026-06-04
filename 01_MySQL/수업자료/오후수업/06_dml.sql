-- ===================================
-- DML
-- ===================================
-- DML(Data Manipulation Language)
-- Data를 조작(삽입, 수정, 삭제, 조회)하기 위해 사용하는 언어
-- Data를 이용하려는 사용자와 DB사이의 인터페이스를 직접적으로 제공하는 언어로써 가장 많이 사용됨
-- INSERT, UPDATE, DELETE, SELECT(DQL)

# INSERT
-- 새로운 행을 추가하는 구문이다.
-- 테이블의 행의 수가 증가한다.
-- insert요청시 처리된 행의 수가 반환된다. (PyCharm에서 Service뷰-Output탭에서 확인이 가능)

# 문법
-- 1. INSERT INTO <테이블명> VALUES (입력데이터1, 입력데이터2, ... );
-- 2. INSERT INTO <테이블명>(컬럼명1,컬럼명2,...) VALUES (입력데이터1, 입력데이터2, ... );`
--      - null을 허용하는 컬럼은 생략가능하다(생략되면 null값이 대입)
--      - not null인 컬럼은 생략할 수 없다.(단, default값이 지정되면 생략가능)
-- 3. INSERT INTO <테이블명>(컬럼명1,컬럼명2,...) VALUES
--      (입력데이터1, 입력데이터2, ... ), (입력데이터1, 입력데이터2, ... ), ... ;

# 행(record) 추가
# - 제약조건에 위배되는 컬럼값이 하나라도 있으면 추가할 수 없다.
# - not null컬럼에는 null값이 있을 수 없다.
# - pk, unique컬럼에는 중복값이 들어갈 수 없다.
# - fk컬럼 참조하는 컬럼 이외의 값을 들어갈 수 없다.
# - check컬럼 제시된 도메인외의 값을 들어갈 수 없다.
desc tbl_menu;

# 문법1. 테이블 구조대로 작성해야 한다. (컬럼순서,개수)
-- 1. INSERT INTO <테이블명> VALUES (입력데이터1, 입력데이터2, ... );
insert into tbl_menu
values (null,'딸기김치찌개', 9500, 5,'Y');

insert into tbl_menu
values (null,null, 9500, 5,'Y');
-- [23000][1048] Column 'menu_name' cannot be null

select * from tbl_menu;



# 문법2: 작성한 컬럼값만 제공
-- 2. INSERT INTO <테이블명>(컬럼명1,컬럼명2,...) VALUES (입력데이터1, 입력데이터2, ... );`
-- 메뉴명, 가격, 카테고리 코드, 주문가능여부만 추가
insert into tbl_menu (menu_name, menu_price, category_code, orderable_status)
values ('돈까스', 14500, 3, 'Y');

insert into tbl_menu (menu_name, menu_price, category_code, orderable_status)
values ('돈까스', 14500, 'Y');
-- [21S01][1136] Column count doesn't match value count at row 1




# 문법3: 대량 데이터 추가
-- 3. INSERT INTO <테이블명>(컬럼명1,컬럼명2,...) VALUES
insert into tbl_menu
values
    (null, '바닐라 쉐이크', 1500, 12, 'Y'),
    (null, '소금빵 쉐이크', 1800, 12, 'Y'),
    (null, '소금빵 국밥', 2800, 12, 'Y');

select * from tbl_menu;
# update
# - 테이블 기존행의 컬럼값을 수정
# - 일반적으로 pk컬럼값을 이용해 행을 찾고, 수정
-- update 테이벌명 set 컬럼명 = 컬럼값 [where 조건식];

set autocommit  = 0; -- 오토커밋 끄기
commit;
# 19번 메뉴의 가격을 천원 인상
update tbl_menu
set menu_price = menu_price + 1000
where menu_code = 19;

select * from tbl_menu;
rollback; -- 마지막 commit 시점으로 되돌리기

# 한식류(4번) 가격 인상
update tbl_menu
set menu_price = menu_price + 500
where category_code = 4;

select * from tbl_menu where category_code = 4;
-- [출력 정보값]
-- select : resultSet (각 행의 정보)
-- DML : 성공한 행의 개수(int)

# delete
# - 지정한 행을 삭제
# - 일반적으로 pk컬럼을 통해 행을 찾고, 삭제
-- delete from 테이블명 [where 조건식];

-- 메뉴 코드가 24번인 행 삭제
delete from tbl_menu where menu_code =24;

# replace
# - upsert기능 수행 (insert + update)
# - pk컬럼 기준으로 행이 존재하지 않으면 insert 처리
# - 존재하면, update 처리
replace into
    tbl_menu
values(100, '참기름막걸리', 5000, 10, 'Y');

replace into
    tbl_menu
values(100, '들기름막걸리', 5000, 10, 'Y');

select * from tbl_menu;
# 트랜잭션 처리
# - dml수행 - commit : 변경사항 적용
# - dml수행 - rollback : 변경사항 폐기
commit;

-- Auto Commit 상태 확인
-- 0 : 꺼짐, 1 : 켜짐
SELECT @@autocommit;

-- Auto Commit 상태 변경
set autocommit = 0;






