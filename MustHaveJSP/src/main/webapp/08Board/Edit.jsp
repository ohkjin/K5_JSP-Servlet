<%@page import="boardManagement.BoardDTO"%>
<%@page import="boardManagement.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 로그인 확인 -->
<%@ include file="./IsLoggedIn.jsp" %>
<%
//일련번호
int num = 0;
String snum = request.getParameter("num");
//snum 에 10/ /이라는 의문의 문자가 붙는다
// value 에 ""!!!!!!
snum = snum.replaceAll("[^0-9]", "");
if(snum!=null) num = Integer.parseInt(snum);

BoardDAO dao = new BoardDAO(application);
BoardDTO dto = dao.selectView(num);

String sessionId = session.getAttribute("UserId").toString(); //get login Id
if(!sessionId.equals(dto.getId())){ //본인 확인
	JSFunction.alertBack("작성자 본인만 수정할 수 있습니다.",out);
	return;
}
dao.close();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

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
<h2>회원제 게시판 - 수정하기(Edit)</h2>

<form action="./EditProcess.jsp" method="post" name="writeFrm" 
			onsubmit="return validateForm(this);"> <!-- false일시 출력 안됨 -->
	<input type = "hidden" name = "num" value ="<%= dto.getNum() %>"/>
	<table border="1" width="90%">
		<tr>
			<td>제목</td>
			<!-- // value 에 ""!!!!!!!!!!!!!!!!!!!!!!"""""""" -->
			<td><input type="text" id="title" name="title" value ="<%= dto.getTitle() %>" placeholder="제목을 입력하세요" style="width:90%;"/></td>
		</tr>
		<tr>
			<td>내용</td>
			<td><textarea id="content" name="content" placeholder="내용을 입력하세요" style="width:90%;height:100px;">
				<%= dto.getContent() %></textarea></td>
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