<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<script type="text/javascript">
	function validateForm(form){
		if(!form.name.value){
			alert("name please");
			form.name.focus();
			return false;
		}
		if(!form.title.value){
			alert("title please");
			form.title.focus();
			return false;
		}
		if(form.content.value==""){
			alert("content please");
			form.content.focus();
			return false;
		}
		if(form.pass.value==""){
			alert("password please");
			form.pass.focus();
			return false;
		}
	}
</script>

<title>파일 첨부형 게시판</title>
</head>
<body>
<jsp:include page="../Common/Link.jsp"/>
<h2>파일 첨부형 게시판 - 글쓰기(Write)</h2>
//////////////////////////////////////////////////////////////////////////////////////////////
<form action="./mvcboard/write.do" method="post" name="writeFrm" enctype="multipart/form-data"
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