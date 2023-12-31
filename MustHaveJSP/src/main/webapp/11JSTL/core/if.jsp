<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSTL -if</title>
</head>
<body>
	<!-- 변수 선언 -->
	<c:set var="number" value ="100"/>
	<c:set var="string" value ="JSP"/>
	
	<h4>JSTL if tag for odd/even</h4>
	<c:if test="${ number mod 2 eq 0 }" var= "result">
		${ number }는 짝수입니다.<br/>
	</c:if>
	result : ${ result } <br/>
	
	<h4>JSTL String comparison and else</h4>
	<c:if test="${ string eq 'Java' }" var= "result2">
		문자열은 Java 입니다.<br/>
	</c:if>
	<c:if test="${ not result2 }">
		'Java'가 아닙니다. ${ string } 입니다.<br/>
	</c:if>
	
	<h4>조건식 주의사항</h4>
	<c:if test="100" var= "result3">
		EL이 아닌 정수를 지정하면 false <br/>
	</c:if>
	result3 : ${ result3 } <br/>
	<c:if test="${ 100 eq 100 }" var= "result3">
		EL안에서는 정수를 지정 조건문 사용 가능 100 eq 100 <br/>
	</c:if>
	result3 : ${ result3 } <br/>
	<c:if test="tRUE" var= "result4">
		대소문자 구분 없이 'tRUE'인 경우 true<br/>
	</c:if>
	result4 : ${ result4 } <br/>
	<c:if test=" ${ true } " var= "result5">
		EL 양쪽에 빈 공백이 있는 경우 false<br/>
	</c:if>
	result5 : ${ result5 } <br/>
	
</body>
</html>