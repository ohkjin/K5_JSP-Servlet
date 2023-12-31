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
#id{
margin:10px;
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

	<%
	MemberDTO m = (MemberDTO)session.getAttribute("member"); 
	//m==null이면 로그인이 되지 않았다는 의미
	if (m==null){
		response.sendRedirect("./BoardLoginSession/LoginForm.jsp");
		return;
	}
	%>
	<%
	String boardErr = request.getParameter("boardErr");
	if(boardErr!= null) out.print("Upload Failed");
	
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
	<input type="text" id="name" name="name" value="<%=m.getName()%>" readonly>
	<input type="submit" id="bt"value="submit"><br/>
	<a href="./BoardLoginSession/Logout.jsp">[Logout]</a>
	</div>
</form>

</body>
</html>