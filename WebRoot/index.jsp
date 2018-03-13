<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page isELIgnored="false"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta charset="utf-8" />
<title></title>
<link rel="stylesheet" type="text/css" href="css/style.css" />

<script type="text/javascript">
	var count = 0;
	var isselect=0;//
	function s(){
		//使可以单击事件，设置动态样式
		var otemp=document.getElementById("overp");
		//不显示，隐藏
		otemp.style.display="none";
		
		var r = new XMLHttpRequest();
		r.open("POST", "http://10.0.6.4:8086/MyQuestionPro/NextQuestion");
		r.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
		r.send(null);

		r.onreadystatechange = function(){
			
			if (r.readyState == 4 && r.status == 200) {
				
				var recv = r.responseText;
				var arr = recv.split("/");
				document.getElementById("q").innerHTML = arr[0];
				document.getElementById("d1").innerHTML = arr[1];
				document.getElementById("d2").innerHTML = arr[2];
				document.getElementById("d3").innerHTML = arr[3];
				document.getElementById("d4").innerHTML = arr[4];
				document.getElementById("answer").innerHTML = arr[5];
			}
		}
		//限制答题总数 
		if (count++ >= 1) {
			if(isselect==0){
			var name="${requestScope.name}";
			window.location.href="/MyQuestionPro/login.jsp";	
			alert("您未答任何题目，成绩为零");
			return ;
			}
			var name="${requestScope.name}";
			window.location.href="/MyQuestionPro/Final?name="+name;			
		}
	}
</script>

<script type="text/javascript">

	function WriteDate(name){
	//alert(name);
		var r = new XMLHttpRequest();
		r.open("POST", "http://10.0.6.4:8086/MyQuestionPro/SaveCored");
		r.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
		r.send("name="+name);//!!
		//r.send("test="+"hello");//
		r.onreadystatechange = function(){			
			if (r.readyState == 4 && r.status == 200) {
			}
		}
	}
	
	function s1(dd){
		var otemp=document.getElementById("overp");
		//不显示，隐藏
		otemp.style.display="block";//限制重复点击
		var an1=document.getElementById(dd).innerHTML;
		var choice=an1.split(".");
		var a=choice[0];
		//响应的数据在答案后加有回车
		var answer=document.getElementById("answer").innerHTML[0];
		if(a==answer){
			var name="${requestScope.name}";
			var sname=name+"/"+"T";
			//1.获取当前用户名，给用户加分
			//2.将用户及分数录入数据库中
			WriteDate(sname);//发送请求
	
		}else{
			var name="${requestScope.name}";
				var sname=name+"/"+"F";
				//1.获取当前用户名，给用户加分
				//2.将用户及分数录入数据库中;
				WriteDate(sname);//发送请求
		}
		isselect++;
	}
	
	function sort(){
	
		var r = new XMLHttpRequest();
		r.open("POST", "http://10.0.6.4:8086/MyQuestionPro/Sort");
		r.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
		r.send(null);
		r.onreadystatechange = function(){
		
			if (r.readyState == 4 && r.status == 200){
				var recv = r.responseText;
				var arr = recv.split("/");
				if(arr.length>3){
					document.getElementById("1").innerHTML = arr[0];
					document.getElementById("2").innerHTML = arr[1];
					document.getElementById("3").innerHTML = arr[2];
				}
				else if(arr.length>2){
					document.getElementById("1").innerHTML = arr[0];
					document.getElementById("2").innerHTML = arr[1];
					document.getElementById("3").innerHTML = "暂无";
				
				}else if(arr.length>1){
					document.getElementById("1").innerHTML = arr[0];
					document.getElementById("2").innerHTML = "暂无";
					document.getElementById("3").innerHTML = "暂无";
				}else {
					document.getElementById("1").innerHTML = "暂无";
					document.getElementById("2").innerHTML = "暂无";
					document.getElementById("3").innerHTML = "暂无";
				}
			}
		}
	
	
	
	}
	
</script>


