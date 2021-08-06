<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="../js/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="../js/paging.js"></script>
<script src="../js/bootstrap.min.js"></script>
<script type="text/javascript" language="javascript" 
		     src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
<link rel="stylesheet" href="../css/bootstrap.min.css">
<link rel="stylesheet" href="../css/bootstrap-theme.min.css">
<style>
.list{
	width: 80%;
	margin: 10px auto;
}
.list_box{
	border: 1px solid black;
	float: left;
	width: 20%;
	box-sizing: border-box;
}
</style>
<script>
	$(document).ready(function(){
		var hdn = $("#cat_hdn_id").val();
		$("#c_"+hdn).attr("selected", "selected");
		var sort_hdn = $("#sort_hdn_id").val();
		$("#s_"+sort_hdn).attr("selected", "selected");
		var search_hdn = $("#search_hdn_id").val();
		$("#food_search").attr("value", search_hdn);
		
		$("#food_search_button").on("click", function(){
			$.ajax({
				url: "search_name.json",
				type: "POST",
				data: {f_name: $("#food_search").val()},
				success: function(data){
					if(!data) return false;
					$("body").html(data);
					$("#frmPaging").attr("action", "search_name");
				}
			});
		});
			
	});
	
	function category(val){
		var category_val = $("#food_type option:selected").val();
		
		if(category_val == "전체"){
		 	$.ajax({
				url: "food_list.do",
				type: "GET",
				success: function(result){
					$("body").html(result);
					$("#frmPaging").attr("action", "list.do");
					$("#all").attr("selected", "selected");
				}
			});		
		}else{
		 	$.ajax({
				url: "category.do",
				type: "GET",
				data: {category : val},
				success: function(result){
					$("body").html(result);
					$("#frmPaging").attr("action", "category.do");
					$("#c_"+val).attr("selected", "selected");
				}
			});			
		}
	}
	
	function sort(val){
		var sort_val = $("#food_sort option:selected").val();
		
		if(sort_val == "new"){
			$.ajax({
				url: "food_list.do",
				type: "GET",
				success: function(result){
					$("body").html(result);
					$("#frmPaging").attr("action", "list.do");
					$("#new").attr("selected", "selected");
				}
			});
		}else if(sort_val == "high"){
			$.ajax({
				url: "price.do",
				type: "GET",
				data: {sort : $("#s_high").val()},
				success: function(result){
					$("body").html(result);
					$("#frmPaging").attr("action", "price.do");
					$("#s_high").attr("selected", "selected");
				}
			});
		}else{
			$.ajax({
				url: "price.do",
				type: "GET",
				data: {sort : $("#s_low").val()},
				success: function(result){
					$("body").html(result);
					$("#frmPaging").attr("action", "price.do");
					$("#s_low").attr("selected", "selected");
				}
			});
		}
	}

	function enterKey(e){
		if(event.keyCode == 13){
			$.ajax({
				url: "search_name.json",
				type: "POST",
				data: {f_name: $("#food_search").val()},
				success: function(data){
					if(!data) return false;
					$("body").html(data);
					$("#frmPaging").attr("action", "search_name");
				}
			});
		}
	}
	
	function cartIntoFunc(val, count){
		console.log(val);
// 		console.log(count);
// 		console.log($("#cartcnt_" + count +""));
// 		console.log($("#cartcnt_" + count +"").find("#count_value_" + count));
		console.log($("#cartcnt_" + count +"").find("#count_value_" + count).text());
		var cartcount = $("#cartcnt_" + count +"").find("#count_value_" + count).text();
		
		$.ajax({
			url:'listCartInsert.do',
			type: 'get',
			data: {cart_count: cartcount,
				f_name : val},
			success: function(result){
				if(result == "true"){
					alert('해당 재료가 담겼습니다');
					location.reload();
				}
				else{
					alert('해당 재료를 담는데 문제가 생김');
					location.reload();
				}

			},
			error: function(err){
				alert('재료 담기 실패');				
			}
		});
	}
	
	//replaceAll prototype 선언
	String.prototype.replaceAll = function(org, dest) {
	    return this.split(org).join(dest);
	}
	
	function minusFunc(val){
			console.log(val);
			var countStr = $('#count_value_' +val).text();
			console.log($('#count_value_' +val));
			console.log(countStr);
			var countNum = parseInt(countStr,10);
			countNum--;
// 			var priceStr = $('#price').text();
// 			var price = parseInt(priceStr,10);
// 			var totalNum = countNum*price;
			
			if(countNum<=0){
				alert('최소 구매수량은 1개 입니다.');
				countNum = 1;
// 				totalNum = ${read.f_price};
			}
			$('#count_value_' + val).text(countNum);
// 			$('#total_price').text(totalNum);
			$('#cart_count_' + val).attr('value', countNum);

	}
	
	function plusFunc(val){
			console.log(val);
			var countStr = $('#count_value_' + val).text();
			console.log($('#count_value_' +val));
			console.log(countStr);
			var countNum = parseInt(countStr,10);
			countNum++;
// 			var priceStr = $('#price').text();
// 			var price = parseInt(priceStr,10);
// 			var totalNum = countNum*price;
			
// 			if(countNum>5){
// 				alert('최대 구매수량은 5개 입니다.');
// 				countNum = 5;
// 			}
			$('#count_value_' + val).text(countNum);
// 			$('#total_price').text(totalNum);
			$('#cart_count_' + val).attr('value', countNum);
	
	}
	

	
