package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AddQuestion extends HttpServlet {

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
		
		request.setCharacterEncoding("utf-8");//����Ӧ��jspҳ����뱣��һֱ
		//��ȡjspҳ���ֵ
		String q=request.getParameter("q");
		String a1=request.getParameter("a1");
		String a2=request.getParameter("a2");
		String a3=request.getParameter("a3");
		String a4=request.getParameter("a4");
		String a=request.getParameter("a");
		
		Connection conn=null;
		PreparedStatement ps=null;
		try {
			//create table p_user(username varchar2(200),password varchar2(200))
			//1.�������ݿ���������
			 Class.forName("oracle.jdbc.OracleDriver");
			//2.�������Ӷ���:���������������ݿ�
			 conn=DriverManager.getConnection("jdbc:oracle:thin:@10.0.6.4:1521:xe","system","root");
			//3.����PreparedStatement���������洢����Ҫ�����ݿ���ִ�е�sql��䣬������sql������ִ��
			 ps=conn.prepareStatement("insert into questions values(?,?,?,?,?,?)");
			 ps.setString(1,q);
			 ps.setString(2,a1);
			 ps.setString(3,a2);
			 ps.setString(4,a3);
			 ps.setString(5,a4);
			 ps.setString(6,a);
			 ps.executeUpdate();//ִ��ps�����д洢��sql��䣬���²���
	
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			try {
				conn.close();
				ps.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			//ҳ����ת
			request.getRequestDispatcher("/addQuestion.jsp").forward(request, response);
		}
		
	}

}
