package servlet;

import java.io.IOException;
import java.net.URLDecoder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/cookieServlet")
public class cookieServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String account = "";
		String password = "";
		Cookie[] cookies = request.getCookies();
		if(cookies != null && cookies.length > 0){
			for(Cookie c:cookies){
				if(c.getName().equals("account")){
					account = URLDecoder.decode(c.getValue(),"utf-8");
					request.setAttribute("account", account);
				}
				if(c.getName().equals("password")){
					password = URLDecoder.decode(c.getValue(),"utf-8");
					request.setAttribute("password", password);
				}
			}
		}
		
		request.getRequestDispatcher("login.jsp").forward(request, response);
	}

}
