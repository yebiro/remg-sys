<%@page language="java" import="java.util.*,java.sql.*,java.net.*,java.text.*" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<% 
    request.setCharacterEncoding("utf-8");
    String oid=request.getParameter("oid");
    String telephone_no=request.getParameter("telephone_no");
    String eid=request.getParameter("eid");
    String sid=request.getParameter("sid");
    String mid=request.getParameter("mid");
    String aid=request.getParameter("aid");
    String qty=request.getParameter("qty");
    double a_discount;
    if(aid=="a000")
    	a_discount=1;
    else
        a_discount=Math.random()*100*0.01;
 
	String url="jdbc:mysql://localhost:3306/remg?useUnicode=true&characterEncoding=utf-8";
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn =DriverManager.getConnection(url, "root","");
	String sql="CALL add_orders('"+oid+"', '"+telephone_no+"', '"+eid+"', '"+sid+"', '"+mid+"', '"+aid+"', '"+qty+"', '"+a_discount+"')";
	Statement stat=conn.createStatement();
    stat.executeQuery("set names utf8");
  
    try
    {
    	int i=stat.executeUpdate(sql);
    	if(i==1)
    	   {
    		//套餐即将售完提示
    		sql="CALL show_low_stock()";
    		ResultSet rs=stat.executeQuery(sql);
    		while(rs.next())
    		{
    			String low_stock=rs.getString("low_stock");
        		if(low_stock != null)
        		{
        			out.println("<script language=javascript>window.alert('"+low_stock+"')</script>");	
        		}	
    		}
    		out.println("<script language=javascript>window.alert('添加订单成功');location.href='order_main'</script>");
    	   }
    	   else
    	  {
    		   
    		   out.println("<script language=javascript>window.alert('添加订单失败！');location.href='orders_add.jsp'</script>");  
    	  }
    }
    catch(Exception e) 
    { 
    	//手机号错误提示
    	sql="CALL show_error_phone()";
    	ResultSet rs=stat.executeQuery(sql);
    	if(rs.next())
    	{
    		String error_phone=rs.getString("error_phone");
    		if(error_phone != null)
    		{
    			out.println("<script language=javascript>window.alert('"+error_phone+"');location.href='order_main'</script>");	
    		}
    		else
    		{
    			//库存不足提示
    			sql="CALL show_out_stock()";
    			rs=stat.executeQuery(sql);
    			if(rs.next())
    			{
    				String out_stock=rs.getString("out_stock");
    				if(out_stock != null)
    	    		{
    	    			out.println("<script language=javascript>window.alert('"+out_stock+"');location.href='order_main'</script>");	
    	    		}
    			}	
    		}
    	}   
    	out.println("<script language=javascript>window.alert('添加订单失败！');location.href='orders_add.jsp'</script>");  
    }
    stat.close();
    conn.close();   
%>