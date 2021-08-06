<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en-US" dir="ltr">

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>ONECOOK: User Recipe</title>
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

.ym {
	position: absolute;
	padding: 40.5rem 0rem 0rem 31rem;
}

@media ( max-width : 1200px) {
	.ym {
		position: absolute;
		padding: 32rem 0rem 0rem 24.5rem;
	}
}

@media ( max-width : 991px) {
	.ym {
		position: absolute;
		padding: 38.5rem 0rem 0rem 29.5rem;
	}
}

@media ( max-width : 767px) {
	.ym {
		position: absolute;
		padding: 45rem 0rem 0rem 34.5rem;
	}
}

.ym-350 {
	height: 350px;
	min-width: 100%;
	object-fit: cover;
}

.ym-450 {
	height: 450px;
	min-width: 100%;
	object-fit: cover;
}
input[type="text"]:focus {
	border-color: rgb(111, 186, 44);
	box-shadow: 0 0 8px 0 rgb(111, 186, 44);
}
</style>
</head>

<body data-spy="scroll" data-target=".onpage-navigation"
	data-offset="60">

	<main>
		<div class="page-loader">
			<div class="loader">Loading...</div>
		</div>

		<%@ include file="../common/header.jsp"%>
		<div class="main">
			<section class="module bg-dark-60 blog-page-header"
				data-background="../assets/images/restaurant-1284351_1920.jpg">
				<div class="container">
					<div class="row">
						<div class="col-sm-6 col-sm-offset-3">
							<h2 class="module-title font-alt">USER RECIPE</h2>
							<div class="module-subtitle font-alt">
								우리 원쿡 가족들이 준비한 레시피들이예요.<br />아이디어가 톡톡 튀는 레시피들, 함께 즐겨보자구요.
							</div>
						</div>
					</div>
				</div>
			</section>

			<section class="module">
				<div class="container">
					<div class="row">
						<div class="col-sm-6 col-sm-offset-3">
							<h2 class="module-title font-alt">ONECOOK BEST RECIPE</h2>
							<div class="module-subtitle font-alt">
								원쿡 가족들이 엄선한 레시피가 준비되어 있어요.<br />자, 즐길 준비 되셨나요?
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-xs-12 col-md-12 col-centered">
							<div id="carousel" class="carousel slide" data-ride="carousel"
								data-type="multi" data-interval="4000">
								<div class="carousel-inner">
									<c:forEach var="dto" items="${list}" varStatus="vs">
										<c:choose>
											<c:when test="${vs.first}">
												<div class="item active">
													<div class="carousel-col">
														<div class="block img-responsive shop-item"
															style="text-align: left;">
															<div class="shop-item-image">
																<img class="ym-350"
																	src="../resources/images/recipe/${dto.rc_img}">
																<div class="shop-item-detail">
																	<a id="yellow_food_btn" class="btn btn-round btn-b"
																		href="user_recipe_detail.do?rc_idx=${dto.rc_idx}"><i
																		class="fas fa-search"></i>&nbsp;상세보기</span></a>
																</div>
															</div>
															<h5>${dto.rc_title}</h5>
															<hr class="divider-w">
															<div class="post-meta" style="padding-top: 5px;">
													
																	By&nbsp;<span style="color: black;">${dto.email}</span>&nbsp;&nbsp;|&nbsp;&nbsp;
												
																<i class="fas fa-eye"></i>&nbsp;${dto.rc_num}&nbsp;&nbsp;
																|&nbsp;&nbsp;<i class="fas fa-heart"></i>&nbsp;${dto.g_count}
															</div>
														</div>
													</div>
												</div>
											</c:when>
											<c:otherwise>
												<div class="item">
													<div class="carousel-col">
														<div class="block green img-responsive shop-item"
															style="text-align: left;">
															<div class="shop-item-image">
																<img class="ym-350"
																	src="../resources/images/recipe/${dto.rc_img}">
																<div class="shop-item-detail">
																	<a id="yellow_food_btn" class="btn btn-round btn-b"
																		href="user_recipe_detail.do?rc_idx=${dto.rc_idx}"><i
																		class="fas fa-search"></i>&nbsp;상세보기</span></a>
																</div>
															</div>
															<h5>${dto.rc_title}</h5>
															<hr class="divider-w">
															<div class="post-meta" style="padding-top: 5px;">
													
																	By&nbsp;<span style="color: black;">${dto.email}</span>&nbsp;&nbsp;|&nbsp;&nbsp;
													
																<i class="fas fa-eye"></i>&nbsp;${dto.rc_num}&nbsp;&nbsp;
																|&nbsp;&nbsp;<i class="fas fa-heart"></i>&nbsp;${dto.g_count}
															</div>
														</div>
													</div>
												</div>
											</c:otherwise>
										</c:choose>
									</c:forEach>
								</div>

								<!-- Controls -->
								<div class="left carousel-control" style="bottom: 8rem;">
									<a href="#carousel" role="button" data-slide="prev"> <span
										class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
										<span class="sr-only">Previous</span>
									</a>
								</div>
								<div class="right carousel-control" style="bottom: 8rem;">
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
			<hr class="divider-w mt-10 mb-20">

			<section class="module">
				<div class="container">
					<div class="row">

						<div class="col-sm-6 col-sm-offset-3">
							<h2 class="module-title font-alt">ONECOOK FAMILY RECIPE</h2>
							<div class="module-subtitle font-alt">원쿡 가족들에게 나만의 레시피를
								공유해보세요. :-)</div>
						</div>

					</div>
					<c:if test="${!empty loginUser}">
						<div class="col-sm-4 col-sm-offset-4">
							<button class="btn btn-block btn-round btn-g btn-lg"
								type="button" onclick="location.href='userRecipeAdd.do'"
								style="background: rgb(255, 223, 96);">레시피 작성</button>
						</div>
						<br />
						<br />
						<br />
						<br />
					</c:if>

					<form class="row" style="padding: 5rem 0rem 15rem 0rem;">
						<div class="col-sm-2 mb-sm-20">
							<input id="sort_hdn" type="hidden" value="${p.sort}"> <select
								class="form-control" id="range_type"
								onchange="sort(this.value);">
								<option selected="selected" id="s_new" value="new">신상품순</option>
								<option id="s_good" value="good">좋아요순</option>
								<option id="s_view" value="view">조회수순</option>
							</select>
						</div>
						<div class="col-sm-2 mb-sm-20"></div>
						<div class="col-sm-2 mb-sm-20">
							<input id="cat_hdn" type="hidden" value="${p.category}">
							<select class="form-control" id="search_cat" name="search_cat">
								<option id="c_title" value="title">제목</option>
								<option id="c_writer" value="writer">작성자</option>
							</select>
						</div>
						<div class="col-sm-4 mb-sm-20">
							<div class="search-box">
								<input id="s_email_hdn" type="hidden" value="${p.email}">
								<input id="s_title_hdn" type="hidden" value="${p.rc_title}">
								<input class="form-control" type="text" placeholder="Search..."
									id="r_user_search" onkeydown="enterKey(this)">
								<button class="search-btn" type="submit" id="btn_icon"
									type="button">
									<i class="fa fa-search"></i>
								</button>
							</div>
						</div>
						<div class="col-sm-2">
							<button class="btn btn-block btn-round btn-g"
								id="r_user_search_btn" type="button">찾기</button>
						</div>
					</form>

					<div class="row multi-columns-row post-columns">

						<c:forEach var="line" items="${list_line}">
							<div class="col-sm-6 col-md-4 col-lg-4">
								<div class="post">

									<div class="post-thumbnail">
										<img class="ym-450"
											src="../resources/images/recipe/${line.rc_img}"
											alt="Blog-post Thumbnail" />
									</div>
									<script>

                  </script>
									<div class="post-header font-alt">
										<h2 class="post-title">
											<a href="user_recipe_detail.do?rc_idx=${line.rc_idx}">${line.rc_title}</a>
										</h2>
										<div class="post-meta">
									
												By&nbsp;<span style="color: black;">${line.email}</span>&nbsp;|
									
											${line.rc_num} Views | <span id="span_${line.rc_idx}">${line.g_count}</span>
											Like |
											<c:if test="${!empty line.good_email}">
												<a onclick="goodDelFunc(this.target)"
													target="${line.rc_idx}"> <i id="i_${line.rc_idx}"
													class="fas fa-heart"
													style="color: rgba(111, 186, 44, 0.6);"></i></a>
											</c:if>
											<c:if test="${empty line.good_email}">
												<c:if test="${!empty loginUser}">
													<a onclick="goodInFunc(this.target)"
														target="${line.rc_idx}"> <i id="i_${line.rc_idx}"
														class="far fa-heart"
														style="color: rgba(111, 186, 44, 0.6);"></i></a>
												</c:if>
												<c:if test="${empty loginUser}">
													<a onclick="login()" target="${line.rc_idx}"> <i
														id="i_${line.rc_idx}" class="far fa-heart"
														style="color: rgba(111, 186, 44, 0.6);"></i></a>
												</c:if>
											</c:if>
											<script>function login() { swal("로그인 후 이용해주세요."); }</script>
										</div>
									</div>
									<!--                   <div class="post-entry"> -->
									<!--                     <p></p> -->
									<!--                   </div> -->
									<hr class="divider-w mt-10 mb-10">
									<div class="post-more">
										<a class="more-link"
											href="user_recipe_detail.do?rc_idx=${line.rc_idx}">Read
											more</a>
									</div>
								</div>
							</div>
						</c:forEach>

					</div>
					<div class="row" style="text-align: center;">
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

						<form method="post" id='frmPaging'>
							<input type='hidden' name='index' id='index' value='${p.index}'>
							<input type='hidden' name='pageStartNum' id='pageStartNum'
								value='${p.pageStartNum}'> <input type='hidden'
								name='listCnt' id='listCnt' value='${p.listCnt}'> <input
								type='hidden' name='category' id='category'
								value='${p.category}'> <input type='hidden' name='sort'
								id='sort' value='${p.sort}'> <input type='hidden'
								name='email' id='email' value='${p.email}'> <input
								type='hidden' name='rc_title' id='rc_title'
								value='${p.rc_title}'>
						</form>
					</div>
				</div>

			</section>

		</div>

		<%@ include file="../common/footer.jsp"%>

		<hr class="divider-d">
		<div class="scroll-up">
			<a href="#totop"><i class="fa fa-angle-double-up"></i></a>
		</div>
		</div>
	</main>
	<%@ include file="../common/js_link.jsp"%>
	<script type="text/javascript" src="../js/paging.js"></script>
	<script>
    $(document).ready(function () {
      var sort_hdn = $("#sort_hdn").val();
      $("#s_" + sort_hdn).attr("selected", "selected");
      var hdn = $("#cat_hdn").val();
      $("#c_" + hdn).attr("selected", "selected");
      var s_email_hdn = $("#s_email_hdn").val();
      $("#r_user_search").attr("value", s_email_hdn);
      var s_title_hdn = $("#s_title_hdn").val();
      $("#r_user_search").attr("value", s_title_hdn);

      $("#r_user_search_btn").on("click", function () {

        var i = $("select[name = search_cat]").val();
        if (i == "title") {
          $.ajax({
            url: "search_title.json",
            type: "POST",
            data: { rc_title: $("#r_user_search").val(), category: i },
            success: function (data) {
              if (!data) return false;
              $("body").html(data);
              $("#frmPaging").attr("action", "search_title");
            }
          });
        } else if (i == "writer") {
          $.ajax({
            url: "search_email.json",
            type: "POST",
            data: { email: $("#r_user_search").val(), category: i },
            success: function (data) {
              if (!data) return false;
              $("body").html(data);
              $("#frmPaging").attr("action", "search_email");
            }
          });
        }
      });
    });
    function enterKey(e) {
      if (event.keyCode == 13) {
        var i = $("select[name = search_cat]").val();
        if (i == "title") {
          $.ajax({
            url: "search_title.json",
            type: "POST",
            data: { rc_title: $("#r_user_search").val(), category: i },
            success: function (data) {
              if (!data) return false;
              $("body").html(data);
              $("#frmPaging").attr("action", "search_title");
            }
          });
        } else if (i == "writer") {
          $.ajax({
            url: "search_email.json",
            type: "POST",
            data: { email: $("#r_user_search").val(), category: i },
            success: function (data) {
              if (!data) return false;
              $("body").html(data);
              $("#frmPaging").attr("action", "search_email");
            }
          });
        }
      }
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
    function sort(val) {
      var sort_val = $("#range_type option:selected").val();

      if (sort_val == "new") {
        $.ajax({
          url: "list_user.do",
          type: "GET",
          success: function (result) {
            $("body").html(result);
            $("#frmPaging").attr("action", "list_user.do");
          }
        });
      } else if (sort_val == "good") {
        $.ajax({
          url: "list_user_sort.do",
          type: "GET",
          data: { sort: $("#s_good").val() },
          success: function (result) {
            $("body").html(result);
            $("#frmPaging").attr("action", "list_user_sort.do");
          }
        });
      } else {
        $.ajax({
          url: "list_user_sort.do",
          type: "GET",
          data: { sort: $("#s_view").val() },
          success: function (result) {
            $("body").html(result);
            $("#frmPaging").attr("action", "list_user_sort.do");
          }
        });
      }
    }
    //좋아요
    function goodInFunc(val) {
      $.ajax({
        url: 'listGoodClick.do',
        type: 'get',
        data: { rc_idx: val, gubun: 'list' },
        success: function (result) {
          $("#i_" + val).attr('class', 'fas fa-heart');
          $("#i_" + val).parent().attr('onclick', 'goodDelFunc(this.target)');
          var goodCnt = $("#span_" + val).text();
          goodCnt = parseFloat(goodCnt);
          $("#span_" + val).text(goodCnt + 1);
        },
        error: function (err) {
          console.log(err);
        }
      });
    }
    function goodDelFunc(val) {
      $.ajax({
        url: 'listUnGoodClick.do',
        type: 'get',
        data: { rc_idx: val, gubun: 'list' },
        success: function (result) {
          $("#i_" + val).attr('class', 'far fa-heart');
          $("#i_" + val).parent().attr('onclick', 'goodInFunc(this.target)');
          var goodCnt = $("#span_" + val).text();
          goodCnt = parseFloat(goodCnt);
          $("#span_" + val).text(goodCnt - 1);
        },
        error: function (err) {
          console.log(err);
        }
      });
    }
  </script>

</body>

</html>