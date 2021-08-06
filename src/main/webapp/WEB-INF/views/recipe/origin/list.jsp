<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="../js/jquery-3.1.1.min.js"></script>
<script src="../js/bootstrap.min.js"></script>
<link rel="stylesheet" href="../css/bootstrap.min.css">
<link rel="stylesheet" href="../css/bootstrap-theme.min.css">

<!-- 4. Javascript -->
<script type="text/javascript" src="../js/paging.js"></script>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</style>
	<script language="javascript">
	
	     $(document).ready(function(){
	    	 $(".show_review_tr").css("display", "none"); //처음 리스트가 띄어지고 리스트에 클릭하면 나오는 content를 감추는 역할
	    	 console.log($(".change_name"));
	    	 for(var i=0; i<$(".change_name").length; i++){
	    		 console.log($(".change_name")[i].innerText);
	    		 var origin = $(".change_name")[i].innerText;
	    		 
	    		 var change_name = replaceAt(origin, 1, '*');
	    		 console.log(change_name);
	    		 $(".change_name")[i].innerText = change_name;
	    	 }
	    	 
	    	 $(".toggle_review_sub").click(function(){ // content (제목을 클릭하면 발생하는 이벤트)
	    		 console.log($(this)); //console.log($(this)[0]); => 현재 클릭된 html코드만 나온다 console.log($(this)); => 전체적인 요소가 다 나온다.
	    		//console.log($(this)[0]);
	    		reviewFname = $(this)[0].childNodes[0].value; //클릭된 요소에 첫번째 자식의 값  
	    		reviewNum = $(this)[0].childNodes[1].value; //클릭된 요소에 두번째 자식의 값
	    		console.log(reviewFname);
	    		console.log(reviewNum);
	    		
	    		$("#tr_head_"+reviewNum).toggle("slow"); //id:tr_head를 준다.
	    		$("#tr_body_"+reviewNum).toggle("slow");
	     	});
	     });
	    		
	   function check()
	   {
	       for(var i=0; i<2; i++)
		   {
		      if(document.input.elements[i].value == "")
			  {
			     alert("모든 값을 입력 하셔야 합니다. ");
				 return false;
			  }
		   }
		   document.input.submit();
       }
	   
	   var replaceAt = function(input, index, character){
		     return input.substr(0, index) + character + input.substr(index+character.length);
// 		     alert(document.getElementById("change_name").innerHTML);
		}
	</script>
</head>
<body>
    
    
	<div class="container">
	
		<!-- <select class='btn btn-primary' id='listCount' name='listCount' onchange='listCnt();'>
			<option value='5' >등록일수</option>
			<option value='10'>조회많은 순</option>
			
		</select> -->
		
		<table class="table table-bordered">
			<tr>
			    <th>번호</th>
				<th>작성자</th>
				<th>제목</th>
				<th>작성일</th>
			</tr>
 			<c:forEach var="dto" items="${list}">
 				<tr> 
				    <td>${dto.reply_idx}</td> 
  					<td><a class="change_name">${dto.user_name}</td> 
  					
  					<td><a class="toggle_review_sub" href="#"><input class="hdn_rvNum" type="hidden" value="${dto.reply_sub}"><input type="hidden" value="${dto.reply_idx}">${dto.reply_sub}</a></td>
  					
  					
  					<td>${dto.reply_date}</td> 
					 
					<%-- <td>${dto.rv_date}</td>
					<td id="readNum_${dto.rv_idx}">${dto.rv_num}</td>
 					<td><a href="del.do?rv_idx=${dto.rv_idx}">삭제</a></td>  --%>
				</tr>

				<tr class="show_review_tr" id="tr_head_${dto.reply_idx}">
					<td>${dto.reply_cont}</td>
					<td><img src="../images/recipe_reply/${dto.reply_img}"></td>
				</tr>
				<tr class="show_review_tr" id="tr_body_${dto.reply_idx}">
				</tr> 			
			</c:forEach>
		</table>
	
		<!-- 5. paging view -->	
		<ul class="pagination">
			<c:if test="${p.pageStartNum ne 1}">
