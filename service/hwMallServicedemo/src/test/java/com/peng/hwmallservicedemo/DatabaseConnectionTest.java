package com.peng.hwmallservicedemo;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@RunWith(SpringRunner.class)
@SpringBootTest
public class DatabaseConnectionTest {

    @Autowired
    private DataSource dataSource;

    @Test
    public void testDatabaseConnection() {
        System.out.println("=== 开始测试数据库连接 ===");
        
        try (Connection connection = dataSource.getConnection()) {
            System.out.println("✅ 数据库连接成功！");
            System.out.println("数据库URL: " + connection.getMetaData().getURL());
            System.out.println("数据库用户: " + connection.getMetaData().getUserName());
            
            // 测试查询用户表
            String sql = "SELECT COUNT(*) as count FROM user";
            try (PreparedStatement ps = connection.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {
                
                if (rs.next()) {
                    int count = rs.getInt("count");
                    System.out.println("✅ 用户表查询成功，记录数: " + count);
                }
            }
            
        } catch (Exception e) {
            System.err.println("❌ 数据库连接失败: " + e.getMessage());
            e.printStackTrace();
        }
        
        System.out.println("=== 数据库连接测试完成 ===");
    }

    @Test
    public void testUserTableExists() {
        System.out.println("=== 开始测试用户表是否存在 ===");
        
        try (Connection connection = dataSource.getConnection()) {
            String sql = "SHOW TABLES LIKE 'user'";
            try (PreparedStatement ps = connection.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {
                
                if (rs.next()) {
                    System.out.println("✅ 用户表存在");
                } else {
                    System.out.println("❌ 用户表不存在，请先执行 init.sql 脚本");
                }
            }
            
        } catch (Exception e) {
            System.err.println("❌ 检查用户表失败: " + e.getMessage());
            e.printStackTrace();
        }
        
        System.out.println("=== 用户表检查完成 ===");
    }
}
