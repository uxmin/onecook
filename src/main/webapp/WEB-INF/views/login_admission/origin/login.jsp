<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>로그인</title>
  <script type="text/JavaScript" src="http://code.jquery.com/jquery-1.7.min.js"></script>
  <!-- 카카오로그인 사용 -->
  <script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
</head>
<body>
    <div style="text-align: center;">
        <h1>로그인 페이지</h1>
        <form id="login_form_id" name="login_form_nm" action="loginChk.do" method="post">
	        <div>
	        	<input type="email" size=50 id="u_email" name="email" placeholder="email을 입력해주세요">
	        </div>
	        <div>
	        	<input type="password" size=50 id="u_pw" name="pw" placeholder="pw를 입력해주세요" onkeydown="enterKey(this)">
	        </div>
	        <div>
				<button id="login_btn" type="button">로그인</button>
			</div>
			<div>
				<a id="kakao_login_btn" href="javascript:kakaoLogin()"><!-- 카카오 -->
					<img src="../resources/images/kakao.png" height="70"/>
				</a>
			</div>
		</form>

		<!-- 카카오로그인 form -->
	    <form id='kakaoSubmit' name='kakaoSubmit' action='kakaoLoginChk.do' method='post'>
	   		<input name='kakao' type='hidden' id='kakao' value='empty'>
	   	</form>
    </div>
    
    <a id="kakao-login-btn"></a>

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
    		$("#login_btn").click(function(){
        		if($("#u_email").val() == ""){
        			alert('이메일을 입력해주세요');
        			$("#u_email").focus();
        		}		
        		else if($("#u_pw").val() == ""){
        			alert('비밀번호를 입력해주세요');
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
        			alert('이메일을 입력해주세요');
        			$("#u_email").focus();
        		}		
        		else if($("#u_pw").val() == ""){
        			alert('비밀번호를 입력해주세요');
        			$("#u_pw").focus();
        		}
        		else{
        			$("#login_form_id").submit();
        		}  			
    		}
    	}
    </script>
</body>
</html>