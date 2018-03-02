package servlets;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.meals;
import dao.MealDaoImpl;

/**
 * Servlet implementation class meal_add
 */
@WebServlet("/meal_add")
public class meal_add extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public meal_add() {
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
		String mid=request.getParameter("mid");
	    String mname=request.getParameter("mname");
	    String mprice=request.getParameter("mprice");
	    String meal_integral=request.getParameter("meal_integral");
	    String qoh=request.getParameter("qoh");
	    String qoh_threshold=request.getParameter("qoh_threshold");
	    
		//System.out.print(birthdate);
		//实例化顾客并调用bean里的方法赋值对象
		meals m=new meals();
		m.set_mid(mid);
		m.set_mname(mname);
		m.set_mprice(mprice);
		m.set_meal_integral(meal_integral);
		m.set_qoh(qoh);
		m.set_qoh_threshold(qoh_threshold);
		//创建DAO对象，接下调用DAO中的方法实现对数据库的访问
		MealDaoImpl dao=new MealDaoImpl();
		//创建跳转对象
	    RequestDispatcher rd = null;

	    try
	    {
	    	request.setAttribute("i", dao.add_meals(m));
    	    rd=request.getRequestDispatcher("meals_save.jsp");
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
