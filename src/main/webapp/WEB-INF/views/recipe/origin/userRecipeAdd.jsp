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
	    	placeholder: '세부 레시피를 입력해주세요',
	        minHeight: 370,
	        maxHeight: null,
	        focus: true, 
	        lang : 'ko-KR',
			callbacks: {
				onImageUpload: function(files, editor, welEditable) {
					alert('이미지가 업로드 됩니다.잠시만 기다려주세요');

					for(var j = 0; j<files.length; j++){
						sendFile(files[j], this);
					}
		        }
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
<h2 style="text-align: center;">유저 레시피 등록</h2><br><br><br>

<div style="width: 60%; margin: auto;">
	<form method="post" action="userRecipeAddOk.do" enctype="multipart/form-data">
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
		<textarea id="summernote" name="get_img_cont"></textarea>
		
		<br/>		

		<input id="subBtn" type="submit" value="글 작성" style="float: right;"/>
	</form>
</div>

</body>
</html>