<!-- 				맨 첫페이지 이동 -->
				<li><a onclick='pagePre(${p.pageCnt+1},${p.pageCnt});'>&laquo;</a></li>
			<!--이전 페이지 이동 -->
				<li><a onclick='pagePre(${p.pageStartNum},${p.pageCnt});'>&lsaquo;</a></li>
			</c:if>
			
			<!--페이지번호 -->
			<c:forEach var='i' begin="${p.pageStartNum}" end="${p.pageLastNum}" step="1">
				<li class='pageIndex${i}'><a onclick='pageIndex(${i});'>${i}</a></li>
			</c:forEach>
			
			<c:if test="${p.lastChk}">
			<!-- 다음 페이지 이동 -->
				<li><a onclick='pageNext(${p.pageStartNum},${p.total},${p.listCnt},${p.pageCnt});'>&rsaquo;</a></li>
			<!-- 마지막 페이지 이동 -->
				<li><a onclick='pageLast(${p.pageStartNum},${p.total},${p.listCnt},${p.pageCnt});'>&raquo;</a></li>
			</c:if>
	</ul>
 		<form action="list.do" method="post" id='frmPaging'>
 			<!-- 출력할 페이지번호, 출력할 페이지 시작 번호, 출력할 리스트 갯수 -->
			<input type='hidden' name='index' id='index' value='${p.index}'>
			<input type='hidden' name='rc_idx' id='ttt' value='${rc_idx}'>
			<input type='hidden' name='pageStartNum' id='pageStartNum' value='${p.pageStartNum}'>
			<input type='hidden' name='listCnt' id='listCnt' value='${p.listCnt}'>	
 		</form>
		<a href='write.do'>글쓰기</a>
		<br/><br/>
	</div>
	<div>
		<font color="gray" size='4' face="휴먼편지체">
    <center>
	   <!-- <hr width="600" size='2' color="gray" noshade>
	      <h3> Spring Board ( Spring5 + MyBatis )</h3>
		  	<font color="gray" size="3" face="휴먼편지체">
			<a href='list.do'>리스트</a>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<a href='../'>인덱스</a>
			</font>
	   <hr width="600" size="2" color="gray" noshade> -->
	</center>

	<form name="input" method="post" action="write.do" enctype="multipart/form-data">
	   <table border="0" width="600" align="center"  cellpadding="3" cellspacing="1" bordercolor="gray">
	      <!-- <tr>
		     <td width="30%" align="center">WRITER</td>
			 <td><input type="text" name="writer" size="60"></td>
		  </tr> -->
<!-- 		  <tr> -->
<!-- 		     <td align="center">EMAIL</td> -->
<!-- 			 <td><input type="text" name="email" size="60"></td> -->
<!-- 		  </tr> -->
          <tr>
		     <td align="center">SUBJECT</td>
			 <td><input type="text" name="reply_sub" size="60"></td>
		  </tr>
		  <tr>
		     <td align="center">CONTENT</td>
			 <td><textarea  name="reply_cont" rows="3" cols="60"></textarea></td>
		  </tr>
		 
		  <tr>
		  	<td></td>
		  	<td><input type="file" name="reply_img_file"></td>
		  </tr>
		  
		 
<!-- 		   <tr> -->
<!-- 		  	<td></td> -->
<!-- 		  	<td><input type="file" name="files"></td> -->
<!-- 		  </tr> -->
<!-- 		  <tr> -->
<!-- 		  	<td></td> -->
<!-- 		  	<td><input type="file" name="files"></td> -->
<!-- 		  </tr>  -->
		  <tr>
		     <td colspan="2" align="center">
			    <input type="button" value="전송" onclick="check()">
<!-- 				<input type="button" value="전송"> -->
				<input type="reset" value="다시입력" onclick="input.writer.focus()">
			 </td>
		  </tr>
	   </table>
	   <hr width="600" size="2" color="gray" noshade>
	</form>
	</font>
	</div>
</body>
</html>