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
		
		//��ȡ�����е��û�������ֵ
		String name=request.getParameter("name");
		System.out.println(name);
		Connection conn=null;
		PreparedStatement ps=null;
		ResultSet set=null;
		//1.�������ݿ�����jar��
		//2.�����ݿ�����������������
		try {
			Class.forName("oracle.jdbc.OracleDriver");///ע���Сд
			//3.�������Ӷ���
			conn=DriverManager.getConnection("jdbc:oracle:thin:@10.0.6.4:1521:xe","system","root");
			//4.����ps����
			ps=conn.prepareStatement("select * from p_user where username='"+name+"'");
			//ִ��ps�з�װ��sql���:���ִ�еĲ�ѯ��sql����ʹ��executeQuery()������������ʹ��executeUpdate()
			set=ps.executeQuery();
			
			//ͨ��������ѭ������ȡset�д洢������ֵ
			if(set.next())
			{
				//��ʶ������д���-���û����Ѵ���
				out.println("�û����Ѿ�����");
				
			}else
			{
				//��ʶ�û���������
				out.println("�û�������");
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