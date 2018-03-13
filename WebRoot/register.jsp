<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page isELIgnored="false" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>注册页面</title>
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

	<script>
		function isHasUserName(){
		//从当前jsp上获取用户名
		var name=document.getElementById("name").value;
		//1.创建请求对象
		/*var r=new XMLHttpRequest();
		//发送请求：参数1：请求方式（Get or POST）,参数2：请求的资源地址
		//r.open("GET","http://10.0.6.4:8086/MyQuestionPro/isHasUserName?name="+name);
		r.open("POST","http://10.0.6.4:8086/MyQuestionPro/isHasUserName");
		//设置请求的头信息
		r.setRequestHeader("Content-Type", "application/x-www-from-urlencoded");
		//获取用户名数据值
		var ss="name="+name;*/
		var r = new XMLHttpRequest();
		r.open("POST", "http://10.0.6.4:8086/MyQuestionPro/isHasUserName");
		r.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
		//r.send("name="+name);//!!
		//发送请求，可给请求的资源发送数据值
		r.send("name="+name);
		//验证请求和响应
		r.onreadystatechange=function(){
		if(r.readyState==4&&r.status==200){
					//接收处理服务器响应回来的数据值
					//如何接收服务器响应回来的数据值
					var msg=r.responseText;
					//在固定位置显示
					document.getElementById("s").innerHTML=msg;
		}
		
		}
		
		
		}
		//两次密码一致验证
	function isSame(){
		var pwd=document.getElementById("pwd").value;
		var pwd1=document.getElementById("repd").value;
		if(pwd1==pwd){
			document.getElementById("Sa").innerHTML="";
		}else{
		document.getElementById("Sa").innerHTML="两次密码输入不一致，请重新输入";
		document.getElementById("repd").value="";
		}
	}
	//表单提交验证
	function checknull(){
		var name=document.getElementById("name").value;
		var pwd=document.getElementById("pwd").value;
		var pwd1=document.getElementById("repd").value;
		if(name==""){
		alert("账号不能为空！");
		return false;
		}
		if(pwd==""){
		alert("密码不可为空！");
		return false;
		}
		if(!(pwd==pwd1)){
		alert("两次输入密码不一致！");
		return false;
		}
		return true;
	}
	
	</script>
	</head>
	<body>
		<form action="http://10.0.6.4:8086/MyQuestionPro/Register" method="post" onsubmit="return checknull()">
		<div class="align-center">
			账号：&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="username" id="name" onblur="isHasUserName()" /><span id="s"></span></br></br>
			密码：&nbsp;&nbsp;&nbsp;&nbsp;<input type="password" name="password" id="pwd"/></br></br>
			重复密码：<input type="text" name="repwd" id="repd" onblur="isSame()"/><span id="Sa"></span></br></br>
			手机验证：<input type="text" name="phonenum" />
			<input type="button" value="发送手机验证码">
			</br></br>
			<center>
				<input type="submit" value="注册" />
			</center>
		</div>	
		</form>
	</body>
</html>