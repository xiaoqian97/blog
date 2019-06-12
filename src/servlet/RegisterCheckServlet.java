package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.User;
import dao.UserDAO;

@WebServlet("/RegisterCheckServlet")
public class RegisterCheckServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/text;charset=utf-8");
		
		PrintWriter out = response.getWriter();
		String account = request.getParameter("account");
		List<User> users = new UserDAO().list();
		for(User user:users) {
			if(user.getAccount().equals(account)){
				out.print("<font>该账号已经存在</font>");
			}
			else
				out.print("<font>&nbsp;</font>");
		}
	}

}
