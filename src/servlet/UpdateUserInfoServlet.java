package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.User;
import dao.UserDAO;

@WebServlet("/UpdateUserInfoServlet")
public class UpdateUserInfoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		User user = new User();
		user.setAccount(request.getParameter("account"));
		user.setPassword(request.getParameter("password"));
		user.setState("0");
		user.setNickname(request.getParameter("nickname"));
		user.setGender(request.getParameter("gender"));
		user.setBirthday(request.getParameter("birthday"));
		
		new UserDAO().update(user);
		
		request.getSession().setAttribute("user", user);    //覆盖之前的session
		response.sendRedirect("SongListServlet");
	}

}
