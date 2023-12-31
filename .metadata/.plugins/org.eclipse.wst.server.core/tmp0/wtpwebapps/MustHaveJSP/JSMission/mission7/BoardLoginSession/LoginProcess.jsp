<%@page import="membership.MemberDTO"%>
<%@page import="membership.MemberDAO"%>
<%@ page import="utils.CookieManager"%>
<%@ page import="utils.JSFunction"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!--doPost  -->
<%
String user_id = request.getParameter("user_id");//전송되는 값 하나
String user_pw = request.getParameter("user_pw");//전송되는 값 하나

String driver = application.getInitParameter("MySQLDriver");
String url = application.getInitParameter("MySQLURL");
String id =application.getInitParameter("MySQLId");
String pwd =application.getInitParameter("MySQLPwd");
MemberDAO dao = new MemberDAO(driver,url,id,pwd);

MemberDTO memberDTO = dao.getMemberDTO(user_id, user_pw);
try{
	if(memberDTO.getId()!=null){
		//Session에 로그인 정보 저장//
		session.setAttribute("member",memberDTO);
		response.sendRedirect("../InsertBoardForm.jsp");
	}else{
		request.setAttribute("LoginErrMsg","Login Error"+user_id+" "+user_pw);
		request.getRequestDispatcher("LoginForm.jsp").forward(request,response);
	}
}catch(Exception e){
	e.getStackTrace();
}
finally{dao.close();}

%>