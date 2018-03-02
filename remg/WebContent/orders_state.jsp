<%@page language="java" import="java.util.*,java.sql.*,java.net.*" contentType="text/html; charset=utf8"
    pageEncoding="utf8"%>
 <%
    request.setCharacterEncoding("utf8");
    String oid=request.getParameter("oid");
    
	request.setCharacterEncoding("utf8");
	String url="jdbc:mysql://localhost:3306/remg?useUnicode=true&characterEncoding=utf-8";
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn =DriverManager.getConnection(url, "root","");
	
	String sql="call finish_orders('"+oid+"')";
    Statement stat=conn.createStatement();
    stat.executeQuery("set names utf8");
    int i=stat.executeUpdate(sql);

    if(i==1)	
    	out.print("<script>location.href='order_main'</script>");
    else
    	out.print("<script language=javascript>window.alert('操作失败!');location.href='order_main'</script>"); 
    stat.close();
    conn.close();
 %>