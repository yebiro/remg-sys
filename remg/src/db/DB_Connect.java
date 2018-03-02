package db;
import java.sql.*;

public class DB_Connect 
{
	private static String driverName = "com.mysql.jdbc.Driver";
	private static String userName = "root";
	private static String userPwd = "";
	private static String dbName = "remg";
	
	//连接数据库
	public static Connection getDBcon()
	{
		String url1="jdbc:mysql://localhost:3306/"+dbName;
		String url2 = "?user=" + userName + "&password=" + userPwd;
	    String url3 = "&useUnicode=true&characterEncoding=UTF-8&useSSL=false";
	    String url = url1 + url2 + url3;
	    try
	    {
	    	Class.forName(driverName);
	    	return DriverManager.getConnection(url);
	    }
	    catch(Exception e)
	    {
	    	e.printStackTrace();
	    }
	    return null;
	}
	
	//关闭数据库
	public static void closeDBcon(Connection con, PreparedStatement pstm, ResultSet rs)
	{
		try
		{
			if(rs!=null)
				rs.close();
			if(pstm!=null)
				pstm.close();
			if(con!=null)
				con.close();
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
	}
}
