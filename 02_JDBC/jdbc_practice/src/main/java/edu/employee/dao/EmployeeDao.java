package edu.employee.dao;

import edu.employee.vo.EmployeeVO;

import java.util.List;

public interface EmployeeDao {

    // 1. 부서명으로 직원 조회
    List<EmployeeVO> getDepartmentEmployees(String deptTitle);

    // 2. 부서/직급별 평균 급여 정보 조회
    List<EmployeeVO> getDepartmentAvgSalary();

    // 3. 현재 재직 중인 직원 목록을 조회
    List<EmployeeVO> getWorkingEmployees();

    // 4. 특정 부서 직원의 급여를 인상
    int increaseSalary(String deptCode);

    // 5. 휴대폰 번호가 없는 직원 정보를 조회
    List<EmployeeVO> getEmployeesWithoutPhone();
}
