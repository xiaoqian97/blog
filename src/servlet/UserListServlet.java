package servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.User;
import dao.UserDAO;

@WebServlet("/UserListServlet")
public class UserListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		int start = 0;
		int count = 10;
		
		try{
			start = Integer.parseInt(request.getParameter("start"));
		}catch(Exception e){}
		
		int total = new UserDAO().getTotal() - 1;      //除去管理员的一条记录
		
		int pre = start - count;
		int next = start + count;
		
		int last;
		if(total % count == 0 )
			last = total - count;
		else
			last = total - total % count;
		
		pre = pre < 0 ? 0 : pre;
		next = next > last ? last : next;
		
		List<User> users = new UserDAO().list(start, count);
		
		request.setAttribute("users", users);
		request.setAttribute("pre", pre);
		request.setAttribute("next", next);
		request.setAttribute("last", last);
		
		request.getRequestDispatcher("listUser.jsp").forward(request, response);
	}

}
