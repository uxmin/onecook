<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<script src="http://code.jquery.com/jquery-1.12.4.min.js" ></script>
    <script src="http://service.iamport.kr/js/iamport.payment-1.1.5.js"></script>
   	<script type="text/JavaScript" src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
    <script src="../js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="../css/bootstrap.min.css">
	<link rel="stylesheet" href="../css/bootstrap-theme.min.css">
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
</script>
<body>
<div style="text-align: center">
	<br/>
	<h1>주문 완료 확인 페이지</h1>
	<br/><br/><br/>
	
	<table class="table table-hover"  align="center">
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
		<c:forEach  var="dto" items="${olist}">
			<tr>
				<td><img src="../resources/images/food/${dto.f_type}/${dto.f_img}" width="100px"></td>
				<td>${dto.f_name}</td>
				<td>${dto.totalcount}</td>
				<td>${dto.f_price} 원</td>
				<td>${dto.f_price*dto.totalcount} 원</td>
				<c:set var="all" value="${sum = sum + dto.f_price*dto.totalcount}"/>
			</tr>
		</c:forEach>
	</table>
	<div>
		<h3> + 배송료 : ${olist[0].order_price}</h3>
		<c:if test="${!empty olist[0].use_point}">
			<h3>-> 결제금액 : ${all + olist[0].order_price}</h3>
			<h3>- 사용된 포인트 : ${olist[0].use_point}</h3>
			<h1>총 결제 금액 : ${all + olist[0].order_price - olist[0].use_point}</h1>
		</c:if>
		<c:if test="${empty olist[0].use_point}">
			<h1>총 결제 금액 : ${all + olist[0].order_price}</h1>
		</c:if>
		<button onclick="location.href='../'">메인 페이지</button>
	</div>
</div>
</body>
</html>