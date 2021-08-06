<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="utf-8">
<title>재료 상세보기</title>
<style>
table, th, td {
	border: 1px solid black;
	border-collapse: collapse;
}

th, td {
	padding: 5px;
}

a {
	text-decoration: none
}

input[type="text"]:focus {
	border-color: rgb(111, 186, 44);
	box-shadow: 0 0 8px 0 rgb(111, 186, 44);
}
</style>
</head>

<body style="text-align: center">
	<center>
		<h1>Food_detail</h1>

		<table border='1' cellpadding='7' cellspacing='2' width='50%'>
			<tr>
				<th>제목</th>
				<th>내용</th>
			</tr>

			<c:if test="${empty Food_detail}">
				<tr>
					<td colspan="5" align="center">데이터가 하나도 없음</td>
				</tr>
			</c:if>

			<c:forEach items="${Food_detail}" var="Food_detail">
				<tr>
					<td>${Food_detail.fd_sub}</td>
					<td>${Food_detail.fd_cont}</td>
				</tr>
			</c:forEach>

		</table>
	</center>
	</div>
</body>
</html>