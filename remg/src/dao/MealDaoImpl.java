package dao;

import bean.meals;
import bean.meals;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.mysql.jdbc.CallableStatement;
import db.DB_Connect;

public class MealDaoImpl implements MealDao{

	@Override
	public int add_meals(meals meal) throws Exception {
		// TODO Auto-generated method stub
		 String sql="call add_meals(?,?,?,?,?,?)";
		 Connection con = null;
		 CallableStatement cstm = null;
		 ResultSet rs = null;
		 int i=1;
		 try
		 {
			 con=DB_Connect.getDBcon();
			 cstm=(CallableStatement) con.prepareCall(sql);
			 cstm.setString(1, meal.get_mid());
			 cstm.setString(2, meal.get_mname());
			 cstm.setString(3, meal.get_mprice());
			 cstm.setString(4, meal.get_meal_integral());
			 cstm.setString(5, meal.get_qoh());  
			 cstm.setString(6, meal.get_qoh_threshold());  
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
	public int del_meals(String id) throws Exception {
		// TODO Auto-generated method stub
		 String sql="call del_meals(?)";
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
	public int upd_meals(meals meal) throws Exception {
		// TODO Auto-generated method stub
		 String sql="call upd_meals(?,?,?,?,?,?)";
		 Connection con = null;
		 CallableStatement cstm = null;
		 ResultSet rs = null;
		 int i=1;
		 try
		 {
			 con=DB_Connect.getDBcon();
			 cstm=(CallableStatement) con.prepareCall(sql);
			 cstm.setString(1, meal.get_mid());
			 cstm.setString(2, meal.get_mname());
			 cstm.setString(3, meal.get_mprice());
			 cstm.setString(4, meal.get_meal_integral());
			 cstm.setString(5, meal.get_qoh());  
			 cstm.setString(6, meal.get_qoh_threshold()); 
			 
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
	public List<meals> que_meals(String info) throws Exception {
		// TODO Auto-generated method stub
		String sql ="select distinct * from meals where mid like '%"+info+"%' or mname like '%"+info+"%'";
		 Connection con = null;
		 CallableStatement cstm = null;
		 ResultSet rs = null;
		 List<meals> list=new ArrayList();
		 try
		 {
			con=DB_Connect.getDBcon();
			cstm=(CallableStatement) con.prepareCall(sql); 
			cstm.executeQuery("set names utf8");
            rs=cstm.executeQuery();  
            while (rs.next())
            {
          	    meals m=new meals();
          	    m.set_mid(rs.getString("mid"));
                m.set_mname(rs.getString("mname"));
                m.set_mprice(rs.getString("mprice"));
                m.set_meal_integral(rs.getString("meal_integral"));
                m.set_qoh(rs.getString("qoh"));
                m.set_qoh_threshold(rs.getString("qoh_threshold"));
                list.add(m);
           }
		 }
		catch(Exception localException){
			System.out.print(localException.getMessage());
			}
	    finally{DB_Connect.closeDBcon(con, cstm, rs);}

		return list;
	}

	@Override
	public List<meals> main_meals() throws Exception {
		// TODO Auto-generated method stub
		String sql ="select distinct * from meals";
		 Connection con = null;
		 CallableStatement cstm = null;
		 ResultSet rs = null;
		 List<meals> list=new ArrayList();
		 try
		 {
			con=DB_Connect.getDBcon();
			cstm=(CallableStatement) con.prepareCall(sql); 
			cstm.executeQuery("set names utf8");
            rs=cstm.executeQuery();  
            while (rs.next())
            {
         	    meals m=new meals();
         	    m.set_mid(rs.getString("mid"));
                m.set_mname(rs.getString("mname"));
                m.set_mprice(rs.getString("mprice"));
                m.set_meal_integral(rs.getString("meal_integral"));
                m.set_qoh(rs.getString("qoh"));
                m.set_qoh_threshold(rs.getString("qoh_threshold"));
                list.add(m);
           }
		 }
		catch(Exception localException){
			System.out.print(localException.getMessage());
			}
	    finally{DB_Connect.closeDBcon(con, cstm, rs);}

		return list;
	}

}
