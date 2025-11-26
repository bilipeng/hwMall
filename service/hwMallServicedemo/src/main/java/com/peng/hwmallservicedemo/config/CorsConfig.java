package com.peng.hwmallservicedemo.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;
import org.springframework.web.filter.CorsFilter;

@Configuration
public class CorsConfig {

    @Bean
    public CorsFilter corsFilter() {
        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        CorsConfiguration config = new CorsConfiguration();
        
        // 允许所有源（开发环境）
        // 生产环境应该指定具体的域名，如 "http://localhost:5173", "http://localhost:5174"
        config.addAllowedOriginPattern("*");
        
        // 允许所有请求头
        config.addAllowedHeader("*");
        
        // 允许所有请求方法
        config.addAllowedMethod("*");
        
        // 注意：使用 addAllowedOriginPattern("*") 时不能设置 setAllowCredentials(true)
        // 如果需要携带凭证，应该使用具体的域名，如：
        // config.addAllowedOrigin("http://localhost:5173");
        // config.addAllowedOrigin("http://localhost:5174");
        // config.setAllowCredentials(true);
        
        // 预检请求的缓存时间（秒）
        config.setMaxAge(3600L);
        
        // 对所有路径应用此配置
        source.registerCorsConfiguration("/**", config);
        
        return new CorsFilter(source);
    }
}

