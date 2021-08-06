<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en-US" dir="ltr">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<style type="text/css">
#email_in {
	width: 67%;
	float: left;
	margin-right: 3%;
	margin-bottom: 3%;
}

#overlap_btn {
	width: 30%;
	margin-bottom: 3%;
}

#u_email_code_id {
	width: 67%;
	float: left;
	margin-right: 3%;
	margin-bottom: 3%;
}
/*     #email_send_chk_btn{ */
/*     	width : 27%;   	 */
/*     	margin-bottom : 3%; */
/*     } */
#email_send_chk_btn, #email_send_btn {
	width: 30%;
	float: left;
	margin-bottom: 3%;
}

#zonecode {
	width: 47%;
	margin-right: 3%;
	float: left;
}

#zonecode1 {
	width: 50%;
}

#address {
	margin-bottom: 3%;
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
input[type="email"]:focus {
	border-color: rgb(111, 186, 44);
	box-shadow: 0 0 8px 0 rgb(111, 186, 44);
}
input[type="password"]:focus {
	border-color: rgb(111, 186, 44);
	box-shadow: 0 0 8px 0 rgb(111, 186, 44);
}
</style>
<!--  
    Document Title
    =============================================
    -->
<title>Admission</title>
<script type="text/JavaScript"
	src="http://code.jquery.com/jquery-1.7.min.js"></script>
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
			<section class="module bg-dark-30"
				data-background="../assets/images/section-4.jpg">
				<div class="container">
					<div class="row">
						<div class="col-sm-6 col-sm-offset-3">
							<!--                 <h1 class="module-title font-alt mb-0">Login</h1> -->
						</div>
					</div>
				</div>
			</section>
			<section class="module">
				<div class="container">
					<div class="row">
						<div class="col-sm-6 col-sm-offset-3">
							<h4 class="font-alt">회원가입</h4>
							<hr class="divider-w mb-10">
							<form class="form" id="admission_form_id" method="POST"
								action="admission_ok.do">
								<div class="form-group">
									<input class="form-control" type="email" id="email_in"
										name="email" placeholder="이메일"> <input
										class="form-control" type="hidden" id="email_chk"
										value="email_uncheck"> <input class="form-control"
										type="button" id="overlap_btn" onclick="" value="중복확인">

								</div>
								<div class="form-group">
									<span class="font-alt" id="msgEmail">중복을 확인해주세요.</span>
								</div>
								<div class="form-group">
									<input class="form-control" type="text" id="u_email_code_id"
										name="u_email_code_nm" placeholder="인증번호" disabled="">
									<input class="form-control" type="hidden"
										id="hdn_email_code_chk" value="email_incode_fail"> <input
										class="form-control" type="button" id="email_send_btn"
										value="인증번호 발송" onclick=""> <input
										class="form-control" type="button" id="email_send_chk_btn"
										value="인증확인" onclick="">
								</div>
								<div class="form-group">
									<input class="form-control" type="password" id="u_pw_id"
										name="pw" placeholder="비밀번호">
								</div>
								<div class="form-group">
									<input class="form-control" type="password" id="u_pw_chk_id"
										name="u_pw_chk" placeholder="비밀번호 확인">
								</div>
								<div class="form-group">
									<input class="form-control" type="text" id="u_name_id"
										name="user_name" placeholder="이름">
								</div>
								<div class="form-group">
									<input class="form-control" type="text" id="u_phone_id"
										name="phone" placeholder="연락처">
								</div>



								<div class="form-group">
									<input class="form-control" id="zonecode" type="text" value=""
										readonly /> <input class="form-control" id="zonecode1"
										type="button" onClick="openDaumZipAddress();" value="주소찾기" />
								</div>

								<div class="form-group">
									<input class="form-control" type="text" id="address"
										name="addr_no1" value="" readonly />
								</div>
								<div class="form-group">
									<input class="form-control" type="text" id="address_etc"
										name="addr_no2" value="" placeholder="상세주소" />
								</div>

								<div class="form-group" style="text-align: center">
									<br />
									<br />
									<!-- 				<button class="btn btn-round btn-b" type="button" id="submit_btn">회원가입</button> -->
									<button class="btn btn-round btn-b" type="button"
										id="yellow_btn">회원가입</button>
								</div>
							</form>
						</div>
					</div>
				</div>
			</section>

			<script type="text/javascript">
		var address_var;
		var start_result;
		var end_result;		
		var split_result;	//해당인증번호가 담긴 변수
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
		
		$(document).ready(function(){
			$("#email_send_chk_btn").css("display", "none");
			var RegEmail = RegExp(/^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/);	//메일 정규식 확인
			var RegPw = RegExp(/^[a-zA-Z0-9]{4,12}$/);	//패스워드 정규식 확인
			// 이메일 중복버튼 클릭
			$("#overlap_btn").click(function(){
				//console.log(address_var.address);	//첫번쨰 주소확인
				//console.log($("#address_etc").val());	//두번째 주소확인
		  		if(!RegEmail.test($("#email_in").val())){
		  	        $("#msgEmail").css("color","red");
		  	        $("#msgEmail").text("올바른 이메일 형식이 아니에요. 다시 입력해주세요.");
		  	        $("#u_email_code_id").attr("placeholder", "이메일 중복을 확인해주세요.");
		  	      	$("#u_email_code_id").val("");
		  	      	$("#u_email_code_id").attr("disabled", true);
		  	        $("#email_in").focus();

		  	        return false;
		  	      }
		  		
		  			$.ajax({
		  				url:"checkEmail.do?email="+$("#email_in").val(),
		  				success: function(result){
		  					if(result == "emailCheckOk"){
		  						$("#msgEmail").css("color", "blue");
		  						$("#msgEmail").text("사용가능한 이메일");
		  			  	        $("#u_email_code_id").attr("placeholder", "메일 인증 코드를 입력해주세요");
		  			  	      	$("#u_email_code_id").attr("disabled", false);
		  						$("#email_chk").val("email_check");
		  					}
		  					else if(result == "emailCheckFail"){
		  						$("#msgEmail").css("color", "green");
		  						$("#msgEmail").text("중복된 이메일");
		  			  	        $("#u_email_code_id").attr("placeholder", "메일 중복을 확인해주세요");
		  			  	    	$("#u_email_code_id").val("");
		  			  	      	$("#u_email_code_id").attr("disabled", true);
		  						$("#email_chk").val("email_uncheck");
		  					}
		  				}
		  			});
		  	
			});
			// 이메일 인증번호 발송 버튼클릭
			$("#email_send_btn").click(function(){
				// 이메일 체크 확인
				if($("#email_chk").val() == "email_check"){
					$.ajax({
						url: "auth.do?email="+$("#email_in").val(),
						success: function(result){
							swal("인증번호가 발송되었습니다. 확인해주세요.");
							$("#email_send_btn").hide();
							$("#email_send_chk_btn").show();
						},
						error: function(err){
							console.log(err);
						}
					});
				}
				// 이메일 체크 비확인
				else{
					swal("잠깐!","이메일 중복을 확인해주세요.","warning");
				}
			});
			// 이메일 인증 유무확인 버튼
			$("#email_send_chk_btn").click(function(){
				// 이메일 체크 확인
				if($("#email_chk").val() == "email_check"){
					$.ajax({
						//url: "auth_check.do?email_inCode=" + split_result,
						url: "auth_check.do?email_inCode=" + $("#u_email_code_id").val(),
						success: function(result){
							//console.log(split_result);
							console.log(result);
							if(result == "email_incode_fail"){
								$("#hdn_email_code_chk").val("email_incode_fail");
								swal("인증 실패!", "다시 인증을 진행해주세요.", "error");
							}
							else{
								$("#u_email_code_id").attr("disabled", true);
								$("#email_send_chk_btn").attr("disabled", true);
								$("#email_send_btn").attr("disabled", true);
								$("#hdn_email_code_chk").val("email_incode_ok");
								swal("인증 확인!", "인증이 완료되었습니다.", "success");	
							}
							
						}
					});
				}
				// 이메일 체크 비확인
				else{
					swal("잠깐!","이메일 중복을 확인해주세요.","warning");
				}
			});
			// 회원가입 버튼 클릭시
			$("#yellow_btn").click(function(){
				if($("#email_in").val() == "" || $("#u_email_code_id").val() == "" || $("#u_pw_id").val() == "" 
						|| $("#u_pw_chk_id").val() == "" || $("#u_name_id").val() == "" || $("#u_phone_id").val() == ""
						|| $("#zonecode").val() == "" || $("#address").val() == "" || $("#address_etc").val() == ""){

					swal("이런...", "모두 입력해주세요.", "warning");
				}
				else{
					if($("#u_pw_id").val() != $("#u_pw_chk_id").val()){
						swal("비밀번호 중복을 확인해주세요.");
					}
					//비밀번호와 비밃번호 비교가 같을 경우
					else{
						// 이메일 중복체크가 되지 않은 경우
						if($("#email_chk").val() == "email_uncheck"){
							swal('이메일 중복을 확인해주세요.')
						}
						// 이메일 중복체크가 된 경우
						else{
							// 이메일 인증코드를 승인하지 않은 경우
							if($("#hdn_email_code_chk").val() == "email_incode_fail"){
								swal('이메일 인증을 먼저 해주세요.');
							}
							// 이메일 인증코드를 승인한 경우
							else{
								$("#admission_form_id").submit();
								swal("Welcome!", '회원가입이 완료되었어요. 수많은 원쿡 레시피들을 만나보세요.', "success");
								//location.href="../";
							}
						}
					}
				}
				
			});
			
		});
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