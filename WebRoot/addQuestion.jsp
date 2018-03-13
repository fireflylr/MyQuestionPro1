<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page isELIgnored="false" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>登录页面</title>
		<style type="text/css" >
		body{
           	 background-image:url(img/bg.jpg);
           	 background-position:center;           
             background-repeat:repeat-y；
        }
        
	</style>
	<style type="text/css"> 
		.align-center{ 
		position:fixed;left:50%;top:50%;margin-left:width/2;margin-top:height/2;
	} 
</style> 
	
	</head>
	<body>
		<form action="/MyQuestionPro/AddQuestion" method="post">
		<div class="align-center">
			
			题目：<input type="text" name="q" /></br></br></br>
			选项一：<input type="text" name="a1" /></br>
			选项二：<input type="text" name="a2" /></br>
			选项三：<input type="text" name="a3" /></br>
			选项四：<input type="text" name="a4" /></br></br></br>
			正确答案：<input type="text" name="a" /></br>
			<center>
				<input type="submit" value="提交" />
				<input type="button" onclick="location='login.jsp'" value="结束" />
			</center>
		</div>	
		</form>
	</body>
</html>