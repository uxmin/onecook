<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en-US" dir="ltr">
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

#order_state_comment {
	margin-top: 5%;
	text-align: center;
	font-size: small;
}

#refund {
	text-align: right;
}

#button1, #button2, #button3 {
	background-color: rgb(255, 255, 255);
	border: 0;
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

#col-sm-8 {
	margin-left: 0%;
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
/* 페이징 색 처리  및 정렬*/
.row_paging_class {
	text-align: center;
}

#paging_form {
	width: 100%;
}

#recipe_type {
	/* 		width: 20%; */
	/*     	margin-right: 2%; */
	/*     	float: left; */
	
}

#recipe_search {
	/* 		width: 55%; */
	/* 		float : left; */
	/* 		margin-right : 2%; */
	
}

.recipe_search_button {
	/*     	width: 21%; */
	
}

#search_box {
	margin-bottom: 6%;
}
input[type="text"]:focus {
	border-color: rgb(111, 186, 44);
	box-shadow: 0 0 8px 0 rgb(111, 186, 44);
}
</style>

<title>ONECOOK: MyPage</title>
<%@ include file="../common/head_link.jsp"%>
<!-- css 링크를 include -->

</head>
<body data-spy="scroll" data-target=".onpage-navigation"
	data-offset="60">
	<main>
		<input id="search_hdn_id" type='hidden' name='rc_title' id='rc_title'
			value='${p.rc_title}'> <input id="cat_hdn_id" type='hidden'
			name='category' id='category' value='${p.category}'>
		<!--       <div class="page-loader"> -->
		<!--         <div class="loader">Loading...</div> -->
		<!--       </div> -->

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
								<h4 class="comment-title font-alt">
									<i class="fas fa-heart" style="color: rgba(111, 186, 44, 0.9);"></i>&nbsp;쿡커레시피
								</h4>
							</div>

							<div class="row" id="search_box">

								<form id="cat_form_id" action="good_user_search.do"
									method="post">
									<div class="col-sm-3 mb-sm-20">
										<!-- 					<select class="form-control" id="cat_id" name="cat_nm" onchange="cat_func(this.value)"> -->
										<select class="form-control" id="recipe_type" name="cat_nm"
											onchange="cat_func(this.value)">
											<option class="form-control" value="email">이메일</option>
											<option class="form-control" value="rc_title">제목</option>
										</select>
									</div>
									<div class="col-sm-4 col-sm-offset-2 mb-sm-20">
										<div class="search-box">
											<!-- 					<input class="form-control" tyep="text" id="cat_input_id" name="cat_text"/> -->
											<input class="form-control" tyep="text" id="recipe_search"
												placeholder="Search..." name="cat_text" />
											<button class="search-btn recipe_search_button">
												<i class="fa fa-search"></i>
											</button>
										</div>
									</div>
									<div class="col-sm-3">
										<button
											class="btn btn-block btn-round btn-g recipe_search_button"
											type="submit">찾기</button>

									</div>
								</form>

							</div>

							<div class="row multi-columns-row post-columns"
								id="order_state_comment">
								<ul class="works-grid works-grid-gut works-grid-3 works-hover-w"
									id="works-grid">
									<c:forEach var="list" items="${good_user}">
										<li class="work-item illustration webdesign"><a
											href="../recipe/user_recipe_detail.do?rc_idx=${list.rc_idx}">
												<div class="work-image">
													<img class="food_list_img"
														src="../images/recipe/${list.rc_img}" alt="Portfolio Item" />
												</div>
												<div class="work-caption font-alt">
													<h3 class="work-title">${list.rc_title}</h3>
												</div>
										</a></li>
									</c:forEach>
								</ul>
							</div>

							<!-- 5. paging view -->
							<div class="pagination font-alt" id="paging_form">
								<div class="row_paging_class">
									<!-- 				<ul class="pagination"> -->
									<%-- 				<c:if test="${p.pageStartNum ne 1}"> --%>
									<!-- 				맨 첫페이지 이동 -->
									<%-- 					<li><a onclick='pagePre(${p.pageCnt+1},${p.pageCnt});'>&laquo;</a></li> --%>
									<!-- 				이전 페이지 이동 -->
									<%-- 					<li><a onclick='pagePre(${p.pageStartNum},${p.pageCnt});'>&lsaquo;</a></li> --%>
									<%-- 				</c:if> --%>

									<!-- 			<!--페이지번호 -->
									<%-- 			<c:forEach var='i' begin="${p.pageStartNum}" end="${p.pageLastNum}" step="1"> --%>
									<%-- 				<li class='pageIndex${i}'><a onclick='pageIndex(${i});'>${i}</a></li> --%>
									<%-- 			</c:forEach> --%>

									<%-- 			<c:if test="${p.lastChk}"> --%>
									<!-- 			<!-- 다음 페이지 이동 -->
									<%-- 				<li><a onclick='pageNext(${p.pageStartNum},${p.total},${p.listCnt},${p.pageCnt});'>&rsaquo;</a></li> --%>
									<!-- 			<!-- 마지막 페이지 이동 -->
									<%-- 				<li><a onclick='pageLast(${p.pageStartNum},${p.total},${p.listCnt},${p.pageCnt});'>&raquo;</a></li> --%>
									<%-- 			</c:if> --%>
									<!-- 	</ul> -->
									<!--  		<form action="good_user.do" method="post" id='frmPaging'> -->
									<!--  			출력할 페이지번호, 출력할 페이지 시작 번호, 출력할 리스트 갯수 -->
									<%-- 			<input type='hidden' name='index' id='index' value='${p.index}'> --%>
									<%-- 			<input type='hidden' name='pageStartNum' id='pageStartNum' value='${p.pageStartNum}'> --%>
									<%-- 			<input type='hidden' name='listCnt' id='listCnt' value='${p.listCnt}'> --%>
									<%-- 			<input type='hidden' name='rc_title' id='rc_title' value='${p.rc_title}'> --%>
									<%-- 			<input type='hidden' name='category' id='category' value='${p.category}'> 	 --%>
									<!--  		</form> -->

									<ul class="pagination">
										<c:if test="${p.pageStartNum ne 1}">
											<li><a
												onclick='pagePre(${p.pageStartNum},${p.pageCnt});'>이전</a></li>
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
											<input type='hidden' name='index' id='index'
												value='${p.index}'> <input type='hidden'
												name='pageStartNum' id='pageStartNum'
												value='${p.pageStartNum}'> <input type='hidden'
												name='listCnt' id='listCnt' value='${p.listCnt}'>
										</form>
										<!-- 	</div>	 -->
									</c:if>
									<!-- 검색 한 페이지일 경우 카테고리와 검색내용을 hidden으로 넣어서 넘겨주기 -->
									<c:if test="${p.category != null}">
										<form method="post" id='frmPaging'
											action="good_user_search.do">
											<input type='hidden' name='index' id='index'
												value='${p.index}'> <input type='hidden'
												name='pageStartNum' id='pageStartNum'
												value='${p.pageStartNum}'> <input type='hidden'
												name='listCnt' id='listCnt' value='${p.listCnt}'> <input
												type='hidden' name='cat_nm' id='cat_nm'
												value='${p.category}'> <input type='hidden'
												name='cat_text' id='cat_text' value='${p.sort}'>
										</form>
										<!-- 	</div> -->
									</c:if>
								</div>
							</div>

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

	<%@ include file="../common/js_link.jsp"%>
	<!-- 4. Javascript -->
	<script type="text/javascript" src="../js/paging.js"></script>

	<script>
	$(document).ready(function(){
		//검색창에 텍스트를 유지 하게 하는 
		var search_hdn = $("#search_hdn_id").val();
		console.log(search_hdn);
		$("#recipe_search").attr("value", search_hdn);
		
		$(".recipe_search_button").on("click", function(){
			console.log($("#recipe_search").val());
		
 			$.ajax({
				url: "user_search_name.json",
				type: "POST",
				data: {rc_title: $("#recipe_search").val()},
				success: function(data){
					if(!data) return false;
					$("body").html(data);
					$("#frmPaging").attr("action", "user_search_name");
				}
			});
		});
	});
	
	function category(val){
		var category_val = $("#recipe_type option:selected").val();
		
		if(category_val == "전체"){
		 	$.ajax({
				url: "good_user.do",
				type: "GET",
				success: function(result){
					$("body").html(result);
					$("#frmPaging").attr("action", "good_user.do");
					$("#all").attr("selected", "selected");
				}
			});		
		}else{
		 	$.ajax({
				url: "category.do",
				type: "GET",
				data: {category : val},
				success: function(result){
					$("body").html(result);
					$("#frmPaging").attr("action", "category.do");
					$("#c_"+val).attr("selected", "selected");
				}
			});			
		}
	}
	
	function enterKey(e){
		if(event.keyCode == 13){
			$.ajax({
				url: "user_search_name.json",
				type: "POST",
				data: {rc_title: $("#recipe_search").val()},
				success: function(data){
					if(!data) return false;
					$("body").html(data);
					$("#frmPaging").attr("action", "user_search_name");
				}
			});
		}
	}
	

</script>
</body>
</html>