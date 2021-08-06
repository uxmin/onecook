<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="en-US" dir="ltr">

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>ONECOOK: Recipe Detail</title>

<!--  
    Favicons
    =============================================
  -->

<link rel="icon" type="image/png" sizes="32x32"
	href="../assets/images/favicons/favicon-32x32.png">
<link rel="icon" type="image/png" sizes="96x96"
	href="../assets/images/favicons/favicon-96x96.png">
<link rel="icon" type="image/png" sizes="16x16"
	href="../assets/images/favicons/logo_noneback_16x16.png">

<meta name="msapplication-TileColor" content="#ffffff">
<meta name="msapplication-TileImage"
	content="../assets/images/favicons/ms-icon-144x144.png">
<meta name="theme-color" content="#ffffff">

<!--  
    Stylesheets
    =============================================
  -->
<!-- Default stylesheets -->

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<!--   <link href="../assets/lib/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet"> -->

<!-- Template specific stylesheets -->
<link
	href="https://fonts.googleapis.com/css?family=Roboto+Condensed:400,700"
	rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Volkhov:400i"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700,800"
	rel="stylesheet">
<link href="../assets/lib/animate.css/animate.css" rel="stylesheet">
<link
	href="../assets/lib/components-font-awesome/css/font-awesome.min.css"
	rel="stylesheet">
<link href="../assets/lib/et-line-font/et-line-font.css"
	rel="stylesheet">
<link href="../assets/lib/flexslider/flexslider.css" rel="stylesheet">
<link href="../assets/lib/owl.carousel/dist/assets/owl.carousel.min.css"
	rel="stylesheet">
<link
	href="../assets/lib/owl.carousel/dist/assets/owl.theme.default.min.css"
	rel="stylesheet">
<link href="../assets/lib/magnific-popup/dist/magnific-popup.css"
	rel="stylesheet">
<link href="../assets/lib/simple-text-rotator/simpletextrotator.css"
	rel="stylesheet">
<!-- Main stylesheet and color file -->
<link href="../assets/css/style.css" rel="stylesheet">
<link id="color-scheme" href="assets/css/colors/default.css"
	rel="stylesheet">

<style>
.col-centered {
	float: none;
	margin: 0 auto;
}

.carousel-control {
	width: 8%;
	width: 0px;
}

.carousel-control.left, .carousel-control.right {
	margin-right: 40px;
	margin-left: 32px;
	background-image: none;
	opacity: 1;
}

.carousel-control>a>span {
	color: white;
	font-size: 29px !important;
}

.carousel-col {
	position: relative;
	min-height: 1px;
	padding: 5px;
	float: left;
}

.active>div {
	display: none;
}

.active>div:first-child {
	display: block;
}

/*xs*/
@media ( max-width : 767px) {
	.carousel-inner .active.left {
		left: -50%;
	}
	.carousel-inner .active.right {
		left: 50%;
	}
	.carousel-inner .next {
		left: 50%;
	}
	.carousel-inner .prev {
		left: -50%;
	}
	.carousel-col {
		width: 50%;
	}
	.active>div:first-child+div {
		display: block;
	}
}

/*sm*/
@media ( min-width : 768px) and (max-width: 991px) {
	.carousel-inner .active.left {
		left: -50%;
	}
	.carousel-inner .active.right {
		left: 50%;
	}
	.carousel-inner .next {
		left: 50%;
	}
	.carousel-inner .prev {
		left: -50%;
	}
	.carousel-col {
		width: 50%;
	}
	.active>div:first-child+div {
		display: block;
	}
}

/*md*/
@media ( min-width : 992px) and (max-width: 1199px) {
	.carousel-inner .active.left {
		left: -33%;
	}
	.carousel-inner .active.right {
		left: 33%;
	}
	.carousel-inner .next {
		left: 33%;
	}
	.carousel-inner .prev {
		left: -33%;
	}
	.carousel-col {
		width: 33%;
	}
	.active>div:first-child+div {
		display: block;
	}
	.active>div:first-child+div+div {
		display: block;
	}
}

