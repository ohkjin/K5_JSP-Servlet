<%@page import="membership.MemberDTO"%>
<%@page import="boardManagement.BoardDTO"%>
<%@page import="boardManagement.BoardDAO"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
</head>
<body>
<%
//Login check
MemberDTO m = (MemberDTO)session.getAttribute("member");
if (m==null){
		// LOGOUT MODE 
		response.sendRedirect("./BoardLoginSession/LoginForm.jsp");
 	/* response.sendRedirect("../../06Session/LoginForm.jsp");  */

%>	
<% 
} else{ // LOGIN MODE 
%>	
	<a href="./BoardLoginSession/Logout.jsp">[Logout]</a>
	<%
	String title=request.getParameter("title");
	String content=request.getParameter("content");
	String id=m.getId();
	
	//JDBConnect
	String driver = application.getInitParameter("MySQLDriver");
	String url = application.getInitParameter("MySQLURL");
	String sql_id =application.getInitParameter("MySQLId");
	String sql_pwd =application.getInitParameter("MySQLPwd");
	BoardDAO dao = new BoardDAO(driver,url,sql_id,sql_pwd);
	try{
		if(id!=null&&title!=null&&content!=null){
			int inResult = dao.insertBoardDTO(title, content,id);
			//Success
				if(inResult==1) { 
					response.sendRedirect("InsertBoardSuccess.jsp");
					request.getRequestDispatcher("InsertBoardForm.jsp?boardErr=null");
				}
			//Failed
				else {
					//response.sendRedirect("InsertFail.jsp");
					request.getRequestDispatcher("InsertBoardForm.jsp?boardErr=1").forward(request,response);
				}
		}
	}catch(Exception e){
		e.getStackTrace();
	}
	finally{dao.close();}
	%>
<% 
	}
%>
</body>
</html>