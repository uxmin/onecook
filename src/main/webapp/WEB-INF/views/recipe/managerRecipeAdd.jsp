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
input[type="text"]:focus {
	border-color: rgb(111, 186, 44);
	box-shadow: 0 0 8px 0 rgb(111, 186, 44);
}
</style>
<script>
    $(document).ready(function() {
  	  var recipe_order_count = 1;
  	  $("#recipe_cnt_btn_id").click(function(){
  		  recipe_order_count++;
  		  var rc_img_order_div = 
  			"<div class='form-group' id='recipe_order_div_"+ recipe_order_count +"' style='margin-bottom:5px;'><label class='sr-only'>Name</label><input class='form-control' type='file' class='rc_img_file_class' name='image_tb_file'><textarea type='text' class='form-control rc_cont_img_class' name='img_cont' placeholder='레시피 순서내용을 입력' cols='70' rows='5' style='margin-top: 5px'></textarea></div>";
  		  
  		  $("#recipe_order_head").append(rc_img_order_div);
  		  
  	  });
  	  
  	  $("#recipe_cnt_remove_id").click(function(){
  		 console.log(recipe_order_count); 
  		 $("#recipe_order_div_"+ recipe_order_count).remove();
  		 recipe_order_count--;
  	  });
  	  
  	  var rt_order_count = 1;
  	  $("#rt_cnt_btn_id").click(function(){
  		  rt_order_count++;
  		  
  		  var rt_add_div =
  			"<div class='form-group' id='rt_add_div_"+ rt_order_count +"'><div class='col-sm-6' style='padding-left:0'><div class='form-group' style='margin-bottom:5px'><label class='sr-only' for='name'>Name</label><input class='form-control' class='rt_cont_class' name='rt_cont' placeholder='재료명'/></div></div><div class='col-sm-6' style='padding:0'><div class='form-group' style='margin-bottom:5px'><select class='form-control' id='rt_cat_id_"+ rt_order_count +"' name='f_type' onchange='category(this.value, this.id);''><option>재료 주문 찾기</option><option value='none'>재료 없음</option><option value='채소'>채소</option><option value='수산_해산_건어물'>수산/해산/건어물</option><option value='정육_계란'>정육/계란</option><option value='면_양념_오일'>면/양념/오일</option><option value='기타재료'>기타재료</option></select></div></div></div></div><div class='form-group'><div id='fname_rt_cat_id_"+ rt_order_count +"'></div></div>";
  			
  		  $("#rt_add_head").append(rt_add_div);
  		  
  	  });
  	  
  	  var rn_order_count = 1;
  	  $("#rn_cnt_btn_id").click(function(){
  		 rn_order_count++;
  		 
  		 var rn_add_div =
   			"<div class='form-group' id='rn_add_div_"+ rn_order_count +"'><div class='col-sm-6' style='padding-left:0'><div class='form-group' style='margin-bottom:5px'><select class='form-control' id='rn_cat_id_"+ rn_order_count + "' name='nutrient_nm'><option>영양소 선택</option><option value='칼로리'>칼로리</option><option value='탄수화물'>탄수화물</option><option value='단백질'>단백질</option><option value='나트륨'>나트륨</option><option value='지방'>지방</option><option value='콜레스테롤'>콜레스테롤</option><option value='식이섬유'>식이섬유</option><option value='칼슘'>칼슘</option><option value='비타민C'>비타민C</option></select></div></div><div class='col-sm-6' style='padding:0'><div class='form-group' style='margin-bottom:5px'><label class='sr-only' for='name'>Name</label><input class='form-control' class='rate_cont_class' name='rate' placeholder='gram / kcal ...'/></div></div>";
		
  		$("#rn_add_head").append(rn_add_div);
  	  });
  	  
  	  $("#rt_cnt_remove_id").click(function(){
  		 console.log(rt_order_count); 
  		 $("#rt_add_div_"+ rt_order_count).remove();
  		 $("#fname_rt_cat_id_"+ rt_order_count).remove();
  		 rt_order_count--;
  	  });

  	  $("#rn_cnt_remove_id").click(function(){
   		 console.log(rn_order_count); 
   		 $("#rn_add_div_"+ rn_order_count).remove();
   		 $("#nutrient_rn_cat_id_"+ rn_order_count).remove();
   		 rn_order_count--;
   	  });
  	});
  	//재료 카테고리 클릭(select내용이 변경시 해당 함수를 실행)
  	function category(val, id){
  		console.log(val);
  		console.log(id);
  		
  		if(val == "none"){
  			console.log(id);
  			var fname_append = "<select class='form-control' id='f_name_result' name='f_name'><option value=''>재료없음</option></select>"
  			
  			$("#fname_"+ id).empty();
  			$("#fname_"+ id).append(fname_append);
  			
  		}
  		else{
  			$.ajax({
  				url:"category_sel.do",
  				type: "GET",
  				data: {category : val},
  				success: function(result){
 	 				console.log(result);
 	 				$("#fname_"+ id).empty();
  					$("#fname_"+ id).append(result);
  				}
  			});			
  		}
  	
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
							<div class="module-subtitle font-alt">레시피 등록하기</div>
						</div>
					</div>
				</div>
			</section>

			<section class="module">
				<div class="container">
					<div class="row">
						<div class="col-sm-8 col-sm-offset-2">
							<h4 class="font-alt mb-0">Recipe Manager Forms</h4>
							<hr class="divider-w mt-10 mb-20">
							<form method="post" action="managerRecipeAddOk.do"
								enctype="multipart/form-data">
								<div class="col-sm-3" style="padding-left: 0">
									<div class="form-group">
										<select class="form-control" id="rc_type_sel_id"
											name="rc_type">
											<option>레시피 가격분류</option>
											<option id="op_3000" name="op_3000" value="3000원대">3000원
												대</option>
											<option id="op_5000" name="op_5000" value="5000원대">5000원
												대</option>
											<option id="op_7000" name="op_5000" value="7000원대">7000원
												대</option>
										</select>
									</div>
								</div>

								<div class="col-sm-5" style="padding-left: 0">
									<div class="form-group">
										<label class="sr-only" for="name">Name</label> <input
											class="form-control" type="text" id="rc_title_id"
											name="rc_title" placeholder="레시피 제목" />
									</div>
								</div>

								<div class="col-sm-4" style="padding: 0">
									<div class="form-group">
										<label class="sr-only">Name</label> <input
											class="form-control" type="file" id="rc_img_file_id"
											name="rc_img_file" accept="image/*"
											onchange="setThumbnail(event);">
									</div>
								</div>


								<div class="form-group">
									<h5 class="font-alt mb-0">미리보기</h5>
									<hr class="divider-w mt-10 mb-20">
									<div id="image_container"
										style="text-align: center; max-height:"></div>
								</div>
								<br />


								<h5 class="font-alt mb-0">레시피 작성</h5>
								<hr class="divider-w mt-10 mb-20">

								<div id="recipe_order_head">
									<div class="form-group" id="recipe_order_div_1"
										style="margin-bottom: 5px;">
										<label class="sr-only">Name</label> <input
											class="form-control" type="file" class="rc_img_file_class"
											name="image_tb_file">
										<textarea type="text" class="form-control rc_cont_img_class"
											name="img_cont" placeholder="레시피 순서내용을 입력" cols="70" rows="5"
											style="margin-top: 5px"></textarea>
									</div>
								</div>

								<div class="form-group" style="margin-bottom: 35px;">
									<div class="col-sm-6" style="padding-left: 0">
										<button class="btn btn-g btn-round btn-block"
											id="recipe_cnt_btn_id" type="button">추가</button>
									</div>

									<div class="col-sm-6" style="padding: 0">
										<button class="btn btn-g btn-round btn-block"
											id="recipe_cnt_remove_id" type="button">제거</button>
									</div>
								</div>
								<br />

								<h5 class="font-alt mb-0">레시피 재료등록</h5>
								<hr class="divider-w mt-10 mb-20">

								<div id="rt_add_head">
									<div class="form-group" id="rt_add_div_1">
										<div class="col-sm-6" style="padding-left: 0">
											<div class="form-group" style="margin-bottom: 5px">
												<label class="sr-only" for="name">Name</label> <input
													class="form-control" class="rt_cont_class" name="rt_cont"
													placeholder="재료명" />
											</div>
										</div>

										<div class="col-sm-6" style="padding: 0">
											<div class="form-group" style="margin-bottom: 5px">
												<select class="form-control" id="rt_cat_id_1" name="f_type"
													onchange="category(this.value, this.id);">
													<option>선택</option>
													<option value="none">재료 없음</option>
													<option value="채소">채소</option>
													<option value="수산_해산_건어물">수산/해산/건어물</option>
													<option value="정육_계란">정육/계란</option>
													<option value="면_양념_오일">면/양념/오일</option>
													<option value="기타재료">기타재료</option>
												</select>
											</div>
										</div>
									</div>

									<!-- ajax로 위의 카테고리 선택시 재료들이 담겨있는 select박스 생성하기-->
									<!-- 9/22 찾은 카테고리 재료를 추가하는 부분을 수정하기 -->
									<div class="form-group">
										<div id="fname_rt_cat_id_1"></div>
									</div>

								</div>

								<div class="form-group">
									<div class="col-sm-6" style="padding-left: 0">
										<button id="rt_cnt_btn_id"
											class="btn btn-g btn-round btn-block" type="button">추가</button>
									</div>
									<div class="col-sm-6" style="padding: 0">
										<button id="rt_cnt_remove_id"
											class="btn btn-g btn-round btn-block" type="button">제거</button>
									</div>
								</div>
								<br />

								<div id="rn_add_head">
									<div class="form-group">
										<h5 class="font-alt mb-0" style="margin-top: 80px">영양소 등록</h5>
										<hr class="divider-w mt-10 mb-20">

										<div class="form-group" id="rt_add_div_1">

											<div class="col-sm-6" style="padding-left: 0">
												<div class="form-group" style="margin-bottom: 5px">
													<select class="form-control" id="rn_cat_id_1"
														name="nutrient_nm">
														<option>영양소 선택</option>
														<option value="칼로리">칼로리</option>
														<option value="탄수화물">탄수화물</option>
														<option value="단백질">단백질</option>
														<option value="나트륨">나트륨</option>
														<option value="지방">지방</option>
														<option value="콜레스테롤">콜레스테롤</option>
														<option value="식이섬유">식이섬유</option>
														<option value="칼슘">칼슘</option>
														<option value="비타민C">비타민C</option>
													</select>
												</div>
											</div>

											<div class="col-sm-6" style="padding: 0">
												<div class="form-group" style="margin-bottom: 5px">
													<label class="sr-only" for="name">Name</label> <input
														class="form-control" class="rate_cont_class" name="rate"
														placeholder="gram / kcal ..." />
												</div>
											</div>
										</div>

									</div>
								</div>


								<div class="form-group">
									<div class="col-sm-6" style="padding-left: 0">
										<button id="rn_cnt_btn_id"
											class="btn btn-g btn-round btn-block" type="button">추가</button>
									</div>
									<div class="col-sm-6" style="padding: 0">
										<button id="rn_cnt_remove_id"
											class="btn btn-g btn-round btn-block" type="button">제거</button>
									</div>
								</div>


								<input class="yellow_btn_add btn btn-round btn-d mt-80"
									id="subBtn" type="submit" value="레시피 등록"
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