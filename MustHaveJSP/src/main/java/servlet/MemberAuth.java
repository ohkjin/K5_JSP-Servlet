package servlet;

import java.io.IOException;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import membership.MemberDAO;
import membership.MemberDTO;

public class MemberAuth extends HttpServlet {
	private static final long serialVersionUID = 1L;
	MemberDAO dao;
	
	@Override
	public void init() throws ServletException {
		//application 내장객체 및 DAO 생성
		ServletContext application = this.getServletContext();
		dao = new MemberDAO(application);
	}
	
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//서블릿 초기화 매개변수에서 관리자id 받기
		String admin_id = this.getInitParameter("admin_id");
		//인증을 요청한 id/pass에 해당하는 회원 dto
		String id = req.getParameter("id");
		String pass = req.getParameter("pass");
		MemberDTO dto = dao.getMemberDTO(id, pass);
		
		if (dto!= null) req.setAttribute("authMessage", dto.getName() + "회원님 반갑습니다.");
		else {
			if(admin_id.equals(id)) req.setAttribute("authMessage", admin_id + "는 최고 관리자입니다.");
			else req.setAttribute("authMessage", "귀하는 회원이 아닙니다.");
		}
		req.getRequestDispatcher("/12Servlet/MemberAuth.jsp").forward(req, resp);
	}
	
	@Override
	public void destroy() {
		dao.close();
	}

}
