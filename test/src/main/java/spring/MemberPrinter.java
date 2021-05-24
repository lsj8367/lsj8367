package spring;

import java.time.format.DateTimeFormatter;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.lang.Nullable;

public class MemberPrinter {
	//@Autowired
	//@Nullable //세번째 방법
	private DateTimeFormatter dateTimeFormatter;
	
	public MemberPrinter() {
		dateTimeFormatter = DateTimeFormatter.ofPattern("yyyy년 MM월 dd일");
	}
	
	public void print(Member member) {
		if(dateTimeFormatter == null) {
			System.out.printf("회원 정보 : 아이디=%d, 이메일=%s, 이름=%s, 등록일=%tF\n",
					member.getId(), member.getEmail(), member.getName(), member.getRegisterDateTime());
		}else {
			System.out.printf("회원 정보 : 아이디=%d, 이메일=%s, 이름=%s, 등록일=%s\n",
					member.getId(), member.getEmail(), member.getName(),
					dateTimeFormatter.format(member.getRegisterDateTime()));
		}
	}
	
//	@Autowired(required = false) //자동주입할 대상이 필수가 아닌경우 required 조건을 넣어준다.
//	public void setDateFormatter(DateTimeFormatter dateTimeFormatter) {
//		this.dateTimeFormatter = dateTimeFormatter;
//	}
	
	// 스프링5 버전부터는 @Autowired 어노테이션의 required 속성을 false로 하는 대신에
	// 의존주입대상에 Optional<>을 사용해도 된다.
	
	// 두번째 방법
	/*
	@Autowired
	public void setDateFormatter(Optional<DateTimeFormatter> formatterOpt) {
//		if(formatterOpt.isPresent()) {
//			this.dateTimeFormatter = formatterOpt.get();
//		}else {
//			this.dateTimeFormatter = null;
//		}
		// 위의 if-else 구문 refactoring

		// 자동주입대상이 Optional이면 값이 없는값을 인자로 전달하기 때문에 Exception을 발생시키지 않는다.
		this.dateTimeFormatter = formatterOpt.orElse(null);
	}*/
	
	
	// 세번째 방법
	@Autowired
	public void setDateFormatter(@Nullable DateTimeFormatter dateTimeFormatter) {
		//@Nullable을 대상 파라미터에 붙이면 자동 주입할 빈이 존재하면 인자로 전달하고
		// 그렇지 않으면 null을 전달
		this.dateTimeFormatter = dateTimeFormatter;
	}
	
}