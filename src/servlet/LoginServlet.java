package servlet;

import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.User;
import dao.UserDAO;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		String account = request.getParameter("account");
		String password = request.getParameter("password");
		
		User user = new UserDAO().getUser(account, password);
		if(user != null) {
			if(user.getState().equals("1")){                      //管理员
				
				String[] isUseCookies = request.getParameterValues("isUseCookie");
				if(isUseCookies != null && isUseCookies.length > 0) {
					account = URLEncoder.encode(account,"utf-8");     //解决无法保存中文cookie问题
					password = URLEncoder.encode(password,"utf-8");
					Cookie accountCookie =new Cookie("account", account);
					Cookie passwordCookie =new Cookie("password", password);
					accountCookie.setMaxAge(3600);              //1小时内记住密码
					passwordCookie.setMaxAge(3600);
					response.addCookie(accountCookie);
					response.addCookie(passwordCookie);
				}
				else {
					Cookie[] cookies = request.getCookies();
					if(cookies != null && cookies.length > 0){
						for(Cookie c:cookies){
							if(c.getName().equals("account") || c.getName().equals("password")){
								c.setMaxAge(0);
								response.addCookie(c);
							}
						}
					}
				}
				request.getSession().setAttribute("user", user);
				response.sendRedirect("UserListServlet");
			}
			else{                                                 //普通用户
				
				String[] isUseCookies = request.getParameterValues("isUseCookie");
				if(isUseCookies != null && isUseCookies.length > 0) {
					account = URLEncoder.encode(account,"utf-8");
					password = URLEncoder.encode(password,"utf-8");
					Cookie accountCookie =new Cookie("account", account);
					Cookie passwordCookie =new Cookie("password", password);
					accountCookie.setMaxAge(604800);             //7天内记住密码
					passwordCookie.setMaxAge(604800);
					response.addCookie(accountCookie);
					response.addCookie(passwordCookie);
				}
				else {
					Cookie[] cookies = request.getCookies();
					if(cookies != null && cookies.length > 0){
						for(Cookie c:cookies){
							if(c.getName().equals("account") || c.getName().equals("password")){
								c.setMaxAge(0);
								response.addCookie(c);
							}
						}
					}
				}
				request.getSession().setAttribute("user", user);
				response.sendRedirect("SongListServlet");
			}
		}
		else{
			request.setAttribute("error", "账号或密码错误");
			request.getRequestDispatcher("login.jsp").forward(request, response);
		}
	}
}
