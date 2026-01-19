package com.grad.platform;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@MapperScan("com.grad.platform.*.mapper")
public class GradPlatformApplication {
    public static void main(String[] args) {
        SpringApplication.run(GradPlatformApplication.class, args);
    }
}
