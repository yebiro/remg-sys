<%@page language="java" import="java.util.*,java.sql.*,java.net.*" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
    request.setCharacterEncoding("UTF-8");
    int i = Integer.parseInt(request.getAttribute("i").toString());     	
    if(i==1)
    {
    	out.println("<script language=javascript>window.alert('删除会员成功');location.href='cust_main'</script>");
    }
    else
    {
    	out.println("<script language=javascript>window.alert('删除会员失败！');location.href='cust_main'</script>");  
    }
%>
