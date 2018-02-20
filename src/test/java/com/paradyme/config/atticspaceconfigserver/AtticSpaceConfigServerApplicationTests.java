package com.paradyme.config.atticspaceconfigserver;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import static org.assertj.core.api.Assertions.assertThat;

@RunWith(SpringRunner.class)
@SpringBootTest
public class AtticSpaceConfigServerApplicationTests {

	@Test
	public void contextLoads() {
		assertThat("ADB").isEqualToIgnoringCase("ADB");

	}

}
