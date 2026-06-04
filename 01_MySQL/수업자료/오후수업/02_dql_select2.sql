# Builtin 함수
# - 문자형/숫자형/날짜형 자료형별 함수 제공
# - 반드시 반환값을 가진다.
# https://dev.mysql.com/doc/refman/8.0/en/built-in-function-reference.html

# 문자형 함수
# instr(대상문자열, 검색문자열) -> 인덱스
SELECT
    instr('사과딸기바나나', '딸기'), -- 3
    instr('사과딸기바나나', '키위') -- 0 (존재하지 않음)
;

-- 메뉴명에 마늘이 포함된 메뉴 찾기
select * from tbl_menu
where instr(menu_name, '마늘') > 0;


# format(숫자, 소수점자리수) -> 포맷팅문자열
select format(1234567890.12345, 3);


# lpad/rpad(문자열, 길이, 패딩문자)
# - 임의문자를 채워서 특정길이의 문자열 반환
select lpad('hello', 10, '*'), rpad('hello', 7, '*');


# substring(대상문자열, 시작인덱스, 길이) -> 잘라낸 문자열
select
    substring('hello world', 7, 3), -- wor
    substring('hello world', 7, 11), -- world
    substring('hello world', 7),  -- world
    substring('hello world', -5), -- world
    substr('hello world', -5)
;

# 정규표현식 (문자열 검색 특화 표현식)
# regexp_replace(문자열, 패턴, 바꿀값)
# regexp_instr(문자열, 패턴)
# regexp_substr(문자열, 패턴)
select
    regexp_replace('123,456원', '[^0-9]', ''), -- 123456
    regexp_instr('$123.456', '[0-9]'), -- 2
    regexp_substr('제 키는 150cm 입니다.', '[0-9]+') -- 150
    -- + : 1개 이상 반복
    -- [0-9] : 숫자
;

# 숫자처리함수
select
    ceiling(1234.56), -- 올림
    floor(1234.56), -- 내림
    truncate(1234.56, 1), -- 절삭
    round(1234.56),
    round(1234.567, 2)
;

# 날짜처리함수
# adddate(date, 일수)
# subdate(date, 일수)
select
    now(),
    adddate(now(), 1),
    subdate(now(), 1),
    adddate(now(), interval 10 year) -- interval 시간 자료형 day/month/year
;


# extract(단위 from datetime) -> 숫자
select
    extract(year from now()), -- 년
    extract(month from now()), -- 월
    extract(day from now()), -- 일
    extract(hour from now()), -- 시(24h)
    extract(minute from now()), -- 분
    extract(second from now())  -- 초
;

# date_format(datetime, 형식문자열) -> 문자열
select
    date_format(now(), '%y/%m/%d'),
    date_format(now(), '%Y/%m/%d'),
    date_format(now(), '%h:%i')
;

# str_to_date(문자열, 형식문자열) -> datetime
select
    str_to_date('26/05/27', '%y/%m/%d'),
    str_to_date('2026/05/27', '%Y/%m/%d')
;

# 기타함수
# null처리 함수 - ifnull(값, null일때 값)
select
    ifnull(category_code, '미지정')
from tbl_menu;

# 삼항연산처리 - if(조건식, 참일때 값, 거짓일때 값)
-- isnull(값) : null이면 1, 아니면 0 반환
select
    isnull(category_code),
    if(isnull(category_code), '미지정', category_code) category_code
from tbl_menu;

-- 메뉴 가격이 만원 미만이면 싸다, 아니면 비싸다 출력
select menu_name, menu_price,
    if(menu_price < 10000, '싸다', '비싸다') as '가격 평가'
from tbl_menu;



-- =============================================================
# 그룹함수
# - 특정행을 그룹핑하고 그룹별로 하나의 결과를 반환하는 함수
# - group by 구문을 사용해 그룹핑, group by를 사용하지 않으면 전체가 하나의 그룹
# - 그룹핑과 관계없는 일반컬럼은 조회불가

# sum(컬럼)
# - null이 아닌 컬럼의 합

select * from tbl_menu;
-- 메뉴 가격 총합 구하기
-- select menu_name, sum(menu_price) from tbl_menu;

select sum(menu_price) from tbl_menu;

-- 카테고리 코드가 10번인 메뉴들의 가격 합계 조회
select sum(menu_price) from tbl_menu
where category_code = 10;


# avg(컬럼) -> 평균값
# - null인 컬럼은 제외한 평균값

select truncate(avg(menu_price), 0) from tbl_menu;

# count(컬럼) -> 개수
# - null인 컬럼은 제외하고 개수 집계
select
    count(*) , -- * (모든 컬럼 = 행)
    count(menu_price) -- null인 컬럼 제외
from tbl_menu;

-- 샘플 데이터 추가
insert into tbl_menu values(22, '순대쉐이크', null, null, 'Y');
commit;
-- menu_price, category_code 제약조건 변경
ALTER TABLE tbl_menu modify menu_price int null;
ALTER TABLE tbl_menu modify category_code int null;

# 카테고리코드가 null이 아닌 행 개수 조회
select count(category_code) from tbl_menu;
select * from tbl_menu
where category_code is not null;

# max/min
# - 숫자/문자열/날짜시간에 대해 최대/최소값을 반환

select
    max(menu_price),
    min(menu_price),
    max(menu_name),
    min(menu_name)
from tbl_menu;


-- =====================================================
# group by 구문
# - 특정컬럼을 기준으로 grouping을 수행
# - 그룹함수와 함께 사용
select
    category_code, -- 그룹핑 기준 컬럼
    count(*),
    avg(menu_price)
from tbl_menu
group by category_code; -- category_code 값이 같은 행끼리 그룹핑 처리 (null도 하나의 그룹으로 처리)


# 주문가능 여부에 따른 메뉴개수 집계
select
    orderable_status, count(*)
from tbl_menu
group by orderable_status;

# 두개이상 컬럼에 대해서 그룹핑 가능
select
    category_code, orderable_status, count(*)
from tbl_menu
group by orderable_status, category_code -- 순서 상관 X
order by category_code;

# having 조건절
# - 그룹핑된 결과에 대한 조건절
# - where절과 달리 그룹함수 작성가능하다.

# 카테고리별 메뉴개수가 2개이상인 카테고리(카테고리명, 개수) 조회
select category_code, count(*)
from tbl_menu
group by category_code
having count(*) >= 2;


# 카테고리별 메뉴 개수 조회 (단, category_code가 NULL인 그룹 제외)
select
    category_code, count(*)
from tbl_menu
group by category_code
having category_code is not null; -- 일반 컬럼 조건은 WHERE가 더 효율적

-- 이유
-- HAVING : 그룹 생성 후 null 제거
-- WHERE  : 그룹 생성 전 null 제거
select
    category_code, count(*)
from tbl_menu
where category_code is not null
group by category_code;

select
    category_name,
    count(*) cnt
from tbl_menu m
join tbl_category c  on m.category_code = c.category_code
where m.category_code is not null
group by category_name
having cnt > 2
order by
    # count(*)
    cnt
;

# 일반적인 조건절





