<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko" dir="ltr">
<head>
<title class="title">ONECOOK: Add Food</title>
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
   	    	placeholder: '세부 제목을 입력해주세요',
  	        minHeight: 370,
  	        maxHeight: null,
  	        focus: true, 
  	        lang : 'ko-KR',
  			callbacks: {
  				onImageUpload: function(files, editor, welEditable) {
  					swal('이미지가 업로드중이에요. 잠시만 기다려주세요.');
//   					console.log(this);
//   					console.log(files[0]);
//   					console.log(files);
//   					console.log(files[0].size);
  					for(var j = 0; j<files.length; j++){
  						sendFile(files[j], this);
  					}
  		        }
  			}
  	  });
  	  
  	  var detail_count = 1;
  	  $("#detail_btn_id").click(function(){
  		  detail_count++;
  		  var detail_div = "<div id='f_detail_div_"+ detail_count +"'><div class='col-sm-4' style='padding-left:0'><input type='text' class='form-control fd_sub_class' name='fd_sub' placeholder='상세정보분류 명'></div><div class='col-sm-8' style='padding:0'><input type='text' class='form-control fd_cont_class' name='fd_cont' placeholder='상세정보내용 명'></div></div>";
  		  console.log(detail_div);
  		  
  		  $(".detail_head").append(detail_div);
  		  
  	  });
  	  
  	  $("#detail_remove_id").click(function(){
  		 console.log(detail_count); 
  		 $("#f_detail_div_"+ detail_count).remove();
  		 detail_count--;
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
  		        url : "./ImageAdd.do",
  		        cache : false,
  		        contentType : false,
  		        enctype: 'multipart/form-data',
  		        processData : false,
  		        success : function(data) { // 처리가 성공할 경우
  	            	// 에디터에 이미지 출력
  		        	setTimeout(function() {
	  		  			swal({
	  		  				title : "이미지 업로드 성공!",
	  		  				text : "업로드된 이미지를 확인해보세요.",
	  		  				icon : "success"
	  		  			}).then(function() {
		  		  			$(editor).summernote('insertImage', data.url);
	  				        $("#asdasd").append('img', data.url);
	  		  			});
	  		  		}, 3000);

  		        },
  		        error:function(request,status,error){
  		            console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
  		             swal({
  		            	title: '이미지 업로드 실패',
  		            	text: '다시 시도해주세요.',
  		            	icon: 'error'
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
				data-background="../assets/images/fruit-1534494_1920.jpg">
				<div class="container">
					<div class="row">
						<div class="col-sm-6 col-sm-offset-3">
							<h2 class="module-title font-alt">ADD FOOD</h2>
							<div class="module-subtitle font-alt">재료 등록하기</div>
						</div>
					</div>
				</div>
			</section>

			<section class="module">
				<div class="container">
					<div class="row">
						<div class="col-sm-8 col-sm-offset-2">
							<h4 class="font-alt mb-0">Food Forms</h4>
							<hr class="divider-w mt-10 mb-20">
							<form method="post" action="fooAddOk.do"
								enctype="multipart/form-data">
								<div class="col-sm-3" style="padding-left: 0">
									<div class="form-group">
										<select class="form-control" id="cat_sel_id" name="f_type">
											<option>대표 분류</option>
											<option id="veg_id" name="veg_nm" value="채소">채소</option>
											<option id="meat_id" name="meat_nm" value="정육_계란">정육/계란</option>
											<option id="sea_id" name="sea_nm" value="수산_해산_건어물">수산/해산/건어물</option>
											<option id="noodle_id" name="noodle_nm" value="면_양념_오일">면/양념/오일</option>
											<option id="other_id" name="other_nm" value="기타재료">기타재료</option>
										</select>
									</div>
								</div>
								<div class="col-sm-5" style="padding-left: 0">
									<div class="form-group">
										<label class="sr-only" for="name">Name</label> <input
											class="form-control" type="text" id="f_name_id" name="f_name"
											placeholder="재료명" />
									</div>
								</div>
								<div class="col-sm-4" style="padding: 0">
									<div class="form-group">
										<label class="sr-only">Name</label> <input
											class="form-control" type="file" id="f_img_id"
											name="f_img_file" accept="image/*"
											onchange="setThumbnail(event);">
									</div>
								</div>

								<div class="form-group">
									<h5 class="font-alt mb-0">미리보기</h5>
									<hr class="divider-w mt-10 mb-20">
									<div id="image_container"
										style="text-align: center; max-height:"></div>
								</div>

								<div class="form-group">
									<input class="form-control" type="text" id="f_price_id"
										name="f_price" placeholder="가격 " />
								</div>

								<div class="form-group">
									<input class="form-control" type="text" id="f_count_id"
										name="f_count" placeholder="재고 수량" />
								</div>

								<div class="form-group">
									<input class="form-control" type="text" id="f_sales_id"
										name="f_sales" placeholder="판매 단위 " />
								</div>

								<div class="form-group">
									<input class="form-control" type="text" id="f_weight_id"
										name="f_weight" placeholder="중량/용량" />
								</div>

								<div class="form-group">
									<input class="form-control" type="text" id="f_origin_id"
										name="f_origin" placeholder="원산지 " />
								</div>

								<div class="form-group">
									<input class="form-control" type="text" id="f_package_id"
										name="f_package" placeholder="포장타입 " />
								</div>

								<textarea class="form-control" id="summernote" name="fe_cont"></textarea>
								<h1 id="asdasd"></h1>

								<div class="form-group" style="margin-bottom: 35px;">
									<div class="col-sm-6" style="padding-left: 0">
										<button class="btn btn-g btn-round btn-block"
											id="detail_btn_id" type="button">추가</button>
									</div>

									<div class="col-sm-6" style="padding: 0">
										<button class="btn btn-g btn-round btn-block"
											id="detail_remove_id" type="button">제거</button>
									</div>
								</div>
								<br />
								<div class="form-group">
									<div id="f_detail_div_1" class="detail_head"
										style="margin-bottom: 10px">
										<div class="col-sm-4" style="padding-left: 0">
											<input type="text" class="form-control fd_sub_class"
												name="fd_sub" placeholder="상세정보분류 명">
										</div>
										<div class="col-sm-8" style="padding: 0"
											style="margin-bottom:10px">
											<input type="text" class="form-control fd_cont_class"
												name="fd_cont" placeholder="상세정보내용 명">
										</div>
									</div>
								</div>

								<input class="yellow_btn_add btn btn-round btn-d mt-80"
									id="subBtn" type="submit" value="재료 등록하기" style="color: black;" />
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