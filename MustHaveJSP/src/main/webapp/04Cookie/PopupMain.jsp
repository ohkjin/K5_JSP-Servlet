
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String popupMode = "on";

Cookie[] cookies = request.getCookies(); //요청 헤더의 모든 쿠키
if(cookies!=null){
	for(Cookie c:cookies){
		String cookieName = c.getName();
		String cookieValue = c.getValue();
		if(cookieName.equals("PopupClose")){
			popupMode = cookieValue;
		}
		
	}
} 
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Popup administration using Cookie</title>
<style>
div#popup{
	position: absolute; top:100px; left:50px; width:270px; height:100px; /* if non of these, then just shown under the text */
	background-color:gray; color:yellow;
}
div#popup>div{
	position: relative;
	background-color:white; color:black;
}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script>
$(function(){
	$('#closeBtn').click(function(){
		$('#popup').hide();
		var chkVal = $("input:checkbox[id=inactiveToday]:checked").val();
		if(chkVal==1){
			$.ajax({
				url : './PopupCookie.jsp',
				type : 'get',
				data : {inactiveToday : chkVal},//jason
				dataType : "text",
				success : function(resData) {
					if(resData != '') location.reload();
				}
			});
		}
	});
})
</script>
</head>
<body>
<h2>Popup Main Page</h2>
<%
	for(int i=1;i<=10;i++){
		out.print("Current Popup is in "+popupMode+" Mode.<br/>");
	}
if(popupMode.equals("on")){
%>
	<div id = "popup">
		<h2 align="center">Alert Popup</h2>
		<div align="right"><form name="popFrm">
			<input type="checkbox" id="inactiveToday" value="1"/>
			Do not open for Today
			<input type="button" id="closeBtn" value="close"/>
		</form></div>
	</div>
<%
}
%>
</body>
</html>