</head>
<body load="s()">
	欢迎用户:${requestScope.name}
	<div class="game_box">
		<!--试题区-->
		<div class="box_1">
			<div id="overp" style="width: 702px;height: 543px;position:absolute;z-index:2"></div>
			<div class="over_time" id="ntime">10</div>
			<!--倒计时-->

			<div class="gg_title">
				<!--题目-->
				<span>题目：</span><br>
				<span id="q"></span>
			</div>
			<div class="gg_answer">
				<!--答案-->
				<div id="d1" class="ans ans1" onclick="s1('d1')">XXXXX</div>
				<div id="d2" class="ans ans2" onclick="s1('d2')">XXXXX</div>
				<div id="d3" class="ans ans3" onclick="s1('d3')">XXXXX</div>
				<div id="d4" class="ans ans4" onclick="s1('d4')">XXXXX</div>
				<div id="answer" style="display:none;"></div>
				<!--正确答案-->
			</div>
		</div>

		<!--排行区-->
		<div class="box_2">
			<div class="logo"></div>
			<!--Logo-->
			<div class="hat"></div>
			<!--皇冠-->
			<div class="topname">
				<!--排行展示区-->
				<div id="1" class="tn topname1">暂无</div>
				<div id="2" class="tn topname2">暂无</div>
				<div id="3" class="tn topname3">暂无</div>
			</div>
		</div>

		<!--聊天区-->
		<div class="box_3">
			<div class="info" id="message"></div>
			<!--聊天信息-->
			<div class="talk">
				<input type="text" class="talk1" name="" id="text" value="" />
			</div>
			<!--文本输入框-->
			<input class="sub" type="button" onclick="send()" value="提交" />
		</div>

		<!--Logo及扩展功能区-->
		<div class="box_4"></div>
	</div>
	<div class="register-bg"
		style="width: 100%;height: 100%;z-index: -1;position: fixed;background: #fafafa;top: 0;">
		<canvas id="stage"></canvas>
	</div>

</body>
<script type="text/javascript">
	var websocket = null;
	//判断当前浏览器是否支持WebSocket
	if ('WebSocket' in window) {
		//alert('支持WebSocket!')
		websocket = new WebSocket("ws://10.0.6.4:8086/MyQuestionPro/websocket");//!!
	} else {
		alert('不支持WebSocket!')
	}

	//连接发生错误的回调方法
	websocket.onerror = function() {
		setMessageInnerHTML("error");
	};

	//连接成功建立的回调方法
	websocket.onopen = function(event) {
		setMessageInnerHTML("聊天室开启");
	}

	//接收到消息的回调方法
	websocket.onmessage = function() {
		setMessageInnerHTML(event.data);
	}

	//连接关闭的回调方法
	websocket.onclose = function() {
		setMessageInnerHTML("聊天室关闭");
	}

	//监听窗口关闭事件，当窗口关闭时，主动去关闭websocket连接，防止连接还没断开就关闭窗口，server端会抛异常。
	window.onbeforeunload = function() {
		websocket.close();
	}

	//将消息显示在网页上
	function setMessageInnerHTML(innerHTML) {
		document.getElementById('message').innerHTML += innerHTML + '<br/>';
	}

	//关闭连接
	function closeWebSocket() {
		websocket.close();
	}

	//发送消息
	function send() {
		var username = "${requestScope.name}";
		var message = document.getElementById('text').value;
		var msg = "【" + username + "】发言:" + message
		websocket.send(msg);
	}
</script>
<!--聊天部分-->
<script type="text/javascript">
	(function() {
		var timer = null;
		var oNTime = document.getElementById("ntime");
		var temp = 5;

		//开始答题
		s();
		
		timer = setInterval(function() {
			//debugger;
			temp = temp - 1;
			if (temp > -1) {
				sort();//显示排行榜
				oNTime.innerHTML = temp;
			} else {
				temp = 5;
				oNTime.innerHTML = temp;

				//开始答题
				s();
			}
		}, 1000);
	})();
</script>

