package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.User;

@WebServlet("/SelectShowPageServlet")
public class SelectShowPageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		User user = (User)request.getSession().getAttribute("user");
		if(user != null){
			if(user.getState().equals("1")){
				response.sendRedirect("UserListServlet");
			}
			else{
				response.sendRedirect("SongListServlet");
			}
		}
		else{
			response.sendRedirect("cookieServlet");
		}
	}

}
