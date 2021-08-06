<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="utf-8" />
<link rel="apple-touch-icon" sizes="76x76"
	href="../assets/img/apple-icon.png">
<link rel="icon" type="image/png" href="../assets/img/favicon.png">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>ONECOOK: Order Check</title>
<meta
	content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0, shrink-to-fit=no'
	name='viewport' />
<!--     Fonts and icons     -->
<link
	href="https://fonts.googleapis.com/css?family=Montserrat:400,700,200"
	rel="stylesheet" />
<link
	href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css"
	rel="stylesheet">
<!-- CSS Files -->
<link href="../assets/css/bootstrap.min.css" rel="stylesheet" />
<link href="../assets/css/paper-dashboard.css?v=2.0.1" rel="stylesheet" />
<!-- CSS Just for demo purpose, don't include it in your project -->
<link href="../assets/demo/demo.css" rel="stylesheet" />

<style>
#chartContainer2 {
	position: relative;
	height: 25em;
	z-index: 9999;
}

#chartContainer {
	position: relative;
	height: 25em;
	z-index: 9999;
}

#varMonthChart_div {
	position: relative;
	height: 20em;
	z-index: 9999;
}

#varDatePaymentChart_div {
	position: relative;
	height: 20em;
	z-index: 9999;
}

#varWeekPaymentChart_div {
	position: relative;
	height: 20em;
	z-index: 9999;
}

@import url('../css/bootstrap.min.css');

@import url('../css/bootstrap-theme.min.css');
/* 페이징 색 처리  및 정렬*/
.row_paging_class {
	text-align: center;
}

#pagination_id>li>a {
	color: rgba(17, 17, 17, 0.8);
}

.pagination>li.active>a {
	border: 1px solid rgb(255, 219, 79);
	background: rgba(255, 219, 79, 0.9);
	color: rgba(17, 17, 17, 0.8);
}
/* .pagination>li.active>a :hover {
		border: 1px solid rgb(255, 219, 79);
	  background: rgba(255, 219, 79, 0.5);
	  color:rgba(17, 17, 17, 0.5);
	} */
.pagination>.active>a:focus, .pagination>.active>a:hover, .pagination>.active>span:focus,
	.pagination>.active>span:hover {
	z-index: 3;
	color: rgba(17, 17, 17, 0.5) !important;
	cursor: default;
	background-color: rgba(255, 219, 79, 0.5) !important;
	border-color: rgb(255, 219, 79) !important;
}
input[type="text"]:focus {
	border-color: rgb(111, 186, 44);
	box-shadow: 0 0 8px 0 rgb(111, 186, 44);
}
</style>
</head>

