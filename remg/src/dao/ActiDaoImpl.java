package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.mysql.jdbc.CallableStatement;

import bean.activities;
import db.DB_Connect;
public class ActiDaoImpl implements ActiDao {

	@Override
	public int add_activities(activities acti) throws Exception {
		// TODO Auto-generated method stub
		 String sql="call add_activities(?,?,?,?)";
		 Connection con = null;
		 CallableStatement cstm = null;
		 ResultSet rs = null;
		 int i=1;
		 try
		 {
			 con=DB_Connect.getDBcon();
			 cstm=(CallableStatement) con.prepareCall(sql);
			 cstm.setString(1, acti.get_aid());
			 cstm.setString(2, acti.get_aname());
			 cstm.setString(3, acti.get_begin_time());
			 cstm.setString(4, acti.get_end_time());
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
	public int del_activities(String id) throws Exception {
		// TODO Auto-generated method stub
		 String sql="call del_activities(?)";
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
	public int upd_activities(activities acti) throws Exception {
		// TODO Auto-generated method stub
		String sql="call upd_activities(?,?,?,?)";
		 Connection con = null;
		 CallableStatement cstm = null;
		 ResultSet rs = null;
		 int i=1;
		 try
		 {
			 con=DB_Connect.getDBcon();
			 cstm=(CallableStatement) con.prepareCall(sql);
			 cstm.setString(1, acti.get_aid());
			 cstm.setString(2, acti.get_aname());
			 cstm.setString(3, acti.get_begin_time());
			 cstm.setString(4, acti.get_end_time());
			 
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
	public List<activities> que_activities(String info) throws Exception {
		// TODO Auto-generated method stub
		 String sql ="select distinct * from activities where aid like '%"+info+"%' or aname like '%"+info+"%'";
		 Connection con = null;
		 CallableStatement cstm = null;
		 ResultSet rs = null;
		 List<activities> list=new ArrayList();
		 try
		 {
			con=DB_Connect.getDBcon();
			cstm=(CallableStatement) con.prepareCall(sql); 
			cstm.executeQuery("set names utf8");
            rs=cstm.executeQuery();  
            while (rs.next())
            {
           	    activities a=new activities();
           	    a.set_aid(rs.getString("aid"));
                a.set_aname(rs.getString("aname"));
                a.set_begin_time(rs.getString("begin_time"));
                a.set_end_time(rs.getString("end_time"));
                list.add(a);
            }
		 }
		catch(Exception localException){
			System.out.print(localException.getMessage());
			}
	    finally{DB_Connect.closeDBcon(con, cstm, rs);}

		return list;
	}

	@Override
	public List<activities> main_activities() throws Exception {
		// TODO Auto-generated method stub
		String sql ="select distinct * from activities";
		 Connection con = null;
		 CallableStatement cstm = null;
		 ResultSet rs = null;
		 List<activities> list=new ArrayList();
		 try
		 {
			con=DB_Connect.getDBcon();
			cstm=(CallableStatement) con.prepareCall(sql); 
			cstm.executeQuery("set names utf8");
           rs=cstm.executeQuery();  
           while (rs.next())
           {
          	    activities a=new activities();
          	    a.set_aid(rs.getString("aid"));
                a.set_aname(rs.getString("aname"));
                a.set_begin_time(rs.getString("begin_time"));
                a.set_end_time(rs.getString("end_time"));
                list.add(a);
           }
		 }
		catch(Exception localException){
			System.out.print(localException.getMessage());
			}
	    finally{DB_Connect.closeDBcon(con, cstm, rs);}

		return list;
	}

}
