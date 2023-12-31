package servlet;

import java.io.IOException;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/12Servlet/TestPass.test")
public class TestPass extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		int lanscore = 0;
		int engscore = 0;
		int mathscore = 0;
		int avg = 0;
		String nativelan = req.getParameter("native");
		if(nativelan!=null) lanscore= Integer.parseInt(nativelan);
		String english = req.getParameter("english");
		if(english!=null) engscore= Integer.parseInt(english);
		String math = req.getParameter("math");
		if(math!=null) mathscore= Integer.parseInt(math);
		
		avg = (int) Math.floor((lanscore+engscore+mathscore)/3);
		
		if (avg>50) req.setAttribute("testMessage", "패스");
		else if (avg==50) req.setAttribute("testMessage", "패스");
		else req.setAttribute("testMessage", "과락");
		req.getRequestDispatcher("/12Servlet/TestPass.jsp").forward(req, resp);
	}
}
