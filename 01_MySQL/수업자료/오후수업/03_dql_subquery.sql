-- ===================================
-- SUBQUERY
-- ===================================
-- 하나의 SQL문(main-query) 안에 포함되어 있는 또 다른 SQL문(sub-query)
-- 존재하지 않는 조건에 근거한 값들을 검색하고자 할때 사용.
-- 메인 쿼리가 서브 쿼리를 포함하는 종속적인 관계이다.
-- 메인 쿼리 실행중에 서브 쿼리를 실행해서 그 결과값을 다시 메인쿼리에 전달하는 방식이다.

# 서브쿼리(SUBQUERY) 유형
-- 1. 일반 서브쿼리
-- 2. 상관 서브쿼리
-- 3. 인라인뷰(파생테이블)

# 규칙
-- 서브쿼리는 반드시 소괄호로 묶어야 함 - (SELECT ... ) 형태
-- 서브쿼리는 연산자의 오른쪽에 위치 해야 함
-- 서브쿼리 내에서 order by 문법은 지원 안됨


# - 민트미역국과 같은 카테고리의 메뉴 조회
-- 민트 미역국 카테고리 코드 조회
select category_code from tbl_menu where menu_name = '민트미역국'; -- 4
-- 카테고리 코드 동일한 메뉴 조회
select menu_name from tbl_menu where category_code = 4;

select *
from
    tbl_menu
where category_code =
      (select category_code
       from tbl_menu
       where menu_name = '민트미역국');

-- 민트미역국 보다 비싼 메뉴 조회

select *
from tbl_menu
where menu_price > (select menu_price
                    from
                        tbl_menu
                    where
                        menu_name = '민트미역국');

# ===================================================
# 다중행 단일컬럼 서브쿼리 - 여러개의 값을 반환하는 경우
# 식사류에 해당하는 메뉴 조회
# - 식사류(부모카테고리) 하위의 카테고리에 해당하는 메뉴 조회

# 1. 식사류의 하위카테고리 조회 (여러개)
select category_code from tbl_category
where ref_category_code = (select category_code
                           from tbl_category
                           where category_name = '식사'); -- 4, 5, 6, 7
# 2. 해당카테고리에 포함되는 메뉴조회
select * from tbl_menu
where  category_code in (4, 5, 6, 7);

select * from tbl_menu
where  category_code in (select category_code from tbl_category
                         where ref_category_code = (select category_code
                                                    from tbl_category
                                                    where category_name = '식사'));



# ===================================================
# CTE Common Table Expression
# - 인라인뷰(from절에 작성하는 서브쿼리)를 테이블 변수에 지정하고, 이를 하위에서 참조하는 것

# 스칼라 서브쿼리
-- select문에서 사용하는 결과값이 스칼라(값 하나)인 상관서브쿼리

 select
    menu_code,
    menu_name,
    menu_price,
    category_code,
    (select category_name from tbl_category
                          where category_code = m.category_code) category_name
from tbl_menu m;

# 인라인뷰
# - from 절에서 사용하는 서브쿼리
# - 테이블처럼 사용 가능

select
    *
from (
        select
             menu_code,
             menu_name,
             menu_price,
             category_code,
             (select category_name from tbl_category
              where category_code = m.category_code) category_name
         from tbl_menu m
) m -- 인라인뷰(테이블) 별칭 작성
where menu_code = 1;

# CTE
with my_menu as (
    select
        menu_code 메뉴코드, -- 별칭이 column명이 됨
        menu_name,
        menu_price,
        category_code,
        (select category_name from tbl_category
         where category_code = m.category_code) category_name
    from tbl_menu m
)

select
    *
from
    my_menu
where 메뉴코드 = 1;