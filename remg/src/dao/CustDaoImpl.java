package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.mysql.jdbc.CallableStatement;

import bean.customers;
import db.DB_Connect;
public class CustDaoImpl implements  CustDao {

	@Override
	public int add_customers(customers cust) throws Exception {
		// TODO Auto-generated method stub
		 String sql="call add_customers(?,?,?,?,?)";
		 Connection con = null;
		 CallableStatement cstm = null;
		 ResultSet rs = null;
		 int i=1;
		 try
		 {
			 con=DB_Connect.getDBcon();
			 cstm=(CallableStatement) con.prepareCall(sql);
			 cstm.setString(1, cust.get_cid());
			 cstm.setString(2, cust.get_cname());
			 cstm.setString(3, cust.get_sex());
			 cstm.setString(4, cust.get_telephone_no());
			 cstm.setString(5, cust.get_birthdate());  
			 cstm.executeQuery("set names utf8");
             cstm.executeUpdate();    	
		 }
		catch(Exception localException){
			i=0;
			System.out.print(localException.getMessage());
			}
	    finally{DB_Connect.closeDBcon(con, cstm, rs);}

		return i;		
	}

	@Override
	public int del_customers(String id) throws Exception {
		// TODO Auto-generated method stub
		 String sql="call del_customers(?)";
		 Connection con = null;
		 CallableStatement cstm = null;
		 ResultSet rs = null;
		 int i=1;
		 try
		 {
			 con=DB_Connect.getDBcon();
			 cstm=(CallableStatement) con.prepareCall(sql);
			 cstm.setString(1, id); 
			 cstm.executeQuery("set names utf8");
             cstm.executeUpdate();    	
		 }
		catch(Exception localException){
			i=0;
			System.out.print(localException.getMessage());
			}
	    finally{DB_Connect.closeDBcon(con, cstm, rs);}

		return i;
	}

	@Override
	public List<customers> que_customers(String info) throws Exception {
		// TODO Auto-generated method stub
		 //String sql="call que_customers(?)";
		 String sql ="select distinct * from customers where cid like binary '%"+info+"%' or cname like binary '%"+info+"%' or sex like binary '%"+info+"%' or level like binary '%"+info+"%' or integral like binary '%"+info+"%' or telephone_no like binary '%"+info+"%' or birthdate like binary '%"+info+"%'";
		 Connection con = null;
		 CallableStatement cstm = null;
		 ResultSet rs = null;
		 List<customers> list=new ArrayList();
		 try
		 {
			 con=DB_Connect.getDBcon();
			 cstm=(CallableStatement) con.prepareCall(sql);
			 //cstm.setString(1, info); 
			 cstm.executeQuery("set names utf8");
             rs=cstm.executeQuery();  
             while (rs.next())
             {
            	 customers c=new customers();
            	 c.set_cid(rs.getString("cid"));
                 c.set_cname(rs.getString("cname"));
                 c.set_sex(rs.getString("sex"));
                 c.set_integral(rs.getString("integral"));
                 c.set_level(rs.getString("level"));
                 c.set_telephone_no(rs.getString("telephone_no"));
                 c.set_birthdate(rs.getString("birthdate"));
                 list.add(c);
             }
		 }
		catch(Exception localException){
			System.out.print(localException.getMessage());
			}
	    finally{DB_Connect.closeDBcon(con, cstm, rs);}

		return list;
	}

	@Override
	public int upd_customers(customers cust) throws Exception {
		// TODO Auto-generated method stub
	     String sql="call upd_customers(?,?,?,?,?)";
		 Connection con = null;
		 CallableStatement cstm = null;
		 ResultSet rs = null;
		 int i=1;
		 try
		 {
			 con=DB_Connect.getDBcon();
			 cstm=(CallableStatement) con.prepareCall(sql);
			 cstm.setString(1, cust.get_cid());
			 cstm.setString(2, cust.get_cname());
			 cstm.setString(3, cust.get_sex());
			 cstm.setString(4, cust.get_telephone_no());
			 cstm.setString(5, cust.get_birthdate());  
			 cstm.executeQuery("set names utf8");
             cstm.executeUpdate();    	
		 }
		catch(Exception localException){
			i=0;
			System.out.print(localException.getMessage());
			}
	    finally{DB_Connect.closeDBcon(con, cstm, rs);}

		return i;		
	}

	@Override
	public List<customers> main_customers() throws Exception {
		// TODO Auto-generated method stub
		 String sql ="select distinct * from customers";
		 Connection con = null;
		 CallableStatement cstm = null;
		 ResultSet rs = null;
		 List<customers> list=new ArrayList();
		 try
		 {
			 con=DB_Connect.getDBcon();
			 cstm=(CallableStatement) con.prepareCall(sql); 
			 cstm.executeQuery("set names utf8");
             rs=cstm.executeQuery();  
             while (rs.next())
             {
            	 customers c=new customers();
            	 c.set_cid(rs.getString("cid"));
                 c.set_cname(rs.getString("cname"));
                 c.set_sex(rs.getString("sex"));
                 c.set_integral(rs.getString("integral"));
                 c.set_level(rs.getString("level"));
                 c.set_telephone_no(rs.getString("telephone_no"));
                 c.set_birthdate(rs.getString("birthdate"));
                 list.add(c);
             }
		 }
		catch(Exception localException){
			System.out.print(localException.getMessage());
			}
	    finally{DB_Connect.closeDBcon(con, cstm, rs);}

		return list;
	}

}
	
