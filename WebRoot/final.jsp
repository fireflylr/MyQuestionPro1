<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page isELIgnored="false"%>
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
			<center>
				${requestScope.n}最终得分为${requestScope.s}
			</center> 
	</body>
	<script type="text/javascript">
	(function() {
		var timer = null;
		timer = setTimeout(function() {
			window.location.href="/MyQuestionPro/login.jsp";	
		}, 1000);
	})();
	</script> 
</html>