<%@page import="oc.md.vo.FoodCartVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	 <script src="http://code.jquery.com/jquery-1.12.4.min.js" ></script>
	  <script
    src="https://code.jquery.com/jquery-3.3.1.min.js"
    integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
    crossorigin="anonymous"></script><!-- jQuery CDN --->
    
    <script src="http://service.iamport.kr/js/iamport.payment-1.1.5.js"></script>
   	<script type="text/JavaScript" src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
    <script src="../js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="../css/bootstrap.min.css">
	<link rel="stylesheet" href="../css/bootstrap-theme.min.css">
	
	<script>
	$(document).ready(function(){
		//초기 최종 주문값 세팅
		$("#final_price")[0].innerText = parseInt($("#order_food_won")[0].innerText) + parseInt($("#delivery_price")[0].innerText);
		var init_p = $("#final_price")[0].innerText;
		$("#init_all_price").val(init_p);
		//초기 주소값
		var origin_addr_id = $("#origin_addr_id")[0].value;
		console.log(origin_addr_id);
		
		var fdList = new Array();
		var fCountList = new Array();
		
		//자바스크립트에서 jstl태그를 사용가능한듯
		<c:forEach items="${query}" var="fitem">
			fdList.push("${fitem.value.f_name}");	//배열에 결제한 음식의 재료의 종류를 파악
			fCountList.push("${fitem.value.cart_count}");
		</c:forEach>
		
		console.log(fdList);
		console.log(fdList.length);
		console.log(fCountList);
		
		//결제하려는 재료의 개수가 여러개인지 한개인지 파악
		var import_sale_name = "";
		if(fdList.length == 1){
			import_sale_name = fdList[0];
		}
		else{
			import_sale_name = fdList[0] + "외 " + (fdList.length-1) + " 개";
		}
		
		$("#import_payment_ok").click(function(){
			var point_input_val = $("#point_input").val();

			var IMP = window.IMP; // 생략가능
			IMP.init('imp50979802'); 
// 			console.log(IMP);
			console.log($("#final_price")[0].innerText);
			console.log($("#user_email_id")[0].value);
			console.log($("#send_email_id")[0].innerText);
			console.log($("#user_name_id")[0].innerText);
			console.log($("#user_phone_id")[0].innerText);
			console.log($("#origin_addr_id")[0].value);
			
			
			IMP.request_pay({
			    pg : 'inicis', // version 1.1.0부터 지원.	 (inicis : 이니시스 activeX 결제창)
// // 			    pay_method : 'card',
			    merchant_uid : $("#user_email_id")[0].value + "_" + new Date().getTime(),	//주문번호생성 (문자 + 결제날짜) 
			    //구매한유저의 아이디 + 결제날자로 설정함
			    name : import_sale_name,	//결제한  주문의 명칭
			    amount : $("#final_price")[0].innerText,			// 결제 가격
			    buyer_email : $("#send_email_id")[0].innerText,	//구매자 이메일
			    buyer_name : $("#user_name_id")[0].value,				//구매자 이름
			    buyer_tel : $("#user_phone_id")[0].innerText,		//구매자 전화번호
			    buyer_addr : $("#origin_addr_id")[0].value	//구매자 주소
//	 		    buyer_postcode : '123-456',			//구매자 우편번호
//	 		    m_redirect_url : 'https://www.yourdomain.com/payments/complete'
			    // m_redirect_url : 모바일 결제시, 결제가 끝나고 랜딩되는 URL을 지정 (카카오페이, 페이코, 다날의 경우는 필요없음. PC와 마찬가지로 callback함수로 결과가 떨어짐)
			}, function(rsp) {
			    if ( rsp.success ) {
			        var msg = '결제가 완료되었습니다.';
			        msg += '고유ID : ' + rsp.imp_uid;
			        //imp_uid : 아임포트에서 부여하는 거래건 당 고유한 번호(success:false일 때, 사전 validation에 실패한 경우라면 imp_uid는 null일 수 있음)
			        msg += '상점 거래ID : ' + rsp.merchant_uid;		//가맹점에서 생성/관리하는 고유 주문번호
			        msg += '결제 금액 : ' + rsp.paid_amount;		//결제금액
			        msg += '결제 수단 : ' + rsp.pay_method;			//결제수단 : card, trans(실시간계좌이체), vbank(가상계좌)...
			        msg += '결제승인시각' + rsp.paid_at;
			        msg += '카드 승인번호 : ' + rsp.apply_num;		//카드사 승인번호 , 신용카드결제에 한하여 제공
			        // 필요한 정보를 JSON화 시키기
			        var timeStamp = rsp.paid_at * 1000;
			        var changeTime = new  Date(timeStamp);
			        
			        var obj = new Object();
			        var objArray = new Array();
			        var subObj = new Object();
			        obj.order_idx = rsp.imp_uid;
			        obj.email = $("#user_email_id").val();
			        obj.pay_date = changeTime;
			        obj.pay_price = rsp.paid_amount;
			        obj.pay_type = rsp.pay_method;
			        if(point_input_val == 0){	//포인트 사용에 값이 없으면 빈값
			        	obj.sale_type = "";
			        }
			        else{	//포인트 사용이 있으면 point로 설정
			        	obj.sale_type = "point";
			        }
			        obj.order_price = $("#delivery_price")[0].innerText;
			        obj.use_point = $("#point_input").val();
			        obj.order_state = 1; 	//주문 상태(주문 취소 : 0 / 주문 완료 : 1) , 주문 성공시 주문 완료 상태이기 때문
			        obj.order_addr = rsp.buyer_addr;
			        for(var i=0; i<fdList.length; i++){
			        	subObj.f_name = fdList[i];
			        	subObj.cart_count = fCountList[i];
			        	objArray.push(subObj);
			        	subObj = {};
			        }
			        obj.food = objArray;
			        var jsonData = JSON.stringify(obj);
			        console.log(jsonData);
				    console.log("rsp 확인 : " + JSON.stringify(rsp));
				    console.log(msg);
				    
				    $.ajax({
				    	url: "paymentOk.do",
				    	type: "POST",
				    	contentType: 'application/json',
// 						contentType: "application/x-www-form-urlencoded; charset=UTF-8",
				    	dataType: 'json',
				    	data: jsonData,
				    	success: function(result){
								if(result == null){
									alert('결제가 실패 되었습니다.');
								}
								else if(result.order_state == "상품의 재고 수량이 부족합니다."){
									alert('상품의 재고 수량이 부족합니다.');
									return false;
								}
								alert("결제가 완료되었습니다.");
// 								location.href="../";	//결제완료 페이지로 이동
								console.log(result);
								console.log(JSON.stringify(result));
								console.log(JSON.stringify(result).order_idx);
								console.log(result.order_idx);
								location.href ="paymentResult.do?order_idx=" + result.order_idx;

				    	},
						error:function(request,status,error){
							console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
						}
				    });
				    
				    
			    } else {
			        var msg = '결제에 실패하였습니다.';
			        msg += '에러내용 : ' + rsp.error_msg;	
			        alert(msg);
				    console.log("rsp 확인 : " + JSON.stringify(rsp));
				    console.log(msg);
			    }

			    
			});
		});
		
		$("#change_addr_div").css("display", "none");
		
		$("#addr_change_id").click(function(){
			$("#change_addr_div").toggle("slow");
				
		});
		// 변경된 주소 적용
		$("#addr_commit").click(function(){
			console.log($("#change_addr_div"));
			console.log($("#change_addr_div")[0].childNodes[13].value);
			
			if($("#change_addr_div")[0].childNodes[11].value == "" || $("#change_addr_div")[0].childNodes[13].value == ""){
				alert("변경할 주소를 모두 입력해주세요.");	
			}
			else{
				var addr1 = $("#change_addr_div")[0].childNodes[11].value;
				var addr2 = $("#change_addr_div")[0].childNodes[13].value;
				$("#origin_addr_id").val(addr1 + " " + addr2);	
			}

		});
		// 기본 주소 적용
		$("#origin_addr_commit").click(function(){
			console.log(origin_addr_id);
			$("#origin_addr_id")[0].value = origin_addr_id;
		});

	});
	
	function cancelPay() {
		console.log('환불');
	      jQuery.ajax({
	        "url": "http://www.myservice.com/payments/cancel",
	        "type": "POST",
	        "contentType": "application/json",
	        "data": JSON.stringify({
	          "merchant_uid": "sonyjun7@naver.com_1598548345984", // 주문번호
	          "cancel_request_amount": 5590, // 환불금액
	          "reason": "테스트 결제 환불" ,// 환불사유
	          "refund_holder": "홍길동", // [가상계좌 환불시 필수입력] 환불 수령계좌 예금주

// 	          "refund_account": "56211105948400" // [가상계좌 환불시 필수입력] 환불 수령계좌 번호
	        }),
	        "dataType": "json"
	      });
	    }
	
	function openDaumZipAddress() {
		new daum.Postcode({
			oncomplete:function(data) {
				//jQuery("#postcode1").val(data.postcode1);
				//jQuery("#postcode2").val(data.postcode2);
				jQuery("#zonecode").val(data.zonecode);
				jQuery("#address").val(data.address);
				jQuery("#address_etc").focus();
				address_var = data;
				console.log(data);
			}
		}).open();
	}
	
	
	function pointAdd(val){
		var user_point = $("#user_point_id")[0].innerText;

		if(parseInt(user_point) < parseInt(val)){
			alert('사용가능한 포인트를 초과 하였습니다.');
			console.log($("#init_all_price")[0]);
			var order_price_init = $("#origin_food_won")[0].attributes[1].value;	//초기값으로 변경
			$("#order_food_won")[0].innerText = order_price_init;
			$("#point_input").val("0");
			$("#final_price")[0].innerText = $("#init_all_price")[0].value;
			return false;
		}
		else if(val < 0){
			alert('0 미만의 값 입력 불가');
			var order_price_init = $("#origin_food_won")[0].attributes[1].value;	//초기값으로 변경
			$("#order_food_won")[0].innerText = order_price_init;
			$("#point_input").val("0");
			$("#final_price")[0].innerText = $("#init_all_price")[0].value;
			return false;
		}
		else if($.isNumeric(val) == false){
			alert('숫자를 입력해주세요');
			var order_price_init = $("#origin_food_won")[0].attributes[1].value;	//초기값으로 변경
			$("#order_food_won")[0].innerText = order_price_init;
			$("#point_input").val("0");
			$("#final_price")[0].innerText = $("#init_all_price")[0].value;
			return false;
		}
		else{
			console.log(val);
//	 		$("#point_input").val(val);
			console.log($("#origin_food_won"));
			var order_price = $("#origin_food_won")[0].innerText - val;
			console.log(order_price);
			$("#order_food_won").text(order_price);	
			$("#final_price")[0].innerText = parseInt($("#order_food_won")[0].innerText) + parseInt($("#delivery_price")[0].innerText);
		}
	
	}
	</script>
	</head>
	<body style="text-align:center">
		<h1>결제창</h1>
		<h3>주문하실 상품명 및 수량을 정확하게 확인해 주세요</h3>
		<br/>
		
		<h4>------- 상품정보 -------</h4>
		<table class="table table-hover">
			<tr>
				<th>이미지</th>
				<th>상품 정보</th>
				<th>상품수량</th>
				<th>원 상품금액</th>
				<th>총상품금액</th>
			</tr>
			<%
				long all_price = 0;
				pageContext.setAttribute("sum", all_price);
			%>
			<c:forEach  var="dto" items="${query}">
