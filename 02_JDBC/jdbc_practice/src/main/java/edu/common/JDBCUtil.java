package edu.common;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class JDBCUtil {
    private static Connection conn = null;

// 정적 초기화 블록
    static {
        try {
            // Properties 객체를 사용하여 설정 파일 로드
            Properties properties = new Properties();
            properties.load(JDBCUtil.class.getResourceAsStream("/application.properties"));

            // 설정 파일에서 연결 정보 추출
            String driver = properties.getProperty("driver");   // JDBC 드라이버 클래스명
            String url = properties.getProperty("url");         // 데이터베이스 URL
            String id = properties.getProperty("edu.id");           // 데이터베이스 사용자 ID
            String password = properties.getProperty("edu.pw"); // 비밀번호

            // JDBC 드라이버 로드 및 연결 수립
            Class.forName(driver);
            conn = DriverManager.getConnection(url, id, password);
            conn.setAutoCommit(false); // 오토커밋 끄기
        } catch (Exception e) {
            // 연결 실패 시 내역 출력
            e.printStackTrace();
        }
    }

   // 데이터 베이스 연결 객체 반환
    public static Connection getConnection() {
        return conn;
    }

    // 데이터 베이스 연결 끊기
    public static void close() {
        try {
            if (conn != null) {
                conn.close();
                conn = null;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
