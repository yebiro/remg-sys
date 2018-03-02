<%@page language="java" import="java.util.*,java.sql.*,java.net.*" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; utf-8">
<title>登录中</title>
</head>
<body>
<% 
request.setCharacterEncoding("UTF-8");
String account=request.getParameter("account");
String password=request.getParameter("password");
String save=request.getParameter("save");

if(!(account==null||account.equals("")||password==null || password.equals("")))
{
try{
	request.setCharacterEncoding("utf8");
	String url="jdbc:mysql://localhost:3306/remg?useUnicode=true&characterEncoding=utf-8";
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn =DriverManager.getConnection(url, "root","");
	
	String sql="CALL confirm_manager('"+account+"', '"+password+"')";
    Statement stat=conn.createStatement();
    stat.executeQuery("set names utf8");
    ResultSet rs=stat.executeQuery(sql); 

    if(rs.next())
    {
       String error_login=rs.getString("error_login");
       if(error_login.equals("账号或密码不对！"))
       {
    	   out.print("<script language=javascript>window.alert('账号或密码错误!');location.href='index.jsp'</script>"); 
       }   
       else
       {
    	   if(save!=null)
           {
              Cookie c1=new Cookie("account",URLEncoder.encode(account,"gb2312"));
              Cookie c2=new Cookie("password",password);
              c1.setMaxAge(660);
              c2.setMaxAge(660);
              response.addCookie(c1);
              response.addCookie(c2); 
           }
    	   session.setAttribute("account", account);
    	   response.sendRedirect("welcome.jsp");
       } 	  
    }
   else
  {
	   out.print("<script language=javascript>window.alert('账号或密码错误!');location.href='index.jsp'</script>"); 
  }
    
 }
  catch(Exception e)
 {
    out.println(e);
 }
}
else
{
	out.print("<script language=javascript>window.alert('账号或密码为空!');location.href='index.jsp'</script>"); 
}
%>
</body>
</html>

