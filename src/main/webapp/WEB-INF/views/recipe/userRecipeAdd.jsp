<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko" dir="ltr">
<head>
<title class="title">ONECOOK: Add Recipe</title>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<%@ include file="../common/head_link.jsp"%>
<%@ include file="../common/js_link.jsp"%>
<!-- include summernote css/js-->
<link
	href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.2/summernote.css"
	rel="stylesheet">
<script
	src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.2/summernote.js"></script>

<style>
#food_tit_img_id {
	padding: 8% 3% 3% 3%;
}

.yellow_btn_add {
	width: 100%;
	background: rgba(255, 219, 79, 0.9) !important;
	border: 1px solid rgb(255, 219, 79);
	color: rgba(17, 17, 17, 0.8);
	font-size: 13px;
}

.yellow_btn_add:hover, .yellow_btn_add:focus {
	background: rgba(255, 219, 79, 0.5) !important;
	color: rgba(17, 17, 17, 0.5);
}
/* 모달창 문제 해결해주는 css */
.modal-backdrop {
	/* bug fix - no overlay */
	display: none;
}
input[type="text"]:focus {
	border-color: rgb(111, 186, 44);
	box-shadow: 0 0 8px 0 rgb(111, 186, 44);
}
</style>
<script>
    $(document).ready(function() {
  	  
  	  $('#summernote').summernote({
  	    	placeholder: '세부 레시피를 입력해주세요',
  	        minHeight: 370,
  	        maxHeight: null,
  	        focus: true, 
  	        lang : 'ko-KR',
  			callbacks: {
  				onImageUpload: function(files, editor, welEditable) {
  					swal('이미지가 업로드중이에요. 잠시만 기다려주세요.');

  					for(var j = 0; j<files.length; j++){
  						sendFile(files[j], this);
  					}
  		        }
  			}
  	  });
  	  
  	  
  	  $("#subBtn").click(function(){
  		 var file_chk = $("#rc_img_file_id")[0].files.length;
  		 if(file_chk > 0){
  			 $("#userForm").submit();
  		 }
  		 else{
  			 swal({
  				text: "대표 이미지를 업로드해주세요.",
  				icon: "warning"
  			 });
  		 }
  	  });
  	});
  	
  	/* summernote에서 이미지 업로드시 실행할 함수 */
  	function sendFile(file, editor) {
  	// 파일 전송을 위한 폼생성
  		console.log(file);
  		console.log(editor);
  		data = new FormData();
  	    data.append("file", file);
  	    $.ajax({ // ajax를 통해 파일 업로드 처리
  	        data : data,
  	        type : "POST",
  	        url : "./userRecipeImageAdd.do",
  	        cache : false,
  	        contentType : false,
  	        enctype: 'multipart/form-data',
  	        processData : false,
  	        success : function(data) { // 처리가 성공할 경우
  	        	// 에디터에 이미지 출력
  	        	setTimeout(function() {
  	    			swal({
  	    				title : "이미지 업로드 성공",
  	    				text : "업로드 된 이미지를 확인해주세요.",
  	    				icon : "success"
  	    			}).then(function() {
  	    				$(editor).summernote('insertImage', data.url);
  	    			});
  	    		}, 3000);
  	
  	        },
  	        error:function(request,status,error){
  	            console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
  	           	swal({
  	           		title: '이미지 업로드 실패',
  	           		text: "이미지 업로드를 다시 시도해주세요."
  	           	});
  	       	}
  	    });
  	}
  	
  	
  	function setThumbnail(event) { 
 	  		$("#image_container").empty();
 	  		
 	  		var reader = new FileReader(); 
 	  	
 	  		reader.onload = function(event) { 
 	  			var img = document.createElement("img"); 
 	  			img.setAttribute("src", event.target.result); 
 	  			img.style.maxHeight = "15rem";
 	  			document.querySelector("div#image_container").appendChild(img);
 				}; 
 	  			reader.readAsDataURL(event.target.files[0]); 
 	  	}
  
    </script>
</head>
<body data-spy="scroll" data-target=".onpage-navigation"
	data-offset="60">
	<main>
		<div class="page-loader">
			<div class="loader">Loading...</div>
		</div>

		<%@ include file="../common/header.jsp"%>

		<div class="main">

			<section id="food_tit_img_id"
				class="module bg-dark-60 shop-page-header"
				data-background="../assets/images/food-1209503_1920.jpg">
				<div class="container">
					<div class="row">
						<div class="col-sm-6 col-sm-offset-3">
							<h2 class="module-title font-alt">ADD RECIPE</h2>
							<div class="module-subtitle font-alt">나만의 통통튀는 아이디어를 함께
								공유해봅시다!</div>
						</div>
					</div>
				</div>
			</section>

			<section class="module">
				<div class="container">
					<div class="row">
						<div class="col-sm-8 col-sm-offset-2">
							<h4 class="font-alt mb-0">Recipe User Forms</h4>
							<hr class="divider-w mt-10 mb-20">
							<form id="userForm" method="post" action="userRecipeAddOk.do"
								enctype="multipart/form-data">

								<div class="form-group">
									<div class="col-sm-6" style="padding-left: 0">
										<div class="form-group">
											<label class="sr-only" for="name">Name</label> <input
												class="form-control" type="text" id="rc_title_id"
												name="rc_title" placeholder="레시피 제목" />
										</div>
									</div>

									<div class="col-sm-6" style="padding: 0">
										<div class="form-group">
											<label class="sr-only">Name</label> <input
												class="form-control" type="file" id="rc_img_file_id"
												name="rc_img_file" accept="image/*"
												onchange="setThumbnail(event);">
										</div>
									</div>
								</div>

								<div class="form-group">
									<h5 class="font-alt mb-0">미리보기</h5>
									<hr class="divider-w mt-10 mb-20">
									<div id="image_container"
										style="text-align: center; max-height:"></div>
								</div>


								<div class="form-group" style="margin-top: 50px">
									<textarea class="form-control" id="summernote"
										name="get_img_cont"></textarea>
								</div>

								<input class="yellow_btn_add btn btn-round btn-d mt-80"
									id="subBtn" type="button" value="레시피 등록하기"
									style="margin-top: 20px; color: black;" />
							</form>
						</div>
					</div>
				</div>
			</section>

			<%@ include file="../common/footer.jsp"%>

		</div>
		<div class="scroll-up">
			<a href="#totop"><i class="fa fa-angle-double-up"></i></a>
		</div>
	</main>

</body>
</html>