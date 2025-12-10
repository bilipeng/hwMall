package com.bilipeng.hwmall;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@MapperScan("com.bilipeng.hwmall.mapper")
public class HwMallApplication {

    public static void main(String[] args) {
        SpringApplication.run(HwMallApplication.class, args);
    }

}
