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

public class NextQuestion extends HttpServlet {

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
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		
		//连接数据库，在questions表中随机获取一行数据，且将该行数据响应回客户端
				Connection conn=null;
				PreparedStatement ps=null;
				ResultSet set=null;
				//1.导入数据库驱动jar包
				//2.对数据库驱动程序进行类加载
				try {
					Class.forName("oracle.jdbc.OracleDriver");
					//3.创建连接对象
					conn=DriverManager.getConnection("jdbc:oracle:thin:@10.0.6.4:1521:xe","system","root");
					//4.创建ps对象
					ps=conn.prepareStatement("select * from (select q.*,rownum r from questions q) where r=(select trunc(dbms_random.value(1,20)) from dual)");
					//执行ps中封装的sql语句:如果执行的查询的sql必须使用executeQuery()方法，其他则使用executeUpdate()
					set=ps.executeQuery();
					
					//通过遍历（循环）提取set中存储的数据值
					if(set.next())
					{
						String q=set.getString("question");
						String a1=set.getString("answer1");
						String a2=set.getString("answer2");
						String a3=set.getString("answer3");
						String a4=set.getString("answer4");
						String a=set.getString("answer");
					//println默认加入回车
						out.println(q+"/"+a1+"/"+a2+"/"+a3+"/"+a4+"/"+a);
						System.out.println(q);
					}
					
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}finally{
					out.flush();
					out.close();
					try {
						conn.close();
						ps.close();
						set.close();
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
	}

}
