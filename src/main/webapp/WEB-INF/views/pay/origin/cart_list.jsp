<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="http://code.jquery.com/jquery-1.10.1.min.js"></script>
<script src="http://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>

</head>
<style>
.a{
	padding: 40px;
}
.b{
	padding: 5px;
}
</style>
<script>
	$(document).ready(function(){
		//전체(n/n) 세팅해놓기 + 전부 체크한 상태로 세팅
		var total_check = $("input:checkbox[name=check_num]").length;
		$("#checkbox_total").text(total_check);
		$("#checkbox_checked").text(total_check);
		$("input:checkbox[name=check_all]").prop("checked", true);
		$("input:checkbox[name=check_num]").prop("checked", true);
		
		//수량*상품금액 & 상품금액 & 결제 예정금액 defalut
		var hid_idx = new Array();
		var total = 0;
		for(var i=0; i<$(".hid_idx").length; i++){
			hid_idx[i] = $(".hid_idx")[i].value;
			var price = $('#price_'+hid_idx[i]).text();
			var num = $('#count_value_'+hid_idx[i]).text();
			var numPrice = price*num;
			$('#num_price_'+hid_idx[i]).text(numPrice);
			$('#cn_hid_'+hid_idx[i]).attr('value', numPrice);
			total += parseInt($('#num_price_'+hid_idx[i]).text(),10);
		}
		$('#total_price').text(total);
		var fee = parseInt($('#fee_price').text(),10);
		var totalPay = total+fee;
		$('#total_pay_price').text(totalPay);
		
		//개별 상품 select box 갯수세기
		$("input:checkbox[name=check_num]").on("click", function(){
			var total_check_checked = $("input:checkbox[name=check_num]:checked").length;
			if($(this).prop("checked")){
				$("#checkbox_checked").text(total_check_checked);
			}else{
				$("#checkbox_checked").text(total_check_checked);
			}
		});
		//잔체 상품 select box 갯수세기
		$("input:checkbox[name=check_all]").on("click", function(){
			if($(this).is(":checked") == true){
				$("input:checkbox[name=check_num]").prop("checked", true);
				var total_check_checked = $("input:checkbox[name=check_num]:checked").length;
				$("#checkbox_checked").text(total_check_checked);
			}else if($(this).is(":checked") == false){
				$("input:checkbox[name=check_num]").prop("checked", false);
				var total_check_checked = $("input:checkbox[name=check_num]:checked").length;
				$("#checkbox_checked").text(total_check_checked);
			}
		});
		
		//form태그 전송	
		$("#order_click").click(function(){
			var cidxarr = [];	//cart_idx
			var farr = [];	//food arr
			var cararr = [];	//cart_count arr
			var fparr = []; 	//f_price arr
			var numparr = [];	//f_numprice(all price) arr
			var f_type = [];	//f_type arr
			var fiarr = [];		//f_img  arr
			
			var count = 0;
			$(".checkClass:checked").each(function(i){
				var id = $(this).parents('tr').attr('id');
				idArr = id.split('_');
				
				console.log($(this).parents('tr').find("#cidxarr_"+idArr[1]).val());
				cidxarr[count] = $(this).parents('tr').find("#cidxarr_"+idArr[1]).val();
				
				console.log($(this).parents('tr').find("#f_"+idArr[1]).text());
				farr[count] = $(this).parents('tr').find("#f_"+idArr[1]).text();
				
				console.log($(this).parents('tr').find("#count_value_"+idArr[1]).text());
				cararr[count] = $(this).parents('tr').find("#count_value_"+idArr[1]).text();

				console.log($(this).parents('tr').find("#price_"+idArr[1]).text());
				fparr[count] = $(this).parents('tr').find("#price_"+idArr[1]).text();
				
				console.log($(this).parents('tr').find("#num_price_"+idArr[1]).text());
				numparr[count] = $(this).parents('tr').find("#num_price_"+idArr[1]).text();
				
				console.log($(this).parents('tr').find("#ftype_"+idArr[1]).val());
				f_type[count] = $(this).parents('tr').find("#ftype_"+idArr[1]).val();
				
				console.log($(this).parents('tr').find("#fimg_"+idArr[1]).val());
				fiarr[count] = $(this).parents('tr').find("#fimg_"+idArr[1]).val();
				
				$("#payment_form").append($('<input/>', {type: 'hidden', name:'cidxarr', value: cidxarr[count]}));
				$("#payment_form").append($('<input/>', {type: 'hidden', name:'farr', value: farr[count]}));
				$("#payment_form").append($('<input/>', {type: 'hidden', name:'cararr', value: cararr[count]}));
				$("#payment_form").append($('<input/>', {type: 'hidden', name:'fparr', value: fparr[count]}));
				$("#payment_form").append($('<input/>', {type: 'hidden', name:'numparr', value: numparr[count]}));
				$("#payment_form").append($('<input/>', {type: 'hidden', name:'f_type', value: f_type[count]}));
				$("#payment_form").append($('<input/>', {type: 'hidden', name:'fiarr', value: fiarr[count]}));
				
				count++;
			});
			console.log(farr);
			console.log(cararr);
			
			console.log($("#payment_form"));
			$("#payment_form")[0].submit();
		});
		
	});
	
	//수량 -- 
	var strArr = new Array();
	function count_minus(id){
		strArr = id.split('_'); //strArr[2] == idx
		//수량
		var countStr = $('#count_value_'+strArr[2]).text();
		var countNum = parseInt(countStr,10);
		countNum--;
		//상품 금액
		var priceStr = $('#price_'+strArr[2]).text();
		var price = parseInt(priceStr,10);
		//배송비 
		var feeStr = $('#fee_price').text();
		var fee = parseInt(feeStr,10);
		//수량*상품금액
		var numPrice = countNum*price;
		
		if(countNum<=0){
 			alert('최소 구매수량은 1개 입니다.');
			countNum = 1;
			numPrice = countNum*price;
			return false;	
		}
		if($('#cn_'+strArr[2]).is(':checked') == true){
			//상품금액 & 결제 예정금액 실시간 변동
			var total = parseInt($('#total_price').text());
			total -= price;
			$('#total_price').text(total);
			var totalPay = parseInt($('#total_pay_price').text());
			totalPay -= price;
			$('#total_pay_price').text(totalPay);
		}
		$('#num_price_'+strArr[2]).text(numPrice);
		$('#count_value_'+strArr[2]).text(countNum);
		$('#cn_hid_'+strArr[2]).attr('value', numPrice);
	}
	//수량 ++
	function count_plus(id){
		strArr = id.split('_'); //strArr[2] == idx
		//수량
		var countStr = $('#count_value_'+strArr[2]).text();
		var countNum = parseInt(countStr,10);
		countNum++;
		//상품 금액
		var priceStr = $('#price_'+strArr[2]).text();
		var price = parseInt(priceStr,10);
		//배송비 
		var feeStr = $('#fee_price').text();
		var fee = parseInt(feeStr,10);
		//수량*상품금액
		var numPrice = countNum*price;
		
		if(countNum>5){
			alert('최대 구매수량은 5개 입니다.');
			countNum = 5;
			numPrice = countNum*price;
			return false;	
		}
		if($('#cn_'+strArr[2]).is(':checked') == true){
			//상품금액 & 결제 예정금액 실시간 변동
			var total = parseInt($('#total_price').text());
			total += price;
			$('#total_price').text(total);
			var totalPay = parseInt($('#total_pay_price').text());
			totalPay += price;
			$('#total_pay_price').text(totalPay);
		}
		$('#num_price_'+strArr[2]).text(numPrice);
		$('#count_value_'+strArr[2]).text(countNum);
		$('#cn_hid_'+strArr[2]).attr('value', numPrice);
	}
	
	//개별삭제
	function del(id){
		strArr = id.split('_');
		
		$.ajax({
			url: "del_each.json",
			type: "POST",
			data: {cart_idx: strArr[1]},
			success: function(){
				//체크박스가 선택이 되어있을 때에만 실시간 값 적용
				if($("input:checkbox[id=cn_"+strArr[1]+"]").is(":checked") == true){
					var countNum = parseInt($('#count_value_'+strArr[1]).text());
					var price = parseInt($('#price_'+strArr[1]).text());
					var numPrice = countNum*price;
					
					var fee = parseInt($('#fee_price').text());
					var total = parseInt($('#total_price').text());
					total -= numPrice;
					
					var totalPay = parseInt($('#total_pay_price').text());
					totalPay -= numPrice;
					
					$('#total_price').text(total);
					$('#total_pay_price').text(totalPay);
				}
				
				//행 제거 후 전체 숫자  (0/n) n값 출력 & 체크박스 갯수 재설정
				$('#tr_'+strArr[1]).remove();
				var len = $("input:checkbox[name=check_num]").length;
				var lenCheck = $("input:checkbox[name=check_num]:checked").length;
				$("#checkbox_total").text(len);
				$("#checkbox_checked").text(lenCheck);
				
				//체크박스 선택된 값이 모두 제거됐을 때 결제 예정금액 0으로 셋팅
				if($("#total_price").text() == 0){
					$("#total_pay_price").text(0);
				}
			}
		});
	}
	//선택삭제
	var cbox = new Array();
	function selectDel(){
		var j = 0;
		for(var i=0; i<$(".checkClass").length; i++){
			if($(".checkClass")[i].checked == true){
				cbox[j] = $(".checkClass")[i].value;
				j++;
			}			
		}
		console.log(cbox);
		$.ajax({
			url: "del_select.do",
			type: "POST",
			data: {cart_idx: cbox},
			traditional: true,
			success: function(){
				for(var i=0; i<cbox.length; i++){
					// 상품금액 & 배송비 & 결제 예정금액 실시간 --
					var countNum = parseInt($('#count_value_'+cbox[i]).text());
	 				var price = parseInt($('#price_'+cbox[i]).text());
	 				var numPrice = countNum*price;
	 				
	 				var fee = parseInt($('#fee_price').text());
	 				var total = parseInt($('#total_price').text());
	 				total -= numPrice;
	 				
	 				var totalPay = parseInt($('#total_pay_price').text());
	 				totalPay -= numPrice;
	 				
	 				$('#total_price').text(total);
					$('#total_pay_price').text(totalPay);
					
					//전체 (0/n) 0값으로 초기화 + n갑 새로 설정
					$('#tr_'+cbox[i]).remove();
					var len = $("input:checkbox[name=check_num]").length;
					$("#checkbox_total").text(len);
					$("#checkbox_checked").text(0);
					$('#total_pay_price').text(0);
				}
			}
		});
	}
	//전부삭제
	function allDel(){
		$.ajax({
			url: "del_all.json",
			type: "POST",
			success: function(){
				$('#total_price').text(0)
				$('#fee_price').text(0);
				$('#total_pay_price').text(0);
				$(".tr").remove();
				
				$("input:checkbox[name=check_all]").prop("checked", false);
				var len = $("input:checkbox[name=check_num]").length;
				var selectlen = $("input:checkbox[name=check_num]:checked").length;
				$("#checkbox_checked").text(selectlen);
				$("#checkbox_total").text(len);
			}
		});
	}
	//개별 체크박스 선택 시 값변동
	function checkBox(){
		if($("input:checkbox[name=check_all]").is(":checked") == true){
			$("input:checkbox[name=check_all]").prop("checked", false);	
		}
		var sum = 0;
		var count = $(".checkClass").length;
		var fee = parseInt($('#fee_price').text());

		for(var i=0; i<count; i++){
			if($(".checkClass")[i].checked == true){
				sum += parseInt($(".checkClass").siblings('.hidcheckClass')[i].value);
			}
		}
		console.log(sum);
		var totalSum = sum+fee;
		$('#total_price').text(sum);
		$('#total_pay_price').text(totalSum);
		if(sum == 0){
			$('#total_pay_price').text(0);
		}
	}
	//전체 체크박스 선택 시 값변동
	function checkBoxAll(){
		if($("input:checkbox[name=check_all]").is(":checked") == true){
		var sum = 0;
		var count = $(".checkClass").length;
		var fee = parseInt($('#fee_price').text());
		
		for(var i=0; i<count; i++){
			sum += parseInt($(".checkClass").siblings('.hidcheckClass')[i].value);
		}
		var totalSum = sum+fee;
		$('#total_price').text(sum);
		$('#total_pay_price').text(totalSum);
		}else if($("input:checkbox[name=check_all]").is(":checked") == false){
			$('#total_price').text(0);
			$('#total_pay_price').text(0);
		}
	}
	//새로고침 방지
	function noReload(){
		if(event.keyCode == 116){
			event.keyCode = 2;
			return false;
		}else if(event.ctrlKey && (event.keyCode == 78 || event.keyCode == 82)){
			return false;
		}
		document.onkeydown = noReload;
	}
	
	/*
	//애증의 json 
	var idArr = new Array();
	function order(){
		var param = [];
		$(".checkClass:checked").each(function(i){
			var id = $(this).parents('tr').attr('id');
			idArr = id.split('_');
			var data = {
				f_name: $(this).parents('tr').find("#f_"+idArr[1]).text(),
				cart_count: $(this).parents('tr').find("#count_value_"+idArr[1]).text(),
				f_price: $(this).parents('tr').find("#price_"+idArr[1]).text(),
				f_numPrice: $(this).parents('tr').find("#num_price_"+idArr[1]).text()
			};
			param.push(data);
		});
		var jsonData = JSON.stringify(param);
		$.ajax({
			url: "order.json",
			type: "POST",
			traditional: true,
			data: {"order": jsonData},
			dataType: "json",
			success: function(data){
				alert(JSON.stringify(data));
				alert("success!");
			},
			error: function(request, status, error){
				alert('error');
				alert("code = " + request.status + " message = " + request.responseText + " error = " + error.message);				
			}
		});
	}
	*/
