package servlet;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/12Servlet/AnnoMapping.do")//.do는 사용자 정의로 정할수 있다: url패턴에 권한 등 규칙을 부여할 수 있다
public class AnnoMapping extends HttpServlet{

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setAttribute("message", "@WebServlet으로 매핑..!!"); // setAttribute를 했으니 EL로 사용 가능
		req.getRequestDispatcher("/12Servlet/AnnoMapping.jsp").forward(req, resp);
		
		 
	}
}
