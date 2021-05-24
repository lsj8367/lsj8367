package config;

import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;

@Configuration
//@Import({AppConf1.class, AppConf2.class}) // Import 어노테이션으로 AppConf2의 설정을 묶어주었기 때문에 ApplicationContext에 클래스를 두개 지정할 필요가 없다.
public class AppConfImport {
		
}
