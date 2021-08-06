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
<title>Recipe: User Recipe Detail</title>

<%@ include file="../common/head_link.jsp"%>
<style>
#pagination_id>li>a {
	color: rgba(17, 17, 17, 0.8);
}

.pagination>li.active>a {
	border: 1px solid rgb(255, 219, 79);
	background: rgba(255, 219, 79, 0.9);
	color: rgba(17, 17, 17, 0.8);
}

.pagination>.active>a:focus, .pagination>.active>a:hover, .pagination>.active>span:focus,
	.pagination>.active>span:hover {
	z-index: 3;
	color: rgba(17, 17, 17, 0.5) !important;
	cursor: default;
	background-color: rgba(255, 219, 79, 0.5) !important;
	border-color: rgb(255, 219, 79) !important;
}

.ym-img {
	max-height: 350px;
	width: 100%;
	object-fit: cover;
}

.ym-div {
	text-align: center;
	border: 1px dotted rgb(194, 194, 194);
	padding: 30px 0px;
}

.yellow_btn {
	background: rgba(255, 219, 79, 0.9) !important;
	color: rgba(17, 17, 17, 0.8);
	margin-bottom: 10px;
}

.yellow_btn:hover, .yellow_btn:focus {
	background: rgba(255, 219, 79, 0.5) !important;
	color: rgba(17, 17, 17, 0.5);
}
input[type="text"]:focus {
	border-color: rgb(111, 186, 44);
	box-shadow: 0 0 8px 0 rgb(111, 186, 44);
}
</style>
</head>

