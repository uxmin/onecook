<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en-US" dir="ltr">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<style type="text/css">
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
</style>
<!--  
    Document Title
    =============================================
    -->
<title>Login</title>
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
							<h4 class="font-alt">카카오 아이디 세부사항 입력</h4>
							<hr class="divider-w mb-10">
							<form class="form" id="kAdmission_form_id" method="POST"
								action="kAdmission_ok.do">
								<input type="hidden" id="hdn_jObj" name="hdn_jObj" value=${jObj}>
								<div class="form-group">
									<input class="form-control" type="text" id="k_email_id"
										name="kakao_email" placeholder="카카오 메일">
								</div>
								<div class="form-group">
									<input class="form-control" type="text" id="k_phone_id"
										name="phone" placeholder="전화번호">
								</div>
								<div class="form-group">
									<div class="form-group">
										<input class="form-control" id="zonecode" type="text" value=""
											readonly /> <input class="form-control" id="zonecode1"
											type="button" onClick="openDaumZipAddress();" value="주소  찾기" />
									</div>


									<input class="form-control" type="text" id="address"
										name="addr_no1" value="" readonly /> <input
										class="form-control" type="text" id="address_etc"
										name="addr_no2" value="" placeholder="상세주소" />
								</div>
								<div class="form-group" style="text-align: center">
									<button class="btn btn-round btn-b" type="button"
										id="yellow_btn">회원가입</button>
								</div>
							</form>
						</div>
					</div>
				</div>
			</section>

			<script>
    	$(document).ready(function(){
    		$("#yellow_btn").click(function(){
    			if($("#k_email_id").val() == "" ||  $("#k_phone_id").val() == "" || $("#zonecode").val() == "" || $("#address").val() == "" || $("#address_etc").val() == ""){
//     				alert('모두 입력해주세요');
    				swal("모두 입력해주세요.");
    			}
    			else{
//     				alert('승인');
    				
// 					var jObj = ${jObj};
// 					console.log(jObj);
//     				$("#kAdmission_form_id").submit();
    				setTimeout(function(){
    					  swal({
    						  title: "회원가입 완료",
    						  text: "다시 로그인해주세요.",
    						  icon: "success"
    					  }).then(function(){
    						  $("#kAdmission_form_id").submit();
    					  });
    				  },1000);
    			}
    		});
    	});
    	
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