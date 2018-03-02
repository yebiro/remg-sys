package dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.mysql.jdbc.CallableStatement;

import bean.orders;
import bean.orders;
import db.DB_Connect;

public class OrderDaoImpl implements OrderDao{

	@Override
	public int add_orders(orders acti) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int del_orders(String id) throws Exception {
		// TODO Auto-generated method stub
		 String sql="call del_orders(?)";
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
	public List<orders> que_orders(String info) throws Exception {
		// TODO Auto-generated method stub
		 String sql ="select distinct o.oid,c.cid,c.level,e.eid,m.mname,o.qty,otime,a_discount,final_price,s.staname from orders o, customers c,employees e,meals m,states s where (o.cid=c.cid and o.eid =e.eid and o.mid= m.mid and o.staid=s.staid) and (o.oid like '%"+info+"%' or c.cid like '%"+info+"%' or c.level like '%"+info+"%'or e.eid like '%"+info+"%' or m.mname like '%"+info+"%' or o.qty like '%"+info+"%' or o.otime like '%"+info+"%' or o.a_discount like '%"+info+"%' or o.final_price like '%"+info+"%' or s.staname like '%"+info+"%')";
		 Connection con = null;
		 CallableStatement cstm = null;
		 ResultSet rs = null;
		 List<orders> list=new ArrayList();
		 try
		 {
			con=DB_Connect.getDBcon();
			cstm=(CallableStatement) con.prepareCall(sql); 
			cstm.executeQuery("set names utf8");
            rs=cstm.executeQuery();  
            while (rs.next())
            {
          	    orders o=new orders();
          	    o.set_oid(rs.getString("oid"));
                o.set_cid(rs.getString("cid"));
                o.set_level(rs.getString("level"));
                o.set_eid(rs.getString("eid"));
                o.set_mname(rs.getString("mname"));
                o.set_qty(rs.getString("qty"));
                o.set_otime(rs.getString("otime"));
                o.set_a_discount(rs.getString("a_discount"));
                o.set_final_price(rs.getString("final_price"));
                o.set_staname(rs.getString("staname"));
                list.add(o);
            }
		 }
		catch(Exception localException){
			System.out.print(localException.getMessage());
			}
	    finally{DB_Connect.closeDBcon(con, cstm, rs);}

		return list;
	}

	@Override
	public List<orders> main_orders() throws Exception {
		// TODO Auto-generated method stub
		 String sql ="select o.oid,c.cid,c.level,e.eid,m.mname,o.qty,otime,a_discount,final_price,s.staname from orders o, customers c,employees e,meals m,states s where o.cid=c.cid and o.eid =e.eid and o.mid= m.mid and o.staid=s.staid order by otime desc;";
		 Connection con = null;
		 CallableStatement cstm = null;
		 ResultSet rs = null;
		 List<orders> list=new ArrayList();
		 try
		 {
			con=DB_Connect.getDBcon();
			cstm=(CallableStatement) con.prepareCall(sql); 
			cstm.executeQuery("set names utf8");
            rs=cstm.executeQuery();  
           while (rs.next())
           {
         	   orders o=new orders();
         	   o.set_oid(rs.getString("oid"));
               o.set_cid(rs.getString("cid"));
               o.set_level(rs.getString("level"));
               o.set_eid(rs.getString("eid"));
               o.set_mname(rs.getString("mname"));
               o.set_qty(rs.getString("qty"));
               o.set_otime(rs.getString("otime"));
               o.set_a_discount(rs.getString("a_discount"));
               o.set_final_price(rs.getString("final_price"));
               o.set_staname(rs.getString("staname"));
               list.add(o);
           }
		 }
		catch(Exception localException){
			System.out.print(localException.getMessage());
			}
	    finally{DB_Connect.closeDBcon(con, cstm, rs);}

		return list;
	}

}
