import com.peng.hwmallservicedemo.model.user.userdao;
import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import java.io.IOException;
import java.util.List;

public class test {
    SqlSession session;
    
    @Before
    public void open(){
        try {
            session = new SqlSessionFactoryBuilder().build(Resources.getResourceAsStream("mybatis.xml")).openSession();
            System.out.println("=== MyBatis 会话创建成功 ===");
        } catch (IOException e) {
            System.err.println("=== MyBatis 配置文件读取失败 ===");
            e.printStackTrace();
        } catch (Exception e) {
            System.err.println("=== 数据库连接失败 ===");
            e.printStackTrace();
        }
    }

    @After
    public void close(){
        if (session != null) {
            session.commit();
            session.close();
            System.out.println("=== MyBatis 会话关闭成功 ===");
        }
    }

    /**
     * 测试数据库连接 - 查询用户表记录数
     */
    @Test
    public void testDatabaseConnection(){
        try {
            System.out.println("\n=== 开始测试数据库连接 ===");
            Integer count = session.selectOne("dao.UserDao.getUserCount");
            System.out.println("用户表中的记录数: " + count);
            System.out.println("=== 数据库连接测试成功 ===");
        } catch (Exception e) {
            System.err.println("=== 数据库连接测试失败 ===");
            e.printStackTrace();
        }
    }

    /**
     * 测试根据ID查询用户
     */
    @Test
    public void testGetUserById(){
        try {
            System.out.println("\n=== 开始测试根据ID查询用户 ===");
            userdao user = session.selectOne("dao.UserDao.getUserById", 1);
            if (user != null) {
                System.out.println("查询到的用户信息: " + user);
            } else {
                System.out.println("未找到ID为1的用户");
            }
            System.out.println("=== 根据ID查询用户测试完成 ===");
        } catch (Exception e) {
            System.err.println("=== 根据ID查询用户测试失败 ===");
            e.printStackTrace();
        }
    }

    /**
     * 测试查询所有用户
     */
    @Test
    public void testGetAllUsers(){
        try {
            System.out.println("\n=== 开始测试查询所有用户 ===");
            List<userdao> users = session.selectList("dao.UserDao.getAllUsers");
            System.out.println("查询到的用户数量: " + users.size());
            for (userdao user : users) {
                System.out.println("用户信息: " + user);
            }
            System.out.println("=== 查询所有用户测试完成 ===");
        } catch (Exception e) {
            System.err.println("=== 查询所有用户测试失败 ===");
            e.printStackTrace();
        }
    }

    /**
     * 测试插入用户
     */
    @Test
    public void testInsertUser(){
        try {
            System.out.println("\n=== 开始测试插入用户 ===");
            userdao testUser = new userdao();
            testUser.setUsername("testuser");
            testUser.setPassword("123456");
            testUser.setPhone("13800138000");
            testUser.setEmail("test@example.com");
            
            int result = session.insert("dao.UserDao.insertTestUser", testUser);
            session.commit(); // 提交事务
            
            System.out.println("插入结果: " + (result > 0 ? "成功" : "失败"));
            System.out.println("=== 插入用户测试完成 ===");
        } catch (Exception e) {
            System.err.println("=== 插入用户测试失败 ===");
            e.printStackTrace();
            session.rollback(); // 回滚事务
        }
    }

    /**
     * 综合测试 - 测试完整的数据库操作流程
     */
    @Test
    public void testCompleteFlow(){
        try {
            System.out.println("\n=== 开始综合测试 ===");
            
            // 1. 测试连接
            Integer count = session.selectOne("dao.UserDao.getUserCount");
            System.out.println("1. 当前用户表记录数: " + count);
            
            // 2. 插入测试用户
            userdao testUser = new userdao();
            testUser.setUsername("flowtest");
            testUser.setPassword("password123");
            testUser.setPhone("13900139000");
            testUser.setEmail("flowtest@example.com");
            
            int insertResult = session.insert("dao.UserDao.insertTestUser", testUser);
            session.commit();
            System.out.println("2. 插入测试用户: " + (insertResult > 0 ? "成功" : "失败"));
            
            // 3. 再次查询记录数
            Integer newCount = session.selectOne("dao.UserDao.getUserCount");
            System.out.println("3. 插入后用户表记录数: " + newCount);
            
            // 4. 查询所有用户
            List<userdao> users = session.selectList("dao.UserDao.getAllUsers");
            System.out.println("4. 查询到的所有用户:");
            for (userdao user : users) {
                System.out.println("   " + user);
            }
            
            System.out.println("=== 综合测试完成 ===");
        } catch (Exception e) {
            System.err.println("=== 综合测试失败 ===");
            e.printStackTrace();
            session.rollback();
        }
    }
}
