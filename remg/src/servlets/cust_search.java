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
 * Servlet implementation class cust_search
 */
@WebServlet("/cust_search")
public class cust_search extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public cust_search() {
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
		String customers_search=request.getParameter("customers_search");
	 
		//System.out.print(customers_search);
		//创建DAO对象，接下调用DAO中的方法实现对数据库的访问
		CustDaoImpl dao=new CustDaoImpl();
		//创建跳转对象
	    RequestDispatcher rd = null;
	    try
	    {
	    	request.setAttribute("list", dao.que_customers(customers_search));
    	    rd=request.getRequestDispatcher("customers_search.jsp");
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
