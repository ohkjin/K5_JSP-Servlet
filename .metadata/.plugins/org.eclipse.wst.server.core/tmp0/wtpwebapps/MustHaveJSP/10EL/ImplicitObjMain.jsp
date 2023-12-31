<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
pageContext.setAttribute("scopeValue","Page 영역");
request.setAttribute("scopeValue","Request 영역");
session.setAttribute("scopeValue","Session 영역");
application.setAttribute("scopeValue","Application 영역");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>표현 언어(EL) - 내장 객체</title>
</head>
<body>
	<h2>ImplicitObjMain Page1</h2>
	<h3>각 영역에 저장된 속성 읽기</h3>
	<ul>
		<li>Page Scope : ${ pageScope.scopeValue }</li>
		<li>Request Scope : ${ requestScope.scopeValue }</li>
		<li>Session Scope : ${ sessionScope.scopeValue }</li>
		<li>Application Scope : ${ applicationScope.scopeValue }</li>
	</ul>
	
	<h3>영역에 지정없이 속성 읽기</h3>
	<ul>
		<!-- 영역 지정없이는 가장 좁은 Page 영역 -->
		<li>${ scopeValue }</li> 
	</ul>
	
	<jsp:forward page="ImplicitForwardResult.jsp" />
</body>
</html>