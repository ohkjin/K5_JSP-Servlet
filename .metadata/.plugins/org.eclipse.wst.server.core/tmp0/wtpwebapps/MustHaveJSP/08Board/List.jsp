<%@page import="boardManagement.BoardDTO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="boardManagement.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
BoardDAO dao = new BoardDAO(application);

// 사용자의 입력 검색 조건을 Map에 저장
Map<String,Object> param = new HashMap<>();

String searchField = request.getParameter("searchField");
String searchWord = request.getParameter("searchWord");

if (searchWord!=null){
	param.put("searchField",searchField);
	param.put("searchWord",searchWord);
}

	/* 게시물 수 확인 */
	int totalCnt = dao.selectCount(param);
	/* 게시물 목록 받기 */
	List<BoardDTO> boardLists = dao.selectList(param);
	dao.close(); //JDBC에서 Exception catch중


%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원제 게시판</title>
</head>
<body>
 	<!-- 공통링크 -->
	<jsp:include page = "../Common/Link.jsp"/>
	<h2>목록 보기(List)</h2>
	<form method="get">
		<!-- 검색폼 -->
		<table border="1" width="90%">
		<tr>
		<td align="center">
			<select name="searchField">
				<option value="title">Title</option>
				<option value="content">Content</option>
			</select>
			<input type="text" id="searchWord" name="searchWord">
			<input type="submit" value="검색하기"><br/>
		</td>
		</tr>
		</table>
	</form>
	<!-- 게시물 목록 테이블 (표) -->
	<table border="1" width="90%">
		<tr>
			<th width="10%">번호</th>
			<th width="10%">제목</th>
			<th width="10%">작성자</th>
			<th width="10%">조회수</th>
			<th width="10%">작성일</th>
		</tr>
<%
if(boardLists.isEmpty()){
%>	
		<tr>
			<td colspan="5" align="center">
				등록된 게시물이 없습니다^^*
			</td>
		</tr>
<%
}else{
	int virtualNum =0;//게시물 번호
	for(BoardDTO dto:boardLists){
		virtualNum= totalCnt--;//전체 게시물에서 1씩 감소
%>
		<tr align="center">
			<!-- 게시물 번호 -->
			<td><%= virtualNum %></td>
			<td align="left"> 
			<!-- 제목 -->
				<a href="View.jsp?num=<%=dto.getNum()%>"><%=dto.getTitle()%></a>
			</td>
			<td align="center"><%=dto.getId()%></td>
			<td align="center"><%=dto.getVisitcount()%></td>
			<td align="center"><%=dto.getPostdate()%></td>
		</tr>
<%
	}
}
%>
	</table>
	<!-- 목록 하단의 글쓰기버튼 -->
	<table border="1" width="90%">
		<tr align="right">
			<td><button type="button" onclick="location.href='Write.jsp';">글쓰기</button></td>
		</tr>
	</table>
</body>
</html>