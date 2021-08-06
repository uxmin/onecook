<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="../js/jquery-3.1.1.min.js"></script>
<script src="../js/bootstrap.min.js"></script>
<link rel="stylesheet" href="../css/bootstrap.min.css">
<link rel="stylesheet" href="../css/bootstrap-theme.min.css">

<!-- 4. Javascript -->
<script type="text/javascript" src="../js/paging.js"></script>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>   
	<div class="container">
		<table class="table table-bordered">
			<tr>
			    <th>재료명</th>
				<th>재료분류</th>
				<th>가격</th>
				<th>재고수량</th>
<!-- 				<th>판매단위</th> -->
<!-- 				<th>중량/용량</th> -->
<!-- 				<th>원산지</th> -->
<!-- 				<th>포장타입</th> -->
<!-- 				<th>날짜</th> -->
<!-- 				<th>재료이미지</th> -->
			</tr>
 			<c:forEach var="dto" items="${list}">
 				<tr> 
				    <td>${dto.f_name}</td> 
  					<td>${dto.f_type}</td>  
					<td>${dto.f_price}</td> 
					<td>${dto.f_count}</td> 
				</tr>	
			</c:forEach>
		</table>
	
		<!-- 5. paging view -->	
		<ul class="pagination">
			<c:if test="${p.pageStartNum ne 1}">
<!-- 				맨 첫페이지 이동 -->
				<li><a onclick='pagePre(${p.pageCnt+1},${p.pageCnt});'>&laquo;</a></li>
			<!--이전 페이지 이동 -->
				<li><a onclick='pagePre(${p.pageStartNum},${p.pageCnt});'>&lsaquo;</a></li>
			</c:if>
			
			<!--페이지번호 -->
			<c:forEach var='i' begin="${p.pageStartNum}" end="${p.pageLastNum}" step="1">
				<li class='pageIndex${i}'><a onclick='pageIndex(${i});'>${i}</a></li>
			</c:forEach>
			
			<c:if test="${p.lastChk}">
			<!-- 다음 페이지 이동 -->
				<li><a onclick='pageNext(${p.pageStartNum},${p.total},${p.listCnt},${p.pageCnt});'>&rsaquo;</a></li>
			<!-- 마지막 페이지 이동 -->
				<li><a onclick='pageLast(${p.pageStartNum},${p.total},${p.listCnt},${p.pageCnt});'>&raquo;</a></li>
			</c:if>
	</ul>
 		<form action="stock_check.do" method="post" id='frmPaging'>
 			<!-- 출력할 페이지번호, 출력할 페이지 시작 번호, 출력할 리스트 갯수 -->
			<input type='hidden' name='index' id='index' value='${p.index}'>
			<input type='hidden' name='pageStartNum' id='pageStartNum' value='${p.pageStartNum}'>
			<input type='hidden' name='listCnt' id='listCnt' value='${p.listCnt}'>	
 		</form>
	</div>
</body>
</html>