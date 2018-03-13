package util;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;

import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;

/*
 * ���� Ч�� �ڴ�ʹ��
 * ά���� �������޸ģ�
 * ��������
 */

public class JDBCUtil {
	private static Properties p = new Properties();
	private static ThreadLocal<Connection> tl = new ThreadLocal<Connection>();
	
	static{
		//1 ����Properties�ļ�
		  InputStream is = JDBCUtil.class.getResourceAsStream("/jdbc.properties");
		 //2 ����Properties����
		  try {
			p.load(is);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
   
	//��������
	public static Connection getConnection() throws Exception{
		  Connection conn = tl.get();
		  if(conn==null){
			  Class.forName(p.getProperty("driver"));
			  conn = DriverManager.getConnection(p.getProperty("url"),p.getProperty("username"),p.getProperty("password"));
			  tl.set(conn);  
			  return conn;
		  }
		  return conn;
	}
	
	public static void commit() {
		
		Connection conn;
		try {
			conn = JDBCUtil.getConnection();
			conn.setAutoCommit(false);
			conn.commit();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

	public static void rollback() {

		try {
			JDBCUtil.getConnection().rollback();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	//�ر���Դ
	public static void close(Connection conn,PreparedStatement pstmt,ResultSet rs){
		if(rs!=null){try{rs.close();}catch(Exception e){}}
		if(pstmt!=null){try{pstmt.close();}catch(Exception e){}}
		if(conn!=null){try{conn.close();tl.remove();}catch(Exception e){}}
	}
	
	public static void close(Connection conn,PreparedStatement pstmt){
		if(pstmt!=null){try{pstmt.close();}catch(Exception e){}}
		if(conn!=null){try{conn.close();tl.remove();}catch(Exception e){}}
	}
	
}
