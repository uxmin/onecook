<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html>
<html lang="ko" dir="ltr">

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<%@ include file="../common/head_link.jsp"%>
<%@ include file="../common/js_link.jsp"%>
<script type="text/javascript" src="../js/paging.js"></script>
<script type="text/javascript" src="../js/paging2.js"></script>
<!-- 	<script src="../js/custom-list.js"></script>	 -->

<style>
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

/* 페이징 색 처리  및 정렬*/
.row_paging_class {
	text-align: center;
}

#pagination_id>li>a {
	color: rgba(17, 17, 17, 0.8);
}

#qna_id>li>a {
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

.all_star {
	font-family: "Font Awesome 5 Free";
	font-weight: 900;
}

.all_star option {
	font-family: "Font Awesome 5 Free";
	font-weight: 900;
}

.ym-500 {
	height: 500px;
	object-fit: contain;
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
<title>ONECOOK: Food</title>
</head>

<body data-spy="scroll" data-target=".onpage-navigation"
	data-offset="60">
	<main>
		<div class="page-loader">
			<div class="loader">Loading...</div>
		</div>

		<%@ include file="../common/header.jsp"%>

		<div class="main">
			<section class="module">
				<div class="container">
					<div class="row">
						<div class="col-sm-6 mb-sm-40">
							<a class="gallery"
								href="../images/food/${read.f_type}/${read.f_img}"><img
								src="../images/food/${read.f_type}/${read.f_img}" alt="상품이미지"
								class="ym-500" /></a>
						</div>

						<form id="insert_form" name="insertCart" method="post"
							action="../pay/cart_list.do" onsubmit="return false">
							<div class="col-sm-6">
								<div class="row">
									<div class="col-sm-12">
										<h1 class="product-title font-alt">${read.f_name}</h1>
										<input type="hidden" name="f_name" value="${read.f_name}">&nbsp;&nbsp;
									</div>
									<div class="col-sm-12" style="margin-top: -30px;">
										<c:set var="avg_star" value="${avg_star}" />
										<%
											long avg_star = (long) pageContext.getAttribute("avg_star");
											for (int j = 1; j <= 5; j++) {
												if (j <= avg_star) {
										%>
										<span><i class="fa fa-star star"></i></span>
										<%
											} else {
										%>
										<span><i class="fa fa-star star-off"></i></span>
										<%
											}
											}
										%>
										<a class="open-tab section-scroll" href="#postScript_id">&nbsp;&nbsp;&nbsp;(
											${review_count} )</a>
									</div>
								</div>

								<div class="row mb-10">
									<div class="col-sm-12">
										<div class="price font-alt">
											<span class="amount" id="price">${read.f_price}</span><span
												class="amount"> &#8361;</span>
										</div>
									</div>
									<div class="col-sm-12">
										<i class="fas fa-exclamation-circle" style="color: #adadad;"></i>&nbsp;&nbsp;<span
											style="color: rgb(111, 186, 44)">지금 로그인 하시고 적립혜택 등 다양한
											혜택을 만나보세요!</span>
									</div>
								</div>
								<hr class="divider-w">
								<br />
								<div class="row mb-20">
									<table class="table table-striped ds-table table-responsive"
										style="text-align: left;">
										<tr>
											<td class="col-sm-3 left">판매단위</td>
											<td>${read.f_sales}</td>
										</tr>
										<tr>
											<td class="col-sm-3">중량/용량</td>
											<td>${read.f_weight}</td>
										</tr>
										<tr>
											<td class="col-sm-3">원산지</td>
											<td>${read.f_origin}</td>
										</tr>
										<tr>
											<td class="col-sm-3">포장타입</td>
											<td>${read.f_package}</td>
										</tr>
									</table>
								</div>
								<div class="row mt-20">
									<div class="col-sm-5 col-sm-offset-7"
										style="text-align: right;">
										<span>총 상품금액: <span id="numXprice"
											style="font-size: 30px; color: rgb(111, 186, 44);">0</span>&nbsp;원
										</span>
									</div>
								</div>
								<div class="row mt-10">
									<div class="col-sm-12" style="text-align: right;">
										<i class="fas fa-money-check" style="color: #adadad;"></i>&nbsp;&nbsp;<span>구매
											시, <span id="pointChange" style="font-size: 15px;">${read.f_price*0.05}</span>
											&#8361; 이 적립
										</span>
									</div>
								</div>
								<div class="row mt-10">
									<div class="col-lg-3 col-lg-offset-3 col-md-3 col-sm-4">
										<input class="form-control input-lg" type="number"
											id="count_value" name="cart_count" value="1"
											max="${read.f_count}" min="1" required="required" />

										<!-- 			<button class="btn btn-xs btn-success" id="count_minus" type="button">-</button> -->
										<!-- 				<span id="count_value">1</span><input type="hidden" name="cart_count" id="cart_count" value="1"> -->
										<!-- 			<button class="btn btn-xs btn-success" id="count_plus" type="button">+</button> -->

									</div>
									<c:if test="${read.f_count != 0}">
										<c:if test="${empty loginUser}">
											<div class="col-lg-6 col-md-9 col-sm-8">
												<a class="btn btn-lg btn-block btn-round btn-b"
													id="yellow_btn" onclick="unknownCart()">장바구니 담기</a>
											</div>
										</c:if>
										<c:if test="${!empty loginUser}">
											<div class="col-lg-6 col-md-9 col-sm-8">
												<a class="btn btn-lg btn-block btn-round btn-b"
													id="yellow_btn" type="submit" onclick="cartFunc()">장바구니
													담기</a>
											</div>
										</c:if>
									</c:if>
									<c:if test="${read.f_count == 0}">
										<div class="col-lg-6 col-md-9 col-sm-8">
											<a class="btn btn-lg btn-block btn-round btn-b"
												id="#" type="button" onclick="#" disabled>일시품절</a>
										</div>
									</c:if>
								</div>

								<!--
								<div class="row mb-20">
									<div class="col-sm-12">
										<div class="product_meta">
											<p>남은 재고수량 : ${read.f_count}</p>
										</div>
									</div>
								</div>
								-->
							</div>
						</form>
					</div>

					<div class="row mt-70">
						<div class="col-sm-12">
							<ul class="nav nav-tabs font-alt" role="tablist">
								<li class="active"><a href="#food_explain_id"
									data-toggle="tab"><i class="fas fa-bookmark"
										style="color: #adadad;"></i>&nbsp;상품설명</a></li>
								<li><a href="#food_detail_id" data-toggle="tab"><i
										class="fas fa-search-plus" style="color: #adadad;"></i>&nbsp;상세정보</a></li>
								<li><a id="postScript_id_get" href="#postScript_id"
									data-toggle="tab"><i class="fas fa-camera"
										style="color: #adadad;"></i>&nbsp;상품후기&nbsp;(${fp.posts_total})</a>
								</li>
								<li><a id="qna_id_get" href="#qna_id" data-toggle="tab"><i
										class="fas fa-comment-dots" style="color: #adadad;"></i>&nbsp;상품문의&nbsp;(${p.total})</a></li>
							</ul>
							<div class="tab-content">
								<div class="tab-pane active" id="food_explain_id">
									<c:forEach items="${explain}" var="fd_ex">
										${fd_ex.fe_cont}
									</c:forEach>
								</div>

								<div class="tab-pane" id="food_detail_id">
									<table class="table table-striped table-border checkout-table">
										<c:forEach items="${detail}" var="Food_detail">
											<tr>
												<td class="col-sm-4" style="background: rgb(240, 240, 240);">
													${Food_detail.fd_sub}</td>
												<td>${Food_detail.fd_cont}</td>
											</tr>
										</c:forEach>
									</table>
								</div>

								<!-- 후기 게시판 -->
								<div class="tab-pane" id="postScript_id">
									<c:if test="${!empty postScript}">
										<div class="row">
											<div class="col-sm-12">
												<table class="table table-striped checkout-table">
													<tbody>
														<tr id="review_head"background-color:rgb(240,240,240);>
															<th class="col-sm-1 hidden-xs">No</th>
															<th class="col-sm-2">Star</th>
															<th class="col-sm-4">Subject</th>
															<th class="col-sm-2">Writer</th>
															<th class="col-sm-2">Date</th>
															<th clss="col-sm-1">View</th>
														</tr>
														<c:forEach var="dto" items="${postScript}">
															<tr>
																<td clsss="hidden-xs">${dto.rv_idx}</td>
																<c:set var="star_count" value="${dto.star}" />
																<td>
																	<%
																		long star_count = (long) pageContext.getAttribute("star_count");
																				for (int i = 1; i <= 5; i++) {
																					if (i <= star_count) {
																	%> <span><i class="fa fa-star star"></i></span> <%
 	} else {
 %> <span><i class="fa fa-star star-off"></i></span> <%
 	}
 			}
 %>
																</td>
																<c:set var="contains_fname" value="${dto.f_name}" />
																<c:choose>
																	<c:when test="${fn : contains(contains_fname, ' ')}">
																		<%
																			String ori_fname = (String) pageContext.getAttribute("contains_fname");
																							String split_fname = ori_fname.replace(" ", "_");
																							pageContext.setAttribute("split_fname", split_fname);
																		%>
																		<td><a
																			class="toggle_review_sub collapsed support_${dto.rv_idx}"
																			data-toggle="collapse" data-parent="#accordion"
																			href="#support_${dto.rv_idx}"
																			onclick="updateCntFunc(this.href, '${dto.f_name}')"><input
																				type="hidden" value="${dto.rv_idx}">${dto.rv_sub}
																				<c:if test="${!empty dto.rv_img}">
																					&nbsp;&nbsp;<i class="fas fa-camera"></i>
																				</c:if></a></td>
																	</c:when>
																	<c:otherwise>
																		<td><a
																			class="toggle_review_sub collapsed support_${dto.rv_idx}"
																			data-toggle="collapse" data-parent="#accordion"
																			href="#support_${dto.rv_idx}"	
																			onclick="updateCntFunc(this.href, '${dto.f_name}')"><input
																				type="hidden" value="${dto.rv_idx}">${dto.rv_sub}
																				<c:if test="${!empty dto.rv_img}">
																					&nbsp;&nbsp;<i class="fas fa-camera"></i>
																				</c:if></a></td>
																	</c:otherwise>
																</c:choose>
																<td class="change_name">${dto.user_name}</td>
																<td>${dto.rv_date}</td>
																<td id="view_count_${dto.rv_idx}">${dto.rv_num}</td>


															</tr>
															<tr class="show_review_tr" id="support_${dto.rv_idx}"
																value=0>
																<input class="hdn_rvNum" type="hidden"
																	value="${dto.rv_idx}">
																<input type="hidden" value="${dto.f_name}">
																<td colspan="6"
																	style="text-align: center; background: white;">
																	<h5>${dto.rv_cont}</h5> <c:if
																		test="${ !empty dto.rv_img}">
																		<img class="mt-10 mb-30"
																			src="../images/food/postScript/${dto.rv_img}"
																			style="max-width: 50%; height: auto;">
																	</c:if> <c:if
																		test="${loginUser.email eq dto.email || loginUser.user_type eq 'MANAGER'}">
																		<br />
																		<hr class="divider-w">
																		<button class="btn btn-g btn-round mt-10"
																			onclick="reviewDel(${dto.rv_idx},'${dto.f_name}')" style="cursor:pointer;">Delete</button>
																		<script>
																			function reviewDel(idx,fname){
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
																										location.href="postScript_del.do?rv_idx="+idx+"&f_name="+fname;
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
										</div>
										<div class="row_paging_class">
											<ul class="pagination" id="pagination2">
												<c:if test="${fp.posts_pageStartNum ne 1}">
													<!-- 				맨 첫페이지 이동 -->
													<li><a
														onclick='pagePre2(${fp.posts_pageCnt+1},${fp.posts_pageCnt});'>&laquo;</a>
													</li>
													<!--이전 페이지 이동 -->
													<%-- 				<li><a onclick='pagePre(${fp.posts_pageStartNum},${fp.posts_pageCnt});'>&lsaquo;</a></li> --%>
												</c:if>

												<!--페이지번호 -->
												<c:forEach var='i' begin="${fp.posts_pageStartNum}"
													end="${fp.pageLastNum}" step="1">
													<li class='pageIndex2${i}'><a
														onclick='pageIndex2(${i});'>${i}</a></li>
												</c:forEach>

												<c:if test="${fp.lastChk}">
													<!-- 다음 페이지 이동 -->
													<li><a
														onclick='pageNext2(${fp.posts_pageStartNum},${fp.posts_total},${fp.posts_listCnt},${fp.posts_pageCnt});'>&rsaquo;</a>
													</li>
													<!-- 마지막 페이지 이동 -->
													<li><a
														onclick='pageLast2(${fp.posts_pageStartNum},${fp.posts_total},${fp.posts_listCnt},${fp.posts_pageCnt});'>&raquo;</a>
													</li>
												</c:if>
											</ul>
											<form action="content.do#postScript_id" method="post"
												id='frmPaging2'>
												<!-- 출력할 페이지번호, 출력할 페이지 시작 번호, 출력할 리스트 갯수 -->
												<input type='hidden' name='posts_index' id='posts_index'
													value='${fp.posts_index}'> <input type='hidden'
													name='posts_pageStartNum' id='posts_pageStartNum'
													value='${fp.posts_pageStartNum}'> <input
													type='hidden' name='posts_listCnt' id='posts_listCnt'
													value='${fp.posts_listCnt}'> <input type='hidden'
													name='f_name' value='${read.f_name}'>
											</form>
										</div>
									</c:if>
									<c:if test="${empty postScript}">
										<div class="row">
											<div class="col-sm-12">
												<div class="features-item">
													<div class="features-icon">
														<span class="icon-caution" aria-hidden="true"></span>
													</div>
													<h3 class="features-title font-alt">이런!</h3>
													아직 작성된 글이 없어요.
												</div>
											</div>
										</div>
									</c:if>

								</div>
								<!-- 문의 게시판 -->
								<div class="tab-pane" id="qna_id">
									<c:if test="${!empty list}">
										<div class="comments" style="margin: 0px;">
											<c:forEach var="dto" items="${list}">
												<div class="comment clearfix">
													<div class="comment-avatar" style="text-align: center;">
														<div class="features-icon" style="font-size: 30px;">
															<span class="icon-chat"></span>
														</div>
														<span>[${dto.q_type}]</span><br /> <span>${dto.q_idx}</span>
													</div>
													<div class="comment-content clearfix">
														<div class="comment-author font-alt">${dto.q_sub}&nbsp;<c:if
																test="${!empty dto.q_reply}">
																<i class="fas fa-check-circle"
																	style="color: rgba(111, 186, 44, 0.8);"></i>
															</c:if>
														</div>

														<!-- 로그인유저 == 글작성유저 && 관리자 -->
														<c:if
															test="${loginUser.email eq dto.email || loginUser.user_type eq 'MANAGER'}">
															<div class="comment-body">
																<p
																	style="border: 1px solid gainsboro; padding: 5px 15px;">
																	${dto.q_cont}</p>
															</div>
														</c:if>
														<!-- 로그인유저 != 글작성유저 -->
														<c:if
															test="${loginUser.email ne dto.email && loginUser.user_type ne 'MANAGER'}">
															<div class="comment-body">
																<p
																	style="border: 1px solid gainsboro; padding: 5px 15px;">
																	<i class="fas fa-lock"></i>&nbsp;&nbsp;해당 글은 작성자와 관리자만
																	볼 수 있어요.
																</p>
															</div>
														</c:if>

														<div class="comment-meta font-alt"
															style="margin-top: -10px;">
															BY&nbsp;${dto.user_name}
															<!-- 로그인유저 == 글작성유저 && 관리자 -->
															<c:if
																test="${loginUser.email eq dto.email || loginUser.user_type eq 'MANAGER'}">
																<c:if test="${!empty dto.q_reply}">
																	&nbsp;|&nbsp;<a id="${dto.q_idx}" href="#qna_id"
																		onclick="view(this.id)">MORE</a>
																</c:if>
																<c:if test="${empty dto.q_reply}">&nbsp;|&nbsp;<a
																		href="#qna_id" onclick="noneView()">MORE</a>
																</c:if>
																&nbsp;|&nbsp;<a
																	onclick="qnaDel(${dto.q_idx},'${dto.f_name}')" style="cursor:pointer;">Delete</a>
																<script>
																	function qnaDel(idx,fname){
																		swal({
																			  text: "작성된 문의를 삭제하시겠어요?",
																			  icon: "warning",
																			  buttons: true,
																			  dangerMode: true,
																			})
																			.then((willDelete) => {
																				  if (willDelete) {
																						setTimeout(function() {
																						    swal("문의가 삭제되었어요.", {
																						      icon: "success",
																						    }).then(function() {
																						    	location.href="qna_del.do?q_idx="+idx+"&f_name="+fname;
																							});
																						}, 1000);   
																				  } else {
																				   		swal("삭제가 취소되었어요.");
																				  }
																			});
																	}
																</script>
															</c:if>
															<!-- 관리자 && 답변X -->
															<c:if
																test="${loginUser.user_type eq 'MANAGER' && empty dto.q_reply}">
																&nbsp;|&nbsp;<a id="c-${dto.q_idx}" href="#qna_id"
																	onclick="cView(this.id)">Comment</a>
															</c:if>
														</div>
													</div>

													<!-- 답변X && 관리자 -->
													<c:if
														test="${loginUser.user_type eq 'MANAGER' && empty dto.q_reply}">
														<form id="f_b_${dto.q_idx}" class="ym-form"
															name="reply_for" onsubmit="return false;">
															<input name="q_idx" type="hidden" value="${dto.q_idx}" />
															<div class="comment clearfix" id="#">
																<textarea class="form-control " name="q_reply"
																	placeholder="답변을 입력해주세요."></textarea>
																<button id="b_${dto.q_idx}"
																	class="btn btn-round btn-d mt-10 mb-30 q_reply_btn yellow_btn"
																	type="button" style="color:black">답변 작성하기</button>
															</div>
														</form>
													</c:if>
													<!-- 답변O -->
													<c:if test="${!empty dto.q_reply}">
														<div class="comment clearfix ym-div"
															id="ym-div-${dto.q_idx}" style="margin-top: 15px;">
															<div class="comment-avatar" style="text-align: center;">
																<div class="features-icon">
																	<img src="../assets/images/logo_noneback.png">
																</div>
															</div>
															<div class="comment-content">
																<pre class="font-alt" style="font-size:12px;padding:0;background-color: #ffffff; margin:0; border:none"><p style="border: 1px solid gainsboro; padding: 10px 15px;">${dto.q_reply}</p></pre>
																<div class="comment-meta font-alt"
																	style="margin-top: -10px;">
																	BY&nbsp;<span style="color: rgba(111, 186, 44, 0.8);">CONECOOK</span>
																</div>
															</div>
														</div>
													</c:if>
												</div>
												<br />
											</c:forEach>
											<br /> <br />

											<div class="row_paging_class">
												<ul class="pagination" id="pagination1">
													<c:if test="${p.pageStartNum ne 1}">
														<!-- 				맨 첫페이지 이동 -->
														<li><a
															onclick='pagePre(${p.pageCnt+1},${p.pageCnt});'>&laquo;</a>
														</li>
														<!-- 				이전 페이지 이동 -->
														<li><a
															onclick='pagePre(${p.pageStartNum},${p.pageCnt});'>&lsaquo;</a>
														</li>
													</c:if>

													<!--페이지번호 -->
													<c:forEach var='i' begin="${p.pageStartNum}"
														end="${p.pageLastNum}" step="1">
														<li class='pageIndex${i}'><a
															onclick='pageIndex(${i});'>${i}</a></li>
													</c:forEach>

													<c:if test="${p.lastChk}">
														<!-- 				다음 페이지 이동 -->
														<li><a
															onclick='pageNext(${p.pageStartNum},${p.total},${p.listCnt},${p.pageCnt});'>&rsaquo;</a>
														</li>
														<!-- 				마지막 페이지 이동 -->
														<li><a
															onclick='pageLast(${p.pageStartNum},${p.total},${p.listCnt},${p.pageCnt});'>&raquo;</a>
														</li>
													</c:if>
												</ul>
											</div>

											<form action="content.do#qna_id" method="post" id='frmPaging'>
												<!-- 출력할 페이지번호, 출력할 페이지 시작 번호, 출력할 리스트 갯수 -->
												<input type='hidden' name='index' id='index'
													value='${p.index}'> <input type='hidden'
													name='pageStartNum' id='pageStartNum'
													value='${p.pageStartNum}'> <input type='hidden'
													name='listCnt' id='listCnt' value='${p.listCnt}'> <input
													type='hidden' name='f_name' id='index'
													value='${read.f_name}'>
											</form>
										</div>
									</c:if>
									<c:if test="${empty list}">
										<div class="row">
											<div class="col-sm-12">
												<div class="features-item">
													<div class="features-icon">
														<span class="icon-caution" aria-hidden="true"></span>
													</div>
													<h3 class="features-title font-alt">이런!</h3>
													아직 작성된 글이 없어요.
												</div>
											</div>
										</div>
									</c:if>

									<c:if test="${ !empty loginUser}">
										<div class="comment-form mt-30">
											<h4 class="comment-form-title font-alt">Add Q&A</h4>
											<form id="form-insert" name="insert" method="post" action="qna_insert.do">
												<input type="hidden" name="f_name" value="${read.f_name}" />
												<div class="row">
													<div class="col-sm-4">
														<div class="form-group">
															<select name="q_type" id="q_type" class="form-control">
																<option id="상품" value="상품">상품</option>
																<option id="배송" value="배송">배송</option>
																<option id="환불" value="환불">환불</option>
															</select>
														</div>
													</div>
													<div class="col-sm-8">
														<div class="form-group">
															<label class="sr-only" for="name">Name</label> <input
																class="form-control" type="text"
																placeholder="${loginUser.user_name}" / readonly>
														</div>
													</div>
													<div class="col-sm-12">
														<div class="form-group">
															<label class="sr-only">Name</label> <input
																class="form-control" id="q_sub" type="text" name="q_sub"
																placeholder="Subject" />
														</div>
													</div>

													<div class=" col-sm-12">
														<div class="form-group">
															<textarea class="form-control" id="a_cont" name="q_cont"
																rows="4" placeholder="Content"></textarea>
														</div>
													</div>
													<div class="col-sm-12">
														<button id="yellow_btn" class="btn btn-round btn-d"
															type="button" onclick="submitQNA()">문의 작성하기</button>
														<script>
															function submitQNA(){
																setTimeout(function(){
																	  swal({
																		  title: "문의작성 완료",
																		  text: "작성된 문의글을 확인해주세요.",
																		  icon: "success"
																	  }).then(function(){
																		  document.getElementById("form-insert").submit();
																	  });
																  },1000);
															}
														</script>
													</div>
												</div>
											</form>
										</div>
									</c:if>

								</div>
							</div>
						</div>
					</div>
			</section>

			<hr class="divider-w">
			<section class="module">
				<div class="container">
					<div class="row">
						<div class="col-sm-6 col-sm-offset-3">
							<h2 class="module-title font-alt">Another FOOD</h2>
							<div class="module-subtitle font-alt">
								비슷한 상품을 찾고 계신가요?<br />여기 원쿡이 다양한 상품들을 준비했어요.
							</div>
						</div>
					</div>
					<div class="row">
						<div class="owl-carousel text-center" data-items="5"
							data-pagination="false" data-navigation="false">
							<c:forEach var="fl" items="${flist}">
								<c:if test="${read.f_name != fl.f_name}">
									<div class="owl-item">
										<div class="col-sm-12">
											<div class="ex-product">
												<a href="content.do?f_name=${fl.f_name}"><img
													src="../images/food/${fl.f_type}/${fl.f_img}" alt="이미지 X" /></a>
												<h4 class="shop-item-title font-alt">
													<a href="content.do?f_name=${fl.f_name}">${fl.f_name}</a>
												</h4>
												<h5 class="font-alt">${fl.f_price}&#8361;</h5>
											</div>
										</div>
									</div>
								</c:if>
							</c:forEach>

						</div>
					</div>
				</div>
			</section>

			<hr class="divider-w">
			<section class="module">
				<div class="container">
					<div class="row">
						<div class="col-sm-6 col-sm-offset-3">
							<h2 class="module-title font-alt">BEST FOOD</h2>
							<div class="module-subtitle font-alt">
								ONECOOK에서 가장 많이 팔리고 있는 재료들이에요.<br />서둘러요. 얼른 둘러보러 가자고요.
							</div>
						</div>
					</div>
					<div class="row multi-columns-row">
						<c:forEach var="bf" items="${bestFood}">
							<div class="col-sm-6 col-md-3 col-lg-3">
								<div class="shop-item">
									<div class="shop-item-image">
										<img src="../images/food/${bf.f_type}/${bf.f_img}"
											alt="Accessories Pack" />
										<div class="shop-item-detail">
											<a id="yellow_btn" class="btn btn-round btn-b"
												href="content.do?f_name=${bf.f_name}"><i
												class="fas fa-search"></i>&nbsp;상세보기</a>
										</div>
									</div>
									<h4 class="shop-item-title font-alt">
										<i class="fas fa-fire" style="color: rgba(111, 186, 44, 0.8);"></i>&nbsp;<a>${bf.f_name}</a>
									</h4>
									<h5 class="font-alt">${bf.f_price}&#8361;</h5>
								</div>
							</div>
						</c:forEach>
					</div>
				</div>
			</section>



			<%@ include file="../common/footer.jsp"%>

		</div>
		<div class="scroll-up">
			<a href="#totop"><i class="fa fa-angle-double-up"></i></a>
		</div>
	</main>
	<!--  
    JavaScripts
    =============================================
    -->
	<%-- 	<%@ include file="../common/js_link.jsp" %> --%>
	<script>
		var replaceAt = function (input, index, character) {
			return input.substr(0, index) + character + input.substr(index + character.length);
		}

		$(document).ready(function () {
			//페이지 url 받아오기
			console.log($(location).attr('href'));
			var findUrl = $(location).attr('href');
			var urlSplit = findUrl.split('#');
			//페이징을 할때 해당 url에 #이 포함되어 있다면
			if (findUrl.indexOf("#") !== -1) {
				if (urlSplit[urlSplit.length - 1] == 'postScript_id') {
					// 			console.log(urlSplit[urlSplit.length-1]);
					var geturl = urlSplit[urlSplit.length - 1];
					console.log(geturl);
					// 			console.log($("#" + urlSplit[urlSplit.length-1]));
					// 	        var offset = $("#" + urlSplit[urlSplit.length-1]).offset();
					// 	        console.log(offset);
					// 	        $('html, body').animate({scrollTop : offset.top}, 400);
					// 			$("."+geturl).attr("class", "active");
					$('#' + geturl + '_get').get(0).click();
					// 			location.href = "#postScript_id";
				}
				else if (urlSplit[urlSplit.length - 1] == 'qna_id') {
					var geturl = urlSplit[urlSplit.length - 1];
					$('#' + geturl + '_get').get(0).click();

				}
			}


			// 	      var jbString = 'abc,def,ghi';
			// 	      var jbSplit = jbString.split(',');
			// 	      for ( var i in jbSplit ) {
			// 	        document.write( '<p>' + jbSplit[i] + '</p>' );
			// 	      }



			for (var i = 0; i < $(".qna_user_name").length; i++) {
				console.log($(".qna_user_name")[i].innerText);
				var origin = $(".qna_user_name")[i].innerText;

				var change_name = replaceAt(origin, 1, '*');
				console.log(change_name);
				$(".qna_user_name")[i].innerText = change_name;
			}

			for (var i = 0; i < $(".rv_user_name").length; i++) {
				console.log($(".rv_user_name")[i].innerText);
				var origin = $(".rv_user_name")[i].innerText;

				var change_name = replaceAt(origin, 1, '*');
				console.log(change_name);
				$(".rv_user_name")[i].innerText = change_name;
			}

			$('#count_minus').click(function (e) {
				e.preventDefault();
				var countStr = $('#count_value').text();
				var countNum = parseInt(countStr, 10);
				countNum--;
				var priceStr = $('#price').text();
				var price = parseInt(priceStr, 10);
				var totalNum = countNum * price;

				if (countNum <= 0) {
					swal('최소 구매수량은 1개 입니다.');
					countNum = 1;
					totalNum = ${ read.f_price };
				}
				$('#count_value').text(countNum);
				$('#total_price').text(totalNum);
				$('#cart_count').attr('value', countNum);
			});

			$('#count_plus').click(function (e) {
				e.preventDefault();
				var countStr = $('#count_value').text();
				var countNum = parseInt(countStr, 10);
				countNum++;
				var priceStr = $('#price').text();
				var price = parseInt(priceStr, 10);
				var totalNum = countNum * price;

				// 			if(countNum>5){
				// 				alert('최대 구매수량은 5개 입니다.');
				// 				countNum = 5;
				// 			}
				$('#count_value').text(countNum);
				$('#total_price').text(totalNum);
				$('#cart_count').attr('value', countNum);
			});

			$(".hide_qna").css("display", "none");

			$(".sub_class").click(function () {
				// 			console.log($(this).css("display"));
				var sub = $(this)[0].id;
				// 			console.log(sub);
				$("#slide_" + sub).slideToggle("slow");
				$("#slide2_" + sub).slideToggle("slow");
			});

			$(".reply_class").click(function () {
				var reply = $(this)[0].target;
				console.log(reply);
				$("#tr_a_" + reply).slideToggle("slow");
				// 			$("#slide2_" + sub).slideToggle("slow");
			});

			$(".q_reply_btn").click(function () {
				var bidx = $(this)[0].id;
				var reply_var = $("#f_" + bidx).serialize();
				$.ajax({
					url: "reply.json",
					type: "POST",
					data: reply_var,
					dataType: "json",
					success: function (response) {
						// 					$("#a_"+response.q_idx).text(response.q_reply);
						// 					$("#tr_"+response.q_idx).css("display", "none");
						// 					$("#tr_a_"+response.q_idx).css("display", "block");
						setTimeout(function () {
							swal({
								title: "답변작성 완료!",
								text: "해당 글의 답변을 확인해주세요.",
								icon: "success"
							}).then(function () {
								location.reload();
							});
						}, 1000);
					}
				});
			});

			//총 상품금액 띄우기
			var p = $("#price").text();
			var n = $("#count_value").val();
			var pn = p * n;
			$("#numXprice").text(pn);

			$("#count_value").bind("keyup mouseup", function () {
				var nn = $("#count_value").val();
				var pnn = p * nn;
				$("#numXprice").text(pnn);
				$("#pointChange").text((pnn * 0.05).toFixed(1));
			});

			//상품후기
			$(".show_review_tr").css("display", "none");
			$(".toggle_review_sub").click(function () {
				reviewNum = $(this)[0].childNodes[0].value; //클릭된 요소에 첫번째 자식의 값
				console.log(reviewNum);
				$("#support_" + reviewNum).toggle("slow");
			});
			//상품문의
			$('.ym-div').hide();
			$('.ym-form').hide();
		});

		//상품문의
		function view(idx) {
			$('#ym-div-' + idx).fadeIn(1000);
			$('#' + idx).attr('onclick', 'hide(this.id)');
		}
		function hide(idx) {
			$('#ym-div-' + idx).fadeOut(1000);
			$('#' + idx).attr('onclick', 'view(this.id)');
		}
		function cView(id) {
			var idx = id.substr(2);
			$('#f_b_' + idx).fadeIn(1000);
			$('#c-' + idx).attr('onclick', 'cHide(this.id)');
		}
		function cHide(id) {
			var idx = id.substr(2);
			$('#f_b_' + idx).fadeOut(1000);
			$('#c-' + idx).attr('onclick', 'cView(this.id)');
		}
		function noneView() {
			setTimeout(function () {
				swal({
					title: "이런...",
					text: "아직 등록된 답변이 없어요.",
					icon: "warning"
				}).then(function () {
					return false;
				});
			}, 1000);
		}

		//장바구니 담기
		function cartFunc() {
			$("#insert_form").attr("onsubmit", "return true");
			$("#insert_form").submit();
		}
		
		function updateCntFunc(thshref, f_name){
			console.log(thshref);
			console.log(f_name);
	// 		console.log(f_name);
			
			var splithref = thshref.split('#');
			var endhref = splithref[splithref.length-1];
			var splitel = f_name.split('#');	
	// 		console.log(splitel[0]);	
	// 		console.log(splitel[1]);	
	
			var split_idx = splithref[1].split("_"); //후기번호 추출 , split_idx[1]에  후기글 번호 존재
			console.log(split_idx);
			
			var ajax_fname= f_name; // == 현재 후기를 남긴 재료명
	
	
			console.log($('#'+endhref)[0].attributes[2].value);
			$('#'+endhref)[0].attributes[2].value++;
			console.log($('#'+endhref).val());
			//짝수일때 줄이기
			if(($('#'+endhref)[0].attributes[2].value)%2 == 0){
	// 			console.log('짝수');
			}
			// 홀수일때 넓히기( 즉, 조회수 업데이트 시키기)
			else{
	// 			console.log('홀수');
				$.ajax({
	    			url:"update.json",
	    			type:"get",
	    			data: {rv_idx : split_idx[1], f_name : ajax_fname},
	    			success: function(result){
						console.log(result);
						console.log(result.rv_num);
						console.log(result.rv_idx);
						console.log($('#view_count_' + result.rv_idx));
						$('#view_count_' + result.rv_idx).text(result.rv_num);
	    			},
					error:function(request,status,error){
						console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
					}
				});
			}
	
		}
	

		function unknownCart() {
			setTimeout(function () {
				swal({
					text: "로그인 후 이용해주세요.",
				}).then(function () {
					location.href = "../login_admission/login.do";
				});
			}, 1000);
		}
		function chkPSFunc(){
			var result = confirm("후기를 작성하시겠습니까?\n(글작성 후기 : 50p / 이미지작성 후기 : 200p)");
			
			if(result){
				$("form[name=input]").submit();
			}
			else{
				return false;
			}
		}
		
	</script>
</body>

</html>