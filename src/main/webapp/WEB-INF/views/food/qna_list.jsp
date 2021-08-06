<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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

<script>
	$(document).ready(function(){
		$(".hide_qna").css("display", "none");
		
		$(".sub_class").click(function(){
			var sub = $(this)[0].id;
			$("#slide_" + sub).slideToggle("slow");
		});
		
		$(".btn").click(function(){
			var bidx = $(this)[0].id;
			var reply_var = $("#f_"+bidx).serialize();
			$.ajax({
				url: "reply.json",
				type: "POST",
				data: reply_var,
	 			dataType: "json",
				success: function(response){
					$("#a_"+response.q_idx).text(response.q_reply);
					$("#tr_"+response.q_idx).css("display", "none");
					$("#tr_a_"+response.q_idx).css("display", "table-row");
				}
			});
		});
		
	});
// 	function enterKey(e){
// 		if(event.keyCode == 13){
// 			console.log(e);
			
// 			var bidx = $(this)[0].id;	//수정해야함 엔터키 입력시 아무것도 안나옴
// 			var reply_var = $("#f_"+bidx).serialize();
// 			console.log($(this));
			
// 			$.ajax({
// 				url: "reply.json",
// 				type: "POST",
// 				data: reply_var,
// 	 			dataType: "json",
// 				success: function(response){
// 					$("#a_"+response.q_idx).text(response.q_reply);
// 					$("#tr_"+response.q_idx).css("display", "none");
// 					$("#tr_a_"+response.q_idx).css("display", "table-row");
// 				}
// 			});
// 		}
// 	}
</script>
</head>
<body>
<div style="text-align: center">
    <h1>상품문의</h1><br/><br/><br/>
    
	<div class="container">
	
		<table class="table table-bordered">
			<tr>
			    <th>번호</th>
				<th>카테고리</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
			</tr>
 			<c:forEach var="dto" items="${list}">
 				<tr bgcolor="#f5eedc"> 
				    <td>${dto.q_idx}</td> 
  					<td>[${dto.q_type}]</td>  
					<td id="sub_${dto.q_idx}" class="sub_class">${dto.q_sub}</td>
					<td>${dto.email}</td>
					<td><fmt:formatDate value="${dto.q_date}" pattern="yyyy-MM-dd"/></td>
				</tr>
				<tbody id="slide_sub_${dto.q_idx}" class="hide_qna">
					<tr>
						<td colspan="5">${dto.q_cont}</td>
					</tr>
					
					<form id="f_b_${dto.q_idx}" name="reply_for" onsubmit="return false;">
					<input name="q_idx" type="hidden" value="${dto.q_idx}"/>
					
					<c:if test="${empty dto.q_reply}">
					<tr id="tr_a_${dto.q_idx}" style="display:none">
						<td colspan="5" id="a_${dto.q_idx}"></td>
					</tr>
					<tr id="tr_${dto.q_idx}">
						<td colspan="4"><input type="text" name="q_reply" style="text-align:left; width:100%; height:100%"></td>
						<td colspan="1"><button id="b_${dto.q_idx}" type="button" class="btn">입력</button></td>
					</tr>
					</c:if>
					
					<c:if test="${!empty dto.q_reply}">
					<tr id="tr_a_${dto.q_idx}">
						<td colspan="5" id="a_${dto.q_idx}">${dto.q_reply}</td>
					</tr>
					</c:if>
					
					</form>
					
				</tbody>
			</c:forEach>
		</table>
	
		<!-- 5. paging view	 -->
		<ul class="pagination">
			<c:if test="${p.pageStartNum ne 1}">
<!-- 				맨 첫페이지 이동 -->
				<li><a onclick='pagePre(${p.pageCnt+1},${p.pageCnt});'>&laquo;</a></li>
<!-- 				이전 페이지 이동 -->
				<li><a onclick='pagePre(${p.pageStartNum},${p.pageCnt});'>&lsaquo;</a></li>
			</c:if>
			
			<!--페이지번호 -->
			<c:forEach var='i' begin="${p.pageStartNum}" end="${p.pageLastNum}" step="1">
				<li class='pageIndex${i}'><a onclick='pageIndex(${i});'>${i}</a></li>
			</c:forEach>
			
			<c:if test="${p.lastChk}">
<!-- 				다음 페이지 이동 -->
				<li><a onclick='pageNext(${p.pageStartNum},${p.total},${p.listCnt},${p.pageCnt});'>&rsaquo;</a></li>
<!-- 				마지막 페이지 이동 -->
				<li><a onclick='pageLast(${p.pageStartNum},${p.total},${p.listCnt},${p.pageCnt});'>&raquo;</a></li>
			</c:if>
		</ul>
		
 		<form action="qna_list.do" method="post" id='frmPaging'>
 			<!-- 출력할 페이지번호, 출력할 페이지 시작 번호, 출력할 리스트 갯수 -->
			<input type='hidden' name='index' id='index' value='${p.index}'>
			<input type='hidden' name='pageStartNum' id='pageStartNum' value='${p.pageStartNum}'>
			<input type='hidden' name='listCnt' id='listCnt' value='${p.listCnt}'>	
 		</form>
 		
		<a href='write.do'>글쓰기</a>
		<br/><br/>
	</div>
	
</div>
</body>
</html>