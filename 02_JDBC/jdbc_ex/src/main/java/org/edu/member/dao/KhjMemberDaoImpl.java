package org.edu.member.dao;

import org.edu.member.common.JDBCUtil;
import org.edu.member.vo.Member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;


public class KhjMemberDaoImpl implements MemberDao {

    // JDBCUtil을 통해 Connection 객체 가져오기
    private Connection conn = JDBCUtil.getConnection();

    // 회원 등록
    @Override
    public int create(Member member) throws SQLException {
        // Statement를 사용하는 경우 sql문
        /*
        String sql = "INSERT INTO members VALUES (DEFAULT, "
                + member.getMemberId() + ", "
                + member.getMemberPw() +", "
                + member.getMemberName()+ ", "
                + member.getMemberRole()+", 'N');";
         */

        // PreparedStatement
        // - Statement의 자식으로 좀 더 향상된 기능을 제공
        // - ?(위치 홀더)를 이용하여 SQL에 작성되어지는 리터럴을 동적으로 제어
        // -> 오타 위험 감소, 가독성 상승

        // sql문 작성 시 세미콜론(;)은 안쓰는 것이 관례
        String sql = "INSERT INTO members VALUES (DEFAULT, ?, ?, ?, ?, ?, 'N')";


        // try-with-resources문을 사용하여 작업이 끝나면 pstmt.close()가 자동 호출됨
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, member.getMemberId());
            pstmt.setString(2, member.getMemberPw());
            pstmt.setString(3, member.getMemberName());
            pstmt.setString(4, member.getMemberRole());

            // SELECT : executeQuery(); -> ResultSet 반환
            // DML    : executeUpdate(); -> 성공한 행의 개수 반환
            int result = pstmt.executeUpdate();

            // 성공 시 커밋
            if (result == 1) conn.commit();

            return result; // 성공한 행의 개수 반환
        }

    }

    // 회원 정보 수정
    @Override
    public int update(Member mem) throws SQLException {

        String sql = "update members set name = ?,  role = ? where no = ?";

        System.out.println(mem);
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, mem.getMemberName());
            pstmt.setString(2, mem.getMemberRole());
            pstmt.setInt(3, mem.getMemberNo());

            int result = pstmt.executeUpdate();

            if (result == 1) conn.commit();

            return result;
        }
    }

    // 회원 정보 삭제
    @Override
    public int delete(int no) throws SQLException {
        String sql = "delete from members where no = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, no);
            int result = pstmt.executeUpdate();
            if (result == 1) conn.commit(); // 커밋 추가
            return result;
        }
    }

    // 회원 번호로 회원 정보 조회
    @Override
    public Member get(int no) throws SQLException {
        String sql = "select * from members where no = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, no);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    Member mem = new Member();
                    mem.setMemberNo(rs.getInt("no"));
                    mem.setMemberId(rs.getString("id"));
                    mem.setMemberName(rs.getString("name"));
                    // mem.setMemberPw(rs.getString("pw"));
                    mem.setMemberRole(rs.getString("role"));
                    return mem;
                }
            }
        }
        return null;
    }

    // 회원 목록 조회
    @Override
    public List<Member> getList() throws SQLException {

        String sql = "SELECT * FROM members";
        List<Member> userList = new ArrayList<>();

        try (PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                Member mem = new Member();
                mem.setMemberNo(rs.getInt("no"));
                mem.setMemberId(rs.getString("id"));
                // mem.setMemberPw(rs.getString("pw"));
                mem.setMemberName(rs.getString("name"));
                mem.setMemberRole(rs.getString("role"));
                // deleted_yn 컬럼이 존재한다면 추가
                userList.add(mem);
            }
        }
        return userList;
    }


    @Override
    public Member getDeptName(int memberNo) throws SQLException {
        return null;
    }
}
