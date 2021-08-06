<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div style="text-align: center">
	<h1>상품문의 작성</h1>
	
	<form name="insert" method="post" action="qna_insert.do">
		<input type="hidden" name="f_name" value="${f_name}"/>
	선택상품: <input type="text" disabled/><br/>
	카테고리: 
	<select name="q_type" id="q_type">
		<option id="상품" value="상품">상품</option>
		<option id="배송" value="배송">배송</option>
		<option id="환불" value="환불">환불</option>
	</select>
	<br/>
	이메일: <input type="text" name="email" disabled/><br/>
	제목: <input type="text" name="q_sub"></input><br/>
	내용: <br/>
	<input type="text" name="q_cont" style="text-align:left; width:500px; height:300px"></input><br/></br>
	<button id="">전송</button>
	</form>
</div>
</body>
</html>