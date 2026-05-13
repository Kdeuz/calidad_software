package fr.cytech.pau.hia_jee;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

@SpringBootApplication
@EnableScheduling
public class HiaJeeApplication {

	public static void main(String[] args) {
		SpringApplication.run(HiaJeeApplication.class, args);
	}

}
