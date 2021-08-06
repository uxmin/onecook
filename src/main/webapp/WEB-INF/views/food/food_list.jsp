<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko" dir="ltr">

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<%@ include file="../common/head_link.jsp"%>
<%@ include file="../common/js_link.jsp"%>
<!-- 	<script src="../js/jquery-3.1.1.min.js"></script> -->
<script type="text/javascript" src="../js/paging.js"></script>
<!-- 	<script src="../js/bootstrap.min.js"></script> -->
<!-- 	<link rel="stylesheet" href="../css/bootstrap.min.css"> -->
<!-- 	<link rel="stylesheet" href="../css/bootstrap-theme.min.css"> -->
<style>
#food_tit_img_id {
	padding: 8% 3% 3% 3%;
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

#yellow_btn {
	background: rgba(255, 219, 79, 0.9) !important;
	color: rgba(17, 17, 17, 0.8);
	font-size: 13px;
}

#yellow_btn:hover, #yellow_btn:focus {
	background: rgba(255, 219, 79, 0.5) !important;
	color: rgba(17, 17, 17, 0.5);
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

.food_list_img {
	max-width: 24em;
	max-height: 24em;
}

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
input[type="text"]:focus {
	border-color: rgb(111, 186, 44);
	box-shadow: 0 0 8px 0 rgb(111, 186, 44);
}
</style>
<script type="text/javascript">
		$(document).ready(function () {
			var sort_hdn = $("#sort_hdn_id").val();
			$("#s_" + sort_hdn).attr("selected", "selected");
			var search_hdn = $("#search_hdn_id").val();
			$("#food_search").attr("value", search_hdn);

			$("#food_search_button").on("click", function () {
				console.log('ass');
				$.ajax({
					url: "search_name.json",
					type: "POST",
					data: { f_name: $("#food_search").val() },
					success: function (data) {
						if (!data) return false;
						$("body").html(data);
						$("#frmPaging").attr("action", "search_name");
					}
				});
			});
			$("#btn_icon").on("click", function () {
				console.log('ass');
				$.ajax({
					url: "search_name.json",
					type: "POST",
					data: { f_name: $("#food_search").val() },
					success: function (data) {
						if (!data) {
							setTimeout(function () {
								swal({
									text: "검색 결과가 없어요.",
									icon: "error"
								}).then(function () {
									return false;
								});
							}, 1000);
						}
						$("body").html(data);
						$("#frmPaging").attr("action", "search_name");
					}
				});
			});

			/* 카테고리 수정건 */
			var toArr = $("#filters li a").toArray();
			toArr[0].setAttribute("style", "color:rgb(111,186,44)"); /*전체 칠하기*/

			var cat = $("#category").val();
			console.log("??" + cat);
			if (cat == "") {
				cat = "전체";
			} else {
				cat = cat.replaceAll("_", "·");
			}
			for (i = 0; i < $("#filters li a").length; i++) {
				if (toArr[i].text == cat) {
					toArr[0].setAttribute("style", "none");
					toArr[i].setAttribute("style", "color:rgb(111,186,44)");
				}
			};

			$("#filters li a").click(function () {
				var cat = $(this).text();
				cat = cat.replaceAll("·", "_");
				console.log(cat);

				if (cat == "전체") {
					$.ajax({
						url: "food_list.do",
						type: "GET",
						success: function (result) {
							$("body").html(result);
							$("#frmPaging").attr("action", "food_list.do");
						}
					});
				} else {
					$.ajax({
						url: "category.do",
						type: "GET",
						data: { category: cat },
						success: function (result) {
							$("body").html(result);
							$("#frmPaging").attr("action", "category.do");
						}
					});
				}
			});
		});

		function sort(val) {
			var sort_val = $("#food_sort option:selected").val();

			if (sort_val == "new") {
				$.ajax({
					url: "food_list.do",
					type: "GET",
					success: function (result) {
						$("body").html(result);
						$("#frmPaging").attr("action", "list.do");
						$("#new").attr("selected", "selected");
					}
				});
			} else if (sort_val == "high") {
				$.ajax({
					url: "price.do",
					type: "GET",
					data: { sort: $("#s_high").val() },
					success: function (result) {
						$("body").html(result);
						$("#frmPaging").attr("action", "price.do");
						$("#s_high").attr("selected", "selected");
					}
				});
			} else {
				$.ajax({
					url: "price.do",
					type: "GET",
					data: { sort: $("#s_low").val() },
					success: function (result) {
						$("body").html(result);
						$("#frmPaging").attr("action", "price.do");
						$("#s_low").attr("selected", "selected");
					}
				});
			}
		}

		function enterKey(e) {
			if (event.keyCode == 13) {
				$.ajax({
					url: "search_name.json",
					type: "POST",
					data: { f_name: $("#food_search").val() },
					success: function (data) {
						if (!data) return false;
						$("body").html(data);
						$("#frmPaging").attr("action", "search_name");
					}
				});
			}
		}

		function cartIntoFunc(val, count) {
			console.log(val);
			// 		console.log(count);
			// 		console.log($("#cartcnt_" + count +""));
			// 		console.log($("#cartcnt_" + count +"").find("#count_value_" + count));
			console.log($("#cartcnt_" + count + "").find("#count_value_" + count).text());
			var cartcount = $("#cartcnt_" + count + "").find("#count_value_" + count).text();

			$.ajax({
				url: 'listCartInsert.do',
				type: 'get',
				data: {
					cart_count: cartcount,
					f_name: val
				},
				success: function (result) {
					if (result == "true") {
						setTimeout(function () {
							swal({
								title: "장바구니 담기완료!",
								text: "나의 장바구니에서 확인해주세요.",
								icon: "success"
							}).then(function () {
								location.reload();
							});
						}, 1000);
					}
					else {
						setTimeout(function () {
							swal({
								title: "장바구니 담기실패!",
								text: "재료를 담는데 문제가 생겼어요. 다시 시도해주세요.",
								icon: "error"
							}).then(function () {
								location.reload();
							});
						}, 1000);
					}

				},
				error: function (err) {
					swal("재료담기 실패");
				}
			});
		}

		//replaceAll prototype 선언
		String.prototype.replaceAll = function (org, dest) {
			return this.split(org).join(dest);
		}

		function minusFunc(val) {
			console.log(val);
			var countStr = $('#count_value_' + val).text();
			console.log($('#count_value_' + val));
			console.log(countStr);
			var countNum = parseInt(countStr, 10);
			countNum--;
			if (countNum <= 0) {
				swal("최소 구매수량은 1개입니다.");
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
	</script>
<title>ONECOOK: Mart</title>
</head>

<body data-spy="scroll" data-target=".onpage-navigation"
	data-offset="60">
	<input id="category" type="hidden" value="${p.category}">
	<input id="sort_hdn_id" type="hidden" value="${p.sort}">
	<input id="search_hdn_id" type="hidden" value="${p.f_name}">


	<main>
		<div class="page-loader">
			<div class="loader">Loading...</div>
		</div>

		<%@ include file="../common/header.jsp"%>
		<div class="main">
			<section id="food_tit_img_id"
				class="module bg-dark-60 shop-page-header"
				data-background="../assets/images/vegetables-1149006_1920.jpg">
				<div class="container">
					<div class="row">
						<div class="col-sm-6 col-sm-offset-3">
							<h2 class="module-title font-alt">ONECOOK MART</h2>
							<div class="module-subtitle font-alt">
								요리는 하고 싶은데 재료가 부족하시다구요?<br />자, 원쿡이 신선한 재료를 제공합니다. 둘러봅시다!
							</div>
						</div>
					</div>
				</div>
			</section>

			<section class="module">
				<div class="container">

					<div class="row">
						<div class="col-sm-12">
							<ul class="filter font-alt" id="filters">
								<li><a class="current wow fadeInUp" href="#">전체</a></li>
								<li><a class="wow fadeInUp" href="#" data-wow-delay="0.2s">채소</a>
								</li>
								<li><a class="wow fadeInUp" href="#" data-wow-delay="0.4s">정육·계란</a>
								</li>
								<li><a class="wow fadeInUp" href="#" data-wow-delay="0.6s">수산·해산·건어물</a>
								</li>
								<li><a class="wow fadeInUp" href="#" data-wow-delay="0.8s">면·양념·오일</a>
								</li>
								<li><a class="wow fadeInUp" href="#" data-wow-delay="1.0s">기타재료</a>
								</li>
							</ul>
						</div>
					</div>
					<form class="row" style="padding: 5rem 0rem 15rem 0rem;">
						<!--
						<div class="col-sm-2 mb-sm-20">
							<select class="form-control" name="food_type" id="food_type"
								onchange="category(this.value);">
								<option id="all" value="전체">전체</option>
								<option id="c_채소" value="채소">채소</option>
								<option id="c_수산_해산_건어물" value="수산_해산_건어물">수산/해산/건어물</option>
								<option id="c_정육_계란" value="정육_계란">정육/계란</option>
								<option id="c_면_양념_오일" value="면_양념_오일">면/양념/오일</option>
								<option id="c_기타재료" value="기타재료">기타재료</option>
							</select>
						</div>
						-->
						<div class="col-sm-2 mb-sm-20">
							<select class="form-control" name="food_sort" id="food_sort"
								onchange="sort(this.value);">
								<option id="new" value="new">신상품순</option>
								<option id="s_high" value="high">높은 가격순</option>
								<option id="s_low" value="low">낮은 가격순</option>
							</select>
						</div>
						<div class="col-sm-4 col-sm-offset-4 mb-sm-20">
							<div class="search-box">
								<input class="form-control" type="text" placeholder="Search..."
									id="food_search" onkeydown="enterKey(this)" />
								<button class="search-btn" id="btn_icon" type="button">
									<i class="fa fa-search"></i>
								</button>
							</div>
						</div>
						<div class="col-sm-2">
							<button class="btn btn-block btn-round btn-g"
								id="food_search_button" type="button">찾기</button>
						</div>
					</form>

					<div class="row multi-columns-row">
						<%
							long cnt = 1;
							pageContext.setAttribute("cnt", cnt);
						%>
						<c:forEach var="dto" items="${list}">
							<div class="col-sm-6 col-md-4 col-lg-4">
								<div class="shop-item">
									<%--                   <div class="shop-item-image"><image src="../images/food/${dto.f_type}/${dto.f_img}" width="70%" height="70%" alt="Accessories Pack"/> --%>
									<div class="shop-item-image">
										<image src="../images/food/${dto.f_type}/${dto.f_img}"
											class="food_list_img" alt="Accessories Pack" />
										<div class="shop-item-detail">
											<a id="yellow_food_btn" class="btn btn-round btn-b"
												href="content.do?f_name=${dto.f_name}"><i
												class="fas fa-search"></i>&nbsp;상세보기</a>
											<c:if test="${! empty loginUser}">
												<a id="yellow_food_btn" class="btn btn-round btn-b"
													data-toggle="modal" data-target="#modalFood_${cnt}"><i
													class="fas fa-shopping-cart"></i>&nbsp;장바구니</a>
											</c:if>
										</div>
									</div>
									<h4 class="shop-item-title font-alt">
										<a href="content.do?f_name=${dto.f_name}">${dto.f_name}</a>
									</h4>${dto.f_price}
									&#8361;
								</div>
							</div>
							<%
							cnt++;
							pageContext.setAttribute("cnt", cnt);
						%>
						</c:forEach>
					</div>

					<div class="row row_paging_class">
						<div class="col-sm-12 mt-80">
							<ul class="pagination font-alt" id="pagination_id">
								<c:if test="${p.pageStartNum ne 1}">
									<li><a onclick='pagePre(${p.pageStartNum},${p.pageCnt});'>이전</a></li>
								</c:if>

								<c:forEach var='i' begin="${p.pageStartNum}"
									end="${p.pageLastNum}" step="1">
									<li class='pageIndex${i}'><a onclick='pageIndex(${i});'>${i}</a></li>
								</c:forEach>

								<c:if test="${p.lastChk}">
									<li><a
										onclick='pageNext(${p.pageStartNum},${p.total},${p.listCnt},${p.pageCnt});'>이후</a>
									</li>
								</c:if>
							</ul>
							<!-- 	<form method="post" id='frmPaging'> -->
							<form method="post" id='frmPaging'>
								<!--출력할 페이지번호, 출력할 페이지 시작 번호, 출력할 리스트 갯수 -->
								<input type='hidden' name='index' id='index' value='${p.index}'>
								<input type='hidden' name='pageStartNum' id='pageStartNum'
									value='${p.pageStartNum}'> <input type='hidden'
									name='listCnt' id='listCnt' value='${p.listCnt}'> <input
									type='hidden' name='category' id='category'
									value='${p.category}'> <input type='hidden' name='sort'
									id='sort' value='${p.sort}'> <input type='hidden'
									name='f_name' id='f_name' value='${p.f_name}'>
							</form>
						</div>
					</div>
				</div>
			</section>



			<%@ include file="../common/footer.jsp"%>

			<hr class="divider-d">

		</div>
		<div class="scroll-up">
			<a href="#totop"><i class="fa fa-angle-double-up"></i></a>
		</div>
	</main>
	<%
		long count = 1;
		pageContext.setAttribute("count", count);
	%>
	<c:forEach var="dto" items="${list}">
		<div id="cartcnt_${count}">
			<!-- Modal -->
			<div class="modal fade" id="modalFood_${count}" tabindex="-1"
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
								</button></h5>
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
							<input id="ori_price_${count}" type="hidden"
								value="${dto.f_price}">
							<div class="row mb-30">
								<button id="count_minus_${count}" value="${count}"
									class="btn btn-g btn-round" style="padding: 8px 12px;"
									onclick="minusFunc(this.value)">-</button>
								&nbsp;&nbsp; <span id="count_value_${count}">1</span><input
									type="hidden" name="cart_count" id="cart_count_${count}"
									value="1">&nbsp;&nbsp;
								<button id="count_plus_${count}" value="${count}"
									class="btn btn-g btn-round" style="padding: 8px 12px;"
									onclick="plusFunc(this.value)">+</button>
							</div>
							<div class="row" style="text-align: right; padding-right: 30px;">
								<b>총&nbsp;&nbsp;&nbsp;<span id="modal_price_${count}"
									style="color: rgb(111, 186, 44); font-size: 25px;">${dto.f_price}</span>&nbsp;원
								</b>
							</div>

						</div>

						<div class="modal-footer" style="text-align: center;">

							<button type="button" class="btn btn-g btn-round"
								data-dismiss="modal">닫기</button>

							<button type="button" value="${dto.f_name}"
								class="btn btn-g btn-round"
								onclick="cartIntoFunc(this.value, ${count})"
								style="background: rgb(255, 219, 79);">재료담기</button>

						</div>
					</div>
				</div>
			</div>

		</div>

		<%
			count++;
			pageContext.setAttribute("count", count);
		%>
	</c:forEach>

</body>


</html>