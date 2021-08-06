<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="../js/jquery-3.1.1.min.js"></script>
<script src="../js/bootstrap.min.js"></script>
<link rel="stylesheet" href="../css/bootstrap.min.css">

<!-- 4. Javascript -->
<script type="text/javascript" src="../js/paging.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<script>
	$(document).ready(function(){
		var s_hdn = $("#s_hdn_id").val();
		$("#s_"+s_hdn).attr("selected", "selected");
		//카테고리 선택 시 버튼 고정
		if(s_hdn == "결제완료"){
			$("#allDelivery").attr("type", "button");
		}else if(s_hdn == "환불요청중"){
			$("#allRefund").attr("type", "button");
		}
	});
	
	//카테고리
	function select(val){
		var select_val = $("#selectBox option:selected").val();
		
		if(select_val == "all"){
		 	$.ajax({
				url: "order_check.do",
				type: "GET",
				success: function(data){
					$("body").html(data);
					$("#frmPaging").attr("action", "order_check.do");
					$("#all").attr("selected", "selected");
				}
			});		
		}else{
		 	$.ajax({
				url: "order_check_select.do",
				type: "GET",
				data: {select : val},
				success: function(data){
					$("body").html(data);
					$("#frmPaging").attr("action", "order_check_select.do");
					$("#s_"+val).attr("selected", "selected");
					if(val == "결제완료"){
						$("#allDelivery").attr("type", "button");
					}else if(val == "환불요청중"){
						$("#allRefund").attr("type", "button");
					}
				}
			});			
		}
	}
	
	//개별배송
	function pay(id){
		$.ajax({
			url: "order_check_delivery.do",
			type: "GET",
			data: {delivery_idx : id},
			success: function(data){
				document.getElementById("state_"+id).innerHTML = "배송중";
				document.getElementById("num_"+id).innerHTML = data;
				$("#"+id).attr("type", "hidden");
			}
		});	
	}
	//개별환불
	function refund(id){
		$.ajax({
			url: "order_check_refund.do",
			type: "GET",
			data: {delivery_idx : id},
			success: function(){
				document.getElementById("state_"+id).innerHTML = "환불완료";
				$("#"+id).attr("type", "hidden");
			}
		});	
	}
	
	var idArr = new Array();
	var idAll = new Array();
	$(".tr").each(function(){
		var state = $(this).children(".td").attr('id');
		idArr = state.split('_');
		idAll.push(idArr[1]);
	});
	//일괄배송
	function allDeli(){
		for(i=0; i<idAll.length; i++){
			(function(i){
				$.ajax({
					url: "order_check_delivery.do",
					type: "GET",
					data: {delivery_idx : idAll[i]},
					success: function(data){
						document.getElementById("state_"+idAll[i]).innerHTML = "배송중";
						document.getElementById("num_"+idAll[i]).innerHTML = data;
						$("#"+idAll[i]).attr("type", "hidden");
					}
				});
			})(i);
		}
	}
	//일괄환불
	function allRe(){
		for(i=0; i<idAll.length; i++){
			(function(i){
				$.ajax({
					url: "order_check_refund.do",
					type: "GET",
					data: {delivery_idx : idAll[i]},
					success: function(){
						document.getElementById("state_"+idAll[i]).innerHTML = "환불완료";
						$("#"+idAll[i]).attr("type", "hidden");
					}
				});	
			})(i);
		}
	}
</script>

</head>
<body>
<div style="text-align: center">
	<h1>배송</h1>
	<input id="s_hdn_id" type="hidden" value="${p.select}">
	
	<select id="selectBox" onchange="select(this.value);">
		<option id="all" value="all">전체</option>
		<option id="s_결제완료" value="결제완료">결제완료</option>
		<option id="s_배송중" value="배송중">배송중</option>
		<option id="s_배송완료" value="배송완료">배송완료</option>
		<option id="s_환불요청중" value="환불요청중">환불요청중</option>
		<option id="s_환불완료" value="환불완료">환불완료</option>
	</select>
	<br/><br/>
	
	<input type="hidden" id="allDelivery" value="일괄배송" onclick="allDeli()">
	<input type="hidden" id="allRefund" value="일괄환불" onclick="allRe()">
	<br/><br/>
	
	<div class="container">
		<table class="table table-bordered">
			<tr>
				<th>주문번호</th>
				<th>주문일자</th>
				<th>유저이름</th>
				<th>주문상태</th>
				<th>배송번호</th>
				<th>버튼</th>
			</tr>
			<c:forEach var="od" items="${list}">
	 			<tr bgcolor="#f5eedc" class="tr">

	  			 	<td>${od.order_idx}</td>
	  			 	<td>${od.order_date}</td>
	  			 	<td>${od.email}</td>
					<td class="td" id="state_${od.delivery_idx}">${od.delivery_state}</td>
					<c:choose>
						<c:when test="${od.delivery_num eq 0}">
							<td id="num_${od.delivery_idx}">-</td>
						</c:when>
						<c:otherwise>
							<td id="num_${od.delivery_idx}">${od.delivery_num}</td>	
						</c:otherwise>
					</c:choose>
					
					<c:choose>
						<c:when test="${od.delivery_state eq '결제완료'}">
							<td><input type="button" id="${od.delivery_idx}" onclick="pay(this.id)" value="배송하기"></td>
						</c:when>
						<c:when test="${od.delivery_state eq '환불요청중'}">
							<td><input type="button" id="${od.delivery_idx}" onclick="refund(this.id)" value="환불하기"></td>
						</c:when>
						
						<c:otherwise>
							<td></td>	
						</c:otherwise>
					</c:choose>
				</tr>
			</c:forEach>
		</table>
		<br/>
		
		<!-- 5. paging view	 -->
		<ul class="pagination">
			<c:if test="${p.pageStartNum ne 1}">
				<!-- 맨 첫페이지 이동 -->
				<li><a onclick='pagePre(${p.pageCnt+1},${p.pageCnt});'>&laquo;</a></li>
				<!-- 이전 페이지 이동 -->
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
		
 		<form method="post" id='frmPaging'>
 			<!-- 출력할 페이지번호, 출력할 페이지 시작 번호, 출력할 리스트 갯수 -->
			<input type='hidden' name='index' id='index' value='${p.index}'>
			<input type='hidden' name='pageStartNum' id='pageStartNum' value='${p.pageStartNum}'>
			<input type='hidden' name='listCnt' id='listCnt' value='${p.listCnt}'>
			<input type='hidden' name='select' id='select' value='${p.select}'>
 		</form>
	</div>
</div>
</body>
</html>