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

#col-sm-8 {
	margin-left: 0%;
}

#last_order_id {
	text-align: center;
}

#table_name {
	text-align: center;
}
input[type="text"]:focus {
	border-color: rgb(111, 186, 44);
	box-shadow: 0 0 8px 0 rgb(111, 186, 44);
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
								<h4 class="comment-title font-alt">마이레시피</h4>
								<table class="table table-hover" id="last_order_id">
									<tr>
										<th id="table_name" style="width: 20%">이미지</th>
										<th id="table_name" style="width: 45%; text-align: left;">레시피
											이름</th>
										<th id="table_name" style="width: 20%">레시피 등록 날짜</th>
										<th id="table_name" style="width: 15%">조회수</th>
									</tr>

									<c:forEach var="list" items="${recipe_list}">
										<tr>
											<td><a
												href="../recipe/user_recipe_detail.do?rc_idx=${list.rc_idx}"><img
													src="../images/recipe/${list.rc_img}" width="100px"></a></td>
											<td style="text-align: left;"><a
												href="../recipe/user_recipe_detail.do?rc_idx=${list.rc_idx}">${list.rc_title}</a></td>
											<td>${list.rc_date}</td>
											<td>${list.rc_num}</td>
										</tr>
									</c:forEach>
								</table>

								<!-- 5. paging view -->
								<div class="row_paging_class">
									<ul class="pagination">
										<c:if test="${p.pageStartNum ne 1}">
											<!-- 				맨 첫페이지 이동 -->
											<li><a onclick='pagePre(${p.pageCnt+1},${p.pageCnt});'>&laquo;</a></li>
											<!--이전 페이지 이동 -->
											<li><a
												onclick='pagePre(${p.pageStartNum},${p.pageCnt});'>&lsaquo;</a></li>
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
									<form action="recipe_list.do" method="post" id='frmPaging'>
										<!-- 출력할 페이지번호, 출력할 페이지 시작 번호, 출력할 리스트 갯수 -->
										<input type='hidden' name='index' id='index'
											value='${p.index}'> <input type='hidden'
											name='pageStartNum' id='pageStartNum'
											value='${p.pageStartNum}'> <input type='hidden'
											name='listCnt' id='listCnt' value='${p.listCnt}'>
									</form>
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
</body>
</html>