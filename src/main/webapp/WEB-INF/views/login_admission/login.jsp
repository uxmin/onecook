<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en-US" dir="ltr">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<style type="text/css">
#yellow_btn {
	background: rgba(255, 219, 79, 0.9) !important;
	color: rgba(17, 17, 17, 0.8);
	font-size: 13px;
	width: 49%;
	margin-right: 2%;
	float: left;
}

#yellow_btn:hover, #yellow_btn:focus {
	background: rgba(255, 219, 79, 0.5) !important;
	color: rgba(17, 17, 17, 0.5);
}

#col_login_button {
	margin-top: 5%;
}

#kakao_login_btn2 {
	width: 49%;
	height: 36.5px;
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
<title>Login</title>
<script type="text/JavaScript"
	src="http://code.jquery.com/jquery-1.7.min.js"></script>
<!-- 카카오로그인 사용 -->
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
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
							<h4 class="font-alt">Login</h4>
							<hr class="divider-w mb-10">
							<form class="form" id="login_form_id" name="login_form_nm"
								action="loginChk.do" method="post">
								<div class="form-group">
									<input class="form-control" type="email" id="u_email"
										name="email" placeholder="email" />
								</div>
								<div class="form-group">
									<input class="form-control" id="u_pw" type="password" name="pw"
										placeholder="password" onkeydown="enterKey(this)" />
								</div>


								<!--                   <div class="form-group"> -->
								<!--                     <button class="btn btn-round btn-b" id="yellow_btn" type="button">Login</button> -->
								<!--                   </div> -->
								<!--                    <div class="form-group"><a href="">Forgot Password?</a></div> -->
								<!--                   <div class="form-group"> -->
								<!-- 					<a id="kakao_login_btn" href="javascript:kakaoLogin()">카카오 -->
								<!-- 					<img src="../resources/images/kakao.png"/></a> -->
								<!-- 				  </div> -->
								<!--                 </form> -->

								<div class="form-group" id="col_login_button">
									<button class="btn btn-round btn-b" id="yellow_btn"
										type="button">Login</button>
									<a id="kakao_login_btn" href="javascript:kakaoLogin()">
										<!-- 카카오 --> <img id="kakao_login_btn2"
										src="../assets/images/kakao.png" />
									</a>
								</div>
							</form>

							<!-- 카카오로그인 form -->
							<form id='kakaoSubmit' name='kakaoSubmit'
								action='kakaoLoginChk.do' method='post'>
								<input name='kakao' type='hidden' id='kakao' value='empty'>
							</form>
						</div>

						<a id="kakao-login-btn"></a>
					</div>
				</div>
		</div>
		<!--         </section> -->

		<script type="text/javascript">
  // 웹 플랫폼 도메인 등 초기화한 앱의 설정이 그대로 적용됩니다.
  // 초기화한 앱에 현재 도메인이 등록되지 않은 경우 에러가 발생합니다.
//   Kakao.init('5f56ff886f56de144809301543987fba')
//   Kakao.Auth.createLoginButton({
//     container: '#kakao-login-btn',
//     success: function(authObj) {
//       Kakao.API.request({
//         url: '/v2/user/me',
//         success: function(res) {
//           alert("어디" +JSON.stringify(res))
//         },
//         fail: function(error) {
//           alert(
//             'login success, but failed to request user information: ' +
//               JSON.stringify(error)
//           )
//         },
//       })
//     },
//     fail: function(err) {
//       alert('failed to login: ' + JSON.stringify(err))
//     },
//   })
</script>


		<script type='text/javascript'>
	  	//<![CDATA[
	    // 본인의 자바스크립트 키를 입력
	    Kakao.init('5f56ff886f56de144809301543987fba');
    	function kakaoLogin(){
    		Kakao.Auth.login({
    			success: function(result){
    				console.log(result);
    				console.log(JSON.stringify(result));
    				aaa = result.access_token;
    				console.log(aaa);
    				
    				Kakao.API.request({
    					url: '/v2/user/me',
    					success: function(res){
    						console.log(res);
    						console.log(JSON.stringify(res));
    						$("#kakao").val(JSON.stringify(res));
    	                    console.log($("#kakao").val());
    	                    kakaoSubmit.submit();
    					}
    				});
    			},
    	        fail: function(err) {
    	        	console.log(JSON.stringify(err));
    	        }
    		});

    	}
    </script>
		<script>
    	$(document).ready(function(){
    		$("#yellow_btn").click(function(){
        		if($("#u_email").val() == ""){
        			swal('이메일을 입력해주세요.');
        			$("#u_email").focus();
        		}		
        		else if($("#u_pw").val() == ""){
        			swal('비밀번호를 입력해주세요.');
        			$("#u_pw").focus();
        		}
        		else{
        			$("#login_form_id").submit();
        		}
    		});

    	});
    	// 비밀번호에서 엔터키를 입력했을 경우
    	function enterKey(e){
    		if(event.keyCode == 13){
        		if($("#u_email").val() == ""){
        			swal('이메일을 입력해주세요.');
        			$("#u_email").focus();
        		}		
        		else if($("#u_pw").val() == ""){
        			swal('비밀번호를 입력해주세요.');
        			$("#u_pw").focus();
        		}
        		else{
        			$("#login_form_id").submit();
        		}  			
    		}
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