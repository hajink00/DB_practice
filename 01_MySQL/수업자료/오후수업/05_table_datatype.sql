-- ===================================
-- TABLE 구조
-- ===================================

-- MySQL의 TABLE은 항상 특정 DATABASE(SCHEMA) 하위에 존재한다.
-- 특정 DATABASE 접근 권한이 있는 사용자만 TABLE을 관리할 수 있다.

-- RDBMS 구성 요소
-- 1. TABLE (Entity, Relation)
--    : 실제 데이터가 저장되는 객체

-- 2. COLUMN (Field, Attribute)
--    : 테이블의 구조를 정의하는 열
--    : 컬럼마다 자료형(Data Type)을 가질 수 있음

-- 3. ROW (Record, Tuple)
--    : 실제 데이터가 저장되는 단위

-- 4. DOMAIN
--    : 하나의 속성(열)이 가질 수 있는 값의 범위
--      예) 성별(남/여), 점수(0~100)

-- 데이터 조회
SELECT * FROM tbl_category;
SELECT * FROM tbl_menu;
SELECT * FROM tbl_order;
SELECT * FROM tbl_order_menu;
SELECT * FROM tbl_payment;
SELECT * FROM tbl_payment_order;


-- 테이블 구조 조회 (열, 자료형, 제약조건 확인)
DESC tbl_menu;
DESC tbl_order;


-- ===================================
-- DATA TYPE
-- ===================================

/*
=====================================
1. 숫자형 (정수 / 실수)
=====================================

TINYINT
- 크기 : 1Byte
- 범위 : -128 ~ 127
- 예시 : 100

SMALLINT
- 크기 : 2Byte
- 예시 : 30000

INT / INTEGER
- 크기 : 4Byte
- 예시 : 1000000

BIGINT
- 크기 : 8Byte
- 예시 : 9000000000

FLOAT(M,D)
- 설명 : 소수점 포함 실수 (4Byte)
- 예시 : 3.14

DOUBLE
- 설명 : 더 정밀한 실수 (8Byte)
- 예시 : 3.1415926535

DECIMAL(M,D)
- 설명 : 고정 소수점 숫자
         주로 금액 계산용
- 예시 : 12345.67


=====================================
2. 문자열형
=====================================

CHAR(n)
- 설명 : 고정 길이 문자열
- 예시 : 'Y', 'YES'

VARCHAR(n)
- 설명 : 가변 길이 문자열
- 예시 : 'Hello world'

TEXT
- 설명 : 긴 문자열
- 최대 : 65,535자

ENUM
- 설명 : 지정한 값 중 하나만 저장 가능
- 예시 : 'male', 'female'


=====================================
3. 날짜 / 시간형
=====================================

DATE
- 형식 : YYYY-MM-DD
- 예시 : '2025-04-18'

TIME
- 형식 : HH:MM:SS
- 예시 : '14:30:00'

DATETIME
- 형식 : YYYY-MM-DD HH:MM:SS
- 예시 : '2025-04-18 14:30:00'

TIMESTAMP
- 설명 : UNIX 타임스탬프 기반 날짜/시간

YEAR
- 설명 : 연도 (4자리)
- 예시 : '2025'
*/


-- 현재 날짜 / 시간 조회

SELECT
    NOW(),                 -- 현재 날짜 + 시간
    CURRENT_DATE,          -- 현재 날짜
    CURRENT_TIME,          -- 현재 시간
    CURRENT_TIMESTAMP;     -- 현재 날짜 + 시간