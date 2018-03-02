package servlets;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.customers;
import dao.CustDaoImpl;

/**
 * Servlet implementation class cust_edit
 */
@WebServlet("/cust_edit")
public class cust_edit extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public cust_edit() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html,charset=utf-8");
		String cid=request.getParameter("cid");
	    String cname=request.getParameter("cname");
	    String sex=request.getParameter("sex");
	    String telephone_no=request.getParameter("telephone_no");
	    String birthdate=request.getParameter("birthdate");
	
		//System.out.print(birthdate);
		//实例化顾客并调用bean里的方法赋值对象
		customers c=new customers();
		c.set_cid(cid);
		c.set_cname(cname);
		c.set_sex(sex);
		c.set_telephone_no(telephone_no);
		c.set_birthdate(birthdate);
		//创建DAO对象，接下调用DAO中的方法实现对数据库的访问
		CustDaoImpl dao=new CustDaoImpl();
		//创建跳转对象
	    RequestDispatcher rd = null;

	    try
	    {
	    	request.setAttribute("i", dao.upd_customers(c));
    	    rd=request.getRequestDispatcher("customers_save_edit.jsp");
    	    rd.forward(request, response);
	    }
	    catch(Exception localExcption){}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