<script>
	(function() {
		//动画兼容
		if (!window.requestAnimationFrame) {
			window.requestAnimationFrame = (window.webkitRequestAnimationFrame
					|| window.mozRequestAnimationFrame
					|| window.oRequestAnimationFrame
					|| window.msRequestAnimationFrame || function(callback) {
				return window.setTimeout(callback, 1000 / 60);
			});
		}
		if (!window.cancelAnimationFrame) {
			window.cancelAnimationFrame = (window.cancelRequestAnimationFrame
					|| window.webkitCancelAnimationFrame
					|| window.webkitCancelRequestAnimationFrame
					|| window.mozCancelAnimationFrame
					|| window.mozCancelRequestAnimationFrame
					|| window.msCancelAnimationFrame
					|| window.msCancelRequestAnimationFrame
					|| window.oCancelAnimationFrame
					|| window.oCancelRequestAnimationFrame || window.clearTimeout);
		}
		window.utils = {};
		window.utils.parseColor = function(color, toNumber) {
			if (toNumber === true) {
				if (typeof color === 'number') {
					return (color | 0); //chop off decimal
				}
				if (typeof color === 'string' && color[0] === '#') {
					color = color.slice(1);
				}
				return window.parseInt(color, 16);
			} else {
				if (typeof color === 'number') {
					color = '#'
							+ ('00000' + (color | 0).toString(16)).substr(-6); //pad
				}
				return color;
			}
		};
		//将16进制颜色转换成rgb
		window.utils.colorToRGB = function(color, alpha) {
			//如果是字符串格式，转换为数字
			if (typeof color === "string" && color[0] === "#") {
				//parseInt(('#ffffff').slice(1),16) 为 16777215
				color = window.parseInt(color.slice(1), 16);
			}
			alpha = (alpha === undefined) ? 1 : alpha;
			//将color转换成r,g,b值，>>右移 <<左移
				var r = color >> 16 & 0xff; //例如：16777215 >> 16 变成 255， 255 & 0xff为255
			var g = color >> 8 & 0xff;
			var b = color & 0xff;
			var a = (alpha < 0) ? 0 : ((alpha > 1) ? 1 : alpha);
			if (a === 1) {
				return "rgb(" + r + "," + g + "," + b + ")";
			} else {
				return "rgba(" + r + "," + g + "," + b + "," + a + ")";
			}
		};

		function Ball(radius, color) {
			if (radius === undefined) {
				radius = 40;
			}
			if (color === undefined) {
				color = '#00ff00';
			}
			this.x = 0;
			this.y = 0;
			this.vx = 0;
			this.vy = 0;
			this.radius = radius;
			this.rotation = 0;
			this.mass = 1;
			this.scaleX = 1;
			this.scaleY = 1;
			this.name = "";
			this.color = utils.parseColor(color);
			this.lineWidth = 1;
		}
		Ball.prototype.draw = function(context) {
			context.save();
			context.translate(this.x, this.y);
			context.rotate(this.rotation);
			context.scale(this.scaleX, this.scaleY);
			context.lineWidth = this.lineWidth;
			context.fillStyle = this.color;
			context.strokeStyle = this.color;
			context.beginPath();
			// context.arc(0,0,this.radius,0,Math.PI*2,false);
			context.fillRect(this.x, this.y, this.radius, this.radius);
			context.closePath();
			context.fill();
			context.stroke();
			context.restore();
		};
		//得到球体的左上角坐标
		Ball.prototype.getBounds = function() {
			return {
				x : this.x - this.radius,
				y : this.y - this.radius,
				width : this.radius * 2,
				height : this.radius * 2
			};
		};

		function Box(width, height, color) {
			if (width === undefined) {
				width = 50;
			}
			if (height === undefined) {
				height = 50;
			}
			if (color === undefined) {
				color = "#ff0000";
			}
			this.x = 0;
			this.x = 0;
			this.y = 0;
			this.width = width;
			this.height = height;
			this.vx = 0;
			this.vy = 0;
			this.rotation = 0;
			this.scaleX = 1;
			this.scaleY = 1;
			this.color = utils.parseColor(color);
			this.lineWidth = 0;
		}
		Box.prototype.draw = function(context) {
			context.save();
			context.translate(this.x, this.y);
			context.rotate(this.rotation);
			context.scale(this.scaleX, this.scaleY);
			context.lineWidth = this.lineWidth;
			context.fillStyle = this.color;
			context.beginPath();
			context.rect(0, 0, this.width, this.height);
			context.closePath();
			context.fill();
			if (this.lineWidth > 0) {
				context.stroke();
			}
			context.restore();
		};
		window.onload = function() {
			var canvas = document.querySelector('canvas'), context = canvas
					.getContext('2d');
			var h = canvas.height = document
					.getElementsByClassName("register-bg")[0].clientHeight;
			var w = canvas.width = document
					.getElementsByClassName("register-bg")[0].clientWidth;
			var square_list = [];
			var grad = context.createLinearGradient(0, 0, 240, 240);
			grad.addColorStop(0, window.utils.colorToRGB('#DEE6F6', 80));
			grad.addColorStop(1, window.utils.colorToRGB('#FFFFFF', 60));

			function add_item(start_x, start_y, vx, vy) {
				var size = parseInt(2000 + 400 * Math.random()) / 10;
				var b = new Box(size, size);
				b.x = start_x;
				b.y = start_y;
				b.rotation = Math.PI / 4;
				b.color = grad;
				b.vx = vx;
				b.vy = vy;
				square_list.push(b);
				return b
			}
			add_item(300, h, -0.1, -1);
			add_item(600, h, 0.1, -1.1);
			var n_count = 0;
			var n_count_max = parseInt(w / 180);
			var t_count = 0;
			(function drawFrame() {
				(function() {
					t_count++;
					if (t_count > 60) {
						add_item(w / 2 + (w * 1.1 * (Math.random() - 0.5)), h
								+ (30 * Math.random()), 0.1 + 0.1 * (Math
								.random() - 0.5), -1 + (Math.random() - 0.5));
						t_count = 0;
					}
				})();
				window.requestAnimationFrame(drawFrame, canvas);
				context.clearRect(0, 0, canvas.width, canvas.height);
				var s = square_list;
				var l = s.length, i;
				for (i = 0; i < l; i++) {
					if (s[i].y + 400 < 0) {
						s.splice(i, 1);
						i--;
						l--;
						continue;
					}
					s[i].x += s[i].vx;
					s[i].y += s[i].vy;
					s[i].draw(context);
				}
			}());
			window.onresize = function() {
				h = canvas.height = document
						.getElementsByClassName("register-bg")[0].clientHeight;
				w = canvas.width = document
						.getElementsByClassName("register-bg")[0].clientWidth;
			}
		}
	})();
</script>
</html>

