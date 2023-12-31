<%@page import="java.io.InputStream"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>
<%@page import="utils.JSFunction"%>
<%@page import="java.io.FileNotFoundException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String saveDirectory = application.getRealPath("/Uploads");
String saveFileName = request.getParameter("sName");
String originalFileName = request.getParameter("oName");

try{
	//파일을 찾아 입력 스트림 생성
	File file = new File(saveDirectory, saveFileName);
	InputStream inStream = new FileInputStream(file);
	
	//한글 파일명 깨짐 방지
	String client = request.getHeader("User-Agent");
	 											 		// String(byte bytes[], String charsetName)
	if(client.indexOf("WOW64")==-1)	
		 originalFileName = new String(originalFileName.getBytes("UTF-8"),"ISO-8859-1");
	else originalFileName = new String(originalFileName.getBytes("KSC5601"),"ISO-8859-1");
	
	//다운로드용 응답헤더 설정
	response.reset();
	response.setContentType("application/octet-stream");
	response.setHeader("Content-Disposition", "attachment; filename=\""+originalFileName+"\"");
	response.setHeader("Content-Length", ""+file.length());
	
	//출력 스트림 초기화 후 resp내장객체로부터 새로운 출력 스트림 생성
	out.clear();
	OutputStream outStream = response.getOutputStream();
	
	//출력 스트림에 파일 내용 출력
	byte b[] = new byte[(int)file.length()];
	int readBuffer = 0;
	while((readBuffer = inStream.read(b))>0){
		outStream.write(b,0,readBuffer);
	}
	//입출력 스트림 닫기
	inStream.close();
	outStream.close();
}catch(FileNotFoundException e){
	JSFunction.alertBack("File not Found"+"("+saveFileName+","+originalFileName+")",out);
}catch(Exception e){
	e.printStackTrace();
	JSFunction.alertBack("Error occurred : "+e.getMessage()+"("+saveFileName+","+originalFileName+")", out);
}
%>