<body data-spy="scroll" data-target=".onpage-navigation"
	data-offset="60">
	<div class="page-loader">
		<div class="loader">Loading...</div>
	</div>
	<main>
		<%@ include file="../common/header.jsp"%>

		<div class="main">
			<!--
			<section class="module bg-dark-60 blog-page-header"
				data-background="../assets/images/restaurant-1284351_1920.jpg">
				<div class="container">
					<div class="row">
						<div class="col-sm-6 col-sm-offset-3">
							<h2 class="module-title font-alt">SHOW COOKER RECIPE</h2>
							<div class="module-subtitle font-alt">
								나만의 통통튀는 레시피를 공개해요.<br />
							</div>
						</div>
					</div>
				</div>
			</section>
			-->
			
			<section class="module-small">
				<div class="container">
					<div class="row">
						<div class="col-sm-12">
							<div class="post">
								<!--
								<div class="post-thumbnail" style="text-align: center;">
									<img class="ym-img"
										src="../resources/images/recipe/${recipe.rc_img}"
										alt="Blog Featured Image" />
								</div>
								<br />
								-->
								<div class="post-header font-alt">
									<h1 class="post-title mb-10 mt-40">${recipe.rc_title}</h1>
									<div class="post-meta">
										By&nbsp;<span style="color: black;">${recipe.email}</span> | <span
											id="span_view">${recipe.g_count}</span> Like |
										${recipe.rc_num} View | ${fn:length(reply_list)} Comments |
										<fmt:formatDate value="${recipe.rc_date}" pattern="yyyy-MM-dd" /> |

										<c:if test="${!empty recipe.good_email}">
											<a onclick="goodDelFunc(this.target)"
												target="${recipe.rc_idx}"><i id="i_${recipe.rc_idx}"
												class="fas fa-heart" style="color: rgba(111, 186, 44, 0.6);"></i></a>
										</c:if>
										<c:if test="${empty recipe.good_email}">
											<c:if test="${ !empty loginUser}">
												<a onclick="goodInFunc(this.target)"
													target="${recipe.rc_idx}"><i id="i_${recipe.rc_idx}"
													class="far fa-heart"
													style="color: rgba(111, 186, 44, 0.6);"></i></a>
											</c:if>
											<c:if test="${ empty loginUser}">
												<a onclick="login()"><i id="i_${recipe.rc_idx}"
													class="far fa-heart"
													style="color: rgba(111, 186, 44, 0.6);"></i></a>
											</c:if>
										</c:if>
										<script>function login() { swal('로그인 후 이용해주세요.'); }</script>
										
										<c:if test="${loginUser.email == recipe.email || loginUser.user_type == 'MANAGER'}">
											| <a href="user_recipe_del.do?rc_idx=${recipe.rc_idx}">DELETE</a>
										</c:if>
									</div>
									
								</div>
								<div class="post-entry">${user_result.img_cont}</div>
							</div>

							<div class="comments">
								<h4 class="comment-title font-alt">
									현재 <span style="color: rgb(125, 193, 65);">${fn:length(reply_list)}</span>개의 댓글이 있어요.
								</h4>
								<c:forEach var="dto" items="${reply_list}">
									<div class="comment clearfix">
										<div class="comment-avatar" style="text-align: right;">
											<div class="features-icon" style="font-size: 30px;">
												<span class="icon-chat"></span>
											</div>
										</div>
										<div class="comment-content clearfix">
											<div class="comment-author font-alt">${dto.reply_sub}&nbsp;<c:if
													test="${!empty dto.reply_img}">
													<i class="fas fa-camera" style="color: rgb(128, 128, 128);"></i>
												</c:if>
											</div>
											<div class="comment-body">
												<p>${dto.reply_cont}</p>
											</div>
											<div class="comment-meta font-alt">
												BY&nbsp;${dto.user_name} | ${dto.reply_date}
												<c:if test="${!empty dto.reply_img}">&nbsp;|&nbsp;<a
														id="${dto.reply_idx}" href="#reply_tb"
														onclick="view(this.id)">More</a>
												</c:if>
												<c:if
													test="${loginUser.email eq dto.email || loginUser.user_type eq 'MANAGER'}"> | <a
														onclick="reviewDel(${dto.rc_idx},${dto.reply_idx},'${recipe.email}','${recipe.rc_title}')"
														style="cursor: pointer;">Delete</a>
													<script>
                            function reviewDel(rcidx,replyidx,email,rctitle){
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
														location.href="userdel.do?rc_idx="+rcidx+"&reply_idx="+replyidx+"&email="+email+"&rc_title="+rctitle;
													});
												}, 1000);   
										  } else {
										   		swal("삭제가 취소되었어요.");
										  }
									});
							}
                            </script>
												</c:if>
											</div>
										</div>
										<div class="comment clearfix ym-div"
											id="ym-div-${dto.reply_idx}">
											<img
												src="../resources/images/recipe/${recipe.email}/${recipe.rc_title}/${dto.reply_img}"
												alt="X" style="max-width: 30%;" />
										</div>
									</div>
								</c:forEach>
								<br />
								<br />
								<div class="row">
									<div class="col-sm-12" style="text-align: center;">
										<!-- 5. paging view -->
										<ul class="pagination" id="pagination">
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
													onclick='pageNext(${p.pageStartNum},${p.total},${p.listCnt},${p.pageCnt});'>&rsaquo;</a>
												</li>
												<!-- 마지막 페이지 이동 -->
												<li><a
													onclick='pageLast(${p.pageStartNum},${p.total},${p.listCnt},${p.pageCnt});'>&raquo;</a>
												</li>
											</c:if>
										</ul>
										<form action="user_recipe_detail.do#pagination" method="post"
											id='frmPaging'>
											<!-- 출력할 페이지번호, 출력할 페이지 시작 번호, 출력할 리스트 갯수 -->
											<input type='hidden' name='index' id='index'
												value='${p.index}'> <input type='hidden'
												name='rc_idx' id='ttt' value='${rc_idx}'> <input
												type='hidden' name='pageStartNum' id='pageStartNum'
												value='${p.pageStartNum}'> <input type='hidden'
												name='listCnt' id='listCnt' value='${p.listCnt}'>
										</form>
									</div>
								</div>
							</div>
						</div>

						<div class="col-sm-12">
							<div class="comment-form mt-30">
								<h4 class="comment-form-title font-alt">Add review</h4>
								<form name="input" method="post" action="write.do"
									enctype="multipart/form-data">
									<input type="hidden" name="write_gubun" value="MEMBER">
									<input type="hidden" name="rc_idx" value="${rc_idx}"> <input
										type="hidden" name="recipe_email" value="${recipe.email}">

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
												<input class="yellow_btn btn btn-round btn-d" type="button"
													value="리뷰작성" style="color: black;" onclick="check()"></input>
											</c:if>
											<c:if test="${empty loginUser}">
												<input class="yellow_btn btn btn-round btn-d" type="button"
													value="리뷰작성" style="color: black;" onclick="reCheck()"></input>
												<script>function reCheck() { swal("로그인 후 이용해주세요."); }</script>
											</c:if>
										</div>
									</div>
								</form>
							</div>
						</div>
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
	<script type="text/javascript" src="../js/paging.js"></script>
	<script>
    $(document).ready(function () {
      $('.ym-div').hide();
    });

    function view(idx) {
      $('#ym-div-' + idx).show();
      $('#' + idx).attr('onclick', 'hide(this.id)');
    }
    function hide(idx) {
      $('#ym-div-' + idx).hide();
      $('#' + idx).attr('onclick', 'view(this.id)');
    }
    function check() {
      if ($("#subject").val() == "") {
        swal("제목을 입력해주세요.");
        swal({
          title: "이런...!",
          text: "제목을 입력해주세요.",
          icon: "warning",
          button: "작성하기"
        })
        return false;
      }
      if ($("#Review").val() == "") {
        swal("내용을 입력해주세요.");
        return false;
      }
      setTimeout(function(){
		  swal({
			  title: "리뷰 작성완료!",
			  text: "리뷰를 확인하러 가볼까요?",
			  icon: "success"
		  }).then(function(){
			  document.input.submit();
		  });
	  },1000);
    }
    //좋아요
    function goodDelFunc(val) {
      $.ajax({
        url: 'listUnGoodClick.do',
        type: 'get',
        data: { rc_idx: val, gubun: 'list' },
        success: function (result) {
          $("#i_" + val).attr('class', 'far fa-heart');
          $("#i_" + val).parent().attr('onclick', 'goodInFunc(this.target)');
          var goodCnt = $("#span_view").text();
          goodCnt = parseFloat(goodCnt);
          $("#span_view").text(goodCnt - 1);
        },
        error: function (err) {
          console.log(err);
        }
      });
    }
    function goodInFunc(val) {
      $.ajax({
        url: 'listGoodClick.do',
        type: 'get',
        data: { rc_idx: val, gubun: 'list' },
        success: function (result) {
          $("#i_" + val).attr('class', 'fas fa-heart');
          $("#i_" + val).parent().attr('onclick', 'goodDelFunc(this.target)');
          var goodCnt = $("#span_view").text();
          goodCnt = parseFloat(goodCnt);
          $("#span_view").text(goodCnt + 1);
        },
        error: function (err) {
          console.log(err);
        }
      });
    }
  </script>
</body>

</html>