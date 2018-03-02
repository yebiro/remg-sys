<%@page language="java" import="java.util.*,java.sql.*,java.net.*,bean.customers" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
<% 
 String Manager="Manager";
 if(session.getAttribute("account")==null)
 {
	 out.println("<script language=javascript>window.alert('请先进行登录');location.href='index.jsp'</script>");
 }   
 else 
 {
	 Manager=session.getAttribute("account").toString();
 }
%>
<head>
	<title>餐饮店点餐 · 消费管理系统</title>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
	<!-- VENDOR CSS -->
	<link rel="stylesheet" href="assets/vendor/bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="assets/vendor/font-awesome/css/font-awesome.min.css">
	<link rel="stylesheet" href="assets/vendor/linearicons/style.css">
	<link rel="stylesheet" href="assets/vendor/chartist/css/chartist-custom.css">
	<!-- MAIN CSS -->
	<link rel="stylesheet" href="assets/css/main.css">
	<!-- FOR DEMO PURPOSES ONLY. You should remove this in your project -->
	<link rel="stylesheet" href="assets/css/demo.css">
	<!-- GOOGLE FONTS -->
	<link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700" rel="stylesheet">
	<!-- ICONS -->
	<link rel="apple-touch-icon" sizes="76x76" href="assets/img/apple-icon.png">
	<link rel="icon" type="image/png" sizes="96x96" href="assets/img/favicon.png">
</head>

