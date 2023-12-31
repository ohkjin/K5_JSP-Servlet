<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSTL - forTokens</title>
</head>
<body>
	<%
	String rgba = "RED,GREEN,BLUE,BLACK";
	%>
	<h4>JSTL의 forTokens 태그 사용</h4>
	<!-- ,기준으로 잘라내서 loop를 돌리기 -->
	<!-- 문자열을 단위로 잘라냈을때 각 단위를 Token이라고 칭함 -->
	<c:forTokens items="<%=rgba %>" delims="," var="color">
		<span style="color: ${ color };"> ${ color } </span>
	</c:forTokens>
	<br/>
	
	<%
	String[] arr = rgba.split(",");
	%>
	<c:forEach items="<%=arr %>" var="ac">
		<span style="color: ${ ac };"> ${ ac } </span>
	</c:forEach>
	<br/>
	
	<%
	request.setAttribute("rgbaEL", arr);
	%>
	<!-- 표현식 없애기 -->
	<c:forEach items="${ rgbaEL }" var="ac">
		<span style="color: ${ ac };"> ${ ac } </span>
	</c:forEach>
	<br/>
</body>
</html>