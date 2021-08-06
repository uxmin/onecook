<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en-US" dir="ltr">

<head>
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css"
	rel="stylesheet">
<style>
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
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title class="title">ONECOOK: Recipe</title>
<%@ include file="../common/head_link.jsp"%>
</head>

<body data-spy="scroll" data-target=".onpage-navigation"
	data-offset="60">
	<div class="page-loader">
		<div class="loader">Loading...</div>
	</div>
	<input id="sort_hdn" type="hidden" value="${p.sort}">
	<input id="search_hdn" type="hidden" value="${p.rc_title}">
	<main>

		<%@ include file="../common/header.jsp"%>

		<div class="main">
			<section class="module bg-dark-60 portfolio-page-header"
				data-background="../assets/images/avocado-1838785_1920.jpg">
				<div class="container">
					<div class="row">
						<div class="col-sm-6 col-sm-offset-3">
							<h2 class="module-title font-alt" id="h2">Recipe</h2>
							<div class="module-subtitle font-alt" id="div">
								원쿡이 제안해드리는 원쿡만의 레시피.<br />간단합니다. 마음껏 즐기세요.
							</div>
						</div>
					</div>
				</div>
			</section>


			<input type='hidden' name='category' id='category'
				value='${p.category}'>
			<section class="module pb-20" id="section">
				<div class="container">
					<div class="row">
						<div class="col-sm-12">
							<ul class="filter font-alt" id="filters">
								<li><a class="current wow fadeInUp" href="#"
									data-filter="*">전체</a></li>
								<li><a class="wow fadeInUp" href="#" data-filter="#"
									data-wow-delay="0.2s">3000원대</a></li>
								<li><a class="wow fadeInUp" href="#" data-filter="#"
									data-wow-delay="0.4s">5000원대</a></li>
								<li><a class="wow fadeInUp" href="#" data-filter="#"
									data-wow-delay="0.6s">7000원대</a></li>
							</ul>
						</div>
					</div>

					<form class="row" style="padding: 5rem 0rem 15rem 0rem;">
						<div class="col-sm-2 mb-sm-20">
							<select class="form-control" id="range_type"
								onchange="sort(this.value);">
								<option selected="selected" id="s_new" value="new">신상품순</option>
								<option id="s_good" value="good">좋아요순</option>
								<option id="s_view" value="view">조회수순</option>
							</select>
						</div>
						<div class="col-sm-4 mb-sm-20"></div>
						<div class="col-sm-4 mb-sm-20">
							<div class="search-box">
								<input class="form-control" type="text" placeholder="Search..."
									id="recipe_search" onkeydown="enterKey(this)">
								<button class="search-btn" id="btn_icon" type="button">
									<i class="fa fa-search"></i>
								</button>
							</div>
						</div>
						<div class="col-sm-2">
							<button class="btn btn-block btn-round btn-g" id="btn"
								type="button">찾기</button>
						</div>
					</form>


					<c:if test="${!empty list}">
						<ul class="works-grid works-grid-gut works-hover-w works-grid-3"
							id="works-grid">
							<c:forEach var="dto" items="${list}">
								<li class="work-item illustration webdesign"
									id="list_box_${dto.rc_idx}"><a
									href="recipe_detail.do?rc_idx=${dto.rc_idx}">
										<div class="work-image">
											<img src="../images/recipe/${dto.rc_title}/${dto.rc_img}"
												alt="Portfolio Item"
												style="height: 45rem; object-fit: cover;" />
											<div class="work-caption font-alt">
												<h3 class="work-title">${dto.rc_title}</h3>
												<div class="work-descr"><i class="fas fa-eye"></i>&nbsp;${dto.rc_num}&nbsp;&nbsp;|&nbsp;&nbsp;<i class="fas fa-thumbs-up"></i>&nbsp;<span id="goodNum-${dto.rc_idx}">${dto.g_count}</span></div>
												<br/>
												<c:if test="${!empty dto.good_email}">
													<a class="gd_btn_${dto.rc_idx}" target="${dto.rc_idx}"
														onclick="goodDelFunc(this.target)"><i
														class="fas fa-heart fa-3x"
														style="color: rgba(111, 186, 44, 0.6); cursor: pointer;"></i></a>
												</c:if>
												<c:if test="${empty dto.good_email}">
													<c:if test="${!empty loginUser}">
														<a class="gd_btn_${dto.rc_idx}" target="${dto.rc_idx}"
															onclick="goodInFunc(this.target)"><i
															class="far fa-heart fa-3x"
															style="color: rgba(111, 186, 44, 0.6); cursor: pointer;"></i></a>
													</c:if>
													<c:if test="${empty loginUser}">
														<a onclick="login()"><i class="far fa-heart fa-3x"
															style="color: rgba(111, 186, 44, 0.6); cursor: pointer;"></i></a>
														<script>
                              								function login() { swal("로그인 후 이용해주세요."); }
                            							</script>
													</c:if>
												</c:if>
												<c:if test="${loginUser.user_type == 'MANAGER'}">
													<br/><br/><div class="work-descr"><a href="manager_recipe_del.do?rc_idx=${dto.rc_idx}"><i class="fas fa-trash-alt fa-3x"></i></a></div>
												</c:if>
											</div>
										</div>
									<div style="padding:10px;text-align: center;">
										<a href="recipe_detail.do?rc_idx=${dto.rc_idx}"><span class="font-alt" style="font-size: 13px;">${dto.rc_title}</span></a>
										<hr class="divider-w mt-10 mb-10">
										<img src="../assets/images/favicons/logo_noneback_32x32.png" style="width: 7%;">&nbsp;&nbsp;<span class="font-alt" style="font-size: 11px;">BY ONECOOK</span>
									</div>
								</a></li>
							</c:forEach>
						</ul>

						<div class="row">
							<div class="col-sm-12 mt-80" style="text-align: center;">
								<div class="pagination font-alt">
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
								</div>
								<form method="post" id='frmPaging'>
									<input type='hidden' name='index' id='index' value='${p.index}'>
									<input type='hidden' name='pageStartNum' id='pageStartNum'
										value='${p.pageStartNum}'> <input type='hidden'
										name='listCnt' id='listCnt' value='${p.listCnt}'> <input
										type='hidden' name='category' id='category'
										value='${p.category}'> <input type='hidden'
										name='sort' id='sort' value='${p.sort}'> <input
										type='hidden' name='rc_title' id='rc_title'
										value='${p.rc_title}'>
								</form>
							</div>
						</div>
					</c:if>


					<c:if test="${empty list}">
						<ul class="works-grid works-grid-gut works-hover-w works-grid-3"
							id="works-grid">
							<div class="features-item">
								<div class="features-icon">
									<span class="icon-caution" aria-hidden="true"></span>
								</div>
								<h3 class="features-title font-alt">이런!</h3>
								해당 레시피가 아직 준비중이네요.<br />어디보자... 다른 레시피를 찾아볼까요?
							</div>
						</ul>
						<input type='hidden' name='category' id='category'
							value='${p.category}'>
					</c:if>
				</div>
			</section>

			<br />
			<br />
			<br />
			<br />
			<br />
			<br />
			<br />

			<%@ include file="../common/footer.jsp"%>
			<hr class="divider-d">
			<div class="scroll-up">
				<a href="#totop"><i class="fa fa-angle-double-up"></i></a>
			</div>

		</div>
	</main>
	<%@ include file="../common/js_link.jsp"%>
	<script src="../js/jquery-3.1.1.min.js"></script>
	<script type="text/javascript" language="javascript"
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
	<script type="text/javascript" src="../js/paging.js"></script>
	<script>
    $(document).ready(function () {
      var toArr = $("#filters li a").toArray();
      toArr[0].setAttribute("style", "color:rgb(111,186,44)");

      var cat = $("#category").val();
      if (cat == "") {
        cat = "전체";
      }

      for (i = 0; i < $("#filters li a").length; i++) {
        if (toArr[i].text == cat) {
          toArr[0].setAttribute("style", "none");
          toArr[i].setAttribute("style", "color:rgb(111,186,44)");
        }
      };

      var sort_hdn = $("#sort_hdn").val();
      $("#s_" + sort_hdn).attr("selected", "selected");
      var search_hdn = $("#search_hdn").val();
      $("#recipe_search").attr("value", search_hdn);

      $("#btn").on("click", function () {
        $.ajax({
          url: "search_name.json",
          type: "POST",
          data: { rc_title: $("#recipe_search").val() },
          success: function (data) {
            if (!data) return false;
            $("body").html(data);
            $("#frmPaging").attr("action", "search_name");
          }
        });
      });
      $("#btn_icon").on("click", function () {
        $.ajax({
          url: "search_name.json",
          type: "POST",
          data: { rc_title: $("#recipe_search").val() },
          success: function (data) {
            if (!data) return false;
            $("body").html(data);
            $("#frmPaging").attr("action", "search_name");
          }
        });
      });

      $("#filters li a").click(function () {
        var cat = $(this).text();
        if (cat == "전체") {
          $.ajax({
            url: "list_manage.do",
            type: "GET",
            success: function (result) {
              console.log(result);
              $("body").html(result);
              $("#frmPaging").attr("action", "list_manage.do");
            }
          });
        } else {
          $.ajax({
            url: "list_manage_cat.do",
            type: "GET",
            data: { category: cat },
            success: function (result) {
              console.log(result);
              $("body").html(result);
              $("#frmPaging").attr("action", "list_manage_cat.do");
            }
          });
        }
      });
    });

    function enterKey(e) {
      if (event.keyCode == 13) {
        $.ajax({
          url: "search_name.json",
          type: "POST",
          data: { rc_title: $("#recipe_search").val() },
          success: function (data) {
            if (!data) return false;
            $("body").html(data);
            $("#frmPaging").attr("action", "search_name");
          }
        });
      }
    }

    function sort(val) {
      var cat = $("#category").val();
      if (cat == "") {
        cat = "전체";
      }

      if (val == "new") {
        $.ajax({
          url: "list_manage_sort.do",
          type: "GET",
          data: { sort: $("#s_new").val(), category: cat },
          success: function (result) {
            $("body").html(result);
            $("#frmPaging").attr("action", "list_manage_sort.do");
          }
        });
      } else if (val == "good") {
        $.ajax({
          url: "list_manage_sort.do",
          type: "GET",
          data: { sort: $("#s_good").val(), category: cat },
          success: function (result) {
            $("body").html(result);
            $("#frmPaging").attr("action", "list_manage_sort.do");
          }
        });
      } else if (val == "view") {
        $.ajax({
          url: "list_manage_sort.do",
          type: "GET",
          data: { sort: $("#s_view").val(), category: cat },
          success: function (result) {
            $("body").html(result);
            $("#frmPaging").attr("action", "list_manage_sort.do");
          }
        });
      } else {
        //         alert("ERROR: Not Found sort(val)");
        swal("ERROR", "Not Found sort(val)", "error");
      }
    }

    //좋아요 눌림
    function goodInFunc(val) {
      $.ajax({
        url: 'listGoodClick.do',
        type: 'get',
        data: { rc_idx: val, gubun: 'list' },
        success: function (result) {
          $("#list_box_" + val).find(".gd_btn_" + val).find('i').attr('class', 'fas fa-heart fa-3x');
          $("#list_box_" + val).find(".gd_btn_" + val).attr('onclick', 'goodDelFunc(this.target)');
          var goodCnt = $("#goodNum-" + val).text();
          goodCnt = parseFloat(goodCnt);
          $("#goodNum-" + val).text(goodCnt + 1);
        },
        error: function (err) {
          console.log(err);
        }
      });
    }
    //좋아요 취소
    function goodDelFunc(val) {
      $.ajax({
        url: 'listUnGoodClick.do',
        type: 'get',
        data: { rc_idx: val, gubun: 'list' },
        success: function (result) {
          $("#list_box_" + val).find(".gd_btn_" + val).find('i').attr('class', 'far fa-heart fa-3x');
          $("#list_box_" + val).find(".gd_btn_" + val).attr('onclick', 'goodInFunc(this.target)');
          var goodCnt = $("#goodNum-" + val).text();
          goodCnt = parseFloat(goodCnt);
          $("#goodNum-" + val).text(goodCnt - 1);
        },
        error: function (err) {
          console.log(err);
        }
      });
    }
  </script>
</body>

</html>