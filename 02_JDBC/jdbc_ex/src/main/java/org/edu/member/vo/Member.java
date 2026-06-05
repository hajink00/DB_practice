package org.edu.member.vo;

import lombok.*;

// VO(Value Object) : 값 자체를 표현하고 의미를 갖는 객체
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class Member {

    private int memberNo;
    private String memberId;
    private String memberPw;
    private String memberName;
    private String memberRole;
    private String memberDeptNo;
    private char deletedYn;

    // 부서
    private int deptNo;
    private String deptName;

    public Member(int memberNo, String memberName, String memberRole) {
        this.memberNo = memberNo;
        this.memberName = memberName;
        this.memberRole = memberRole;
    }
}
