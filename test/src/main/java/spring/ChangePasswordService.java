package spring;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class ChangePasswordService {
	
	@Autowired
	private MemberDao memberDao; // @Autowired를 했기때문에 beans에서 setter 의존성 주입을 제거한다.
	//setter로 의존성 주입도 하지않고 autowired를 사용하여 DI를 하지 않았을때 null을 발생시킨다.
	
	public void changePassword(String email, String oldPwd, String newPwd) {
		Member member = memberDao.selectByEmail(email);
		
		if(member == null) throw new MemberNotFoundException();
		
		member.changePassword(oldPwd, newPwd);
		
		memberDao.Update(member);
	}
	
	public void setMemberDao(MemberDao dao) {
		this.memberDao = dao;
	}
}