<body>
	<!-- WRAPPER -->
	<div id="wrapper">
		<!-- NAVBAR -->
		<nav class="navbar navbar-default navbar-fixed-top">
			<div class="brand">
				<a href="welcome.jsp" class="panel-title">餐饮店点餐 · 消费管理系统</a>
			</div>
			<div class="container-fluid">
				<div class="navbar-btn">
					<button type="button" class="btn-toggle-fullwidth"><i class="lnr lnr-arrow-left-circle"></i></button>
				</div>
				<div id="navbar-menu">
					<ul class="nav navbar-nav navbar-right">
						<li class="dropdown">
							<a href="#" class="dropdown-toggle" data-toggle="dropdown"><img src="assets/img/user.png" class="img-circle" alt="Avatar"> <span><%=Manager%></span> <i class="icon-submenu lnr lnr-chevron-down"></i></a>
							<ul class="dropdown-menu">
								<!-- <li><a href="#"><i class="lnr lnr-user"></i> <span>My Profile</span></a></li> -->
								<li><a href="index.jsp"><i class="lnr lnr-exit"></i> <span>Logout</span></a></li>
							</ul>
						</li>
					</ul>
				</div>
			</div>
		</nav>
		<!-- END NAVBAR -->
		<!-- LEFT SIDEBAR -->
		<div id="sidebar-nav" class="sidebar">
			<div class="sidebar-scroll">
				<nav>
					<ul class="nav">
						<li><a href="cust_main" class="active"><i class="lnr lnr-user"></i> <span>会员管理</span></a></li>
						<li><a href="order_main" class=""><i class="lnr lnr-book"></i> <span>订单管理</span></a></li>
						<li><a href="meal_main" class=""><i class="lnr lnr-dinner"></i> <span>套餐管理</span></a></li>
						<li><a href="acti_main" class=""><i class="lnr lnr-layers"></i> <span>活动管理</span></a></li>
						<li><a href="reports_main.jsp" class=""><i class="lnr lnr-chart-bars"></i> <span>消费报告</span></a></li>
					</ul>
				</nav>
			</div>
		</div>
		<!-- END LEFT SIDEBAR -->
		<!-- MAIN -->
		<div class="main">
			<!-- MAIN CONTENT -->
			<div class="main-content">
				<div class="container-fluid">
					<!-- TEST -->
					<div class="panel panel-headline">
						<div class="panel-body no-padding">
							<form class="navbar-form navbar-left" method="post" action="cust_search">
								<div class="input-group">
									<input type="text" value="" class="form-control" placeholder="搜索会员" name="customers_search">
									<span class="input-group-btn"><button type="submit" class="btn btn-primary">Go</button></span>
								</div>
								<img src="../assets/img/little_blank.png">
								<a href="customers_add.jsp"><button type="button" class="btn btn-success btn-toastr" data-context="success">添加</button></a>
							</form>
						</div>
					</div>
					<%
                     String path = request.getContextPath();
                     String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
                    %>
                   
					<%
					request.setCharacterEncoding("UTF-8");

				    List<customers> list = (List)request.getAttribute("list");
				    Iterator<customers> it = list.iterator();
				    if(!it.hasNext())
				    {
				    	out.print("暂无会员信息！");
				    }
				    //it.previous();
				    
				    String cid="",cname="",sex="",level="",integral="",telephone_no="",birthdate="";
				    while(it.hasNext()){
					       customers rs = it.next();	
				    	   cid=rs.get_cid();
				    	   cname=rs.get_cname();
						   sex=rs.get_sex();
						   level=rs.get_level();
						   integral=rs.get_integral();
						   telephone_no=rs.get_telephone_no();
						   birthdate=rs.get_birthdate().substring(0, 10);  
					%>
					<div class="panel panel-headline">
						<div class="panel-body">
						 <!-- <img src="<%=basePath%>+"assets/img/"+blank.png></div> -->
						<div><img src="assets/img/blank.png"></div> 
							<table class="table">
								<thead>
									<tr>
										<th>会员ID</th>
									    <th>姓名</th>
									    <th>性别</th>
									    <th>积分</th>
									    <th>会员等级</th>
									    <th>手机号码</th>
									    <th>生日</th>
									    <th>操作</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td><%=cid%></td>
										<td><%=cname%></td>
										<td><%=sex%></td>
										<td><%=integral%></td>
										<td><%=level%></td>
										<td><%=telephone_no%></td>
										<td><%=birthdate%></td>
										<td>
											<a href="customers_edit.jsp?cid=<%=cid%>"><span class="lnr lnr-pencil"></span></a>
											<img src="assets/img/little_blank_1.png">
											<a href="cust_del?cid=<%=cid%>" onclick="return del()"><span class="lnr lnr-trash"></span></a>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
					
					<%
					}
					%>
					
				</div>
				<!-- END TEST -->
			</div>
			<!-- END MAIN CONTENT -->
		</div>
		<!-- END MAIN -->
		<div class="clearfix"></div>
		<footer>
			<div class="container-fluid">
				<p class="copyright">&copy; 2017. All Rights Reserved.</p>
			</div>
		</footer>
	</div>
	<!-- END WRAPPER -->
	<!-- Javascript -->
	<script src="assets/vendor/jquery/jquery.min.js"></script>
	<script src="assets/vendor/bootstrap/js/bootstrap.min.js"></script>
	<script src="assets/vendor/jquery-slimscroll/jquery.slimscroll.min.js"></script>
	<script src="assets/vendor/jquery.easy-pie-chart/jquery.easypiechart.min.js"></script>
	<script src="assets/vendor/chartist/js/chartist.min.js"></script>
	<script src="assets/scripts/klorofil-common.js"></script>
	<script>
	$(function() {
		var data, options;

		// headline charts
		data = {
			labels: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
			series: [
				[23, 29, 24, 40, 25, 24, 35],
				[14, 25, 18, 34, 29, 38, 44],
			]
		};

		options = {
			height: 300,
			showArea: true,
			showLine: false,
			showPoint: false,
			fullWidth: true,
			axisX: {
				showGrid: false
			},
			lineSmooth: false,
		};

		new Chartist.Line('#headline-chart', data, options);


		// visits trend charts
		data = {
			labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
			series: [{
				name: 'series-real',
				data: [200, 380, 350, 320, 410, 450, 570, 400, 555, 620, 750, 900],
			}, {
				name: 'series-projection',
				data: [240, 350, 360, 380, 400, 450, 480, 523, 555, 600, 700, 800],
			}]
		};

		options = {
			fullWidth: true,
			lineSmooth: false,
			height: "270px",
			low: 0,
			high: 'auto',
			series: {
				'series-projection': {
					showArea: true,
					showPoint: false,
					showLine: false
				},
			},
			axisX: {
				showGrid: false,

			},
			axisY: {
				showGrid: false,
				onlyInteger: true,
				offset: 0,
			},
			chartPadding: {
				left: 20,
				right: 20
			}
		};

		new Chartist.Line('#visits-trends-chart', data, options);


		// visits chart
		data = {
			labels: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
			series: [
				[6384, 6342, 5437, 2764, 3958, 5068, 7654]
			]
		};

		options = {
			height: 300,
			axisX: {
				showGrid: false
			},
		};

		new Chartist.Bar('#visits-chart', data, options);


		// real-time pie chart
		var sysLoad = $('#system-load').easyPieChart({
			size: 130,
			barColor: function(percent) {
				return "rgb(" + Math.round(200 * percent / 100) + ", " + Math.round(200 * (1.1 - percent / 100)) + ", 0)";
			},
			trackColor: 'rgba(245, 245, 245, 0.8)',
			scaleColor: false,
			lineWidth: 5,
			lineCap: "square",
			animate: 800
		});

		var updateInterval = 3000; // in milliseconds

		setInterval(function() {
			var randomVal;
			randomVal = getRandomInt(0, 100);

			sysLoad.data('easyPieChart').update(randomVal);
			sysLoad.find('.percent').text(randomVal);
		}, updateInterval);

		function getRandomInt(min, max) {
			return Math.floor(Math.random() * (max - min + 1)) + min;
		}

	});
 
 	//---------------删除确认--------------------
	function del() { 
		if (confirm("您确定要删除吗?") == true){ 
			return true; 
		}else{ 
			return false; 
		} 
	} 
	</script>
</body>
</html>
