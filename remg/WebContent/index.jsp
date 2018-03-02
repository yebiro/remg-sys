<%@page language="java" import="java.util.*,java.sql.*,java.net.*" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en" class="fullscreen-bg">

<head>
	<title>餐饮店点餐 · 消费管理系统</title>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
	<!-- VENDOR CSS -->
	<link rel="stylesheet" href="assets/css/bootstrap.min.css">
	<link rel="stylesheet" href="assets/vendor/font-awesome/css/font-awesome.min.css">
	<link rel="stylesheet" href="assets/vendor/linearicons/style.css">
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
<%
session.setAttribute("account", null);
String account = "";
String password = "";
Cookie c[]=request.getCookies();
if(c!=null)
{
    for(int i=0;i<c.length;i++)
   {
       //从cookie中将account和password获取
       if(c[i].getName().equals("account"))
    	   account= URLDecoder.decode(c[i].getValue(),"gb2312"); 
       else if(c[i].getName().equals("password"))
    	   password= URLDecoder.decode(c[i].getValue(),"gb2312"); 
    	  // request.setAttribute("password",c[i].getValue()); 
   } 
}
%>
	<!-- WRAPPER -->
	<div id="wrapper">
		<div class="vertical-align-wrap">
			<div class="vertical-align-middle">
				<div class="auth-box ">
					<div class="left">
						<div class="content">
							<div class="header">
								<div class="logo text-center"><h3>餐饮店点餐 · 消费管理系统</h3></div>
								<p class="lead">登录账户</p>
							</div>
							<form class="form-auth-small" action="login_check.jsp" method="post">
								<div class="form-group">
									<!-- <label for="signin-email" class="control-label sr-only">Email</label> -->
									<input type="text" class="form-control" name="account" placeholder="帐号" value=<%=account%>>
									<span></span>
									<br>
								</div>
								<div class="form-group">
									<!-- <label for="signin-password" class="control-label sr-only">Password</label> -->
									<input type="password" class="form-control" name="password" placeholder="密码" value=<%=password%>>
									<span></span>
									<br>
								</div>
								<div class="form-group clearfix">
									<label class="fancy-checkbox element-left">
										<input type="checkbox" name="save">
										<span>记住密码</span>
									</label>
								</div>
								<a href="javascript:;"><button type="submit" class="btn btn-primary btn-lg btn-block">登录</button></a>
								<!-- <div class="bottom">
									<span class="helper-text"><i class="fa fa-lock"></i> <a href="#">Forgot password?</a></span>
								</div> -->
							</form>
						</div>
					</div>
					<div class="right">
						<div class="overlay"></div>
						<div class="content text">
							<h1 class="heading">一叶落锅一叶飘，一叶离面又出刀。</h1>
							<h1 class="heading">银鱼落水翻白浪，柳叶乘风下树梢。</h1>
							<!-- <p>by The Develovers</p> -->
						</div>
					</div>
					<div class="clearfix"></div>
				</div>
			</div>
		</div>
	</div>
	<!-- END WRAPPER -->
	<script src="assets/vendor/jquery/jquery.js"></script>
	<script type="text/javascript">
	$(function() {
		//-----------------------表单验证-----------------------------
		var ok1=false;
        var ok2=false;
        // var ok3=false;

        // 验证管理员帐号
        $('input[name="account"]').focus(function(){
          // $(this).next().text(' 会员ID应该为4位');
        }).blur(function(){
          if($(this).val().length == 6 && $(this).val()!=''){
          	$(this).next().text('');
            ok1=true;
          }else{
            $(this).next().text('帐号应该为6位');
          }
        });
  
        //验证密码
        $('input[name="password"]').focus(function(){
          // $(this).next().text(' 姓名应该为1-15位之间');
        }).blur(function(){
          if($(this).val().length >= 6 && $(this).val().length <=20 && $(this).val()!=''){
            $(this).next().text('');
            ok2=true;
          }else{
            $(this).next().text('密码应该为6-20位之间');
          }
        });
  
        //提交按钮,所有验证通过方可提交
  
        $('.submit').click(function(){
          if(ok1 && ok2){
            $('form').submit();
          }else{
            return false;
          }
        });

	});
	</script>
</body>

</html>