<%-- 				<p>${dto.value.f_name}</p> --%>
			<tr>
				<td><img src="../resources/images/food/${dto.value.f_type}/${dto.value.f_img}" width="100px"></td>
				<td>${dto.value.f_name}</td>
				<td>${dto.value.cart_count}</td>
				<td>${dto.value.f_price} 원</td>
				<td>${dto.value.f_price*dto.value.cart_count} 원</td>
				<c:set var = "balance" value = "${dto.value.f_price*dto.value.cart_count}" />
				<fmt:parseNumber var = "valval" type = "number" value = "${balance}" />

   				<c:set var="all" value="${sum = sum + dto.value.f_price*dto.value.cart_count}"/>
<%--    				<c:out value="${all}"/> --%>
<%-- 				<fmt:parseNumber type="number" value="{dto.value.f_price*dto.value.cart_count}"/> --%>
<%-- 				<input type="hidden" value="${all_price += (dto.value.f_price*dto.value.cart_count)}"> --%>
				<input type="hidden" value="${all}" >
			</tr>
			</c:forEach>

		</table>
		
		<h4>------- 주문자정보 -------</h4>
		<h5><b>보내는 분*</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span id="user_name_id">${loginUser.user_name}</span></h5>
		<h5><b>휴대폰*</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span id="user_phone_id">${loginUser.phone}</span></h5>
		<c:choose>
		<c:when test="${empty loginUser.kakao_email}"> 
			<h5><b>이메일*</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span id="send_email_id">${loginUser.email}</span></h5>
			<input type="hidden" id="user_email_id" value="${loginUser.email}" />
		</c:when>
		<c:when test="${!empty loginUser.kakao_email }">
			<h5><b>카카오메일*</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span id="send_email_id">${loginUser.kakao_email}</span>(카카오)</h5>
			<input type="hidden" id="user_email_id" value="${loginUser.email}" />
		</c:when>
		</c:choose>
		<h5><b>보유포인트</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span id="user_point_id">${loginUser.point}</span></h5>
		<br/>
		
		<h4>------- 배송 정보 -------</h4>
		<h5>기존 배송지&nbsp;&nbsp;<input type="text" id="origin_addr_id" name="order_addr" value="${loginUser.addr}" disabled="" size="70"></h5>
		<br/>
		<input type="button" id="addr_change_id" value="주소 변경하기" >
		
		<div id="change_addr_div">
			<input type="button" onClick="openDaumZipAddress();" value = "주소  검색" />
			<input id="zonecode" type="text" value="" style="width:50px;" readonly/>
			&nbsp;
			<button id="addr_commit">변경된 주소 적용</button>
			<button id="origin_addr_commit">기존 주소 사용</button>
			<br/>
			<input type="text" id="address" name="addr_no1" value="" style="width:240px;" readonly/>
			<input type="text" id="address_etc" name="addr_no2" value="" style="width:200px;"/>	   
		</div>
 
		<br/>
		<h4>------- 결제 금액 -------</h4>
		<h5>+ 주문 금액 : &nbsp;&nbsp;&nbsp; <span id="order_food_won">${all}</span> 원</h5>
		<h5> -> 상품 금액 : &nbsp;&nbsp;&nbsp; <span id="origin_food_won" value="${all}">${all}</span> 원</h5>
		<h5> -> 포인트 할인 : &nbsp;&nbsp;&nbsp;- <input type="text" id="point_input" value="0" onchange="pointAdd(this.value)">원</h5>
		<p>최대 사용 가능한 포인트 금액 --> ${loginUser.point} 원</p>
		<h5>+ 배송비 : &nbsp;&nbsp;&nbsp; <span id="delivery_price">3000</span> 원</h5>
		<h4>최종 결제 금액 : &nbsp;&nbsp;&nbsp; <span id="final_price"></span> 원</h4>
		<input type="hidden" id="init_all_price" value="">
		
		<c:set var = "point_add_val" value = "${all*0.05}" />
		<fmt:parseNumber var = "point_int" type = "number" integerOnly= "true" value = "${point_add_val}" />
		<h5>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 구매 시<span>${point_int}</span>원 적립 (5%)</h5>
		<br/>
		<button id="import_payment_ok" type="button">결제하기</button>
		
		 <button onclick="cancelPay()">환불하기</button>
	
	</body>
</html>