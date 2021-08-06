<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>카카오 아아디 등록</title>
  	<script type="text/JavaScript" src="http://code.jquery.com/jquery-1.7.min.js"></script>
	<script type="text/JavaScript" src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>

</head>
<body>
    <div style="text-align: center;">
        <h1>카카오 아이디 세부사항 입력</h1>
        <form id="kAdmission_form_id" method="POST" action="kAdmission_ok.do">
	        <input type="hidden" id="hdn_jObj" name="hdn_jObj" value=${jObj}>
	        <div>
	        	<input type="text" size=50 id="k_email_id" name="kakao_email" placeholder="카카오 메일을 입력해주세요">
	        </div>
	       	<div>
	        	<input type="text" size=50 id="k_phone_id" name="phone" placeholder="전화번호를 입력해주세요">
	        </div>
	        <div>
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
    </div>
    
    <script>
    	$(document).ready(function(){
    		$("#submit_btn").click(function(){
    			if($("#k_email_id").val() == "" ||  $("#k_phone_id").val() == "" || $("#zonecode").val() == "" || $("#address").val() == "" || $("#address_etc").val() == ""){
    				alert('모두 입력해주세요');
    			}
    			else{
    				alert('승인');
// 					var jObj = ${jObj};
// 					console.log(jObj);
    				$("#kAdmission_form_id").submit();
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
</body>
</html>