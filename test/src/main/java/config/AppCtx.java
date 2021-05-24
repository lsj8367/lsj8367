package config;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.ComponentScan.Filter;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.FilterType;

import spring.MemberPrinter;
import spring.MemberSummaryPrinter;
import spring.VersionPrinter;

@Configuration
@ComponentScan(basePackages = {"spring"})//@Component 어노테이션을 붙인 클래스를 스캔해 스프링 빈으로 등록함.
//,excludeFilters = @Filter(type = FilterType.REGEX, pattern = "spring\\..*Dao")) 
public class AppCtx {
	
	@Bean
	@Qualifier("printer") // ()안에는 변수의 이름과 통일시켜준다.
	public MemberPrinter memberPrinter1() {
		return new MemberPrinter();
	}
	
	// 자동 주입을 시키려면 명확하게 뭐가 어떤 부분을 참조하고 있는지 잡아줘야 하는데
	// 같은 MemberPrinter객체를 두개를 생성했지만 참조하는게 뭔지 몰라서 에러를 발생시키게된다.
	// 이 오류를 탈피할수 있는 어노테이션이 바로 @Qualifier이다.
	@Bean
	@Qualifier("summaryPrinter")
	public MemberSummaryPrinter memberPrinter2() {
		return new MemberSummaryPrinter();
		//여기서도 마찬가지로 에러가 발생하는 이유
		// MemberSummaryPrinter는 MemberPrinter를 상속받은 클래스이므로
		// MemberPrinter에도 할당할수 있기때문에 구분을 지을수 없다.
		
	}
	
	@Bean
	public VersionPrinter versionPrinter() {
		VersionPrinter versionPrinter = new VersionPrinter();
		versionPrinter.setMajorVersion(5);
		versionPrinter.setMinorVersion(0);
		return versionPrinter;
	}
}