/*lg*/
@media ( min-width : 1200px) {
	.carousel-inner .active.left {
		left: -25%;
	}
	.carousel-inner .active.right {
		left: 25%;
	}
	.carousel-inner .next {
		left: 25%;
	}
	.carousel-inner .prev {
		left: -25%;
	}
	.carousel-col {
		width: 25%;
	}
	.active>div:first-child+div {
		display: block;
	}
	.active>div:first-child+div+div {
		display: block;
	}
	.active>div:first-child+div+div+div {
		display: block;
	}
}

/* 추가 */
.block {
	width: 100%;
	height: 160%;
}

.post-images-slider .flex-control-nav {
	bottom: 8rem;
}

.carousel-control .icon-prev, .carousel-control .icon-next,
	.carousel-control .glyphicon-chevron-left, .carousel-control .glyphicon-chevron-right
	{
	position: absolute;
	top: 40%;
	z-index: 5;
	display: inline-block;
}

.progress-bar.pb-dark {
	background: rgba(255, 219, 79, 0.5);
}

#yellow_food_btn {
	background: rgba(255, 219, 79, 0.9) !important;
	color: rgba(17, 17, 17, 0.8);
	font-size: 13px;
	width: 170px;
	margin-bottom: 10px;
}

#yellow_food_btn:hover, #yellow_food_btn:focus {
	background: rgba(255, 219, 79, 0.5) !important;
	color: rgba(17, 17, 17, 0.5);
}

.modal {
	text-align: center;
}

@media screen and (min-width: 768px) {
	.modal:before {
		display: inline-block;
		vertical-align: middle;
		content: " ";
		height: 100%;
	}
}

.modal-dialog {
	display: inline-block;
	text-align: left;
	vertical-align: middle;
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

.yellow_btn {
	background: rgba(255, 219, 79, 0.9) !important;
	border: 1px solid rgb(255, 219, 79);
	color: rgba(17, 17, 17, 0.8);
	font-size: 13px;
}

.yellow_btn:hover, .yellow_btn:focus {
	background: rgba(255, 219, 79, 0.5) !important;
	color: rgba(17, 17, 17, 0.5);
}

#yellow_btn {
	background: rgba(255, 219, 79, 0.9) !important;
	color: rgba(17, 17, 17, 0.8);
	font-size: 13px;
}

#yellow_btn:hover, #yellow_btn:focus {
	background: rgba(255, 219, 79, 0.5) !important;
	color: rgba(17, 17, 17, 0.5);
}
input[type="text"]:focus {
	border-color: rgb(111, 186, 44);
	box-shadow: 0 0 8px 0 rgb(111, 186, 44);
}
input[type="textarea"]:focus {
	border-color: rgb(111, 186, 44);
	box-shadow: 0 0 8px 0 rgb(111, 186, 44);
}
</style>
</head>

