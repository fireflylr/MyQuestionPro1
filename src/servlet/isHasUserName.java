package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class isHasUserName extends HttpServlet {

	/**
	 * The doGet method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to get.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.doPost(request, response);
	}

	/**
	 * The doPost method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to post.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
//		String test1=request.getParameter("name");
//		System.out.println(test1+"test");
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		
		//获取请求中的用户名数据值
		String name=request.getParameter("name");
		System.out.println(name);
		Connection conn=null;
		PreparedStatement ps=null;
		ResultSet set=null;
		//1.导入数据库驱动jar包
		//2.对数据库驱动程序进行类加载
		try {
			Class.forName("oracle.jdbc.OracleDriver");///注意大小写
			//3.创建连接对象
			conn=DriverManager.getConnection("jdbc:oracle:thin:@10.0.6.4:1521:xe","system","root");
			//4.创建ps对象
			ps=conn.prepareStatement("select * from p_user where username='"+name+"'");
			//执行ps中封装的sql语句:如果执行的查询的sql必须使用executeQuery()方法，其他则使用executeUpdate()
			set=ps.executeQuery();
			
			//通过遍历（循环）提取set中存储的数据值
			if(set.next())
			{
				//标识结果集中存在-》用户名已存在
				out.println("用户名已经存在");
				
			}else
			{
				//标识用户名不存在
				out.println("用户名可用");
			}
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			try {
				conn.close();
				ps.close();
				set.close();
				out.flush();
				out.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

}
