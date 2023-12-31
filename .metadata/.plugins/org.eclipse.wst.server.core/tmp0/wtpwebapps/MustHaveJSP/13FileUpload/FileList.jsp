<%@page import="java.net.URLEncoder" %>
<%@page import="fileupload.MyFileDTO"%>
<%@page import="fileupload.MyFileDAO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FileUpload</title>
</head>
<body>
	<h2>DB에 등록된 파일 목록 보기(List)</h2>
	<a href="FileUploadMain.jsp">AttachFile1</a>
	<a href="MultiUploadMain.jsp">AttachFile2</a>
	<%
	MyFileDAO dao = new MyFileDAO();
	List<MyFileDTO> fileLists = dao.myFileList();
	dao.close();
	%>
	<table border="1" width="90%">
		<tr>
			<th>No</th><th>Title</th><th>Category</th>
			<th>Original File Name</th><th>Saved File Name</th><th>Post Date</th>
		</tr>
	<% for (MyFileDTO f: fileLists){ %>
		<tr align="center">
			<td align="center"><%=f.getIdx()%></td>
			<td align="center"><%=f.getTitle()%></td>
			<td align="center"><%=f.getCate()%></td>
			<td align="center"><%=f.getOfile()%></td>
			<td align="center"><%=f.getSfile()%></td>
			<td align="center"><%=f.getPostdate()%></td>
			<td align="left"> 
			
				<a href="Download.jsp?oName=<%=URLEncoder.encode(f.getOfile(),"UTF-8")
				//문자열에 enter시 file에 _____추가
								   %>&sName=<%=URLEncoder.encode(f.getSfile(),"UTF-8")%>">
					[다운로드]</a>
			</td>
		</tr>
	<% } %>
	</table>
</body>
</html>