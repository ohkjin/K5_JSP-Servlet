<%@page import="membership.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
#title,#content{
width:1000px;
margin:10px;
}
#title{
height:30px;
}
#content{
height:500px;
}
#bt{
width:50px;
height:30px;
}
</style>
<title>Insert Board</title>
</head>
<body>
<h2>글쓰기</h2>

<%-- 	<%
	String isLogin = request.getParameter("isLogin");
	String LoginId = request.getParameter("loginid");
	String sid = "";
	if (session.getAttribute("UserId")!=null){
		MemberDTO m = (MemberDTO)session.getAttribute("member"); 
		isLogin = "true";
		LoginId = m.getId();
	}
	if(LoginId!= null) sid=LoginId;
	
	%> --%>
	<%
	String sid = request.getParameter("id");
	String boardErr = request.getParameter("boardErr");
	if(boardErr!= null) out.print("Upload Failed");;
	%>
	<script>
		function validateForm(form){
			if(!form.title.value){
				alert("title please");
				return false;
			}
			if(form.content.value==""){
				alert("content please");
				return false;
			}
			
		}
	</script>
<form action="./InsertBoardProcess.jsp" method="post" name="onBoard" 
			onsubmit="return validateForm(this);"> <!-- false일시 출력 안됨 -->
	<div id="board">
	<input type="text" id="title" name="title" placeholder="제목을 입력하세요"><br/>
	<input type="text" id="content" name="content" placeholder="내용을 입력하세요"><br/>
	<%-- <input type="text" id="id" name="id" value="<%=sid%>" readOnly> --%>
	<input type="text" id="id" name="id" placeholder="작성자">
	<input type="submit" id="bt"value="submit"><br/>
<%-- <%if(isLogin!=null){ %> --%>
	<a href="./BoardLoginSession/Logout.jsp">[Logout]</a>
<%-- <%}else out.print("Not Logged in");%> --%>
	</div>
</form>

</body>
</html>