<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="common.Person"%>
<%@page import="java.util.LinkedList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSTL - forEach 2</title>
</head>
<body>
	<h4>Using List Collection</h4>
	<%
	LinkedList<Person> lists = new LinkedList<>();
	lists.add(new Person("One",34));
	lists.add(new Person("Two",26));
	lists.add(new Person("Three",67));
	%>
	<c:set var="lists" value="<%= lists %>"/>
	<c:forEach items="<%= lists %>" var="list">
		<li>이름 : ${ list.name }, 나이 : ${ list.age }</li>
	</c:forEach>
	
	<h4>Using Map Collection</h4>
	<%
	Map<String,Person> maps = new HashMap<>();
	maps.put("1st",new Person("One",34));
	maps.put("2nd",new Person("Two",26));
	maps.put("3rd",new Person("Three",67));
	%>
	<c:set var="maps" value="<%= maps %>"/>
	<c:forEach items="<%= maps %>" var="map">
		<li>${map.key} 이름 : ${ map.value.name }, 나이 : ${ map.value.age }</li>
	</c:forEach>
</body>
</html>