<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="../js/jquery-3.1.1.min.js"></script>
<script src="../js/bootstrap.min.js"></script>
<link rel="stylesheet" href="../css/bootstrap.min.css">
<link rel="stylesheet" href="../css/bootstrap-theme.min.css">

<!-- 4. Javascript -->
<script type="text/javascript" src="../js/paging.js"></script>
<script type="text/javascript" src="../js/paging2.js"></script>
<style>
.list{
	width: 80%;
	margin: 10px auto;
}
.list_block{
	border: 1px solid black;
	float: left;
	width: 50%;
	box-sizing: border-box;
}
</style>
<script>
	var replaceAt = function(input, index, character){
	    return input.substr(0, index) + character + input.substr(index+character.length);
	}
	
	$(document).ready(function(){
        for(var i=0; i<$(".qna_user_name").length; i++){
            console.log($(".qna_user_name")[i].innerText);
            var origin = $(".qna_user_name")[i].innerText;

            var change_name = replaceAt(origin, 1, '*');
            console.log(change_name);
            $(".qna_user_name")[i].innerText = change_name;
        }
        
        for(var i=0; i<$(".rv_user_name").length; i++){
            console.log($(".rv_user_name")[i].innerText);
            var origin = $(".rv_user_name")[i].innerText;

            var change_name = replaceAt(origin, 1, '*');
            console.log(change_name);
            $(".rv_user_name")[i].innerText = change_name;
        }
        
		$('#count_minus').click(function(e){
			e.preventDefault();
			var countStr = $('#count_value').text();
			var countNum = parseInt(countStr,10);
			countNum--;
			var priceStr = $('#price').text();
			var price = parseInt(priceStr,10);
			var totalNum = countNum*price;
			
			if(countNum<=0){
				alert('최소 구매수량은 1개 입니다.');
				countNum = 1;
				totalNum = ${read.f_price};
			}
			$('#count_value').text(countNum);
			$('#total_price').text(totalNum);
			$('#cart_count').attr('value', countNum);
		});
		
		$('#count_plus').click(function(e){
			e.preventDefault();
			var countStr = $('#count_value').text();
			var countNum = parseInt(countStr,10);
			countNum++;
			var priceStr = $('#price').text();
			var price = parseInt(priceStr,10);
			var totalNum = countNum*price;
			
// 			if(countNum>5){
// 				alert('최대 구매수량은 5개 입니다.');
// 				countNum = 5;
// 			}
			$('#count_value').text(countNum);
			$('#total_price').text(totalNum);
			$('#cart_count').attr('value', countNum);
		});
		
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
</script>
</head>
<body>
<div style="text-align: center; float: left;">
	<h1>상품 상세보기</h1>
	<div class="list">
		<div class="list_block" style="text-align: center">
			<image src="../images/food/${read.f_type}/${read.f_img}" width="85%" height="8500%"/>
		</div>
		<div class="list_block">
			<br/>
			<form name="insertCart" method="post" action="../pay/cart_list.do">
			<p>${read.f_name}</p><input type="hidden" name="f_name" value="${read.f_name}">
			<p id="price">${read.f_price}</p>
			<p>${read.f_sales}</p>
			<p>${read.f_weight}</p>
			<p>${read.f_origin}</p>
			<p>${read.f_package}</p>
			<br/>
			<button id="count_minus">-</button>
			<span id="count_value">1</span><input type="hidden" name="cart_count" id="cart_count" value="1">
			<button id="count_plus">+</button>
			<br/><br/>
			<p>남은 재고수량 : ${read.f_count}</p>
			<br/><br/>
			총 구매금액: <span id="total_price">${read.f_price}</span>
			<br/>
			<c:if test="${empty loginUser}">
				<a href="../login_admission/login.do" style="text-decoration:none"><input type="submit" value="장바구니"></a>
			</c:if>
			<c:if test="${!empty loginUser}">
				<input type="submit" value="장바구니">
			</c:if>
			</form>
		</div>
	</div>
	<br/>
	<div style="text-align:center;float: left;">
		<c:forEach items="${explain}" var="fd_ex">
			${fd_ex.fe_cont}
		</c:forEach>			
	</div>
	<br/>
	<div>
		<h1>Food_detail</h1>
			
		<table border='1' cellpadding='7' cellspacing='2' width='50%'>
		<tr>
		<th>제목</th>
		<th>내용</th>
		</tr>
			
		<c:forEach items="${detail}" var="Food_detail">
		<tr>
			<td>${Food_detail.fd_sub}</td>
			<td>${Food_detail.fd_cont}</td>				
		</tr>
		</c:forEach>		
		</table>		
	</div>
	
	<!-- 문의 -->
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
					<td class="qna_user_name">${dto.user_name}</td>
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
						<c:if test="${loginUser.user_type eq 'MANAGER'}">
						<tr id="tr_${dto.q_idx}">
							<td colspan="4"><input type="text" name="q_reply" style="text-align:left; width:100%; height:100%"></td>
							<td colspan="1"><button id="b_${dto.q_idx}" type="button" class="btn">입력</button></td>
						</tr>
						</c:if>
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
		<ul class="pagination" id="pagination1">
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
		
 		<form action="content.do#pagination1" method="post" id='frmPaging'>
 			<!-- 출력할 페이지번호, 출력할 페이지 시작 번호, 출력할 리스트 갯수 -->
			<input type='hidden' name='index' id='index' value='${p.index}'>
			<input type='hidden' name='pageStartNum' id='pageStartNum' value='${p.pageStartNum}'>
			<input type='hidden' name='listCnt' id='listCnt' value='${p.listCnt}'>	
			<input type='hidden' name='f_name' id='index' value='${read.f_name}'>
 		</form>
<%--  		<p>${loginUser}</p> --%>
 		<c:if test="${ !empty loginUser}">
			<a href='qna_insert.do?f_name=${read.f_name}'>문의 등록</a>
		</c:if>
		<br/><br/>
	</div>
		
	<!-- 후기 -->	
	<h1>상품후기</h1><br/><br/><br/>
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
				<th>작성자</th>
				<th>삭제</th>
			</tr>
 			<c:forEach var="dto" items="${postScript}">
 				<tr> 
				    <td>${dto.rv_idx}</td> 
  					<%-- <td><a href="content.do?rv_idx=${dto.rv_idx}">${dto.rv_sub}</a></td> --%>  
					<td><a class="toggle_review_sub" href="#tr_head_${dto.rv_idx}"><input class="hdn_rvNum" type="hidden" value="${dto.rv_idx}"><input type="hidden" value="${dto.f_name}">${dto.rv_sub}</a></td> 
					<td>${dto.rv_date}</td>
					<td id="readNum_${dto.rv_idx}">${dto.rv_num}</td>
					<td class="rv_user_name">${dto.user_name}</td>
 					<td><a href="del.do?rv_idx=${dto.rv_idx}">삭제</a></td> 
				</tr>

				<tr class="show_review_tr" id="tr_head_${dto.rv_idx}">
				</tr>
				<tr class="show_review_tr" id="tr_body_${dto.rv_idx}">
				</tr>				
			</c:forEach>
		</table>
	
		<!-- 5. paging view -->	
		<ul class="pagination" id="pagination2">
			<c:if test="${fp.posts_pageStartNum ne 1}">
<!-- 				맨 첫페이지 이동 -->
				<li><a onclick='pagePre2(${fp.posts_pageCnt+1},${fp.posts_pageCnt});'>&laquo;</a></li>
			<!--이전 페이지 이동 -->
<%-- 				<li><a onclick='pagePre(${fp.posts_pageStartNum},${fp.posts_pageCnt});'>&lsaquo;</a></li> --%>
			</c:if>
			
			<!--페이지번호 -->
			<c:forEach var='i' begin="${fp.posts_pageStartNum}" end="${fp.pageLastNum}" step="1">
				<li class='pageIndex2${i}'><a onclick='pageIndex2(${i});'>${i}</a></li>
			</c:forEach>
			
			<c:if test="${fp.lastChk}">
			<!-- 다음 페이지 이동 -->
				<li><a onclick='pageNext2(${fp.posts_pageStartNum},${fp.posts_total},${fp.posts_listCnt},${fp.posts_pageCnt});'>&rsaquo;</a></li>
			<!-- 마지막 페이지 이동 -->
				<li><a onclick='pageLast2(${fp.posts_pageStartNum},${fp.posts_total},${fp.posts_listCnt},${fp.posts_pageCnt});'>&raquo;</a></li>
			</c:if>
	</ul>
 		<form action="content.do#pagination2" method="post" id='frmPaging2'>
 			<!-- 출력할 페이지번호, 출력할 페이지 시작 번호, 출력할 리스트 갯수 -->
			<input type='hidden' name='posts_index' id='posts_index' value='${fp.posts_index}'>
			<input type='hidden' name='posts_pageStartNum' id='posts_pageStartNum' value='${fp.posts_pageStartNum}'>
			<input type='hidden' name='posts_listCnt' id='posts_listCnt' value='${fp.posts_listCnt}'>	
			<input type='hidden' name='f_name' value='${read.f_name}'>
 		</form>
 		<c:if test="${ !empty loginUser}">
			<a href='postScript_write.do?f_name=${read.f_name}'>후기 등록</a>
		</c:if>
		<br/><br/>
	</div>
	
	<script src="../js/custom-list.js"></script>		
</div>
</body>
</html>