package edu.employee.dao;

import edu.employee.vo.EmployeeVO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import static edu.common.JDBCUtil.getConnection;

public class EmployeeDaoImpl implements EmployeeDao {


    @Override
    public List<EmployeeVO> getDepartmentEmployees(String deptName) {

        List<EmployeeVO> list = new ArrayList<>();

        String sql = """
            select emp_name,
                   dept_title,
                   job_name,
                   ifnull(bonus,'보너스 없음') bonus,
                   case
                       when ent_yn='N' then '재직'
                       else '퇴사'
                   end ent_yn
            from employee e
            join department d on e.dept_code = d.dept_id
            join job j on e.job_code = j.job_code
            where d.dept_title = ?
            order by bonus desc
            """;

        try (
                PreparedStatement pstmt = getConnection().prepareStatement(sql)
        ) {

            pstmt.setString(1, deptName);

            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {

                EmployeeVO emp = new EmployeeVO();

                emp.setEmpName(rs.getString("emp_name"));
                emp.setDeptTitle(rs.getString("dept_title"));
                emp.setJobName(rs.getString("job_name"));
                emp.setBonus(rs.getString("bonus"));
                emp.setEntYn(rs.getString("ent_yn"));

                list.add(emp);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    @Override
    public List<EmployeeVO> getDepartmentAvgSalary() {

        List<EmployeeVO> list = new ArrayList<>();

        String sql = """
            select d.dept_title,
                   j.job_name,
                   count(*) emp_count,
                   round(avg(salary)) avg_salary
            from employee e
            join department d on e.dept_code = d.dept_id
            join job j on e.job_code = j.job_code
            where ent_yn = 'N'
            group by d.dept_title, j.job_name
            having avg(salary) >= 3000000
            order by avg_salary desc
            """;

        try (
                PreparedStatement pstmt = getConnection().prepareStatement(sql);
                ResultSet rs = pstmt.executeQuery()
        ) {

            while (rs.next()) {

                EmployeeVO emp = new EmployeeVO();

                emp.setDeptTitle(rs.getString("dept_title"));
                emp.setJobName(rs.getString("job_name"));
                emp.setEmployeeCount(rs.getInt("emp_count"));
                emp.setAvgSalary(rs.getDouble("avg_salary"));

                list.add(emp);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    @Override
    public List<EmployeeVO> getWorkingEmployees() {

        List<EmployeeVO> list = new ArrayList<>();

        String sql = """
            select ifnull(d.dept_title,'부서없음') dept_title,
                   j.job_name,
                   e.emp_name,
                   e.salary
            from employee e
            left join department d
                   on e.dept_code = d.dept_id
            join job j
                   on e.job_code = j.job_code
            where e.ent_yn='N'
            order by j.job_name asc
            limit 10
            """;

        try (
                PreparedStatement pstmt = getConnection().prepareStatement(sql);
                ResultSet rs = pstmt.executeQuery()
        ) {

            while (rs.next()) {

                EmployeeVO emp = new EmployeeVO();

                emp.setDeptTitle(rs.getString("dept_title"));
                emp.setJobName(rs.getString("job_name"));
                emp.setEmpName(rs.getString("emp_name"));
                emp.setSalary(rs.getInt("salary"));

                list.add(emp);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    @Override
    public int increaseSalary(String deptCode) {

        int result = 0;

        String sql = """
            update employee
            set salary = salary * 1.1
            where dept_code = ?
            """;

        try (
                Connection conn = getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)
        ) {

            pstmt.setString(1, deptCode);

            result = pstmt.executeUpdate();

            conn.commit();

        } catch (Exception e) {

            e.printStackTrace();
        }

        return result;
    }

    @Override
    public List<EmployeeVO> getEmployeesWithoutPhone() {

        List<EmployeeVO> list = new ArrayList<>();

        String sql = """
            select emp_name,
                   ifnull(phone,'없음') phone,
                   ifnull(dept_title,'부서없음') dept_title
            from employee e
            left join department d
                   on e.dept_code = d.dept_id
            where phone is null
            order by emp_name desc
            """;

        try (
                PreparedStatement pstmt = getConnection().prepareStatement(sql);
                ResultSet rs = pstmt.executeQuery()
        ) {

            while (rs.next()) {

                EmployeeVO emp = new EmployeeVO();

                emp.setEmpName(rs.getString("emp_name"));
                emp.setPhone(rs.getString("phone"));
                emp.setDeptTitle(rs.getString("dept_title"));

                list.add(emp);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }


}
