package servlet;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
//ctrl shift o

public class HelloServlet extends HttpServlet{
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doGet(HttpServletRequest req,HttpServletResponse resp) throws ServletException, IOException{
		req.setAttribute("message", "Hello Servlet..!!"); // setAttribute를 했으니 EL로 사용 가능
		/*
		 * req.getRequestDispatcher("/12Servlet/HelloServlet.jsp").forward(req, resp);//=>jsp에서 실행
		 * //req,session,resp... 다 공유
		 */		
		req.getRequestDispatcher("/WEB-INF/views/HelloServlet.jsp").forward(req, resp);//java에서 실행
	}
	
}
