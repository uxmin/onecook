<%@page import="oc.md.vo.OrderListVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
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
	font-size: 13px;
}

.yellow_btn:hover, .yellow_btn:focus {
	background: rgba(255, 219, 79, 0.5) !important;
	color: rgba(17, 17, 17, 0.5);
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

<title>ONECOOK: Pay Success</title>

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
							<h2 class="module-title font-alt">Success Pay</h2>
							<div class="module-subtitle font-alt">결제된 내역을 확인해주세요.</div>
						</div>
					</div>
				</div>
			</section>
			<!-- 상품정보 영역 -->
			<!--         <section class="module-small" style="padding-bottom:0"> -->
			<!--           <div class="container"> -->
			<!-- 			<div class="form-group"> -->
			<%-- 				<h5 class="module-subtitle font-alt" id="pay_title">결제된 상품 총 <span style="color:rgb(111,186,44);">${fn:length(olist)}</span>건</h5>	 --%>
			<!-- 					<table class="table table-hover"> -->
			<!-- 						<tr> -->
			<!-- 							<th style="text-align:center;">Image</th> -->
			<!-- 							<th>Name</th> -->
			<!-- 							<th style="text-align:center;">Count</th> -->
			<!-- 							<th style="text-align:center;">Price</th> -->
			<!-- 							<th style="text-align:center;">Total</th> -->
			<!-- 						</tr> -->
			<%-- 						<% --%>
			<!-- // 							long all_price = 0; -->
			<!-- // 							pageContext.setAttribute("sum", all_price); -->
			<%-- 						%> --%>
			<%-- 						<c:forEach  var="dto" items="${olist}"> --%>
			<!-- 							<tr> -->
			<%-- 								<td style="text-align:center;"><img src="../resources/images/food/${dto.f_type}/${dto.f_img}" width="100px"></td> --%>
			<%-- 								<td>${dto.f_name}</td> --%>
			<%-- 								<td style="text-align:center;">${dto.totalcount}</td> --%>
			<%-- 								<td style="text-align:center;">${dto.f_price} &#8361;</td> --%>
			<%-- 								<td style="text-align:center;">${dto.f_price*dto.totalcount} &#8361;</td> --%>
			<%-- 								<c:set var="all" value="${sum = sum + dto.f_price*dto.totalcount}"/> --%>
			<!-- 							</tr> -->
			<%-- 						</c:forEach> --%>
			<!-- 					</table> -->
			<!-- 				</div> -->
			<!--          	 </div> -->
			<!--         </section> -->

			<!-- 주문자 정보 영역 -->
			<section class="module-small">
				<div class="container">
					<div class="row">
						<div class="col-sm-6 col-sm-offset-3"
							style="padding: 20px 50px;">
							<div class="form-group">
								<div class="comments" style="margin: 0px;">
									<div class="row mb-80">
										<h1 style="text-align: center;">
											<i class="fas fa-thumbs-up" style="color: rgba(111, 186, 44, 0.5);"></i>
										</h1>
										<h3 class="font-alt" style="text-align: center;">
											구매완료
										</h3>
										<h5 style="text-align: center;">
											[${olist[0].f_name}] 포함 총 <span
												style="color: rgb(111, 186, 44);">${fn:length(olist)}</span>건
										</h5>
									</div>
									<!-- 						<div class="row"> -->
									<!-- 							<h5 class="comment-title font-alt" id="pay_title">구매영수증</h5> -->
									<!-- 						</div> -->
									<!-- 2020 10 26추가 -->
									<%
										long all = 0;
										pageContext.setAttribute("all", all);

									%>
									<c:forEach var="dto" items="${olist}">
										<c:set var = "price" value="${dto.f_price * dto.totalcount}"/>
									
									<%
						
										String price_str = pageContext.getAttribute("price").toString();
										all += Integer.parseInt(price_str);
										pageContext.setAttribute("all", all);
									%>
									</c:forEach>
									<!-- 2020 10 26추가 -->
									
									<hr class="divider-w mt-10 mb-10">	
									<c:if test="${!empty olist[0].use_point}">
										<div class="row">
											<div class="col-sm-5">
												<span class="font-alt"><i class="fas fa-check-circle" style="color:rgba(111, 186, 44, 0.3);"></i>&nbsp;결제금액</span>
											</div>
											<div class="col-sm-7">
												<!-- 변경 -->
												<span class="font-alt">${all}
													&#8361;</span>
											</div>
										</div>

										<div class="row">
											<div class="col-sm-5">
												<span class="font-alt"><i class="fas fa-check-circle" style="color:rgba(111, 186, 44, 0.3);"></i>&nbsp;사용된
													포인트</span>
											</div>
											<div class="col-sm-7">
												<span class="font-alt">${olist[0].use_point} point</span>
											</div>
										</div>

										<div class="row">
											<div class="col-sm-5">
												<span class="font-alt"><i class="fas fa-check-circle" style="color:rgba(111, 186, 44, 0.3);"></i>&nbsp;배송비</span>
											</div>
											<div class="col-sm-7">
												<span class="font-alt">${olist[0].order_price}
													&#8361;</span>
											</div>
										</div>

										<div class="row">
											<div class="col-sm-5">
												<span class="font-alt"><i class="fas fa-check-circle" style="color:rgba(111, 186, 44, 0.3);"></i>&nbsp;총
													결제금액</span>
											</div>
											<div class="col-sm-7">
												<span class="font-alt">${all + olist[0].order_price - olist[0].use_point}
													&#8361;</span>
											</div>
										</div>

									</c:if>
									
									<c:if test="${empty olist[0].use_point}">
										<div class="row">
											<div class="col-sm-5">
												<span class="font-alt"><i class="fas fa-check-circle" style="color:rgba(111, 186, 44, 0.3);"></i>&nbsp;총
													결제금액</span>
											</div>
											<div class="col-sm-7">
												<span class="font-alt">${all}
													&#8361;</span>
											</div>
										</div>
									</c:if>
									<hr class="divider-w mt-10 mb-10">
									<div class="row mt-80">
										<div class="col-sm-6 col-sm-offset-3">
											<button id="import_payment_ok"
												class="yellow_btn btn btn-d btn-round btn-block"
												type="button" onclick="location.href='../'"
												style="color: black;">돌아가기</button>
										</div>
									</div>



								</div>
							</div>
						</div>
					</div>
				</div>
			</section>

			<%@ include file="../common/footer.jsp"%>

		</div>
		<div class="scroll-up">
			<a href="#totop"><i class="fa fa-angle-double-up"></i></a>
		</div>
	</main>

	<%@ include file="../common/js_link.jsp"%>

	<script src="http://service.iamport.kr/js/iamport.payment-1.1.5.js"></script>
	<script type="text/JavaScript"
		src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
</body>


</html>