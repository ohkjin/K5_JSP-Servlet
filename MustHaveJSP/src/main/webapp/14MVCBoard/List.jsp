<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>파일 첨부형 게시판</title>
<style>a{text-decoration:none;}</style>
</head>
<body>
	<h2>파일 첨부형 게시판 - 목록 보기(List)</h2>
	
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
			<th width="*">제목</th>
			<th width="15%">작성자</th>
			<th width="10%">조회수</th>
			<th width="15%">작성일</th>
			<th width="8%">첨부</th>
		</tr>
<c:choose>
	<c:when test="${ empty boardLists }">
		<tr>
			<td colspan="6" align="center">
				등록된 게시물이 없습니다^^*
			</td>
		</tr>
	</c:when>
	<c:otherwise>
		<c:forEach items = "${ boardLists }" var="row" varStatus="loop">
		<tr align="center">
			<!-- 게시물 번호 매번 1에서 시작하게 -->
			<td>${ map.totalCnt - (((map.pageNum-1)*map.pageSize)+loop.index) }</td>
			<!-- 제목 링크 -->
			<td align="left"><a href="../mvcboard/view.do?idx=${ row.idx }">${ row.title }</a></td>
			<td>${ row.name }</td>
			<td>${ row.visitcount }</td>
			<td>${ row.postdate }</td>
			<!-- 첨부 파일 -->
			<td>
			<c:if test="${ not empty row.ofile }">
				<a href="../mvcboard/download.do?ofile=${ row.ofile }&sfile=${ row.sfile }&idx=${ row.idx }">
				[Download]</a>
			</c:if>
			</td>
		</tr>
		</c:forEach>
	</c:otherwise>
	</c:choose>
	</table>
	
	<!-- 목록 하단의 글쓰기버튼 -->
	<table border="1" width="90%">
		<tr align="center">
			<td>${ map.pagingImg }</td>
			<td width="100">
				<button type="button" onclick="location.href='../mvcboard/write.do';">
				글쓰기</button>
			</td>
		</tr>
	</table>
</body>
</html>