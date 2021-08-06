<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>회원가입</title>
  	<script type="text/JavaScript" src="http://code.jquery.com/jquery-1.7.min.js"></script>
	<script type="text/JavaScript" src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>

</head>
<body>
    <div style="text-align: center;">
        <h1>회원가입 페이지</h1>
        <form id="admission_form_id" method="POST" action="admission_ok.do">
	        <div>
	        	<input type="email" id="email_in" size=50 name="email" placeholder="email을 입력해주세요">
	        	<input type="hidden" id="email_chk" value="email_uncheck">
	        	<p id="msgEmail">인증을 해주세요</p>
	        </div>
			<div>
	        	<input type="text" size=50 id="u_email_code_id" name="u_email_code_nm" placeholder="메일 중복을 확인해주세요" disabled="">
	        	<input type="hidden" id="hdn_email_code_chk" value="email_incode_fail">
	        </div>
	        <div>
	        	<input type="password" size=50 id="u_pw_id" name="pw" placeholder="pw를 입력해주세요">
	        </div>
	       	<div>
	        	<input type="password" size=50 id="u_pw_chk_id" name="u_pw_chk" placeholder="pw를 다시 한번 입력해주세요">
	        </div>
	        <div>
	        	<input type="text" size=50 id="u_name_id" name="user_name" placeholder="이름을 입력해주세요">
	        </div>
	        <div>
	        	<input type="text" size=50 id="u_phone_id" name="phone" placeholder="전화번호를 입력해주세요">
	        </div>
	        <div>
			<!-- 	<input id="postcode1" type="text" value="" style="width:50px;" readonly/> -->
			<!-- 	&nbsp;-&nbsp; -->
			<!-- 	<input id="postcode2" type="text" value="" style="width:50px;" readonly/> -->
			<!-- 	&nbsp;&nbsp; -->
				<input id="zonecode" type="text" value="" style="width:50px;" readonly/>
				&nbsp;
				<input type="button" onClick="openDaumZipAddress();" value = "주소  찾기" />
				<br/>
				<input type="text" id="address" name="addr_no1" value="" style="width:240px;" readonly/>
				<input type="text" id="address_etc" name="addr_no2" value="" style="width:200px;"/>	        	
	        </div>
	        <div>
				<button type="button" id="submit_btn">회원가입</button>
			</div>
		</form>
		<div>
			<button id="overlap_btn" onclick="">중복확인</button>
		</div>
		<div>
			<button id="email_send_chk_btn" onclick="">인증확인</button>
			<button id="email_send_btn" onclick="">인증번호발송</button>
		</div>
    </div>
    
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
			var RegEmail = RegExp(/^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/);	//메일 정규식 확인
			var RegPw = RegExp(/^[a-zA-Z0-9]{4,12}$/);	//패스워드 정규식 확인
			// 이메일 중복버튼 클릭
			$("#overlap_btn").click(function(){
				//console.log(address_var.address);	//첫번쨰 주소확인
				//console.log($("#address_etc").val());	//두번째 주소확인
		  		if(!RegEmail.test($("#email_in").val())){
		  	        $("#msgEmail").css("color","red");
		  	        $("#msgEmail").text("이메일 형식에 맞게 입력해주세요");
		  	        $("#u_email_code_id").attr("placeholder", "메일 중복을 확인해주세요");
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
							alert("인증번호 발송");
						},
						error: function(err){
							console.log(err);
						}
					});
				}
				// 이메일 체크 비확인
				else{
					alert("이메일 중복을 체크해 주세요");
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
								alert("인증 실패");
							}
							else{
								$("#u_email_code_id").attr("disabled", true);
								$("#email_send_chk_btn").attr("disabled", true);
								$("#email_send_btn").attr("disabled", true);
								$("#hdn_email_code_chk").val("email_incode_ok");
								alert("인증 확인");	
							}
							
						}
					});
				}
				// 이메일 체크 비확인
				else{
					alert("이메일 중복을 체크해 주세요");
				}
			});
			// 회원가입 버튼 클릭시
			$("#submit_btn").click(function(){
				if($("#email_in").val() == "" || $("#u_email_code_id").val() == "" || $("#u_pw_id").val() == "" 
						|| $("#u_pw_chk_id").val() == "" || $("#u_name_id").val() == "" || $("#u_phone_id").val() == ""
						|| $("#zonecode").val() == "" || $("#address").val() == "" || $("#address_etc").val() == ""){

					alert('모두 입력해주세요');
				}
				else{
					if($("#u_pw_id").val() != $("#u_pw_chk_id").val()){
						alert('비밀번호가 다릅니다');
					}
					//비밀번호와 비밃번호 비교가 같을 경우
					else{
						// 이메일 중복체크가 되지 않은 경우
						if($("#email_chk").val() == "email_uncheck"){
							alert('이메일 중복을 확인해주세요')
						}
						// 이메일 중복체크가 된 경우
						else{
							// 이메일 인증코드를 승인하지 않은 경우
							if($("#hdn_email_code_chk").val() == "email_incode_fail"){
								alert('이메일 인증을 해주세요');
							}
							// 이메일 인증코드를 승인한 경우
							else{
								$("#admission_form_id").submit();
								alert('회원가입이 되었습니다. 다시 로그인해주세요');
								//location.href="../";
							}
						}
					}
				}
				
			});
			
		});
	</script>
</body>
</html>