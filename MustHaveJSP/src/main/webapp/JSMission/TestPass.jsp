<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Test Score</title>
</head>
<body>

	<form method="post" action="../12Servlet/TestPass.test">
	<table border="1">
		<tr>
			<td>국</td>
			<td border="1">
				<input type="text" name="nativelan"/>
			</td>
		</tr>
		<tr>
			<td>영</td>
			<td border="1">
				<input type="text" name="english"/>
			</td>
		</tr>
		<tr>
			<td>국</td>
			<td border="1">
				<input type="text" name="math"/>
			</td>
		</tr>
		<tr>
			<td><strong>${ testMessage }</strong></td>
		</tr>
		<tr>
			<td><input type="submit" value="제출"/></td>
		</tr>
		</table>
	</form>
</body>
</html>