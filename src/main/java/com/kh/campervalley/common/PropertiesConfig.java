package com.kh.campervalley.common;

import org.springframework.beans.factory.config.PropertiesFactoryBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.ClassPathResource;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Configuration
public class PropertiesConfig {

	@Bean
	public PropertiesFactoryBean customProperties() {
		PropertiesFactoryBean bean = new PropertiesFactoryBean();
		bean.setLocation(new ClassPathResource("datasource.properties"));
		log.debug("bean = {}", bean);
		return bean;
	}

}
