-- =============================
-- JOIN
-- =============================
-- 두개 이상의 테이블의 레코드를 연결해서 가상테이블(relation) 생성
-- 연관성을 가지고 있는 컬럼을 기준(데이터)으로 조합

# relation을 생성하는 2가지 방법
-- 1. join : 특정컬럼 기준으로 행과 행을 연결한다. (가로)
-- 2. union : 컬럼과 컬럼을 연결한다.(세로)
-- join은 두 테이블의 행사이의 공통된 데이터를 기준으로 **선을 연결해서** 새로운 하나의 행을 만든다.

# JOIN 구분
-- 1. Equi JOIN : 일반적으로 사용하는 Equality Condition(=)에 의한 조인
-- 2. Non-Equi JOIN : 동등조건(=)이 아닌 BETWEEN AND, IS NULL, IS NOT NULL, IN, NOT IN, !=  등으로 사용.

# EQUI JOIN 구분
-- 1. INNER JOIN(내부 조인) : 교집합 (일반적으로 사용하는 JOIN)
-- 2. OUTER JOIN(외부 조인) : 합집합
        -- LEFT (OUTER) JOIN (왼쪽 외부 조인)
        -- RIGHT (OUTER) JOIN (오른쪽 외부 조인)
-- 3. CROSS JOIN
-- 4. SELF JOIN(자가 조인)
-- 5. MULTIPLE JOIN(다중 조인)


-- 한우딸기국밥 메뉴 정보 조회 (메뉴명, 카테고리명, 가격)
select
    menu_name,
    category_name,
    menu_price
from tbl_menu
join tbl_category on tbl_menu.category_code = tbl_category.category_code
where menu_name = '한우딸기국밥';

-- 조인을 통해서 처리
-- 1. tbl_menu, tbl_cateogory를 합쳐서 relation 생성
-- 2. relation을 마치 실체 테이블처럼 사용



# inner join 내부조인
# - 행과 행을 연결할때, 기준컬럼값이 null이거나 상대테이블에 매칭되는 행이 없는 경우 relation생성에서 제외된다.
# - A (inner) join B on ....
select * from tbl_menu; -- 22행
select * from tbl_category; -- 12행

select
    *
from tbl_menu
         join tbl_category on tbl_menu.category_code = tbl_category.category_code; -- 21행
-- tbl_menu에서 category_code가 null인 순대쉐이크 제외
-- tbl_category에서 매칭되는 행이 없는 1, 2, 3, 7 제외


# outer join 외부조인
# - 좌/우측 기준테이블의 모든 행을 relation에 포함하는 조인
# - 내부조인에서 제외된 기준테이블 행을 모두 포함한다.
# - A left | right (outer) join B
select
    *
from tbl_menu
        left join tbl_category on tbl_menu.category_code = tbl_category.category_code; -- 22행

select
    *
from tbl_menu
         right join tbl_category on tbl_menu.category_code = tbl_category.category_code; -- 25행
# cross join
# - 카테시안곱. 모든 경우의 수를 조인처리(조건이 필요없음)
select
    *
from tbl_menu cross join tbl_category; -- 264행 = 22행 * 12행

# self join
# - 하나의 테이블안에서 한행이 다른행을 참조하는 관계가 있는 경우, 같은 테이블끼리 조인가능
select * from tbl_category;

select
    concat(parent.category_name, ' > ', child.category_name)
from tbl_category child
    join tbl_category parent
    on child.ref_category_code = parent.category_code;
