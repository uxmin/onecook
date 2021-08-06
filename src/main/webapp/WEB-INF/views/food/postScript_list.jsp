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
	
		<!-- <select class='btn btn-primary' id='listCount' name='listCount' onchange='listCnt();'>
			<option value='5' >등록일수</option>
			<option value='10'>조회많은 순</option>
			
		</select> -->
		
		<table class="table table-bordered">
			<tr>
			    <th>번호</th>
				<th>제목</th>
				<th>작성일</th>
				<th>조회</th>
				<th>삭제</th>
			</tr>
 			<c:forEach var="dto" items="${list}">
 				<tr> 
				    <td>${dto.rv_idx}</td> 
  					<%-- <td><a href="content.do?rv_idx=${dto.rv_idx}">${dto.rv_sub}</a></td> --%>  
					<td><a class="toggle_review_sub" href="#"><input class="hdn_rvNum" type="hidden" value="${dto.rv_idx}"><input type="hidden" value="${dto.f_name}">${dto.rv_sub}</a></td> 
					<td>${dto.rv_date}</td>
					<td id="readNum_${dto.rv_idx}">${dto.rv_num}</td>
 					<td><a href="del.do?rv_idx=${dto.rv_idx}">삭제</a></td> 
				</tr>

				<tr class="show_review_tr" id="tr_head_${dto.rv_idx}">
				</tr>
				<tr class="show_review_tr" id="tr_body_${dto.rv_idx}">
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
 		<form action="postScript_list.do" method="post" id='frmPaging'>
 			<!-- 출력할 페이지번호, 출력할 페이지 시작 번호, 출력할 리스트 갯수 -->
			<input type='hidden' name='index' id='index' value='${p.index}'>
			<input type='hidden' name='pageStartNum' id='pageStartNum' value='${p.pageStartNum}'>
			<input type='hidden' name='listCnt' id='listCnt' value='${p.listCnt}'>	
 		</form>
		<a href='postScript_write.do'>글쓰기</a>
		<br/><br/>
	</div>
	
	<script src="../js/custom-list.js"></script>
</body>
</html>