</script>
<body>
<div style="text-align: center">
	<br/>
	<h1>장바구니</h1>
	<br/><br/><br/>
	
	<table style="border-collapse:collapse; width:80%" align="center">
		<tr>
			<th width="5%"><input type="checkbox" name="check_all" onclick="checkBoxAll()"></th>
			<th width="20%">상품이미지</th>
			<th width="35%" style="text-align:left">상품명</th>
			<th width="10%">수량</th>
			<th width="10%">상품금액</th>
			<th width="15%">수량*상품금액</th>
			<th width="5%">삭제</th>
		</tr>
		<form method="post" action="getPayment.do" id="payment_form" onsubmit="return false">
			<c:forEach var="dto" items="${list}">
				<input class="hid_idx" type="hidden" value="${dto.cart_idx}"/>
				
				<tr style="border:1px solid grey" id="tr_${dto.cart_idx}" class="tr">
					<td>
						<input type="checkbox" name="check_num" id="cn_${dto.cart_idx}" class="checkClass" value="${dto.cart_idx}" onclick="checkBox()">
						<input type="hidden" class="hidcheckClass" id="cn_hid_${dto.cart_idx}">
					</td>
					<td>
						<image src="../images/food/${dto.f_type}/${dto.f_img}" width="100px" height="100px"/>
						<input type="hidden" id="ftype_${dto.cart_idx}" value="${dto.f_type}">
						<input type="hidden" id="fimg_${dto.cart_idx}" value="${dto.f_img}">
						<input type="hidden" id="cidxarr_${dto.cart_idx}" value="${dto.cart_idx}">
					</td>
					<td style="text-align:left" id="f_${dto.cart_idx}">${dto.f_name}</td>
					<td>
						<button id="count_minus_${dto.cart_idx}" onclick="count_minus(this.id)">-</button>&nbsp;
						<span id="count_value_${dto.cart_idx}">${dto.cart_count}</span>&nbsp;
						<button id="count_plus_${dto.cart_idx}" onclick="count_plus(this.id)">+</button>
					</td>
					<td><span id="price_${dto.cart_idx}">${dto.f_price}</span>&nbsp;원</td>
					<td><span id="num_price_${dto.cart_idx}">0</span>&nbsp;원</td>
					<td><button id="del_${dto.cart_idx}" onclick="del(this.id)">X</button></td>
				</tr>
			</c:forEach>
		</form>
		
		<tr>
			<td colspan="1"></td>
			<td colspan="4" style="text-align:left">
				&nbsp;전체 (<span id="checkbox_checked">0</span>/<span id="checkbox_total">0</span>)&nbsp;&nbsp;
				<button onclick="selectDel()">선택삭제</button>&nbsp;
				<button onclick="allDel()">전체삭제</button>
			</td>
		</tr>
	</table>
	<br/><br/><br/>
	
	<table style="border-collapse:collapse" align="center">
		<tr>
			<td class="a" style="border: 1px solid grey">상품금액<br/><span id="total_price">0</span>won</td>
			<td class="b">+</td>
			<td class="a" style="border: 1px solid grey">배송비<br/><span id="fee_price">3000</span>won</td>
			<td class="b">=</td>
			<td class="a" style="border: 1px solid grey">결제 예정금액<br/><span id="total_pay_price">0</span>won</td>
		</tr>
	</table>
	<br/><br/>
	
	<button id="order_click">주문하기</button>
	
</div>
</body>
</html>