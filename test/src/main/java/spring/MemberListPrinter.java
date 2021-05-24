package spring;

import java.util.Collection;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

@Component("listPrinter") //빈 이름은 listPrinter로 등록
public class MemberListPrinter {
	private MemberDao memberDao;
	private MemberPrinter printer;
	
	public MemberListPrinter() {
		
	}
	
	public MemberListPrinter(MemberDao memberDao, MemberPrinter printer) {
		this.memberDao = memberDao;
		this.printer = printer;
	}
	
	public void printAll() {
		Collection<Member> members = memberDao.selectAll();
		members.forEach(m -> printer.print(m));
	}
	
	@Autowired
	public void setMemberDao(MemberDao memberDao) {
		this.memberDao = memberDao;
	}
	
	//첫번째 방법
	@Autowired
	@Qualifier("summaryPrinter") // AppConf1 의 Qualifier 인자와 같게 맞춰준다.
	public void setMemberPrinter(MemberPrinter printer) {
		this.printer = printer;
	}
	
	//두번째 방법
//	@Autowired
//	public void setMemberPrinter(MemberSummaryPrinter printer){
//		this.printer = printer;
//	}
	
	
}
