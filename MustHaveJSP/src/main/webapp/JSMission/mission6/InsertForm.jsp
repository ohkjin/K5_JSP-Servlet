<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%-- <%
String id_value=request.getParameter("id");
String pwd_value=request.getParameter("pwd");
String nn_value=request.getParameter("nickname");
%> --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Mission6</title>
</head>
<body>
	<h2>회원 가입</h2>
	<%
	String idErr = request.getParameter("idErr");
	if(idErr!= null) out.print("Redudant ID: "+idErr);
	%>
	<form action="./InsertProcess.jsp" method="post">
<!-- 	<form> -->
		ID: <input type="text" name="id" value="" placeholder="ID" ><br/>
		PWD: <input type="text" name="pwd" value="" placeholder="Password"><br/>
		닉네임: <input type="text" name="nickname" value="" placeholder="Nickname"><br/>
		<input type="submit" value="회원 등록">
	</form>
</body>
</html>