package servlet; 

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.SongDAO;
import net.sf.json.JSONArray; 

@WebServlet("/SearchServlet") 
public class SearchServlet extends HttpServlet { 
	private static final long serialVersionUID = 1L; 
	
	List<String> datas = new SongDAO().songnameList();
	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException { 
		request.setCharacterEncoding("UTF-8"); 
		response.setCharacterEncoding("UTF-8"); 
		String keyword=request.getParameter("keyword"); 
		List<String> listdata= getData(keyword); 
		// 返回json,以流的形式写到前台 
		response.getWriter().write(JSONArray.fromObject(listdata).toString()); 
	} 
	//获取假数据中符合条件的值 
	public List<String> getData(String keyword) 
	{ 
		List<String> list=new ArrayList<String>(); 
		for(String data:datas) 
		{ 
			if(data.contains(keyword)){ 
				list.add(data); 
			} 
		} 
		return list; 
	} 
}