<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%-- <%@page import="java.sql.Connection"%> --%>
<%@page import="common.JDBConnect"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JDBC</title>
</head>
<body>
	<h2>회원 목록 조회 테스트 using (executeQuery())</h2>
	<%
	JDBConnect jdbc = new JDBConnect();
	
	String sql = "SELECT id,pass,name,regidate FROM member;";
	Statement st=jdbc.getCon().createStatement();

	ResultSet rs = st.executeQuery(sql);

	while(rs.next()){
		String id = rs.getString(1);
		String pwd = rs.getString(2);
		String name = rs.getString("name");
		java.sql.Date regidate= rs.getDate("regidate");
		
		out.println(String.format("%s %s %s %s",id,pwd,name,regidate)+"<br/>");
	}

	try{
		st.close();
		rs.close();
	}catch(Exception e){
		e.printStackTrace();
	}
	jdbc.close();//jbdc instance의 con, psmt가 일치 하지 않아서 따로 닫아줘야함
	%>
</body>
</html>