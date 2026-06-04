package org.scoula.jdbc_ex;

import org.junit.jupiter.api.*;
import org.scoula.jdbc_ex.common.JDBCUtil;

import java.sql.*;

@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
public class CrudTest {
    Connection conn = JDBCUtil.getConnection();

    @AfterAll
    // 다른 메서드 다 실행하고 나서 무조건 실행할 메서드
    static void tearDown() {
        JDBCUtil.close();
    }

}