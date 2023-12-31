<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 로그인 확인 -->
<%@ include file="./IsLoggedIn.jsp" %>

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

<script type="text/javascript">
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

<title>회원제 게시판</title>
</head>
<body>
<jsp:include page="../Common/Link.jsp"/>
<h2>회원제 게시판 - 글쓰기(Write)</h2>

<form action="./WriteProcess.jsp" method="post" name="writeFrm" 
			onsubmit="return validateForm(this);"> <!-- false일시 출력 안됨 -->
	<table border="1" width="90%">
		<tr>
			<td>제목</td>
			<td><input type="text" id="title" name="title" placeholder="제목을 입력하세요" style="width:90%;"/></td>
		</tr>
		<tr>
			<td>내용</td>
			<td><textarea id="content" name="content" placeholder="내용을 입력하세요" style="width:90%;height:100px;"></textarea></td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<button type="submit">작성 완료</button>
				<button type="reset">다시 입력</button>
				<button type="submit" onclick="location.href='List.jsp';">목록보기</button>
			</td>
		</tr>
	</table>
</form>
</body>
</html>