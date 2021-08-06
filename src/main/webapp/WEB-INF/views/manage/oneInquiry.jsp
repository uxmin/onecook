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
<title>ONECOOK: QNA</title>
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

<body class="">
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
					<li class="active "><a href="oneInquiry.do"> <i
							class="nc-icon nc-chat-33"></i>
							<p>상품문의</p>
					</a></li>
					<li><a href="order_check.do"> <i
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
			<!-- End Navbar -->
			<div class="content" style="margin-top: 50px;">
				<div class="col-md-12">
					<div class="card">
						<div class="card-header">
							<h4 class="card-title">상품문의</h4>
						</div>
						<div class="card-body" style="text-align: center;">
							<form id="cat_form_id" action="one_cat_form.do" method="post">
								<div class="row" style="margin-bottom: 20px;">
									<div class="col-sm-3">
										<select class="form-control" id="cat_id" name="cat_nm"
											onchange="cat_func(this.value)" style="height: 100%">
											<option value="q_type">선택</option>
											<option value="email">이메일</option>
											<option value="f_name">재료명</option>
											<option value="q_sub">제목</option>
											<option value="q_date">등록일</option>
										</select>
									</div>
									<div class="col-sm-6">
										<input type="text" id="cat_input_id" class="form-control"
											name="cat_text" style="height: 100%" />
									</div>
									<div class="col-sm-3">
										<button type="submit" id="search_id" class="btn btn-primary"
											style="margin: 0; width: 100%">검색</button>
									</div>

								</div>
							</form>
							<div class="table-responsive">
								<table class="table">
									<thead class=" text-primary">
										<tr>
											<th style="width: 10%">문의번호</th>
											<th style="width: 15%">이메일</th>
											<th style="width: 15%">재료명</th>
											<th style="width: 30%">제목</th>
											<th style="width: 15%">등록일</th>
											<th style="width: 15%;">답변 유무</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="qvo" items="${qlist}">
											<tr>
												<td>${qvo.q_idx}</td>
												<td>${qvo.email}</td>
												<td>${qvo.f_name}</td>
												<td>${qvo.q_sub}</td>
												<td><fmt:formatDate value="${qvo.q_date}"
														pattern="yyyy-MM-dd" /></td>
												<%-- 							<td>${qvo.q_date}</td> --%>
												<c:if test="${qvo.q_reply != null}">
													<td>답글작성 완료</td>
												</c:if>
												<c:if test="${qvo.q_reply == null}">
													<td><a
														href="../food/content.do?f_name=${qvo.f_name}#qna_id">답글작성</a></td>
												</c:if>
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
					<ul class="pagination">
						<c:if test="${p.pageStartNum ne 1}">
							<li><a onclick='pagePre(${p.pageStartNum},${p.pageCnt});'>이전</a></li>
						</c:if>

						<c:forEach var='i' begin="${p.pageStartNum}"
							end="${p.pageLastNum}" step="1">
							<li class='pageIndex${i}'><a onclick='pageIndex(${i});'>${i}</a></li>
						</c:forEach>

						<c:if test="${p.lastChk}">
							<li><a
								onclick='pageNext(${p.pageStartNum},${p.total},${p.listCnt},${p.pageCnt});'>이후</a></li>
						</c:if>
					</ul>
					<%-- 	<p>${p.category}</p> --%>
					<%-- 	<p>${p.sort}</p>	 --%>
					<c:if test="${p.category == null && p.sort == null}">
						<form method="post" id='frmPaging'>
							<input type='hidden' name='index' id='index' value='${p.index}'>
							<input type='hidden' name='pageStartNum' id='pageStartNum'
								value='${p.pageStartNum}'> <input type='hidden'
								name='listCnt' id='listCnt' value='${p.listCnt}'>
						</form>
				</div>
				</c:if>
				<!-- 검색 한 페이지일 경우 카테고리와 검색내용을 hidden으로 넣어서 넘겨주기 -->
				<c:if test="${p.category != null}">
					<form method="post" id='frmPaging' action="one_cat_form.do">
						<input type='hidden' name='index' id='index' value='${p.index}'>
						<input type='hidden' name='pageStartNum' id='pageStartNum'
							value='${p.pageStartNum}'> <input type='hidden'
							name='listCnt' id='listCnt' value='${p.listCnt}'> <input
							type='hidden' name='cat_nm' id='cat_nm' value='${p.category}'>
						<input type='hidden' name='cat_text' id='cat_text'
							value='${p.sort}'>
					</form>
			</div>
			</c:if>



		</div>

		<!--       <footer class="footer footer-black  footer-white "> -->
		<!--         <div class="container-fluid"> -->
		<!--           <div class="row"> -->
		<!--             <nav class="footer-nav"> -->
		<!--               <ul> -->
		<!--                 <li><a href="https://www.creative-tim.com" target="_blank">Creative Tim</a></li> -->
		<!--                 <li><a href="https://www.creative-tim.com/blog" target="_blank">Blog</a></li> -->
		<!--                 <li><a href="https://www.creative-tim.com/license" target="_blank">Licenses</a></li> -->
		<!--               </ul> -->
		<!--             </nav> -->
		<!--             <div class="credits ml-auto"> -->
		<!--               <span class="copyright"> -->
		<!--                 © <script> -->
		<!-- //                   document.write(new Date().getFullYear()) -->
		<!--                 </script>, made with <i class="fa fa-heart heart"></i> by Creative Tim -->
		<!--               </span> -->
		<!--             </div> -->
		<!--           </div> -->
		<!--         </div> -->
		<!--       </footer> -->
	</div>
	</div>
	<!--   Core JS Files   -->
	<script src="../assets/js/core/jquery.min.js"></script>
	<script src="../assets/js/core/popper.min.js"></script>
	<script src="../assets/js/core/bootstrap.min.js"></script>
	<script src="../assets/js/plugins/perfect-scrollbar.jquery.min.js"></script>
	<!--  Google Maps Plugin    -->
	<script src="https://maps.googleapis.com/maps/api/js?key=YOUR_KEY_HERE"></script>
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

</body>

</html>
