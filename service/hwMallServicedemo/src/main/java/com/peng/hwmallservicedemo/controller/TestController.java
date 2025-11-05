package com.peng.hwmallservicedemo.controller;

import com.peng.hwmallservicedemo.model.user.userdao;
import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/test")
public class TestController {

    /**
     * 测试数据库连接的REST接口
     */
    @GetMapping("/database")
    public Map<String, Object> testDatabase() {
        Map<String, Object> result = new HashMap<>();
        SqlSession session = null;
        
        try {
            // 创建MyBatis会话
            session = new SqlSessionFactoryBuilder()
                    .build(Resources.getResourceAsStream("mybatis.xml"))
                    .openSession();
            
            // 测试查询用户表记录数
            Integer count = session.selectOne("dao.UserDao.getUserCount");
            
            result.put("success", true);
            result.put("message", "数据库连接成功");
            result.put("userCount", count);
            result.put("timestamp", System.currentTimeMillis());
            
        } catch (IOException e) {
            result.put("success", false);
            result.put("message", "MyBatis配置文件读取失败: " + e.getMessage());
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "数据库连接失败: " + e.getMessage());
        } finally {
            if (session != null) {
                session.close();
            }
        }
        
        return result;
    }

    /**
     * 获取所有用户的REST接口
     */
    @GetMapping("/users")
    public Map<String, Object> getAllUsers() {
        Map<String, Object> result = new HashMap<>();
        SqlSession session = null;
        
        try {
            session = new SqlSessionFactoryBuilder()
                    .build(Resources.getResourceAsStream("mybatis.xml"))
                    .openSession();
            
            List<userdao> users = session.selectList("dao.UserDao.getAllUsers");
            
            result.put("success", true);
            result.put("message", "查询成功");
            result.put("data", users);
            result.put("count", users.size());
            
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "查询失败: " + e.getMessage());
        } finally {
            if (session != null) {
                session.close();
            }
        }
        
        return result;
    }

    /**
     * 插入测试用户的REST接口
     */
    @GetMapping("/insert-test-user")
    public Map<String, Object> insertTestUser() {
        Map<String, Object> result = new HashMap<>();
        SqlSession session = null;
        
        try {
            session = new SqlSessionFactoryBuilder()
                    .build(Resources.getResourceAsStream("mybatis.xml"))
                    .openSession();
            
            // 创建测试用户
            userdao testUser = new userdao();
            testUser.setUsername("webtest_" + System.currentTimeMillis());
            testUser.setPassword("123456");
            testUser.setPhone("13800138000");
            testUser.setEmail("webtest@example.com");
            
            int insertResult = session.insert("dao.UserDao.insertTestUser", testUser);
            session.commit();
            
            result.put("success", true);
            result.put("message", "用户插入成功");
            result.put("insertResult", insertResult);
            result.put("testUser", testUser);
            
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "用户插入失败: " + e.getMessage());
            if (session != null) {
                session.rollback();
            }
        } finally {
            if (session != null) {
                session.close();
            }
        }
        
        return result;
    }

    /**
     * 应用健康检查接口
     */
    @GetMapping("/health")
    public Map<String, Object> healthCheck() {
        Map<String, Object> result = new HashMap<>();
        result.put("status", "UP");
        result.put("message", "应用运行正常");
        result.put("timestamp", System.currentTimeMillis());
        return result;
    }
}
