package com.peng.hwmallservicedemo;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@MapperScan("com.peng.hwmallservicedemo.repository")
public class HwMallServicedemoApplication {

    public static void main(String[] args) {
        SpringApplication.run(HwMallServicedemoApplication.class, args);
    }

}