</script>
</head>
<body>
<div style="text-align: center">
	<h1>상품 리스트</h1>
	<input id="cat_hdn_id" type="hidden" value="${p.category}">
	<input id="sort_hdn_id" type="hidden" value="${p.sort}">
	<input id="search_hdn_id" type="hidden" value="${p.f_name}">
	
	<select name="food_type" id="food_type" onchange="category(this.value);">
		<option id="all" value="전체">전체</option>
		<option id="c_채소" value="채소">채소</option>
		<option id="c_수산_해산_건어물" value="수산_해산_건어물">수산/해산/건어물</option>
		<option id="c_정육_계란" value="정육_계란">정육/계란</option>
		<option id="c_면_양념_오일" value="면_양념_오일">면/양념/오일</option>
		<option id="c_기타재료" value="기타재료">기타재료</option>
	</select>
	<select name="food_sort" id="food_sort" onchange="sort(this.value);">
		<option id="new" value="new">신상품순</option>
		<option id="s_high" value="high">높은 가격순</option>
		<option id="s_low" value="low">낮은 가격순</option>
	</select>
	<br/>
	
	<input id="food_search" type="search" size="30%" onkeydown="enterKey(this)"/>
	<button id="food_search_button">찾기</button>
	<br/><br/>
	<%
		long count = 1;
		pageContext.setAttribute("count", count);
	%>
	<c:forEach var="dto" items="${list}">
	<div class="list_box">
		<image src="../images/food/${dto.f_type}/${dto.f_img}" width="70%" height="70%"/><br/><br/>
		<a href="content.do?f_name=${dto.f_name}">${dto.f_name}</a><br/>
		<p>${dto.f_price} won</p>
		
		<div id="cartcnt_${count}">
<%-- 			<button id="count_minus_${count}" value="${count}" onclick="minusFunc(this.value)">-</button> --%>
<%-- 			<span id="count_value_${count}">1</span><input type="hidden" name="cart_count" id="cart_count_${count}" value="1"> --%>
<%-- 			<button id="count_plus_${count}"  value="${count}" onclick="plusFunc(this.value)">+</button> --%>
			<c:if test="${! empty loginUser}">
				<button data-toggle="modal" data-target="#modalFood_${count}">장바구니 담기</button>
			</c:if>
			<!-- Button trigger modal -->
<!-- 			<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModalCenter"> -->
<!-- 			  Launch demo modal -->
<!-- 			</button> -->
			
			<!-- Modal -->
			<div class="modal fade" id="modalFood_${count}" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
			  <div class="modal-dialog modal-dialog-centered" role="document">
			    <div class="modal-content">
			      <div class="modal-header">
			        <h5 class="modal-title" id="exampleModalLongTitle">장바구니 담기</h5>
			        <button type="button" class="close" data-dismiss="modal" aria-label="close">
			          <span aria-hidden="true">&times;</span>
			        </button>
			      </div>
			      <div class="modal-body">
			      	<image src="../images/food/${dto.f_type}/${dto.f_img}" width="70%" height="70%"/><br/><br/>
					<span>${dto.f_name}</span><br/>
					<button id="count_minus_${count}" value="${count}" onclick="minusFunc(this.value)">-</button>
					<span id="count_value_${count}">1</span><input type="hidden" name="cart_count" id="cart_count_${count}" value="1">
					<button id="count_plus_${count}"  value="${count}" onclick="plusFunc(this.value)">+</button>
			      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
			        <button type="button" value="${dto.f_name}" class="btn btn-primary" onclick="cartIntoFunc(this.value, ${count})">재료 담기</button>
			      </div>
			    </div>
			  </div>
			</div>
		</div>
	</div>
	<%
		count++;
		pageContext.setAttribute("count", count);
	%>
	</c:forEach>
	<br/><br/><br/><br/><br/>
	
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
<!-- 	<form method="post" id='frmPaging'> -->
	<form method="post" id='frmPaging'>
		<!--출력할 페이지번호, 출력할 페이지 시작 번호, 출력할 리스트 갯수 -->
		<input type='hidden' name='index' id='index' value='${p.index}'>
		<input type='hidden' name='pageStartNum' id='pageStartNum' value='${p.pageStartNum}'>
		<input type='hidden' name='listCnt' id='listCnt' value='${p.listCnt}'>	
<%-- 		<input type='hidden' name='category' id='category' value='${p.category}'> --%>
		<input type='hidden' name='sort' id='sort' value='${p.sort}'>
		<input type='hidden' name='f_name' id='f_name' value='${p.f_name}'>
	</form>
	
</div>
</body>
</html>