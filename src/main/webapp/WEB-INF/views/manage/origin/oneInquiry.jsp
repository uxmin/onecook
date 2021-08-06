<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>oneInquiry(1대1문의)</title>
<script src="../js/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="../js/paging.js"></script>
<script src="../js/bootstrap.min.js"></script>
<script type="text/javascript" language="javascript" 
		     src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
<link rel="stylesheet" href="../css/bootstrap.min.css">
<link rel="stylesheet" href="../css/bootstrap-theme.min.css">
<script>
	$(document).ready(function(){

	});
	
	function cat_func(val){
		console.log(val);
	}
</script>
</head>
<body style="text-align:center">
	<div>
		<h2>1 대 1 문의 확인</h2>
	</div>
	<div>
		<form id="cat_form_id" action="one_cat_form.do" method="post">
		<select id="cat_id" name="cat_nm" onchange="cat_func(this.value)">
			<option value="email">유저 이메일</option>
			<option value="f_name">재료명</option>
			<option value="q_sub">제목</option>
			<option value="q_date">등록일</option>
			<option value="q_type">카테고리 구분</option>
		</select>
		<input tyep="text" id="cat_input_id" name="cat_text"/>
		<button type="submit" id="search_id">검색</button>
		</form>
	</div>
	<div>
		<table class="table table-hover">
			<tr>
				<th>문의번호</th>
				<th>이메일</th>
				<th>재료명</th>
				<th>제목</th>
				<th>등록일</th>
				<th>답변 유무</th>
			</tr>
			<c:forEach var="qvo" items="${qlist}">
			<tr>
				<td>${qvo.q_idx}</td>
				<td>${qvo.email}</td>
				<td><a href="../food/content.do?f_name=${qvo.f_name}#pagination1">${qvo.f_name}</a></td>
				<td>${qvo.q_sub}</td>
				<td><fmt:formatDate value="${qvo.q_date}" pattern="yyyy-MM-dd"/></td>
				<c:if test="${qvo.q_reply != null}">
					<td>답글 작성 완료됨</td>
				</c:if>
				<c:if test="${qvo.q_reply == null}">
					<td>답글 작성 X</td>
				</c:if>			
			</tr>
			</c:forEach>
		</table>
	</div>
	
	<ul class="pagination">
		<c:if test="${p.pageStartNum ne 1}">
			<li><a onclick='pagePre(${p.pageStartNum},${p.pageCnt});'>이전</a></li>
		</c:if>
		
		<c:forEach var='i' begin="${p.pageStartNum}" end="${p.pageLastNum}" step="1">
			<li class='pageIndex${i}'><a onclick='pageIndex(${i});'>${i}</a></li>
		</c:forEach>
		
		<c:if test="${p.lastChk}">
			<li><a onclick='pageNext(${p.pageStartNum},${p.total},${p.listCnt},${p.pageCnt});'>이후</a></li>
		</c:if>
	</ul>
<%-- 	<p>${p.category}</p> --%>
<%-- 	<p>${p.sort}</p>	 --%>
	<c:if test="${p.category == null && p.sort == null}">
	<form method="post" id='frmPaging'>
		<input type='hidden' name='index' id='index' value='${p.index}'>
		<input type='hidden' name='pageStartNum' id='pageStartNum' value='${p.pageStartNum}'>
		<input type='hidden' name='listCnt' id='listCnt' value='${p.listCnt}'>
	</form>
	</div>	
	</c:if>
	<!-- 검색 한 페이지일 경우 카테고리와 검색내용을 hidden으로 넣어서 넘겨주기 -->
	<c:if test="${p.category != null}">
	<form method="post" id='frmPaging' action="one_cat_form.do">
		<input type='hidden' name='index' id='index' value='${p.index}'>
		<input type='hidden' name='pageStartNum' id='pageStartNum' value='${p.pageStartNum}'>
		<input type='hidden' name='listCnt' id='listCnt' value='${p.listCnt}'>
		<input type='hidden' name='cat_nm' id='cat_nm' value='${p.category}'>
		<input type='hidden' name='cat_text' id='cat_text' value='${p.sort}'>
	</form>
	</div>
	</c:if>
</body>
</html>