package org.scoula.jdbc_ex.test;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.scoula.jdbc_ex.common.JDBCUtil;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * JDBC 연결 테스트를 위한 클래스
 * - 데이터베이스 연결이 정상적으로 이루어지는지 확인하는 테스트 케이스 포함
 */
public class ConnectionTest {

    /*
     * @Test - JUnit 테스트 메서드임을 나타내는 어노테이션.
     *          이 어노테이션이 붙은 메서드는 테스트 러너에 의해 실행됨
     * @DisplayName - 테스트 실행 시 보여질 테스트 이름을 지정하는 어노테이션.
     *                  테스트 결과 리포트에 표시됨
     */

    /**
     * DB 연결 테스트
     * @throws SQLException
     * @throws ClassNotFoundException
     */
    @Test
    @DisplayName("jdbc_ex 데이터베이스에 접속한다.")
    public void testConnection() throws SQLException, ClassNotFoundException {
        // MySQL JDBC 드라이버 로딩
        // 없으면 ClassNotFoundException 발생
        Class.forName("com.mysql.cj.jdbc.Driver");

        // 연결 정보 설정 -> "jdbc:mysql://[host]:[포트]/[db이름]
        String url = "jdbc:mysql://127.0.0.1:3306/jdbc_ex";   // 로컬 MySQL 서버의 jdbc_ex 데이터베이스
        String id = "scoula";                                // 데이터베이스 사용자 계정
        String password = "1234";                            // 계정 비밀번호

        // 데이터베이스 연결 수립
        Connection conn = DriverManager.getConnection(url, id, password);
        System.out.println("DB 연결 성공");

        // 연결 종료 (리소스 해제)
        conn.close();
    }

    @Test
    @DisplayName("jdbc_ex에 접속한다.(자동 닫기)")
    public void testConnection2() throws SQLException {
        // try-with-resources 구문을 사용하여 자동 리소스 해제
        // JDBCUtil 클래스의 getConnection() 메서드로 연결 획득
        try(Connection conn = JDBCUtil.getConnection()) {
            // 연결 성공 메시지 출력
            System.out.println("DB 연결 성공");

            // try 블록이 종료되면 자동으로 Connection이 닫힘 (close() 호출)
        }
        // SQLException은 메서드 선언부에서 throws로 처리
    }

}