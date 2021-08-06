<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko" dir="ltr">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<style type="text/css">
#modul {
	padding-top: 50px;
}

#order_state {
	margin-top: 10px;
}

#col-sm-8 {
	margin-left: 0%;
}

#last_order_id {
	text-align: center;
}

#order_list_detail_table {
	text-align: center;
}
/* 테이블 */
#last_order_id td {
	vertical-align: middle;
}

#last_order_id tr div img {
	width: 15rem;
}

#yellow_food_btn {
	background: rgba(255, 219, 79, 0.9) !important;
	color: rgba(17, 17, 17, 0.8);
	/* 	  font-size: 13px; */
	/* 	  width:170px; */
	/* 	  width: 70%; */
	margin-bottom: 10px;
}

#yellow_food_btn:hover, #yellow_food_btn:focus {
	background: rgba(255, 219, 79, 0.5) !important;
	color: rgba(17, 17, 17, 0.5);
}

input[type="text"]:focus {
	border-color: rgb(111, 186, 44);
	box-shadow: 0 0 8px 0 rgb(111, 186, 44);
}

.all_star {
	font-family: "Font Awesome 5 Free";
	font-weight: 900;
}

.all_star option {
	font-family: "Font Awesome 5 Free";
	font-weight: 900;
}
/* 모달창 문제 해결해주는 css */
.modal-backdrop {
	/* bug fix - no overlay */
	display: none;
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
</style>

<title>ONECOOK: MyPage</title>
<%@ include file="../common/head_link.jsp"%>
<!-- css 링크를 include -->

<!-- 4. Javascript -->
<script type="text/javascript" src="../js/paging.js"></script>
</head>

<body data-spy="scroll" data-target=".onpage-navigation"
	data-offset="60">
	<main>

		<%@ include file="../common/header.jsp"%>
		<!-- 상단에 메뉴를 include -->

		<div class="main">

			<%@ include file="../common/mypage_banner.jsp"%>
			<!-- mypage banner를 include -->

			<section class="module" id="modul">
				<div class="container">
					<div class="row">
						<div class="col-sm-4 col-md-3 sidebar">
							<div class="widget">
								<h4 class="comment-title font-alt">MyPage</h4>
								<ul class="icon-list">
									<li><a href="order_list.do">주문내역</a></li>
									<li><a href="mypage.do">정보수정</a></li>
									<li><a href="recipe_list.do">마이레시피</a></li>
									<li><a href="good_manager.do"><i class="fas fa-heart"
											style="color: rgba(111, 186, 44, 0.9);"></i>&nbsp;원쿡레시피</a></li>
									<li><a href="good_user.do"><i class="fas fa-heart"
											style="color: rgba(111, 186, 44, 0.9);"></i>&nbsp;쿡커레시피</a></li>
								</ul>
							</div>
						</div>

						<div class="col-sm-8 col-sm-offset-1" id="col-sm-8">
							<div class="comments" id="order_state">
								<h4 class="comment-title font-alt">주문상세목록</h4>
								<table class="table" id="last_order_id">
									<tr>
										<th id="order_list_detail_table" style="width: 15%;">제품사진</th>
										<th id="order_list_detail_table" style="width: 25%;">주문번호</th>
										<th id="order_list_detail_table" style="width: 25%;">주문명</th>
										<th id="order_list_detail_table" style="width: 10%;">수량</th>
										<th id="order_list_detail_table" style="width: 10%;">금액</th>
										<th id="order_list_detail_table" style="width: 15%;">총 금액</th>
									</tr>

									<%-- 									<c:forEach var="detail" items="${order_list_detail}"> --%>
									<!-- 										<tr> -->
									<!-- 											<td class="shop-item"> -->
									<!-- 												<div class="shop-item-image"> -->
									<%-- 													<img src="../images/food/${detail.f_type}/${detail.f_img}"> --%>
									<!-- 													<div class="shop-item-detail"> -->
									<%-- 														<c:if test="${chk_ps > 0}"> --%>
									<%-- 															<c:if test="${detail.ps_exist == 0}"> --%>
									<!-- 																<a -->
									<%-- 																	href="../food/content.do?f_name=${detail.f_name}#postScript_id"><i --%>
									<!-- 																	class="fas fa-plus-circle fa-5x" -->
									<!-- 																	style="color: rgba(111, 186, 44, 0.5);"></i></a> -->
									<%-- 															</c:if> --%>
									<%-- 															<c:if test="${detail.ps_exist == 1}"> --%>
									<!-- 																<i class="fas fa-check-circle fa-5x" -->
									<!-- 																	style="color: rgba(100, 100, 100, 0.5);"></i> -->
									<%-- 															</c:if> --%>
									<%-- 														</c:if> --%>
									<%-- 														<c:if test="${chk_ps == 0}"> --%>
									<!-- 															<a onclick="none()"><i -->
									<!-- 																class="fas fa-minus-circle fa-5x" -->
									<!-- 																style="color: rgba(100, 100, 100, 0.5);"></i></a> -->
									<!-- 															<script> -->
									<!-- // 																function none() { -->
									<!-- // 																	swal("후기작성이 만료되었어요."); -->
									<!-- // 																} -->
									<!-- 															</script> -->
									<%-- 														</c:if> --%>
									<!-- 													</div> -->
									<!-- 												</div> -->
									<!-- 											</td> -->
									<%-- 											<td>${detail.order_idx}</td> --%>
									<%-- 											<td><a href="../food/content.do?f_name=${detail.f_name}">${detail.f_name}</a></td> --%>
									<%-- 											<td>${detail.totalcount}</td> --%>
									<%-- 											<td>${detail.f_price}</td> --%>
									<%-- 											<td>${detail.pay_price}</td> --%>
									<!-- 										</tr> -->
									<%-- 									</c:forEach> --%>
									<%
										long cnt = 1;
										pageContext.setAttribute("cnt", cnt);
									%>
									<c:forEach var="detail" items="${order_list_detail}">
										<tr>
											<td class="shop-item">
												<div class="shop-item-image">
													<img src="../images/food/${detail.f_type}/${detail.f_img}">
													<div class="shop-item-detail">
														<c:if test="${chk_ps > 0}">
															<c:if test="${detail.ps_exist == 0}">
																<a data-toggle="modal" data-target="#modalFood_${cnt}"><i class="fas fa-plus-circle fa-3x" style="color: rgba(111, 186, 44, 0.5);"></i></a>
															</c:if>
															<c:if test="${detail.ps_exist == 1}">
																<i class="fas fa-check-circle fa-3x" style="color: rgba(100, 100, 100, 0.5);"></i>
															</c:if>
														</c:if>
														<c:if test="${chk_ps == 0}">
															<a onclick="none()" style="cursor:pointer;"><i class="fas fa-minus-circle fa-3x" style="color: rgba(100, 100, 100, 0.5);"></i></a>
															<script>
																function none() { 
																	swal("후기작성이 만료되었어요."); 
																}
															</script> 
														</c:if>
													</div>
												</div>
											</td>
											<td>${detail.order_idx}</td>
											<td><a href="../food/content.do?f_name=${detail.f_name}">${detail.f_name}</a></td>
											<td>${detail.totalcount}</td>
											<td>${detail.f_price}</td>
											<td>${detail.pay_price}</td>
										</tr>

										<%
											cnt++;
												pageContext.setAttribute("cnt", cnt);
										%>
									</c:forEach>
								</table>

							</div>
						</div>
					</div>
				</div>
			</section>

			<%@ include file="../common/footer.jsp"%>

			<hr class="divider-d">
			<%
				long count = 1;
				pageContext.setAttribute("count", count);
			%>
			<c:forEach var="dto" items="${order_list_detail}">
				<form id="my_order_md_form_${count}" name="input" method="post"
					action="postScript_write.do" enctype="multipart/form-data">
					<div id="cartcnt_${count}">
						<!-- Modal -->
						<div class="modal fade" id="modalFood_${count}" tabindex="-1"
							role="dialog" aria-labelledby="exampleModalCenterTitle"
							aria-hidden="true">
							<div class="modal-dialog modal-lg modal-dialog-centered" role="document">
								<div class="modal-content">
									<div class="modal-header">
										<h5 class="modal-title" id="exampleModalLongTitle">ADD REVIEW
										&nbsp;&nbsp;|&nbsp;&nbsp;<span style="font-size:11px;'">(지금 글 작성하면 <span style="color:rgb(111,186,44);">50</span> point, 이미지 작성하면 <span style="color:rgb(111,186,44);">200</span> point 적립!)</span>
										<button type="button" class="close" data-dismiss="modal"
											aria-label="close">
											<span aria-hidden="true">&times;</span>
										</button></h5>
									</div>
									<div class="modal-body">
										<div class="comment-form mt-10">
											<!--                       <h4 class="comment-form-title font-alt">Add review</h4> -->

											<input type="hidden" name="f_name" value="${dto.f_name}">
											<!-- 주문한 사람의 주문번호(추가 10/08) -->
											<%-- 							<c:forEach var="chk" items="${chk_ps}"> --%>
											<input type="hidden" name="order_idx"
												value="${dto.order_idx}">
											<%-- 							</c:forEach> --%>
											<div class="row">
<!-- 												<div class="col-sm-4"> -->
<!-- 													<div class="form-group"> -->
<!-- 														<label class="sr-only" for="name">Name</label> <input -->
<!-- 															class="form-control" type="text" -->
<%-- 															placeholder="${loginUser.user_name}" readonly /> --%>
<!-- 													</div> -->
<!-- 												</div> -->
												<div class="col-sm-4">
													<div class="form-group">
														<select class="form-control all_star" name="star"
															style="font-family: 'Font Awesome 5 Free';">
															<option value="1">&#xf005</option>
															<option value="2">&#xf005 &#xf005</option>
															<option value="3">&#xf005 &#xf005 &#xf005</option>
															<option value="4">&#xf005 &#xf005 &#xf005
																&#xf005</option>
															<option value="5" selected>&#xf005 &#xf005
																&#xf005 &#xf005 &#xf005</option>
														</select>
													</div>
												</div>
												<div class="col-sm-8">
													<!--                           <div class="col-sm-8"> -->
													<div class="form-group">
														<label class="sr-only">Name</label> <input
															class="form-control" id="rv_sub" type="text"
															name="rv_sub" placeholder="제목" />
													</div>
												</div>
												<div class="col-sm-12">
													<div class="form-group">
														<textarea class="form-control" id="rv_cont" name="rv_cont"
															rows="4" placeholder="내용입력"></textarea>
													</div>
												</div>
												<div class="col-sm-12">
													<div class="form-group">
														<input class="form-control" type="file" name="rv_img_file">
													</div>
												</div>
												<div class="col-sm-12 mt-20">

													<button id="yellow_food_btn" class="btn btn-round btn-d"
														type="button" value="${count}"
														onclick="chkPSFunc(this.value)">리뷰 작성하기</button>

												</div>
											</div>

										</div>
									</div>
								</div>
							</div>
						</div>
					</div>

					<%
			count++;
			pageContext.setAttribute("count", count);
		%>
				</form>
			</c:forEach>
		</div>
		<div class="scroll-up">
			<a href="#totop"><i class="fa fa-angle-double-up"></i></a>
		</div>
	</main>
	<%@ include file="../common/js_link.jsp"%>
	<script>
		function chkPSFunc(val){			
			swal({
				  text: "후기를 등록하시겠어요?",
				  buttons: true,
				})
				.then((willDelete) => {
					  if (willDelete) {
							setTimeout(function() {
							    swal("후기가 작성되었어요. 리뷰를 확인하러 가봅시다.", {
							      icon: "success",
							    }).then(function() {
							    	$("#my_order_md_form_" + val).submit();
								});
							}, 1000);   
					  } else {
					   		swal("후기 작성이 취소되었어요.");
					  }
				});
		}	
	</script>
</body>
</html>