<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="common.JDBConnect"%>
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
JDBConnect jdbc = new JDBConnect();

/* String id ="test1";
String pwd = "1111";
String name = "testMem1";// 길이 주의 */
String id=request.getParameter("id");
String pwd=request.getParameter("pwd");
String nn=request.getParameter("nickname");
if(id!=null&&pwd!=null&&nn!=null){
	String sql = "INSERT INTO member(id,pass,name)"
				+"SELECT ?,?,?"
				+"WHERE NOT EXISTS (SELECT id FROM member WHERE id=?)";
	PreparedStatement psmt=jdbc.getCon().prepareStatement(sql);
	psmt.setString(1,id);
	psmt.setString(2,pwd);
	psmt.setString(3,nn);
	psmt.setString(4,id);
	
	try{
	int inResult = psmt.executeUpdate();
		if(inResult==1) { 
		
			response.sendRedirect("InsertSuccess.jsp");
			request.getRequestDispatcher("InsertForm.jsp?idErr=null");
		}
		else {
			//response.sendRedirect("InsertFail.jsp");
			request.getRequestDispatcher("InsertForm.jsp?idErr="+id).forward(request,response);
		}
	}
	catch(Exception e) {
		String str = e.getMessage();
		//response.sendRedirect("InsertFail.jsp");
		request.getRequestDispatcher("InsertForm.jsp?idErr="+str).forward(request,response);
	}
/* 	try{
		psmt.executeUpdate();
		out.println("회원가입 완료되었습니다");
		response.sendRedirect("InsertSuccess.jsp");
		request.getRequestDispatcher("InsertForm.jsp?idErr=null");
	}
	catch(Exception e) {
		String str = e.getMessage();
		out.println(e.getMessage());
		//response.sendRedirect("InsertFail.jsp");
		request.getRequestDispatcher("InsertForm.jsp?idErr="+id).forward(request,response);
	} */
	try{
		psmt.close();
	}catch(Exception e){
		e.printStackTrace();
	}
}
jdbc.close();//jbdc instance의 con, psmt가 일치 하지 않아서 따로 닫아줘야함

%>

</body>
</html>