<body data-spy="scroll" data-target=".onpage-navigation"
	data-offset="60">
	<main>
		<%@ include file="../common/header.jsp"%>
		<div class="page-loader">
			<div class="loader">Loading...</div>
		</div>

		<div class="main">
			<section class="module bg-dark-60 portfolio-page-header"
				data-background="../assets/images/restaurant/slider1.jpg">
				<div class="container">
					<div class="row">
						<div class="col-sm-6 col-sm-offset-3">
							<h2 class="module-title font-alt">Show OneCook Recipe</h2>
							<div class="module-subtitle font-alt">원쿡이 제공해드리는 레시피예요. <br/>요리를
								할 생각에 벌써 흥분이 됩니다!</div>
						</div>
					</div>
				</div>
			</section>

			<section class="module">
				<div class="container">
					<div class="row">
						<div class="col-sm-6 col-sm-offset-3" style="text-align: center;">
							<span><i class="fas fa-utensils fa-3x" style="color:rgba(111,186,44,0.5);margin-bottom: 5px;"></i></span><br/>
							<span class="font-serif" style="font-size: 13px;">Recipe</span><br/><br/>
							<span class="font-alt" style="font-size: 15px;">${recipe.rc_type}</span>
							<hr class="divider-w mt-20 mb-20">
							<h3 class="module-title font-alt">${recipe.rc_title}</h3>
						</div>
					</div>

					<div class="row">
						<div class="col-sm-12">
							<div class="post-images-slider">
								<ul class="slides">
									<c:forEach var="dto" items="${recipe_detail}">
										<li><img class="center-block"
											src="../resources/images/recipe/${dto.rc_title}/${dto.img_file}"
											alt="Slider Image" height="60%" width="140%" /> <br />
											<h5 class="font-alt" style="text-align: center;">${dto.img_cont}</h5></li>
									</c:forEach>
								</ul>
							</div>
						</div>
					</div>
					<hr class="divider-w mt-60 mb-60">

					<div class="row multi-columns-row">
						<div class="col-sm-12">
							<h5 class="work-details-title font-alt">Recipe Material</h5>
						</div>
						<c:forEach var="i" begin="0" end="${fn:length(recipe_material)-1}"
							step="1">
							<div class="col-sm-6 col-md-4 col-lg-3">
								<div class="work-details" style="margin:0px;">
									<ul>
										<c:forEach var="material" items="${recipe_material}"
											begin="${i}" end="${i+2}" step="3">
										
											<li><span class="font-alt"><i class="fas fa-check-circle" style="color:rgba(111,186,44,0.5);"></i>&nbsp;${material.rt_cont}</span></li>
										</c:forEach>
									</ul>
								</div>
							</div>
						</c:forEach>
					</div>
					<hr class="divider-w mt-60 mb-60">

					<div class="row">
						<div class="col-sm-12">
							<h5 class="font-alt mb-0">Nutrient</h5>
							<hr class="divider-w mt-10 mb-20">
							<!-- progress bar  -->
							<c:forEach var="nu" items="${nutrient}">
								<c:if test="${nu.nutrient_nm == '칼로리'}">
									<h6 class="font-alt">
										<span class="icon-happy"></span>&nbsp;${nu.nutrient_nm}</h6>
									<div class="progress">
										<div class="progress-bar pb-dark"
											aria-valuenow="${(nu.rate/2500)*100}" role="progressbar"
											aria-valuemin="0" aria-valuemax="2500"
											style="width: ${(nu.rate/2500)*100}%;">
											<span class="font-alt" style="opacity: 1;">${(nu.rate/2500)*100}</span>
										</div>
									</div>
								</c:if>
								<c:if test="${nu.nutrient_nm != '칼로리'}">
									<h6 class="font-alt">
										<span class="icon-happy"></span>&nbsp;${nu.nutrient_nm}</h6>
									<div class="progress">
										<div class="progress-bar pb-dark" aria-valuenow="${nu.rate}"
											role="progressbar" aria-valuemin="0" aria-valuemax="100"
											style="width: ${nu.rate}%;">
											<span class="font-alt" style="opacity: 1;">${nu.rate}</span>
										</div>
									</div>
								</c:if>
							</c:forEach>

							<!-- radar chart
              <div style="text-align:center">
              <canvas id="marksChart" width="500" height="300" style="text-align:center"></canvas>
              </div>
                -->
						</div>
					</div>
				</div>
			</section>

			<section class="module">
				<div class="container">
					<div class="row">
						<div class="col-sm-6 col-sm-offset-3">
							<h1 class="module-title font-alt">ONECOOK FOOD</h1>
							<div class="module-subtitle font-alt">
								재료가 없다구요? 걱정마세요.<br />그래서 원쿡이 여기 다양한 재료를 준비해뒀어요.
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-xs-12 col-md-12 col-centered">
							<div id="carousel" class="carousel slide" data-ride="carousel"
								data-type="multi" data-interval="4000">
								<div class="carousel-inner">
									<%
                    long count = 1;
                    pageContext.setAttribute("count", count);
                  %>
									<c:forEach var="food" items="${recipe_food}" varStatus="vs">
										<c:choose>
											<c:when test="${vs.first}">
												<div class="item active">
													<div class="carousel-col">
														<div class="block img-responsive shop-item">
															<div class="shop-item-image">
																<img
																	src="../resources/images/food/${food.f_type}/${food.f_img}">
																<div class="shop-item-detail">
																	<a id="yellow_food_btn" class="btn btn-round btn-b"
																		href="../food/content.do?f_name=${food.f_name}"><i
																		class="fas fa-search"></i>&nbsp;상세보기</a>
																	<c:if test="${!empty loginUser}">
																		<a id="yellow_food_btn" class="btn btn-round btn-b"
																			data-toggle="modal" data-target="#modalFood_${count}"><i
																			class="fas fa-shopping-cart"></i>&nbsp;장바구니</a>
																	</c:if>
																</div>
															</div>
															<h5>${food.f_name}</h5>
															<h6>${food.f_price}&#8361;</h6>
														</div>
													</div>
												</div>
											</c:when>

											<c:otherwise>
												<div class="item">
													<div class="carousel-col">
														<div class="block green img-responsive shop-item">
															<div class="shop-item-image">
																<img
																	src="../resources/images/food/${food.f_type}/${food.f_img}">
																<div class="shop-item-detail">
																	<a id="yellow_food_btn" class="btn btn-round btn-b"
																		href="../food/content.do?f_name=${food.f_name}"><i
																		class="fas fa-search"></i>&nbsp;상세보기</a>
																	<c:if test="${!empty loginUser}">
																		<a id="yellow_food_btn" class="btn btn-round btn-b"
																			data-toggle="modal" data-target="#modalFood_${count}"><i
																			class="fas fa-shopping-cart"></i>&nbsp;장바구니</a>
																	</c:if>
																</div>
															</div>
															<h5>${food.f_name}</h5>
															<h6>${food.f_price}&#8361;</h6>
														</div>
													</div>
												</div>
											</c:otherwise>
										</c:choose>
										<%
                      count++;
                      pageContext.setAttribute("count", count);
                    %>
									</c:forEach>
								</div>

								<!-- Controls -->
								<div class="left carousel-control">
									<a href="#carousel" role="button" data-slide="prev"> <span
										class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
										<span class="sr-only">Previous</span>
									</a>
								</div>
								<div class="right carousel-control">
									<a href="#carousel" role="button" data-slide="next"> <span
										class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
										<span class="sr-only">Next</span>
									</a>
								</div>
							</div>

						</div>
					</div>
				</div>
			</section>



			<section class="module">
				<div class="container">
					<div class="row">
						<div class="col-sm-6 col-sm-offset-3">
							<h1 class="module-title font-alt">REVIEW</h1>
						</div>
						<div class="col-sm-12 comment-form">
							<h4 class="comment-form-title font-alt">
								현재 <span style="color: rgb(111, 186, 44);">${p.total}</span>개의
								후기가 있어요.
							</h4>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-12">
							<table class="table table-striped table-border checkout-table">
								<tbody>
									<tr>
										<th class="col-sm-1">No</th>
										<th class="col-sm-7">Subject</th>
										<th class="col-sm-2">Writer</th>
										<th class="col-sm-2">Date</th>
									</tr>
									<c:forEach var="dto" items="${reply_list}">
										<tr>
											<td>${dto.reply_idx}</td>
											<td><a class="toggle_review_sub" href="#reply_tb"><input
													type="hidden" value="${dto.reply_idx}">${dto.reply_sub}<c:if
														test="${!empty dto.reply_img}">&nbsp;&nbsp;<i
															class="fas fa-camera"></i>
													</c:if></a></td>
											<td class="change_name">${dto.user_name}</td>
											<td>${dto.reply_date}</td>
										</tr>
										<tr class="show_review_tr" id="tr_head_${dto.reply_idx}">
											<td colspan="4"
												style="text-align: center; background: white;">
												<h5>${dto.reply_cont}</h5> <c:if
													test="${!empty dto.reply_img}">
													<img class="mt-10 mb-10"
														src="../resources/images/recipe/${recipe_detail[0].rc_title}/${dto.reply_img}"
														style="max-width: 50%; height: auto;">
												</c:if> <c:if
													test="${loginUser.email eq dto.email || loginUser.user_type eq 'MANAGER'}">
													<br />
													<hr class="divider-w">
													<button class="btn btn-g btn-round mt-10"
														onclick="reviewDel(${dto.rc_idx},${dto.reply_idx},'${recipe.rc_title}')">Delete</button>
													<script>
                          function reviewDel(rcidx,replyidx,rctitle){
								swal({
									  text: "작성된 후기를 삭제하시겠어요?",
									  icon: "warning",
									  buttons: true,
									  dangerMode: true,
									})
									.then((willDelete) => {
										  if (willDelete) {
												setTimeout(function() {
												    swal("후기가 삭제되었어요.", {
												      icon: "success",
												    }).then(function() {
														location.href="del.do?rc_idx="+rcidx+"&reply_idx="+replyidx+"&rc_title="+rctitle;
													});
												}, 1000);   
										  } else {
										   		swal("삭제가 취소되었어요.");
										  }
									});
							}
                          </script>
												</c:if>
											</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
						<div class="col-sm-12" style="text-align: center;">
							<div class="pagination font-alt">
								<ul class="pagination" id="pagination">
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

								<form action="recipe_detail.do#pagination" method="post"
									id='frmPaging'>
									<!-- 출력할 페이지번호, 출력할 페이지 시작 번호, 출력할 리스트 갯수 -->
									<input type='hidden' name='index' id='index' value='${p.index}'>
									<input type='hidden' name='rc_idx' id='ttt' value='${rc_idx}'>
									<input type='hidden' name='pageStartNum' id='pageStartNum'
										value='${p.pageStartNum}'> <input type='hidden'
										name='listCnt' id='listCnt' value='${p.listCnt}'>
								</form>
							</div>
						</div>
						<div class="col-sm-12">
							<div class="comment-form mt-30">
								<h4 class="comment-form-title font-alt">Add review</h4>
								<form name="input" method="post" action="write.do"
									enctype="multipart/form-data">
									<input type="hidden" name="write_gubun" value="MANAGER">
									<input type="hidden" name="rc_idx" value="${rc_idx}">

									<div class="row">
										<div class="col-sm-4">
											<div class="form-group">
												<label class="sr-only" for="email">Name</label>
												<c:if test="${!empty loginUser}">
													<input class="form-control" id="email" type="text"
														name="email" placeholder="${loginUser.user_name}" disabled>
												</c:if>
												<c:if test="${empty loginUser}">
													<input class="form-control" id="email" type="text"
														name="email" placeholder="로그인 후 이용해주세요." disabled>
												</c:if>
											</div>
										</div>
										<div class="col-sm-8">
											<div class="form-group">
												<label class="sr-only" for="file">File</label> <input
													class="form-control" id="file" type="file"
													name="reply_img_file" placeholder="File">
											</div>
										</div>
										<div class="col-sm-12">
											<div class="form-group">
												<label class="sr-only" for="subject">Subject</label> <input
													class="form-control" id="subject" type="text"
													name="reply_sub" placeholder="Subject">
											</div>
										</div>
										<div class="col-sm-12">
											<div class="form-group">
												<textarea class="form-control" id="Review" name="reply_cont"
													rows="4" placeholder="Review"></textarea>
											</div>
										</div>
										<div class="col-sm-12">
											<c:if test="${!empty loginUser}">
												<input id="yellow_btn" class="btn btn-round btn-d"
													type="button" value="리뷰작성" onclick="check()"></input>
											</c:if>
											<c:if test="${empty loginUser}">
												<input id="yellow_btn" class="btn btn-round btn-d"
													type="button" value="리뷰작성" onclick="reCheck()"></input>
											</c:if>
										</div>
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
			</section>

			<hr class="divider-w">

			<%@ include file="../common/footer.jsp"%>
			<hr class="divider-d">
			<div class="scroll-up">
				<a href="#totop"><i class="fa fa-angle-double-up"></i></a>
			</div>
		</div>

	</main>
	<%
    long count2 = 1;
    pageContext.setAttribute("count2", count2);
  %>
	<c:forEach var="dto" items="${recipe_food}">
		<div id="cartcnt_${count2}">
			<!-- Modal -->
			<div class="modal fade" id="modalFood_${count2}" tabindex="-1"
				role="dialog" aria-labelledby="exampleModalCenterTitle"
				aria-hidden="true">
				<div class="modal-dialog modal-sm" style="margin: 20rem;"
					role="document">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="exampleModalLongTitle">${dto.f_name}
								<button type="button" class="close" data-dismiss="modal"
									aria-label="close">
									<span aria-hidden="true">&times;</span>
								</button>
						</div>
						<div class="modal-body" style="text-align: center;">
							<br />
							<div class="row mb-20">
								<img src="../images/food/${dto.f_type}/${dto.f_img}"
									style="max-width: 80%" />
							</div>
							<div class="row mb-10">
								<span>${dto.f_name}</span>
							</div>
							<input id="ori_price_${count2}" type="hidden"
								value="${dto.f_price}">
							<div class="row mb-30">
								<button id="count_minus_${count2}" value="${count2}"
									class="btn btn-g btn-round" style="padding: 8px 12px;"
									onclick="minusFunc(this.value)">-</button>
								&nbsp;&nbsp; <span id="count_value_${count2}">1</span><input
									type="hidden" name="cart_count" id="cart_count_${count2}"
									value="1">&nbsp;&nbsp;
								<button id="count_plus_${count2}" value="${count2}"
									class="btn btn-g btn-round" style="padding: 8px 12px;"
									onclick="plusFunc(this.value)">+</button>
							</div>
							<div class="row" style="text-align: right; padding-right: 30px;">
								<b>총&nbsp;&nbsp;&nbsp;<span id="modal_price_${count2}"
									style="color: rgb(111, 186, 44); font-size: 25px;">${dto.f_price}</span>&nbsp;원
								</b>
							</div>

						</div>

						<div class="modal-footer" style="text-align: center;">

							<button type="button" class="btn btn-g btn-round"
								data-dismiss="modal">닫기</button>

							<button type="button" value="${dto.f_name}"
								class="btn btn-g btn-round"
								onclick="cartIntoFunc(this.value, ${count2})"
								style="background: rgb(255, 219, 79);">재료담기</button>

						</div>
					</div>
				</div>
			</div>
		</div>
		<%
      count2++;
      pageContext.setAttribute("count2", count2);
    %>
	</c:forEach>


	<%@ include file="../common/js_link.jsp"%>
	<script type="text/javascript" src="../js/paging.js"></script>
	<script type="text/javascript"
		src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.min.js"></script>
	<script>
    $(document).ready(function () {
      $(".show_review_tr").css("display", "none");
      for (var i = 0; i < $(".change_name").length; i++) {
        var origin = $(".change_name")[i].innerText;
        var change_name = replaceAt(origin, 1, '*');
        $(".change_name")[i].innerText = change_name;
      }
      $(".toggle_review_sub").click(function () {
        reviewNum = $(this)[0].childNodes[0].value; //클릭된 요소에 첫번째 자식의 값  
        $("#tr_head_" + reviewNum).toggle("slow");
      });
    });

    var replaceAt = function (input, index, character) {
      return input.substr(0, index) + character + input.substr(index + character.length);
    }

    $('.carousel[data-type="multi"] .item').each(function () {
      var next = $(this).next();
      if (!next.length) {
        next = $(this).siblings(':first');
      }
      next.children(':first-child').clone().appendTo($(this));
      for (var i = 0; i < 2; i++) {
        next = next.next();
        if (!next.length) {
          next = $(this).siblings(':first');
        }
        next.children(':first-child').clone().appendTo($(this));
      }
    });

    function check() {
      if ($("#subject").val() == "") {
        swal("제목을 입력해주세요.");
        return false;
      }
      if ($("#Review").val() == "") {
        swal("내용을 입력해주세요.");
        return false;
      }
      document.input.submit();
    }
    function reCheck() {
      swal("로그인 후 이용해주세요.");
      return false;
    }

    function cartIntoFunc(val, count) {
      console.log(val);
      console.log($("#cartcnt_" + count + "").find("#count_value_" + count).text());
      var cartcount = $("#cartcnt_" + count + "").find("#count_value_" + count).text();
      $.ajax({
        url: '../food/listCartInsert.do',
        type: 'get',
        data: {
          cart_count: cartcount,
          f_name: val
        },
        success: function (result) {
          if (result == "true") {
            setTimeout(function() {
    			swal({
    				title : "장바구니 담기완료",
    				text : "나의 장바구니에서 확인해주세요.",
    				icon : "success"
    			}).then(function() {
    				location.reload();
    			});
    		}, 1000);
          }
          else {
            setTimeout(function() {
    			swal({
    				title : "장바구니 담기실패",
    				text : "다시 시도해주세요.",
    				icon : "error"
    			}).then(function() {
    				location.reload();
    			});
    		}, 1000);
          }
        },
        error: function (err) {
          swal('장바구니 담기실패');
        }
      });
    }

    function minusFunc(val) {
      console.log(val);
      var countStr = $('#count_value_' + val).text();
      console.log($('#count_value_' + val));
      console.log(countStr);
      var countNum = parseInt(countStr, 10);
      countNum--;
      if (countNum <= 0) {
        swal('최소 구매수량은 1개 입니다.');
        countNum = 1;
      }
      $('#count_value_' + val).text(countNum);
      $('#cart_count_' + val).attr('value', countNum);
      
      var m_price = parseInt($('#ori_price_'+val).val());
      console.log(m_price*countNum);
      $('#modal_price_'+val).text(m_price*countNum);
    }

    function plusFunc(val) {
      console.log(val);
      var countStr = $('#count_value_' + val).text();
      console.log($('#count_value_' + val));
      console.log(countStr);
      var countNum = parseInt(countStr, 10);
      countNum++;
      $('#count_value_' + val).text(countNum);
      $('#cart_count_' + val).attr('value', countNum);
      
      var m_price = parseInt($('#ori_price_'+val).val());
      console.log(m_price*countNum);
      $('#modal_price_'+val).text(m_price*countNum);
    }

    var marksCanvas = document.getElementById("marksChart");

    var tArr = new Array();
    var rArr = new Array();

    <c:forEach var="item" items="${nutrient}">
      <c:if test="${item.nutrient_nm == '칼로리'}">
			rArr.push(${item.rate / 2500 * 100});
			tArr.push("${item.nutrient_nm}");
		</c:if>
      <c:if test="${item.nutrient_nm != '칼로리'}">
        rArr.push(${item.rate});
			tArr.push("${item.nutrient_nm}");
		</c:if>
	</c:forEach >

      console.log(rArr);
    console.log(tArr);

    var marksData = {
      labels: tArr,
      datasets: [{
        label: "영양성분",
        backgroundColor: "rgba(255, 219, 79, 0.5)",
        data: rArr
      }]
    };

    var radarChart = new Chart(marksCanvas, {
      type: 'radar',
      data: marksData,
      options: {
        "elements": {
          "line": {
            "tension": 0,
            "borderWidth": 3
          }
        },

        "legend": {
          "display": true,
          "labels": {
            "fontSize": 20,
          }
        },
        scale: {
          pointLabels: {
            fontSize: 18,
            fontColor: "green"
          },
          legend: {
            position: 'center'
          },
          ticks: {
            fontSize: 18,
            min: 0,
            max: 100
          },
          gridLines: {
            lineWidth: 1
          }
        }
      }
    });
  </script>
</body>

</html>