package servlets;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.activities;
import dao.ActiDaoImpl;


/**
 * Servlet implementation class acti_edit
 */
@WebServlet("/acti_edit")
public class acti_edi extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public acti_edi() {
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
		String aid=request.getParameter("aid");
	    String aname=request.getParameter("aname");
	    String begin_time=request.getParameter("begin_time");
	    String end_time=request.getParameter("end_time");
	
		//System.out.print(birthdate);
		//实例化顾客并调用bean里的方法赋值对象
		activities a=new activities();
		a.set_aid(aid);
		a.set_aname(aname);
		a.set_begin_time(begin_time);
		a.set_end_time(end_time);
		//创建DAO对象，接下调用DAO中的方法实现对数据库的访问
		ActiDaoImpl dao=new ActiDaoImpl();
		//创建跳转对象
	    RequestDispatcher rd = null;

	    try
	    {
	    	request.setAttribute("i", dao.upd_activities(a));
    	    rd=request.getRequestDispatcher("activities_save_edit.jsp");
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
