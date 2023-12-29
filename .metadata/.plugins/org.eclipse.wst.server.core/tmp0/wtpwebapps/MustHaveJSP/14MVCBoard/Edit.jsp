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
	}
</script>

<title>파일 첨부형 게시판</title>
</head>
<body>
<h2>파일 첨부형 게시판 - 수정하기(Edit)</h2>
<form action="../mvcboard/edit.do" method="post" name="writeFrm" enctype="multipart/form-data"
			onsubmit="return validateForm(this);">
	<input type="hidden" id="idx" name="idx" value="${ dto.idx }"/>
	현재 첨부된 파일: <input type="text" readonly id="prevOfile" name="prevOfile" value="${ dto.ofile }"/><br/>
	(파일 선택시 첨부 파일이 변경됩니다.)
	<input type="hidden" id="prevSfile" name="prevSfile" value="${ dto.sfile }"/>
	
	<table border="1" width="90%">
		<tr>
			<td>작성자</td>
			<td><input type="text" id="name" name="name" value="${ dto.name }" style="width:150px;"/></td>
		</tr>
		<tr>
			<td>제목</td>
			<td><input type="text" id="title" name="title" value="${ dto.title }" style="width:90%;"/></td>
		</tr>
		<tr>
			<td>내용</td>
			<td><textarea id="content" name="content" style="width:90%;height:100px;">
				${ dto.content }
			</textarea></td>
		</tr>
		<tr>
			<td>첨부 파일</td>
			<td><input type="file" id="ofile" name="ofile"/></td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<button type="submit">작성 완료</button>
				<button type="reset" style="background-color:orange;">RESET</button>
				<button type="submit" onclick="location.href='../mvcboard/list.do';">목록 보기</button>
			</td>
		</tr>
	</table>
</form>
</body>
</html>