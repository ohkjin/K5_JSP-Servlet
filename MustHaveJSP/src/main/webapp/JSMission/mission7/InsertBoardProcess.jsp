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
if (session.getAttribute("UserId")==null){ //session:내장객체 
	response.sendRedirect("./BoardLoginSession/LoginForm.jsp");
 	/* response.sendRedirect("../../06Session/LoginForm.jsp");  */

%>	<!-- LOGOUT MODE -->

<% 
} else{ 
%>	<!-- LOGIN MODE -->
<%-- 	<%MemberDTO m = (MemmberDTO)session.getAttribute("member"); %>
	<%=m.getName() %> --%>
<%=session.getAttribute("UserName")%> Uploading...<br/>
<a href="./BoardLoginSession/Logout.jsp">[Logout]</a>
	
<%
String title=request.getParameter("title");
String content=request.getParameter("content");
String id=request.getParameter("id");

String driver = application.getInitParameter("MySQLDriver");
String url = application.getInitParameter("MySQLURL");
String sql_id =application.getInitParameter("MySQLId");
String sql_pwd =application.getInitParameter("MySQLPwd");

BoardDAO dao = new BoardDAO(driver,url,sql_id,sql_pwd);


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

%>
<% 
	}
%>
</body>
</html>