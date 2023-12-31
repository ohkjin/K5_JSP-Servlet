<%@ page import="common.JDBConnect"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JDBC</title>
</head>
<body>
	<h2>JDBC Test 1</h2>
	Simple Test - not used b/c server can be changed
	<%
	JDBConnect j1 = new JDBConnect();
	j1.close();
	%>
	
	<h2>JDBC Test 2</h2>
	web.xml에 외부에서 입력해두고 내장객체 application을 통해 얻어오기<br/>
	외부에서 하드코딩
	<%
	String driver = application.getInitParameter("MySQLDriver");
	String url = application.getInitParameter("MySQLURL");
	String id =application.getInitParameter("MySQLId");
	String pwd =application.getInitParameter("MySQLPwd");
	
	JDBConnect j2 = new JDBConnect(driver,url,id,pwd);
	j2.close();
	%>
	
	<h2>JDBC Test 3</h2>
	반복 금지를 위해
	컨텍스트 초기화 매개 변수를 생성자에서 직접 가져오기
	<%
	JDBConnect j3 = new JDBConnect(application);
	j3.close();
	%>
</body>
</html>