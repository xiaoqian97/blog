package servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.Song;
import bean.User;
import dao.SongDAO;

@WebServlet("/SongListServlet")
public class SongListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		
			int start = 0;
			int count = 8;

			try{
				start = Integer.parseInt(request.getParameter("start"));
			}catch(Exception e){}

			int total = new SongDAO().getTotal((User)request.getSession().getAttribute("user"));
			
			int pre = start - count;
			int next = start + count;

			int last;
			if(total % count == 0 )
				last = total - count;
			else
				last = total - total % count;

			pre = pre < 0 ? 0 : pre;
			next = next > last ? last : next;

			List<Song> songs = new SongDAO().list(start, count, (User)request.getSession().getAttribute("user"));

			request.setAttribute("songs", songs);
			request.setAttribute("pre", pre);
			request.setAttribute("next", next);
			request.setAttribute("last", last);

			request.getRequestDispatcher("listSong.jsp").forward(request, response);
	}

}
