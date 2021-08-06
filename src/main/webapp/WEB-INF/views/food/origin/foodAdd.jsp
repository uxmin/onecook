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
<!-- include summernote css/js-->
<link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.2/summernote.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.2/summernote.js"></script>
<title>글쓰기</title>

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
					alert('이미지가 업로드 됩니다.잠시만 기다려주세요');
// 					console.log(this);
// 					console.log(files[0]);
// 					console.log(files);
// 					console.log(files[0].size);
					for(var j = 0; j<files.length; j++){
						sendFile(files[j], this);
					}
		        }
			}
	  });
	  
	  var detail_count = 1;
	  $("#detail_btn_id").click(function(){
		  detail_count++;
		  var detail_div = "<div id='f_detail_div_"+ detail_count +"'><input type='text' class='fd_sub_class' name='fd_sub' placeholder='상세정보분류 명'><input type='text' class='fd_cont_class' name='fd_cont' placeholder='상세정보내용 명'></div>";
		  
		  $("#detail_head").append(detail_div);
		  
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
		        		alert('이미지 업로드 성공');
			            console.log(data);
			            console.log(JSON.stringify(data));
			            console.log(data.url);
				        $(editor).summernote('insertImage', data.url);
		        	}, 3000);

		        },
		        error:function(request,status,error){
		            console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		            alert('업로드가 실패 했습니다. 다시 한번 업로드 해주세요');
		           }
		    });
		}
	
</script>
</head>
<body>
<h2 style="text-align: center;">글 작성</h2><br><br><br>

<div style="width: 60%; margin: auto;">
	<form method="post" action="fooAddOk.do" enctype="multipart/form-data">
		<div>
			<span>재료명</span>
			<input type="text" id="f_name_id" name="f_name">
		</div>
		<div>
			<span>대표이미지</span>
			<input type="file" id="f_img_id" name="f_img_file">
		</div>
		<div>
			<span>대표 분류</span>
			<select id="cat_sel_id" name="f_type">
				<option>선택</option>
				<option id="veg_id" name="veg_nm" value="채소">채소</option>
				<option id="meat_id" name="meat_nm" value="정육_계란">정육/계란</option>
				<option id="sea_id" name="sea_nm" value="수산_해산_건어물">수산/해산/건어물</option>
				<option id="noodle_id" name="noodle_nm" value="면_양념_오일">면/양념/오일</option>
				<option id="other_id" name="other_nm" value="기타재료">기타재료</option>
			</select>
		</div>
		<div>
			<span>가격</span>
			<input type="text" id="f_price_id" name="f_price">
		</div>
		<div>
			<span>재고수량</span>
			<input type="text" id="f_count_id" name="f_count">
		</div>
		<div>
			<span>판매단위</span>
			<input type="text" id="f_sales_id" name="f_sales">
		</div>
		<div>
			<span>중량/용량</span>
			<input type="text" id="f_weight_id" name="f_weight">
		</div>		
		<div>
			<span>원산지</span>
			<input type="text" id="f_origin_id" name="f_origin">
		</div>		
		<div>
			<span>포장 타입</span>
			<input type="text" id="f_package_id" name="f_package">
		</div>				
	
		<h3>---- 세부내용 입력 ----</h3>
<!-- 		<span>세부 제목</span> -->
<!-- 		<input type="text" name="fe_sub" style="width: 40%;" placeholder="세부 제목 입력"/> -->
<!-- 		<br> -->
		<br> 
		<span>세부 내용</span>
		<textarea id="summernote" name="fe_cont"></textarea>
		
		<h3>---- 상세정보 입력 ----</h3>
		<div id="detail_head">
			<button id="detail_btn_id" type="button">상세정보 생성</button>
			<button id="detail_remove_id" type="button">상세정보 제거(마지막 순)</button>
			<div id="f_detail_div_1">
				<input type="text" class="fd_sub_class" name="fd_sub" placeholder="상세정보분류 명">
				<input type="text" class="fd_cont_class" name="fd_cont" placeholder="상세정보내용 명">
			</div>	
		</div>

		
		<input id="subBtn" type="submit" value="글 작성" style="float: right;"/>
	</form>
</div>

</body>
</html>