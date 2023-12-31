<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cookie</title>
</head>
<body>
	<h2>1. 쿠키(Cookie) 설정</h2>
	<%
	Cookie cookie = new Cookie("myCookie","쿠기맛나요"); //쿠키생성
	cookie.setPath(request.getContextPath()); //경로를 컨텍스트 루트로 설정
	cookie.setMaxAge(3600); //유지기간 1시간으로 설정
	response.addCookie(cookie); //응답 레더에 쿠키 추가
	%>
	
	<h2>2. 쿠키 설정 직후 쿠키값 확인하기</h2>
	<%
	Cookie[] cookies = request.getCookies(); //요청 헤더의 모든 쿠키
	if(cookies!=null){
		for(Cookie c:cookies){
			String cookieName = c.getName();
			String cookieValue = c.getValue();
			out.println(String.format("%s:%swhat?<br/>",cookieName,cookieValue));
		}
	}
	%>
	
	<h2>3. 페이지 이동 후 쿠키값 확인하기</h2>
	<a href = "CookieResult.jsp">
		다음 페이지 쿠키 확인
	</a>
</body>
</html>