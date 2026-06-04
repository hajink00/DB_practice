-- ====================================
-- DQL
-- ====================================
-- DML 하위 분류
-- Data Query Language 데이터 질의 언어
-- 테이블의 데이터를 검색/조회하는 명령어
-- 조회결과를 ResultSet (결과집합)이라고 한다. (0행이상을 반환)
-- 특정테이블, 특정행, 시각화할 컬럼, 정렬방식등을 선택할 수 있다.

# DQL구조
/*
    select 컬럼명 (5)  -- 필수
    from 테이블 (1)  -- 필수
    where 조건절(필터링) (2)
    group by 그룹핑 (3)
    having 조건절(그룹핑에 대해 필터링) (4)
    order by 정렬기준 (6)
    limit 행수제한

    1. SELECT : 조회하고자 하는 컬럼명을 기술함. 여러개를 기술하고자 하면 쉼표(,)로 구분하고 모든 컬럼 조회시 '*'을 사용
    2. FROM : 조회 대상 컬럼이 포함된 테이블명을 기술
    3. WHERE :
        행을 선택하는 조건을 기술함.
        여러 개의 제한 조건을 포함할 수 있으며, 각각의 제한 조건은 논리 연산자로 연결함
        제한조건을 만족시키는 행들만 Result Set에 포함됨
    4. ORDER BY : 정렬할 컬럼을 기준으로 오름/내림차순 지정
    5. GROUP BY : 행을 그룹핑함
    6. HAVING : 그룹핑된 행을 선택하는 조건을 기술함
*/

desc tbl_menu; -- tbl_menu 테이블의 구조 확인
DESCRIBE tbl_category;

-- tbl_menu 테이블에서 메뉴코드, 메뉴명, 가격 조회
SELECT menu_code, menu_name, menu_price
FROM tbl_menu;

-- tbl_menu 테이블의 모든 컬럼 조회
SELECT * FROM tbl_menu;

-- 계산된 식 사용 가능
-- 별칭(alias)지정 가능
SELECT
    menu_name,
    menu_price as 원가,
    menu_price * 0.9 '할인된 금액'
FROM tbl_menu;

# sql 산술연산자
# from 생략하면, 가상테이블에서 조회함
SELECT
    5 + 3,
    5 - 3,
    5 * 3,
    5 / 3,
    -- 5 // 3
    5 div 3, -- 몫
    5 % 3,    -- 나머지
    5 mod 3
;

# 문자열 연결처리
# - concat(문자열, 문자열)
-- OOO메뉴의 금액은 OOO원 입니다.
SELECT
    concat(menu_name, ' 메뉴의 금액은 ', menu_price, '원 입니다.') as 설명
FROM tbl_menu;

# 중복행 제거
-- 카테고리 코드 중복 제거
SELECT DISTINCT category_code
FROM tbl_menu;


-- =====================================================
# WHERE 행 필터링
# - 각행별로 제시한 조건을 검사하고, TRUE인 행만 결과집합에 포함시킨다.

# WHERE 비교 연산자
-- 표현식 사이의 관계를 비교하기 위해 사용하고, 비교 결과는 논리 결과중에 하나 (TRUE/FALSE/NULL)가 됨
-- 단, 비교하는 두 컬럼 값/표현식은 서로 동일한 데이터 타입이어야 함

-- --------------------------------------------------------------------------------
-- 연산자			        설명
-- --------------------------------------------------------------------------------
-- =			            같다
-- >,<			            크다/작다
-- >=,<=		            크거나 같다/작거나 같다
-- <>,!=		            같지 않다 (^= 없음)
-- BETWEEN AND		        특정 범위에 포함되는지 비교
-- LIKE / NOT LIKE		    문자 패턴 비교
-- IS NULL / IS NOT NULL	NULL 여부 비교
-- IN / NOT IN		        비교 값 목록에 포함/미포함 되는지 여부 비교
-- --------------------------------------------------------------------------------


# WHERE 논리 연산자
-- 여러 개의 제한 조건 결과를 하나의 논리결과로 만들어 줌 (&&,|| 사용불가)
-- AND &&	여러 조건이 동시에 TRUE일 경우에만 TRUE 값 반환
-- OR ||	여러 조건들 중에 어느 하나의 조건만 TRUE이면 TRUE값 반환
-- NOT !	조건에 대한 반대값으로 반환(NULL은 예외)
-- XOR	    두 값이 같으면 거짓, 두 값이 다르면 참


SELECT * FROM tbl_menu
WHERE
    # orderable_status = 'Y' -- tbl_menu 테이블에서 주문 가능한 행만 조회
    # menu_price = 12000 -- 메뉴 가격이 12000원인 행만 조회
    # menu_name = '라자냐' -- 메뉴명이 라자냐
    -- 가격이 10000원 이상 20000원 이하
    -- menu_price >= 10000 and menu_price <= 20000
    -- menu_price between 10000 and 20000

    -- 가격이 10000원 미만 또는 20000원 초과
    -- menu_price < 10000 or menu_price > 20000
    menu_price < 10000 || menu_price > 20000
;

-- ==================================================
# 문자열 패턴 연산자 like
# - 와일드카드 % _를 사용해 문자열 특정패턴을 검사
# - % 0개이상의 문자
# - _ 딱 1개 문자


SELECT
    *
FROM
    tbl_menu
WHERE
    # menu_name like '%밥' -- 밥으로 끝나는 메뉴명 조회
    # menu_name like '%마늘%' -- 마늘이 들어가는 메뉴명
    menu_name like '___쥬스'-- 3글자 + 쥬스
;


# 특정목록에 포함여부 in
-- 카테고리 코드가 8 이거나, 9 또는 10 만 조회
SELECT * FROM tbl_menu
WHERE category_code in (8, 9, 10);



# null 값 조회
-- 카테고리 코드가 null이 아닌 것만 조회
SELECT * FROM tbl_menu
WHERE
    # category_code != null -- 조회 안됨
    category_code is not null
;

# 실습
# 메뉴가격이 5000원보다 비싸면서, 카테고리코드가 10번이고, 메뉴명에 갈치가 들어가는 메뉴 조회
SELECT * FROM tbl_menu
WHERE menu_price > 5000
AND category_code = 10
AND menu_name like '%갈치%';


-- ================================================================
# order by
# - 거의 마지막 순서에 실행하는 정렬기준 절
# - 하나 이상의 정렬기준을 작성
# - 기본 오름차순 정렬 (숫자 작은수-큰수, 문자형 사전등재순, 날짜형 과거-미래순)


SELECT
    *
FROM
    tbl_menu
ORDER BY
    # menu_price ASC -- 메뉴 가격 오름차순 정렬
    # menu_price desc -- 메뉴 가격 내림차순 정렬
    # menu_price desc, menu_name -- 메뉴 가격 내림차순, 메뉴명 오름 차순
    -- 메뉴 코드 오름차순, 메뉴명 내림차순
    # menu_code, menu_name desc
    1 asc, 2 desc -- 컬럼 순서(1-based index)
;


# limit 절
# - 결과집합에 offset(건너뛰기), 행수를 제한하는 구문
# - limit [offset] row_count (offset기본값 0)
# - top-n분석, 페이징처리에 활용

-- tbl_menu 테이블에서 가장 비싼 가격의 메뉴 5행 조회
SELECT * FROM tbl_menu
ORDER BY menu_price desc
limit
    # 5 -- 상위 5개
    # 0, 5 -- 상위 5개
      5, 5  -- 5개 건너 뛰고 그다음 5행 조회
;
