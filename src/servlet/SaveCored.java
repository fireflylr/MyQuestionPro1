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

public class SaveCored extends HttpServlet {

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
			//1.接收数据
			String dat=request.getParameter("name");
			///System.out.println(dat);
			String [] arr=dat.split("/");
			String name=arr[0];
			//System.out.println(name);
//			String test1=request.getParameter("test");
//			System.out.println("My"+test1);
			Connection conn=null;
			PreparedStatement ps=null;
			ResultSet set=null;
			//2.业务处理
			try {
				
				Class.forName("oracle.jdbc.OracleDriver");
				
				conn=DriverManager.getConnection("jdbc:oracle:thin:@10.0.6.4:1521:xe","system","root");
				
				ps=conn.prepareStatement("select * from grade where username='"+name+"'");
				set=ps.executeQuery();
				
				if(set.next()){
					
					int s=set.getInt("core");
					int ns=0;
					if(arr[1].equals("T")){
						ns=s+10;
						ps=conn.prepareStatement("update grade set core="+ns+" where username='"+name+"'");
						ps.executeUpdate();
					}
//						ns=s+10;
//						ps=conn.prepareStatement("update grade set core="+ns+" where username='"+name+"'");
//						ps.executeUpdate();
						
				}
				else{
					ps=conn.prepareStatement("insert into grade values(?,?)");
					ps.setString(1,name);         
					if(arr[1].equals("T")){
						ps.setInt(2, 10);
					}else{
						ps.setInt(2, 0);
					}
					ps.executeUpdate();	
				}
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally{
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