<body>

	<div class="wrapper ">
		<div class="sidebar" data-color="white" data-active-color="danger">
			<div class="logo">
				<a href="https://www.creative-tim.com" class="simple-text logo-mini">
					<div class="logo-image-small">
						<img src="../assets/images/logo_noneback.png">
					</div> <!-- <p>CT</p> -->
				</a> <a href="salesChart.do" class="simple-text logo-normal">
					ONECOOK <!-- <div class="logo-image-big">
            <img src="../assets/img/logo-big.png">
          </div> -->
				</a>
			</div>
			<div class="sidebar-wrapper">
				<ul class="nav">
					<li><a href="salesChart.do"> <i
							class="nc-icon nc-chart-pie-36"></i>
							<p>대시보드</p>
					</a></li>
					<li><a href="stock_check.do"> <i class="nc-icon nc-app"></i>
							<p>재고조회</p>
					</a></li>
					<li><a href="oneInquiry.do"> <i class="nc-icon nc-chat-33"></i>
							<p>상품문의</p>
					</a></li>
					<li class="active "><a href="order_check.do"> <i
							class="nc-icon nc-delivery-fast"></i>
							<p>주문/배송조회</p>
					</a></li>
				</ul>
			</div>
		</div>
		<div class="main-panel">
			<!-- Navbar -->
			<!--       <nav class="navbar navbar-expand-lg navbar-absolute fixed-top navbar-transparent"> -->
			<!--         <div class="container-fluid"> -->
			<!--           <div class="navbar-wrapper"> -->
			<!--             <div class="navbar-toggle"> -->
			<!--               <button type="button" class="navbar-toggler"> -->
			<!--                 <span class="navbar-toggler-bar bar1"></span> -->
			<!--                 <span class="navbar-toggler-bar bar2"></span> -->
			<!--                 <span class="navbar-toggler-bar bar3"></span> -->
			<!--               </button> -->
			<!--             </div> -->
			<!--             <a class="navbar-brand" href="salesChart.do"><i class="nc-icon nc-minimal-left"></i>&nbsp;&nbsp;Go back MAIN</a> -->
			<!--           </div> -->
			<!--           <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navigation" aria-controls="navigation-index" aria-expanded="false" aria-label="Toggle navigation"> -->
			<!--             <span class="navbar-toggler-bar navbar-kebab"></span> -->
			<!--             <span class="navbar-toggler-bar navbar-kebab"></span> -->
			<!--             <span class="navbar-toggler-bar navbar-kebab"></span> -->
			<!--           </button> -->

			<!--         </div> -->
			<!--       </nav> -->

			<div class="content" style="margin-top: 50px;">
				<div class="col-md-12">
					<div class="card">
						<div class="card-header">
							<h4 class="card-title">주문/배송조회</h4>

							<input id="s_hdn_id" type="hidden" value="${p.select}">

							<div class="row">
								<div class="col-sm-8"></div>

								<div class="col-sm-2">
									<input type="hidden" id="allDelivery" value="일괄배송"
										onclick="allDeli()" style="margin: 0; width: 100%"> <input
										type="hidden" id="allRefund" value="일괄환불" onclick="allRe()"
										style="margin: 0; width: 100%">
								</div>
								<div class="col-sm-2">
									<select id="selectBox" class="form-control"
										onchange="select(this.value);" style="height: 100%;">
										<option id="all" value="all">전체</option>
										<option id="s_결제완료" value="결제완료">결제완료</option>
										<option id="s_배송중" value="배송중">배송중</option>
										<option id="s_배송완료" value="배송완료">배송완료</option>
										<option id="s_환불요청중" value="환불요청중">환불요청중</option>
										<option id="s_환불완료" value="환불완료">환불완료</option>
									</select>
								</div>

							</div>

						</div>
						<div class="card-body" style="text-align: center;">
							<div class="table-responsive">
								<table class="table">
									<thead class=" text-primary">
										<tr>
											<th style="width: 25%">주문번호</th>
											<th style="width: 10%">주문일자</th>
											<th style="width: 20%">유저이름</th>
											<th style="width: 10%">주문상태</th>
											<th style="width: 20%">배송번호</th>
											<th style="width: 15%; text-align: center">요청처리</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="od" items="${list}">
											<tr bgcolor="white" class="tr">

												<td>${od.order_idx}</td>
												<%-- 				  			 	<td>${od.order_date}</td> --%>
												<td><fmt:formatDate value="${od.order_date}"
														pattern="yyyy-MM-dd" /></td>
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
														<td style="text-align: center"><input type="button"
															id="${od.delivery_idx}" class="btn btn-primary"
															onclick="pay(this.id)" value="배송하기"></td>
													</c:when>
													<c:when test="${od.delivery_state eq '환불요청중'}">
														<td style="text-align: center"><input type="button"
															id="${od.delivery_idx}" class="btn btn-success"
															onclick="refund(this.id)" value="환불하기"></td>
													</c:when>

													<c:otherwise>
														<td style="text-align: center"></td>
													</c:otherwise>
												</c:choose>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>


				<!-- 5. paging view -->
				<div class="row_paging_class">
					<!-- 5. paging view	 -->
					<ul class="pagination">
						<c:if test="${p.pageStartNum ne 1}">
							<!-- 맨 첫페이지 이동 -->
							<li><a onclick='pagePre(${p.pageCnt+1},${p.pageCnt});'>&laquo;</a></li>
							<!-- 이전 페이지 이동 -->
							<li><a onclick='pagePre(${p.pageStartNum},${p.pageCnt});'>&lsaquo;</a></li>
						</c:if>

						<!--페이지번호 -->
						<c:forEach var='i' begin="${p.pageStartNum}"
							end="${p.pageLastNum}" step="1">
							<li class='pageIndex${i}'><a onclick='pageIndex(${i});'>${i}</a></li>
						</c:forEach>

						<c:if test="${p.lastChk}">
							<!-- 다음 페이지 이동 -->
							<li><a
								onclick='pageNext(${p.pageStartNum},${p.total},${p.listCnt},${p.pageCnt});'>&rsaquo;</a></li>
							<!-- 마지막 페이지 이동 -->
							<li><a
								onclick='pageLast(${p.pageStartNum},${p.total},${p.listCnt},${p.pageCnt});'>&raquo;</a></li>
						</c:if>
					</ul>
				</div>

				<form method="post" id='frmPaging'>
					<!-- 출력할 페이지번호, 출력할 페이지 시작 번호, 출력할 리스트 갯수 -->
					<input type='hidden' name='index' id='index' value='${p.index}'>
					<input type='hidden' name='pageStartNum' id='pageStartNum'
						value='${p.pageStartNum}'> <input type='hidden'
						name='listCnt' id='listCnt' value='${p.listCnt}'> <input
						type='hidden' name='select' id='select' value='${p.select}'>
				</form>



			</div>
		</div>
	</div>


	<!--   Core JS Files   -->
	<script src="../assets/js/core/jquery.min.js"></script>
	<script src="../assets/js/core/popper.min.js"></script>
	<script src="../assets/js/core/bootstrap.min.js"></script>
	<script src="../assets/js/plugins/perfect-scrollbar.jquery.min.js"></script>
	<!--  Google Maps Plugin    -->
	<!--   <script src="https://maps.googleapis.com/maps/api/js?key=YOUR_KEY_HERE"></script> -->
	<!-- Chart JS -->
	<script src="../assets/js/plugins/chartjs.min.js"></script>
	<!--  Notifications Plugin    -->
	<script src="../assets/js/plugins/bootstrap-notify.js"></script>
	<!-- Control Center for Now Ui Dashboard: parallax effects, scripts for the example pages etc -->
	<script src="../assets/js/paper-dashboard.min.js?v=2.0.1"
		type="text/javascript"></script>
	<!-- Paper Dashboard DEMO methods, don't include it in your project! -->
	<script src="../assets/demo/demo.js"></script>

	<%@ include file="../common/js_link.jsp"%>

	<script type="text/javascript" src="../js/paging.js"></script>
	<script>
		$(document).ready(function(){
			var s_hdn = $("#s_hdn_id").val();
			$("#s_"+s_hdn).attr("selected", "selected");
			//카테고리 선택 시 버튼 고정
			if(s_hdn == "결제완료"){
				$("#allDelivery").attr("type", "button");
				$("#allDelivery").attr("class", "btn btn-primary");
			}else if(s_hdn == "환불요청중"){
				$("#allRefund").attr("type", "button");
				$("#allRefund").attr("class", "btn btn-primary");
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
// 				console.log('asdsad');
			 	$.ajax({
					url: "order_check_select.do",
					type: "GET",
					data: {select : val},
					success: function(data){
						console.log(data);
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
</body>

</html>
