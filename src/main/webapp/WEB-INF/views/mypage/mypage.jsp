<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en-US" dir="ltr">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<style type="text/css">
#left_side_bar {
	padding-top: 50px;
}

#mypage_order_state {
	margin-top: 10px;
}

#mypage_user {
	margin-left: 0%;
	margin-top: 0%;
}

#order_state_comment {
	margin-top: 20px;
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
	width: 20%;
	margin-left: 40%;
	margin-right: 40%;
	margin-top: 7%;
}

#yellow_btn:hover, #yellow_btn:focus {
	background: rgba(255, 219, 79, 0.5) !important;
	color: rgba(17, 17, 17, 0.5);
}

#col-sm-8 {
	margin-left: 0%;
}

#mypage_id_btn {
	width: 20%;
	float: left;
	margin-right: 2%;
	border: 0;
}

#u_name_id {
	width: 78%;
}

#mypage_phone_btn {
	width: 20%;
	float: left;
	margin-right: 2%;
	border: 0;
}

#u_phone_id {
	width: 78%;
}

#mypage_point_btn {
	width: 20%;
	float: left;
	margin-right: 2%;
	border: 0;
}

#u_point_in {
	width: 78%;
}

#mypage_addr_btn {
	width: 20%;
	float: left;
	margin-right: 2%;
	border: 0;
}

#u_addr_in {
	width: 51%;
	float: left;
	margin-right: 2%;
}

#addr_update {
	width: 25%;
}

#zonecode {
	width: 51%;
	float: left;
	margin-left: 22%;
	margin-right: 2%;
	margin-bottom: 2%;
}

#addr_btn {
	width: 25%;
	margin-bottom: 2%;
}

#address {
	width: 78%;
	margin-left: 22%;
	margin-bottom: 2%;
}

#address_etc {
	width: 78%;
	margin-left: 22%;
	margin-bottom: 2%;
}
input[type="text"]:focus {
	border-color: rgb(111, 186, 44);
	box-shadow: 0 0 8px 0 rgb(111, 186, 44);
}
</style>

<title>ONECOOK: MyPage</title>
<script type="text/JavaScript"
	src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<%@ include file="../common/head_link.jsp"%>
<!-- css 링크를 include -->

</head>
<body data-spy="scroll" data-target=".onpage-navigation"
	data-offset="60">
	<main>
		<div class="page-loader">
			<div class="loader">Loading...</div>
		</div>

		<%@ include file="../common/header.jsp"%>
		<!-- 상단에 메뉴를 include -->

		<div class="main">

			<%@ include file="../common/mypage_banner.jsp"%>
			<!-- mypage banner를 include -->

			<section class="module" id="left_side_bar">
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
							<div class="comments" id="mypage_order_state">
								<h4 class="comment-title font-alt">정보수정</h4>
							</div>
							<div class="comments" id="mypage_user">
								<form id="mypage" method="POST" action="mypage.do">
									<div class="form-group">
										<input class="form-control" type="button" id="mypage_id_btn"
											onclick="" value="이름"> <input class="form-control"
											type="text" id="u_name_id" name="user_name"
											value="${mypage.user_name}">
									</div>
									<div class="form-group">
										<input class="form-control" type="button"
											id="mypage_phone_btn" onclick="" value="전화번호"> <input
											class="form-control" type="text" id="u_phone_id" name="phone"
											value="${mypage.phone}">
									</div>
									<div class="form-group">
										<input class="form-control" type="button" id="mypage_addr_btn"
											onclick="" value="주소"> <input class="form-control"
											type="point" id="u_addr_in" name="email"
											value="${mypage.addr}" disabled=""> <input
											class="form-control" id="addr_update" type="button"
											value="주소변경">
									</div>
									<div class="addr" id="addr_ajax">
										<input class="form-control" id="zonecode" type="text" value=""
											readonly /> <input class="form-control" id="addr_btn"
											type="button" onClick="openDaumZipAddress();" value="주소찾기" />

										<input class="form-control" type="text" id="address"
											name="addr_no1" value="" readonly /> <input
											class="form-control" type="text" id="address_etc"
											name="addr_no2" value="" />
									</div>
									<div>
										<button class="form-control" type="button" onclick="change()" id="yellow_btn">수정</button>
										<script>
											function change(){
												swal({
													  text: "정보를 수정하시겠어요?",
													  icon: "warning",
													  buttons: true,
													  dangerMode: true,
													}).then((willDelete) => {
														  if (willDelete) {
																setTimeout(function() {
																    swal("정보가 수정되었어요.", {
																      icon: "success",
																    }).then(function() {
																    	document.getElementById('mypage').submit();
																	});
																}, 1000);   
														  } else {
														   		swal("수정이 취소되었어요.");
														  }
											   });
											}
										</script>
									</div>
								</form>
							</div>

						</div>
					</div>
				</div>
			</section>

			<script type="text/javascript">
	var address_var;
	var start_result;
	var end_result;		
	var split_result;	//해당인증번호가 담긴 변수
	
	// 주소변경 클릭시
		$(document).ready(function(){
			$(".addr").css("display", "none");
				$("#addr_update").click(function(){
					$(".addr").toggle("slow")
					//.toggle("slow");
				});
				
	

		// 회원가입 버튼 클릭시
		$("#yellow_btn").click(function(){
			if($("#email_in").val() == "" || $("#u_email_code_id").val() == "" || $("#u_pw_id").val() == "" 
					|| $("#u_pw_chk_id").val() == "" || $("#u_name_id").val() == "" || $("#u_phone_id").val() == ""
					|| $("#zonecode").val() == "" || $("#address").val() == "" || $("#address_etc").val() == ""){

				//alert('모두 입력해주세요');
			}
			else{
				if($("#u_pw_id").val() != $("#u_pw_chk_id").val()){
					swal('비밀번호가 달라요. 다시 확인해주세요.');
				}
			}
			
		});
	});
	

		// 다음 주소록 api 연동
		function openDaumZipAddress() {
			new daum.Postcode({
				oncomplete:function(data) {
					//jQuery("#postcode1").val(data.postcode1);
					//jQuery("#postcode2").val(data.postcode2);
					jQuery("#zonecode").val(data.zonecode);
					jQuery("#address").val(data.address);
					jQuery("#address_etc").focus();
					address_var = data;
					console.log(data);
				}
			}).open();
		}
	
	
	
		
	</script>

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