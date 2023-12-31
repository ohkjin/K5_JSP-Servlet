<%@page import="boardManagement.BoardDTO"%>
<%@page import="boardManagement.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 로그인 확인 -->
<%@ include file="./IsLoggedIn.jsp" %>
<%
//수정 내용 얻기
int num = 0;
String snum = request.getParameter("num");
/* snum = snum.replaceAll("[^0-9]", ""); */
if(snum!=null) num = Integer.parseInt(snum);

String title=request.getParameter("title");
String content=request.getParameter("content");

//DTO 객체에 저장
BoardDTO dto = new BoardDTO();
dto.setNum(num);
dto.setTitle(title);
dto.setContent(content);

//DB에 반영
BoardDAO dao = new BoardDAO(application);
int eResult = dao.updateEdit(dto);
dao.close();

//Success
 if(eResult==1) { 
	response.sendRedirect("View.jsp?num="+dto.getNum());
}
//Failed
else {
	JSFunction.alertBack("글쓰기에 실패하였습니다.",out); //경고후 이전페이지
} 


/* catch(Exception e){
	System.out.println(e.getMessage());
} */
%>
