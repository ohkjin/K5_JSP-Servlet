<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MultiUploadMain.jsp</title>
</head>
<script>
function validateForm(form){
	if(form.title.value==""){
		alert("제목을 입력하세요.");
		form.title.focus();
		return false
	}
	if(form.ofile.value==""){
		alert("첨부 파일은 필수 입력입니다.");
		return false
	}
}
</script>
<body>
	<h3>Multi-File Upload</h3>
	<a href="FileList.jsp">File List</a>
	<a href="FileUploadMain.jsp">Single Upload</a>
	<span style="color:red;">${ errorMessage }</span>
	<form name="fileForm" method="post" enctype="multipart/form-data"
		action="MultipleProcess.do" onsubmit="return validateForm(this);">
		Title : <input type="text" name ="title" /><br/>
		Category(select) :
			<input type="checkbox" name ="cate" value="PDF" checked/>PDF
			<input type="checkbox" name ="cate" value="사진" />사진
			<input type="checkbox" name ="cate" value="워드" />워드
			<input type="checkbox" name ="cate" value="음원" />음원<br/>
		Attach File(Multi-select) : <input type="file" name ="ofile" multiple/><br/>
		<input type="submit" value ="submit"/><br/>
	</form>
</body>
</html>