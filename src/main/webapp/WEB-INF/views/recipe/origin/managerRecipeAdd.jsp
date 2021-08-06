<%@page contentType="text/html;charset=utf-8"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<!-- include libraries(jQuery, bootstrap) -->
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.4/jquery.js"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script>
<title>글쓰기</title>

<script>
$(document).ready(function() {
	  var recipe_order_count = 1;
	  $("#recipe_cnt_btn_id").click(function(){
		  recipe_order_count++;
		  var rc_img_order_div = 
			"<br/><div id='recipe_order_div_"+ recipe_order_count +"'><input type='file' class='rc_img_file_class' name='image_tb_file'><span>레시피 순서</span><textarea type='text' class='rc_cont_img_class' name='img_cont' placeholder='레시피 순서내용을 입력해주세요' cols='70'></textarea></div>";
		  
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
			"<div id='rt_add_div_"+ rt_order_count +"'><span>레시피 재료</span><input type='text' class='rt_cont_class' name='rt_cont'><span>재료 주문 찾기</span><select id='rt_cat_id_"+ rt_order_count +"' name='f_type' onchange='category(this.value, this.id);'><option>선택</option><option value='none'>재료 없음</option><option value='채소'>채소</option><option value='수산_해산_건어물'>수산/해산/건어물</option><option value='정육_계란'>정육/계란</option><option value='면_양념_오일'>면/양념/오일</option><option value='기타재료'>기타재료</option></select><div id='fname_rt_cat_id_"+ rt_order_count +"'></div></div>";
			
		  $("#rt_add_head").append(rt_add_div);
		  
	  });
	  
	  $("#rt_cnt_remove_id").click(function(){
		 console.log(rt_order_count); 
		 $("#rt_add_div_"+ rt_order_count).remove();
		 rt_order_count--;
	  });
	 
	});
	//재료 카테고리 클릭(select내용이 변경시 해당 함수를 실행)
	function category(val, id){
		console.log(val);
		console.log(id);
		
		if(val == "none"){
			console.log(id);
			var fname_append = "<select id='f_name_result' name='f_name'><option value=''>재료없음</option></select>"
			
			$("#fname_"+ id).append(fname_append);
		}
		else{
			$.ajax({
				url:"category_sel.do",
				type: "GET",
				data: {category : val},
				success: function(result){
//	 				console.log(result);
					$("#fname_"+ id).html(result);
				}
			});			
		}
	
	}
	
</script>
</head>
<body>
<h2 style="text-align: center;">관리자 레시피 등록</h2><br><br><br>

<div style="width: 60%; margin: auto;">
	<form method="post" action="managerRecipeAddOk.do" enctype="multipart/form-data">
		<div>
			<span>레시피 제목</span>
			<input type="text" id="rc_title_id" name="rc_title">
		</div>
		<div>
			<span>레시피 가격분류</span>
			<select id="rc_type_sel_id" name="rc_type">
				<option>선택</option>
				<option id="op_3000" name="op_3000" value="3000원대">3000원 대</option>
				<option id="op_5000" name="op_5000" value="5000원대">5000원 대</option>
				<option id="op_7000" name="op_5000" value="7000원대">7000원 대</option>
			</select>
		</div>
		<br/>
		<div>
			<span>레시피 메인 이미지 등록</span>
			<input type="file" id="rc_img_file_id" name="rc_img_file">
		</div>
		<br/>		
		<h3>---- 레시피 순서 작성 ----</h3>
		<div id="recipe_order_head">
			<div id="recipe_order_div_1">
				<input type="file" class="rc_img_file_class" name="image_tb_file">
				<span>레시피 순서</span>
				<textarea type="text" class="rc_cont_img_class" name="img_cont" placeholder="레시피 순서내용을 입력해주세요" cols="70"></textarea>
			</div>	
		</div>
		<button id="recipe_cnt_btn_id" type="button">레시피순서 추가하기</button>
		<button id="recipe_cnt_remove_id" type="button">레시피순서 제거</button>
		<br/>		
		<h3>---- 재료 추가 하기 ----</h3>
		<div id="rt_add_head">
			<div id="rt_add_div_1">
			<span>레시피 재료</span>
			<input type="text" class="rt_cont_class" name="rt_cont">
			<span>재료 주문 찾기</span>
			<select id="rt_cat_id_1" name="f_type" onchange="category(this.value, this.id);">
				<option>선택</option>
				<option value="none">재료 없음</option>
				<option value="채소">채소</option>
				<option value="수산_해산_건어물">수산/해산/건어물</option>
				<option value="정육_계란">정육/계란</option>
				<option value="면_양념_오일">면/양념/오일</option>
				<option value="기타재료">기타재료</option>
			</select>
			<!-- ajax로 위의 카테고리 선택시 재료들이 담겨있는 select박스 생성하기-->
			<div id="fname_rt_cat_id_1"></div>
			</div>
		</div>
		<button id="rt_cnt_btn_id" type="button">재료 추가하기</button>
		<button id="rt_cnt_remove_id" type="button">재료 제거</button>
		<br/>
		<input id="subBtn" type="submit" value="글 작성" style="float: right;"/>
	</form>
</div>

</body>
</html>