<%@page import="el.MyELClass"%>
<%@page import="common.Person"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
MyELClass myClass = new MyELClass();
pageContext.setAttribute("myClass", myClass);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>표현 언어(EL) - 메서드 호출</title>
</head>
<body>
	<h3>영역 저장 후 메서드 호출</h3>
	001225-3000000 => ${ myClass.getGender("001225-3000000") }<br/>
	001225-2000000 => ${ myClass.getGender("001225-2000000") }<br/>
	
	<h3>클래스명을 통해 메서드 호출</h3>
	${ MyELClass.showGugudan(5) }
</body>
</html>