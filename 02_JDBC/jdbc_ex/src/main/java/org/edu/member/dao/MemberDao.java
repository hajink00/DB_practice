package org.edu.member.dao;

import org.edu.member.vo.Member;

import java.sql.SQLException;
import java.util.List;

// DAO(Data Access Object) : 데이터 접근 객체
// DB와 연결되어 SQL을 수행하고 결과를 반환 받는 역할
public interface MemberDao {

    // 회원 등록
    int create(Member member) throws SQLException;

    // 회원 정보 수정
    int update(Member mem) throws SQLException;

    // 회원 정보 삭제
    int delete(int no) throws SQLException;

//    int delete(Member mem) throws SQLException;

    // 회원 번호 일치 1명 조회
    Member get(int no) throws SQLException;

    // 회원 정보 전체 목록 조회
    List<Member> getList() throws SQLException;

    // 회원 부서명 조회
    Member getDeptName(int memberNo) throws SQLException;
}
