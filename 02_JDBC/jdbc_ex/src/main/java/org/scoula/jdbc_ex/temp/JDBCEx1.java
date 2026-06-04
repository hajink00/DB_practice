package org.scoula.jdbc_ex.temp;

import java.sql.*;

public class JDBCEx1 {
    public static void main(String[] args) {
        // JDBC : Java와 DB를 연결할 수 있게 해주는 java API

        // [1단계] : JDBC 객체 참조 변수 선언(java.sql 패키지)

        Connection conn = null;
        // DB 연결 정보를 담은 객체
        // -> Java와 DB 사이를 연결해주는 일종의 통로

        Statement stmt = null;
        // Connection 객체를 통해
        // Java에서 작성된 SQL을 DB로 전달하여 수행한 후
        // 결과를 반환 받아 다시 Java로 돌아오는 역할의 객체

        ResultSet rs = null;
        // SELECT 질의 성공 시 반환되는
        // 결과 행의 집합(Result Set)을 나타내는 객체

        try{
            // [2단계] 참조변수에 알맞은 객체 대입하기

            // 1. DB 연결에 필요한 MySQL JDBC Driver 메모리 로드하기
            Class.forName("com.mysql.cj.jdbc.Driver");



            // 2. 연결 정보를 담은 Connection 생성
            // DriverManager : JDBC 드라이버를 통해 Connection 객체 만드는 역할
            String url = "jdbc:mysql://localhost:3306/jdbc_ex";
            String id = "scoula";
            String password = "1234";

            conn = DriverManager.getConnection(url, id, password);

            // System.out.println(conn); // 중간 확인
            // com.mysql.cj.jdbc.ConnectionImpl@24313fcc




            // 3. Statement 객체에 적재할 SQL 작성하기
            String sql = "SELECT * FROM users";

            // 4. Statement 객체 생성
            stmt = conn.createStatement();

            // 5. SQL을 Statement에 적재 후 DB로 전달하여
            //    수행한 후 결과를 반환 받아와 rs 변수에 대입
            rs = stmt.executeQuery(sql);

            // [3단계]
            while(rs.next()){
                // rs.next() : 참조하고 있는 ResultSet 객체의
                // 첫 번째 컬럼부터 순서대로 한 행씩 이동하며
                // 다음 행이 있을 경우 true 반환

                // rs.get[Type]("컬럼명")
                String userId = rs.getString("id");
                String userName = rs.getString("name");

                System.out.println(userId);
                System.out.println(userName);
                // 이름 출력
            }



        } catch (ClassNotFoundException e) {
            e.printStackTrace();

        } catch (SQLException e) {
            // SQLException : DB 연결 관련 예외의 최상위 부모
            e.printStackTrace();

        }finally {
            // [4단계] 사용한 JDBC 객체 자원 반환(close)
            // -> 자원 반환 순서는 객체 생성 순서의 역순
            try {
                if(rs != null) rs.close();
                if(stmt != null) stmt.close();
                if(conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

    }
}
