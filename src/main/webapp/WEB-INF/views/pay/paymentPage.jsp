<%@page import="oc.md.vo.FoodCartVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko" dir="ltr">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<%@ include file="../common/head_link.jsp"%>

<style>
#food_tit_img_id {
	padding: 8% 3% 3% 3%;
}

#pay_title {
	margin-bottom: 3%;
	text-align: left;
}

#change_addr_div {
	clear: both;
}

.yellow_btn {
	background: rgba(255, 219, 79, 0.9) !important;
	color: rgba(17, 17, 17, 0.8);
}

.yellow_btn:hover, .yellow_btn:focus {
	background: rgba(255, 219, 79, 0.5) !important;
	color: rgba(17, 17, 17, 0.5);
}

.ym-text {
	background-color: rgb(245, 245, 245);
	padding: 5px 15px;
}
input[type="text"]:focus {
	border-color: rgb(111, 186, 44);
	box-shadow: 0 0 8px 0 rgb(111, 186, 44);
}
</style>
<!--  
    Document Title
    =============================================
    -->

<title>ONECOOK: PayPage</title>

</head>
<body data-spy="scroll" data-target=".onpage-navigation"
	data-offset="60">
	<main>
		<div class="page-loader">
			<div class="loader">Loading...</div>
		</div>

		<%@ include file="../common/header.jsp"%>

		<div class="main">
			<section id="food_tit_img_id"
				class="module bg-dark-60 shop-page-header"
				data-background="../assets/images/showcase_bg.jpg">
				<div class="container">
					<div class="row">
						<div class="col-sm-6 col-sm-offset-3">
							<h2 class="module-title font-alt">주문서</h2>
							<div class="module-subtitle">
								신선한 상품들이 집으로 배송될 생각을 하니, 벌써부터 떨리네요!<br />어서 주문을 해볼까요?
							</div>
						</div>
					</div>
				</div>
			</section>

			<section class="module-small">
				<div class="container">
					<div class="row">
						<div class="col-sm-8">
							<!-- 상품정보 영역 -->
							<div class="comments">
								<h5 class="comment-title font-alt" id="pay_title"
									style="color: rgb(111, 186, 44);">
									<b>상품정보</b>
								</h5>
								<table class="table table-hover">
									<tr>
										<th class="col-sm-2" style="text-align: center;">Image</th>
										<th class="col-sm-5">Name</th>
										<th class="col-sm-1" style="text-align: center;">Count</th>
										<th class="col-sm-2" style="text-align: center;">Price</th>
										<th class="col-sm-2" style="text-align: center;">Total</th>
									</tr>
									<%
										long all_price = 0;
										pageContext.setAttribute("sum", all_price);
									%>
									<c:forEach var="dto" items="${query}">
										<%-- 				<p>${dto.value.f_name}</p> --%>
										<tr>
											<td style="text-align: center;"><img
												src="../resources/images/food/${dto.value.f_type}/${dto.value.f_img}"
												width="100px"></td>
											<td>${dto.value.f_name}</td>
											<td style="text-align: center;">${dto.value.cart_count}</td>
											<td style="text-align: center;">${dto.value.f_price}
												&#8361;</td>
											<td style="text-align: center;">${dto.value.f_price*dto.value.cart_count}
												&#8361;</td>
											<c:set var="balance"
												value="${dto.value.f_price*dto.value.cart_count}" />
											<fmt:parseNumber var="valval" type="number"
												value="${balance}" />

											<c:set var="all"
												value="${sum = sum + dto.value.f_price*dto.value.cart_count}" />
											<%--    				<c:out value="${all}"/> --%>
											<%-- 				<fmt:parseNumber type="number" value="{dto.value.f_price*dto.value.cart_count}"/> --%>
											<%-- 				<input type="hidden" value="${all_price += (dto.value.f_price*dto.value.cart_count)}"> --%>
											<input type="hidden" value="${all}">
										</tr>
									</c:forEach>

								</table>
							</div>

							<!-- 주문자 정보 영역 -->


							<div class="comments">
								<h5 class="comment-title font-alt" id="pay_title"
									style="color: rgb(111, 186, 44);">
									<b>주문자 정보</b>
								</h5>
								<div class="row">
									<div class="col-sm-2">
										<div class="form-group">
											<p>
												<b>주문자명&nbsp;*</b>
											</p>
										</div>
									</div>
									<div class="col-sm-10">
										<div class="form-group">
											<p class="ym-text">
												<span id="user_name_id">${loginUser.user_name}</span>
											</p>
										</div>
									</div>

									<div class="col-sm-2">
										<div class="form-group">
											<p>
												<b>연락처&nbsp;*</b>
											</p>
										</div>
									</div>
									<div class="col-sm-10">
										<div class="form-group">
											<p class="ym-text">
												<span id="user_phone_id">${loginUser.phone}</span>
											</p>
										</div>
									</div>

									<c:choose>
										<c:when test="${empty loginUser.kakao_email}">

											<div class="col-sm-2">
												<div class="form-group">
													<p>
														<b>E-mail&nbsp;*</b>
													</p>
												</div>
											</div>
											<div class="col-sm-10">
												<div class="form-group">
													<p id="send_email_id" class="ym-text">${loginUser.email}</p>
													<input type="hidden" id="user_email_id"
														value="${loginUser.email}" />
												</div>
											</div>

										</c:when>
										<c:when test="${!empty loginUser.kakao_email }">

											<div class="col-sm-2">
												<div class="form-group">
													<p>
														<b>Kakao-mail&nbsp;*</b>
													</p>
												</div>
											</div>
											<div class="col-sm-10">
												<div class="form-group">
													<p id="send_email_id" class="ym-text">${loginUser.kakao_email}</p>
													<input type="hidden" id="user_email_id"
														value="${loginUser.email}" />
												</div>
											</div>

										</c:when>
									</c:choose>
								</div>
							</div>



							<!--배송정보 영역 -->


							<div class="comments">
								<h5 class="comment-title font-alt" id="pay_title"
									style="color: rgb(111, 186, 44);">
									<b>배송정보</b>
								</h5>
								<div class="row">
									<div class="col-sm-2">
										<div class="form-group">
											<p>
												<b>기존 배송지&nbsp;*</b>
											</p>
										</div>
									</div>
									<div class="col-sm-7">
										<div class="form-group">
											<input type="text" id="origin_addr_id" class="form-control"
												name="order_addr" value="${loginUser.addr}" disabled=""
												size="70">
										</div>
									</div>
									<div class="col-sm-3">
										<div class="form-group">
											<input type="button" id="addr_change_id"
												class="yellow_btn btn btn-d btn-round btn-block"
												value="주소변경" style="color: black;">
										</div>
									</div>
								</div>
							</div>

							<div class="comment-form" id="change_addr_div"
								style="margin: 0px;">
								<div class="row">
									<div class="col-sm-2 col-sm-offset-2">
										<div class="form-group">
											<button class="btn btn-g btn-round"
												onClick="openDaumZipAddress();">찾기</button>
										</div>
									</div>

									<div class="col-sm-3">
										<div class="form-group">
											<input id="zonecode" class="form-control" type="text"
												value="" readonly />
										</div>
									</div>
									<div class="col-sm-2">
										<div class="form-group">
											<input type="button" id="addr_commit"
												class="btn btn-g btn-round" style="width: 100%;" value="변경">
											</button>
										</div>
									</div>
									<div class="col-sm-3">
										<div class="form-group">
											<input type="button" id="origin_addr_commit"
												class="btn btn-g btn-round" style="width: 100%;"
												value="되돌리기">
											</button>
										</div>
									</div>

									<div class="col-sm-6 col-sm-offset-2">
										<div class="form-group">
											<input type="text" id="address" class="form-control"
												name="addr_no1" value="" readonly />
										</div>
									</div>
									<div class="col-sm-4">
										<div class="form-group">
											<input type="text" id="address_etc" class="form-control"
												name="addr_no2" value="" />
										</div>
									</div>
								</div>
							</div>
						</div>

						<div class="col-sm-3 col-sm-offset-1"
							style="background: rgba(111, 186, 44, 0.1);">
							<!--결제금액 확인 영역 -->


							<div class="comments">
								<h5 class="comment-title font-alt" id="pay_title"
									style="color: rgb(111, 186, 44);">
									<b>결제확인</b>
								</h5>
								<div class="row mb-20">
									<div class="col-sm-12">
										<div class="form-group">
											<span><i class="fas fa-plus-circle"></i>&nbsp;&nbsp;&nbsp;<b>결제금액</b></span>
										</div>
									</div>
									<div class="col-sm-12">
										<div class="form-group">
											<p class="ym-text" style="background: white;">
												<span id="order_food_won">${all}</span>&nbsp;&#8361;
											</p>
										</div>
									</div>



									<div class="col-sm-12">
										<div class="form-group">
											<span><i class="fas fa-minus-circle"></i>&nbsp;&nbsp;&nbsp;<b>포인트
													할인</b></span>
										</div>
									</div>
									<div class="col-sm-12">
										<div class="form-group">
											<p>
												<input type="text" id="point_input" value="0"
													onchange="pointAdd(this.value)"
													style="background: rgb(245, 245, 245); width: 100%;">
											</p>
										</div>
									</div>

									<div class="col-sm-12">
										<div class="form-group">
											<span><i class="fas fa-exclamation-circle"></i>&nbsp;&nbsp;&nbsp;<b>가능
													포인트</b></span>
										</div>
									</div>
									<div class="col-sm-12">
										<div class="form-group">
											<p class="ym-text" style="background: white;">
												<span id="user_point_id">${loginUser.point}</span>&nbsp;point
											</p>
										</div>
									</div>



									<div class="col-sm-12">
										<div class="form-group">
											<span><i class="fas fa-plus-circle"></i>&nbsp;&nbsp;&nbsp;<b>배송비</b></span>
										</div>
									</div>
									<div class="col-sm-12">
										<div class="form-group">
											<p class="ym-text" style="background: white;">
												<span id="delivery_price">3000</span>&nbsp;&#8361;
											</p>
										</div>
									</div>


									<div class="col-sm-12">
										<div class="form-group">
											<span style="font-size: 15px;"><i
												class="fas fa-check-circle"
												style="color: rgb(111, 186, 44);"></i>&nbsp;&nbsp;&nbsp;<b>총
													결제금액</b></span>
										</div>
									</div>
									<div class="col-sm-12">
										<div class="form-group">
											<span id="final_price" style="font-size: 15px;"></span>&nbsp;&#8361;<br />
											<input type="hidden" id="init_all_price" value="">
											<c:set var="point_add_val" value="${all*0.05}" />
											<fmt:parseNumber var="point_int" type="number"
												integerOnly="true" value="${point_add_val}" />
											<span style="color: rgb(111, 186, 44);">구매 시
												${point_int}&#8361; 적립 (5%)</span>
										</div>
									</div>
								</div>
							</div>





							<div class="row mb-80">
								<div class="col-sm-12">
									<div class="form-group">
										<button id="import_payment_ok"
											class="yellow_btn btn btn-d btn-round btn-block"
											type="button" style="color: black;">결제하기</button>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</section>
		</div>

		<%@ include file="../common/footer.jsp"%>

		<hr class="divider-d">

		</div>
		<div class="scroll-up">
			<a href="#totop"><i class="fa fa-angle-double-up"></i></a>
		</div>
	</main>

	<%@ include file="../common/js_link.jsp"%>

	<script src="http://service.iamport.kr/js/iamport.payment-1.1.5.js"></script>
	<script type="text/JavaScript"
		src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>

	<script>
		$(document)
				.ready(
						function() {
							//초기 주소값
							var origin_addr_id = $("#origin_addr_id")[0].value;
							console.log(origin_addr_id);

							$("#change_addr_div").css("display", "none");

							$("#addr_change_id").click(function() {
								console.log('asdasd');
								$("#change_addr_div").toggle("slow");

							});

							// 변경된 주소 적용
							$("#addr_commit")
									.click(
											function() {
												console
														.log($("#change_addr_div"));
												// 			console.log($("#change_addr_div")[0].childNodes[13].value);
												console
														.log($(
																"#change_addr_div")
																.find(
																		"#address")
																.val());

												if ($("#change_addr_div").find(
														"#address").val() == ""
														|| $("#change_addr_div")
																.find(
																		"#address_etc")
																.val() == "") {
													// 				alert("변경할 주소를 모두 입력해주세요.");
													swal("변경할 주소를 모두 입력해주세요.");
												} else {
													var addr1 = $(
															"#change_addr_div")
															.find("#address")
															.val();
													var addr2 = $(
															"#change_addr_div")
															.find(
																	"#address_etc")
															.val();
													$("#origin_addr_id")
															.val(
																	addr1
																			+ " "
																			+ addr2);
												}

											});
							// 기본 주소 적용
							$("#origin_addr_commit").click(function() {
								console.log(origin_addr_id);
								$("#origin_addr_id")[0].value = origin_addr_id;
							});

							//초기 최종 주문값 세팅
							$("#final_price")[0].innerText = parseInt($("#order_food_won")[0].innerText)
									+ parseInt($("#delivery_price")[0].innerText);
							var init_p = $("#final_price")[0].innerText;
							console.log(init_p);
							$("#init_all_price").val(init_p);

							var fdList = new Array();
							var fCountList = new Array();

							//자바스크립트에서 jstl태그를 사용가능한듯
							<c:forEach items="${query}" var="fitem">
							fdList.push("${fitem.value.f_name}"); //배열에 결제한 음식의 재료의 종류를 파악
							fCountList.push("${fitem.value.cart_count}");
							</c:forEach>

							console.log(fdList);
							console.log(fdList.length);
							console.log(fCountList);

							//결제하려는 재료의 개수가 여러개인지 한개인지 파악
							var import_sale_name = "";
							if (fdList.length == 1) {
								import_sale_name = fdList[0];
							} else {
								import_sale_name = fdList[0] + "외 "
										+ (fdList.length - 1) + " 개";
							}

							$("#import_payment_ok")
									.click(
											function() {
												var point_input_val = $(
														"#point_input").val();

												var IMP = window.IMP; // 생략가능
												IMP.init('imp50979802');
												// 			console.log(IMP);
												console
														.log($("#final_price")[0].innerText);
												console
														.log($("#user_email_id")[0].value);
												console
														.log($("#send_email_id")[0].innerText);
												console
														.log($("#user_name_id")[0].innerText);
												console
														.log($("#user_phone_id")[0].innerText);
												console
														.log($("#origin_addr_id")[0].value);

												IMP
														.request_pay(
																{
																	pg : 'inicis', // version 1.1.0부터 지원.	 (inicis : 이니시스 activeX 결제창)
																	// // 			    pay_method : 'card',
																	merchant_uid : $("#user_email_id")[0].value
																			+ "_"
																			+ new Date()
																					.getTime(), //주문번호생성 (문자 + 결제날짜) 
																	//구매한유저의 아이디 + 결제날자로 설정함
																	name : import_sale_name, //결제한  주문의 명칭
																	amount : $("#final_price")[0].innerText, // 결제 가격
																	buyer_email : $("#send_email_id")[0].innerText, //구매자 이메일
																	buyer_name : $("#user_name_id")[0].value, //구매자 이름
																	buyer_tel : $("#user_phone_id")[0].innerText, //구매자 전화번호
																	buyer_addr : $("#origin_addr_id")[0].value
																//구매자 주소
																//	 		    buyer_postcode : '123-456',			//구매자 우편번호
																//	 		    m_redirect_url : 'https://www.yourdomain.com/payments/complete'
																// m_redirect_url : 모바일 결제시, 결제가 끝나고 랜딩되는 URL을 지정 (카카오페이, 페이코, 다날의 경우는 필요없음. PC와 마찬가지로 callback함수로 결과가 떨어짐)
																},
																function(rsp) {
																	if (rsp.success) {
																		var msg = '결제가 완료되었습니다.';
																		msg += '고유ID : '
																				+ rsp.imp_uid;
																		//imp_uid : 아임포트에서 부여하는 거래건 당 고유한 번호(success:false일 때, 사전 validation에 실패한 경우라면 imp_uid는 null일 수 있음)
																		msg += '상점 거래ID : '
																				+ rsp.merchant_uid; //가맹점에서 생성/관리하는 고유 주문번호
																		msg += '결제 금액 : '
																				+ rsp.paid_amount; //결제금액
																		msg += '결제 수단 : '
																				+ rsp.pay_method; //결제수단 : card, trans(실시간계좌이체), vbank(가상계좌)...
																		msg += '결제승인시각'
																				+ rsp.paid_at;
																		msg += '카드 승인번호 : '
																				+ rsp.apply_num; //카드사 승인번호 , 신용카드결제에 한하여 제공
																		// 필요한 정보를 JSON화 시키기
																		var timeStamp = rsp.paid_at * 1000;
																		var changeTime = new Date(
																				timeStamp);

																		var obj = new Object();
																		var objArray = new Array();
																		var subObj = new Object();
																		obj.order_idx = rsp.imp_uid;
																		obj.email = $(
																				"#user_email_id")
																				.val();
																		obj.pay_date = changeTime;
																		obj.pay_price = rsp.paid_amount;
																		obj.pay_type = rsp.pay_method;
																		if (point_input_val == 0) { //포인트 사용에 값이 없으면 빈값
																			obj.sale_type = "";
																		} else { //포인트 사용이 있으면 point로 설정
																			obj.sale_type = "point";
																		}
																		obj.order_price = $("#delivery_price")[0].innerText;
																		obj.use_point = $(
																				"#point_input")
																				.val();
																		obj.order_state = 1; //주문 상태(주문 취소 : 0 / 주문 완료 : 1) , 주문 성공시 주문 완료 상태이기 때문
																		obj.order_addr = rsp.buyer_addr;
																		for (var i = 0; i < fdList.length; i++) {
																			subObj.f_name = fdList[i];
																			subObj.cart_count = fCountList[i];
																			objArray
																					.push(subObj);
																			subObj = {};
																		}
																		obj.food = objArray;
																		var jsonData = JSON
																				.stringify(obj);
																		console
																				.log(jsonData);
																		console
																				.log("rsp 확인 : "
																						+ JSON
																								.stringify(rsp));
																		console
																				.log(msg);

																		$
																				.ajax({
																					url : "paymentOk.do",
																					type : "POST",
																					contentType : 'application/json',
																					// 						contentType: "application/x-www-form-urlencoded; charset=UTF-8",
																					dataType : 'json',
																					data : jsonData,
																					success : function(
																							result) {
																						if (result == null) {
																							// 									alert('결제가 실패 되었습니다.');
																							swal(
																									"결제 실패",
																									"다시 시도해주세요.",
																									"error");
																						} else if (result.order_state == "상품의 재고 수량이 부족합니다.") {
																							// 									alert('상품의 재고 수량이 부족합니다.');
																							swal(
																									"재고 부족",
																									"다시 시도해주세요.",
																									"error");
																							return false;
																						}
																						// 								alert("결제가 완료되었습니다.");
// 																						swal(
// 																								"결제 완료",
// 																								"결제가 성공적으로 완료되었습니다.",
// 																								"success");
																						// 								location.href="../";	//결제완료 페이지로 이동
																						console
																								.log(result);
																						console
																								.log(JSON
																										.stringify(result));
																						console
																								.log(JSON
																										.stringify(result).order_idx);
																						console
																								.log(result.order_idx);
// 																						location.href = "paymentResult.do?order_idx="
// 																								+ result.order_idx;
																						
																						setTimeout(function () {
																							swal({
																								title: "결제 완료",
																								text: "결제가 성공적으로 완료되었습니다.",
																								icon: 'success'
																							}).then(function () {
																								location.href = "paymentResult.do?order_idx=" + result.order_idx;
																							});
																						}, 1000);

																					},
																					error : function(
																							request,
																							status,
																							error) {
																						console
																								.log("code:"
																										+ request.status
																										+ "\n"
																										+ "message:"
																										+ request.responseText
																										+ "\n"
																										+ "error:"
																										+ error);
																					}
																				});

																	} else {
																		// 			        var msg = '결제에 실패하였습니다.';
																		// 			        msg += '에러내용 : ' + rsp.error_msg;	
																		// 			        alert(msg);
																		swal(
																				"결제 실패",
																				"다시 시도해주세요.",
																				"error");
																		console
																				.log("rsp 확인 : "
																						+ JSON
																								.stringify(rsp));
																		// 				    console.log(msg);
																	}

																});
											});

							// 		$("#change_addr_div").css("display", "none");

							// 		$("#addr_change_id").click(function(){
							// 			console.log('asdasd');
							// 			$("#change_addr_div").toggle("slow");

							// 		});
							// 		// 변경된 주소 적용
							// 		$("#addr_commit").click(function(){
							// 			console.log($("#change_addr_div"));
							// 			console.log($("#change_addr_div")[0].childNodes[13].value);

							// 			if($("#change_addr_div")[0].childNodes[11].value == "" || $("#change_addr_div")[0].childNodes[13].value == ""){
							// 				alert("변경할 주소를 모두 입력해주세요.");	
							// 			}
							// 			else{
							// 				var addr1 = $("#change_addr_div")[0].childNodes[11].value;
							// 				var addr2 = $("#change_addr_div")[0].childNodes[13].value;
							// 				$("#origin_addr_id").val(addr1 + " " + addr2);	
							// 			}

							// 		});
							// 		// 기본 주소 적용
							// 		$("#origin_addr_commit").click(function(){
							// 			console.log(origin_addr_id);
							// 			$("#origin_addr_id")[0].value = origin_addr_id;
							// 		});

						});

		function cancelPay() {
			console.log('환불');
			jQuery.ajax({
				"url" : "http://www.myservice.com/payments/cancel",
				"type" : "POST",
				"contentType" : "application/json",
				"data" : JSON.stringify({
					"merchant_uid" : "sonyjun7@naver.com_1598548345984", // 주문번호
					"cancel_request_amount" : 5590, // 환불금액
					"reason" : "테스트 결제 환불",// 환불사유
					"refund_holder" : "홍길동", // [가상계좌 환불시 필수입력] 환불 수령계좌 예금주

				// 	          "refund_account": "56211105948400" // [가상계좌 환불시 필수입력] 환불 수령계좌 번호
				}),
				"dataType" : "json"
			});
		}

		function openDaumZipAddress() {
			new daum.Postcode({
				oncomplete : function(data) {
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

		function pointAdd(val) {
			var user_point = $("#user_point_id")[0].innerText;

			if (parseInt(user_point) < parseInt(val)) {
				// 			alert('사용가능한 포인트를 초과 하였습니다.');
				swal("사용 가능한 포인트를 초과했어요.");
				console.log($("#init_all_price")[0]);
				var order_price_init = $("#order_food_won").text(); //초기값으로 변경
				$("#order_food_won")[0].innerText = order_price_init;
				$("#point_input").val("0");
				$("#final_price")[0].innerText = $("#init_all_price")[0].value;
				return false;
			} else if (val < 0) {
				// 			alert('0 미만의 값 입력 불가');
				swal("0 포인트 이상의 값을 입력해주세요.");
				var order_price_init = $("#order_food_won").text(); //초기값으로 변경
				$("#order_food_won")[0].innerText = order_price_init;
				$("#point_input").val("0");
				$("#final_price")[0].innerText = $("#init_all_price")[0].value;
				return false;
			} else if ($.isNumeric(val) == false) {
				// 			alert('숫자를 입력해주세요');
				swal("숫자를 입력해주세요.");
				var order_price_init = $("#order_food_won").text(); //초기값으로 변경
				$("#order_food_won")[0].innerText = order_price_init;
				$("#point_input").val("0");
				$("#final_price")[0].innerText = $("#init_all_price")[0].value;
				return false;
			} else {
				console.log(val);
				//	 		$("#point_input").val(val);
				console.log($("#order_food_won"));
				var order_price = $("#order_food_won")[0].innerText - val;
				console.log(order_price);
				$("#order_food_won").text(order_price);
				$("#final_price")[0].innerText = parseInt($("#order_food_won")[0].innerText)
						+ parseInt($("#delivery_price")[0].innerText);
			}

		}
	</script>
</body>


</html>