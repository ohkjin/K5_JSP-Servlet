<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>표현 언어(EL) - 내장 객체</title>
</head>
<body>
	<h2>ImplicitFowardResult Page2</h2>
	<h3>각 영역에 저장된 속성 읽기</h3>
	<ul>
		<li>Page Scope : ${ pageScope.scopeValue }</li>
		<li>Request Scope : ${ requestScope.scopeValue }</li>
		<li>Session Scope : ${ sessionScope.scopeValue }</li>
		<li>Application Scope : ${ applicationScope.scopeValue }</li>
	</ul>
	
	<h3>영역에 지정없이 속성 읽기</h3>
	<ul>
		<li>${ scopeValue }</li>
	</ul>
	
</body>
</html>