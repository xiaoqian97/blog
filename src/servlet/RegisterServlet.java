package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.User;
import dao.UserDAO;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		User user = new User();
		user.setAccount(request.getParameter("account"));
		user.setPassword(request.getParameter("password"));
		user.setNickname(request.getParameter("nickname"));
		user.setGender(request.getParameter("gender"));
		user.setBirthday(request.getParameter("birthday"));
		
		new UserDAO().add(user);
		
		request.getRequestDispatcher("register_success.jsp").forward(request, response);
	}

}
