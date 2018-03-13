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
		<form action="/MyQuestionPro/Login" method="post">
		<div class="align-center">
			<span>${requestScope.msg}</span></br>
			账号：<input type="text" name="username" /></br></br></br>
			密码：<input type="password" name="password" /></br></br></br>
			<center>
				<input type="submit" value="登录" />
				<input type="button" onclick="location='register.jsp'" value="注册">
			</center>
		</div>	
		</form>
	</body>
</html>