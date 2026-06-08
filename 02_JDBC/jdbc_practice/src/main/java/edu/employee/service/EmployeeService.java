package edu.employee.service;

import edu.employee.dao.EmployeeDao;
import edu.employee.dao.EmployeeDaoImpl;
import edu.employee.vo.EmployeeVO;

import java.sql.SQLException;
import java.util.List;
import java.util.Scanner;

public class EmployeeService {

    private Scanner sc = new Scanner(System.in);
    private EmployeeDao dao = new EmployeeDaoImpl();

    public void displayMenu() {

        int menu = 0;

        do {

            try {

                System.out.println("\n===== 직원 관리 프로그램 =====");
                System.out.println("1. 마케팅부 직원 정보 조회");
                System.out.println("2. 부서·직급별 평균 급여 조회");
                System.out.println("3. 재직 중인 직원 목록 조회");
                System.out.println("4. 부서 급여 10% 인상");
                System.out.println("5. 휴대폰 번호 없는 직원 조회");
                System.out.println("0. 종료");
                System.out.print("메뉴 선택 >> ");

                menu = sc.nextInt();
                sc.nextLine();

                switch (menu) {

                    case 1:
                        getDepartmentEmployees();
                        break;

                    case 2:
                        getDepartmentAvgSalary();
                        break;

                    case 3:
                        getWorkingEmployees();
                        break;

                    case 4:
                        increaseSalary();
                        break;

                    case 5:
                        getEmployeesWithoutPhone();
                        break;

                    case 0:
                        System.out.println("프로그램을 종료합니다.");
                        break;

                    default:
                        System.out.println("잘못된 메뉴입니다.");
                }

            } catch (Exception e) {

                sc.nextLine();
                e.printStackTrace();
            }

        } while (menu != 0);
    }

    /**
     * 부서명을 입력받아 해당 부서에 근무하는 직원 정보를 조회
     *
     * 조회 컬럼 : 사원명(EMP_NAME), 부서명(DEPT_TITLE), 직급명(JOB_NAME), 보너스율(BONUS), 퇴직여부(ENT_YN)
     *
     * 요구사항
     * - 보너스율이 NULL인 경우 '보너스 없음'으로 표시
     * - 퇴직여부가 'N'이면 '재직', 'Y'이면 '퇴사'로 표시
     * - 보너스율 내림차순 정렬
     *
     */
    private void getDepartmentEmployees() throws SQLException {

        System.out.println("===== 마케팅부 직원 정보 조회 =====");
        System.out.print("부서명 입력 : ");

        String deptTitle = sc.nextLine();

        List<EmployeeVO> list = dao.getDepartmentEmployees(deptTitle);

        if (list == null || list.isEmpty()) {

            System.out.println("조회 결과가 없습니다.");
            return;
        }

        for (EmployeeVO emp : list) {

            System.out.printf(
                    "사원명 : %s, 부서명 : %s, 직급명 : %s, 보너스율 : %s, 퇴직여부 : %s%n",
                    emp.getEmpName(),
                    emp.getDeptTitle(),
                    emp.getJobName(),
                    emp.getBonus(),
                    emp.getEntYn()
            );
        }
    }

    /**
     * 부서별, 직급별 평균 급여 정보를 조회
     *
     * 조회 컬럼 : 부서명, 직급명, 사원수, 평균급여
     *
     * 요구사항:
     * - 재직 중인 직원만 조회
     * - 부서+직급 별 평균 급여가 300만원 이상인 경우만 조회
     * - 평균급여 반올림, 내림차순 정렬
     *
     */
    private void getDepartmentAvgSalary() throws SQLException {

        System.out.println("===== 부서·직급별 평균 급여 조회 =====");

        List<EmployeeVO> list = dao.getDepartmentAvgSalary();

        if (list == null || list.isEmpty()) {

            System.out.println("조회 결과가 없습니다.");
            return;
        }

        for (EmployeeVO emp : list) {

            System.out.printf(
                    "부서명 : %s, 직급명 : %s, 사원수 : %d, 평균급여 : %.0f%n",
                    emp.getDeptTitle(),
                    emp.getJobName(),
                    emp.getEmployeeCount(),
                    emp.getAvgSalary()
            );
        }
    }

    /**
     * 현재 재직 중인 직원 목록을 조회
     *
     * 조회 컬럼 : 부서명, 직급명, 사원명, 급여
     *
     * 요구사항:
     * - 재직 중인 직원만 조회
     * - 부서가 없는 직원도 조회
     * - 직급명 오름차순 정렬
     * - 상위 10명만 조회
     *
     */
    private void getWorkingEmployees() throws SQLException {

        System.out.println("===== 재직 중인 직원 목록 조회 =====");

        List<EmployeeVO> list = dao.getWorkingEmployees();

        if (list == null || list.isEmpty()) {

            System.out.println("조회 결과가 없습니다.");
            return;
        }

        for (EmployeeVO emp : list) {

            System.out.printf(
                    "부서명 : %s, 직급명 : %s, 사원명 : %s, 급여 : %,d%n",
                    emp.getDeptTitle(),
                    emp.getJobName(),
                    emp.getEmpName(),
                    emp.getSalary()
            );
        }
    }

    /**
     * 특정 부서 직원의 급여를 인상한다.
     *
     * 요구사항:
     * - 부서코드를 입력받는다.
     * - 해당 부서 직원들의 급여를 10% 인상한다.
     *
     * 출력 예시:
     * 부서코드 입력 >> D5
     * 5명의 급여가 10% 인상되었습니다.
     */
    private void increaseSalary() throws SQLException {

        System.out.println("===== 부서 급여 10% 인상 =====");
        System.out.print("부서코드 입력 >> ");

        String deptCode = sc.nextLine();

        int result = dao.increaseSalary(deptCode);

        if (result > 0) {

            System.out.println(result + "명의 급여가 10% 인상되었습니다.");

        } else {

            System.out.println("해당 부서 직원이 존재하지 않습니다.");
        }
    }

    /**
     * 휴대폰 번호가 없는 직원 정보를 조회한다.
     *
     * 조회 컬럼 : 사원명, 휴대폰번호, 부서명
     *
     * 요구사항:
     * - 휴대폰 번호가 NULL인 직원만 조회
     * - 휴대폰 번호가 NULL인 경우 '없음'으로 표시
     * - 사원명 내림차순 정렬
     *
     */
    private void getEmployeesWithoutPhone() throws SQLException {

        System.out.println("===== 휴대폰 번호 없는 직원 조회 =====");

        List<EmployeeVO> list = dao.getEmployeesWithoutPhone();

        if (list == null || list.isEmpty()) {

            System.out.println("조회 결과가 없습니다.");
            return;
        }

        for (EmployeeVO emp : list) {

            System.out.printf(
                    "사원명 : %s, 휴대폰번호 : %s, 부서명 : %s%n",
                    emp.getEmpName(),
                    emp.getPhone(),
                    emp.getDeptTitle()
            );
        }
    }
}