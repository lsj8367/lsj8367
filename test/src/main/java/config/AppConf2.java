package config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import spring.ChangePasswordService;
import spring.MemberDao;
import spring.MemberInfoPrinter;
import spring.MemberListPrinter;
import spring.MemberPrinter;
import spring.MemberRegisterService;
import spring.VersionPrinter;

@Configuration //Spring bean 관리 클래스임을 명시
public class AppConf2 {
	// Autowired 어노테이션을 필드나 setter 메소드에 붙이게되면
	// 같은 타입 빈 객체를 찾아 의존성을 주입해준다.
//	@Autowired
//	private MemberDao memberDao;
//	
//	@Autowired
//	private MemberPrinter memberPrinter;
	
	// 의존을 주입하지 않아도 스프링이 @Autowired를 붙인 필드에
	// 해당 타입의 bean 객체를 찾아서 주입한다.
	
	
	@Bean
	public MemberRegisterService memberRegSvc() {
//		return new MemberRegisterService(memberDao); Autowired 의존성 주입
		return new MemberRegisterService();
	}
	
	@Bean //메소드 이름으로 bean 호출
	public ChangePasswordService changePwdSvc() {
		//ChangePasswordService pwdSvc = new ChangePasswordService();
		//pwdSvc.setMemberDao(memberDao); // Autowired 사용했기때문에 지워줌.
		//Autowired를 사용하지 않을거면 생성자 or setter로 의존 주입을 해주어야한다.
		//return pwdSvc;
		return new ChangePasswordService();
	}
	

	@Bean
	public MemberListPrinter listPrinter() {
//		return new MemberListPrinter(memberDao, memberPrinter); autowired로 의존성 주입해서 사용X
		return new MemberListPrinter();
	}
	
	@Bean
	public MemberInfoPrinter infoPrinter() {
//		MemberInfoPrinter infoPrinter = new MemberInfoPrinter();
//		infoPrinter.setMemberDao(memberDao); // 왜 안해주냐? ---> MemberInfoPrinter 클래스에서 @Autowired로 의존성을 주입해주었기 때문.
//		infoPrinter.setPrinter(memberPrinter);
//		return infoPrinter;
		return new MemberInfoPrinter();
	}
	
	@Bean
	public VersionPrinter versionPrinter() {
		VersionPrinter versionPrinter = new VersionPrinter();
		versionPrinter.setMajorVersion(5);
		versionPrinter.setMinorVersion(0);
		return versionPrinter;
	}
}
