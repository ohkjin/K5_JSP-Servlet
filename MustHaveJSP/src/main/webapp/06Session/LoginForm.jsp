<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Session</title>
</head>
<body>
	<jsp:include page="../Common/Link.jsp"/>
	<h2>로그인 페이지</h2>
	<span style="color: red; font-size:1.2em;">
		<%= request.getAttribute("LoginErrMsg")==null?
				"" : request.getAttribute("LoginErrMsg")%>
	</span>
	<%
	//Login check
	if (session.getAttribute("UserId")==null){ //session:내장객체 
/* 	if (session.getAttribute("member")==null){ */
	
	%>	<!-- LOGOUT MODE -->
		<script>
		function validateForm(form){
			if(!form.user_id.value){
				alert("id please");
				return false;
			}
			if(form.user_pw.value==""){
				alert("password please");
				return false;
			}
		}
		</script>
		<form action="LoginProcess.jsp"method="post" name ="loginFrm"
				onsubmit="return validateForm(this);"> <!-- to check error for submit -->
			ID: <input type="text" name="user_id"/><br/>
			PW: <input type="password" name="user_pw"/><br/>
			<input type="submit" value="Login"/>
		</form>
	<% 
	} else{ 
	%>	<!-- LOGIN MODE -->
<%-- 	<%MemberDTO m = (MemmberDTO)session.getAttribute("member"); %>
	<%=m.getName() %> --%>
		<%=session.getAttribute("UserName")%> Login Success.<br/>
		<a href="Logout.jsp">[Logout]</a>
	<% 
	}
	%>
</body>
</html>