package spring;

import java.time.LocalDateTime;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class MemberRegisterService {
	@Autowired
	private MemberDao memberDao;
	
	public MemberRegisterService() {
		
	}
	
	public MemberRegisterService(MemberDao memberDao) {
		this.memberDao = memberDao;
	}
	
	public Long regist(RegisterRequest req) {
		Member member = memberDao.selectByEmail(req.getEmail()); //반환값이 Member타입인 객체에 email주소를 받아 조회하여 돌려줌
		if (member != null) { //있으면 오류를 발생시킴 왜? 이미 있음
			throw new DuplicateMemberException("dup email : " + req.getEmail());
		}
		//없으면 새롭게 생성해줌
		Member newMember = new Member(req.getEmail(), req.getPassword(), req.getName(), LocalDateTime.now());
		memberDao.Insert(newMember);
		
		return newMember.getId();
	}
}
