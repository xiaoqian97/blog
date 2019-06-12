package servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.SongDAO;

@WebServlet("/FindSongServlet")
public class FindSongServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	List<String> datas = new SongDAO().songnameList();
	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		String songname = request.getParameter("keyword");
		int index = datas.indexOf(songname) + 1;
		int start = (((index - 1)/ 8 + 1) - 1) * 8;
		
		response.sendRedirect("AllSongListServlet?start=" + start);
	}

}
