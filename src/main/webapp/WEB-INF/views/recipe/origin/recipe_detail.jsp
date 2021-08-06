<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>MANAGER Recipe_detail</title>
<!--Bootstrap-->

<link rel="stylesheet" href="../css/bootstrap.min.css">
<link rel="stylesheet" href="../css/bootstrap-theme.min.css">
<script type="text/javascript" src="../js/paging.js"></script>
<!--javascript -->
<!-- <script type="text/javascript" src="../js/paging.js"></script> -->
<!--jquery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="../js/jquery-3.1.1.min.js"></script>
<script src="../js/bootstrap.min.js"></script>

</head>
<body>
<h1>Recipe_detail</h1></br>
<p>조회수 : ${recipe.rc_num}</p>
<p> 좋아요 : 
	<c:if test="${!empty recipe.good_email}">
		<button style="background-color:CYAN" onclick="location.href='listUnGoodClick.do?rc_idx=${recipe.rc_idx}&gubun=detail'">좋아요 눌림</button>
	</c:if>
	<c:if test="${empty recipe.good_email}">
		<c:if test="${ !empty loginUser}">
			<button onclick="location.href='listGoodClick.do?rc_idx=${recipe.rc_idx}&gubun=detail'">조아효</button>
		</c:if>
		<c:if test="${ empty loginUser}">
			<button disabled="">좋아요</button>
		</c:if>
	</c:if>
</p>
<%--  <p>HELLO : ${fn:length(recipe_detail)}</p>  --%>
<div id="myCarousel" class="carousel slide" data-ride="carousel" data-interval="false">
  <!-- Indicators -->
  <ol class="carousel-indicators"> 
      <c:forEach var="i" begin="0" end="${fn:length(recipe_detail)-1}"> 
      <c:choose>
      	<c:when test="${i == 0}">
		  <li data-target="#myCarousel" data-slide-to="${i}" class="active"></li>
      	</c:when>
      	<c:otherwise>
		  <li data-target="#myCarousel" data-slide-to="${i}"></li>
      	</c:otherwise>
      </c:choose>
  </c:forEach>
  </ol>

  <!-- Wrapper for slides -->
  <div class="carousel-inner" role="listbox"> 
  <c:forEach var="dto" items="${recipe_detail}" varStatus="status">
  <c:choose> 
  	<c:when test="${status.index == 0}"> 
	    <div class="item active">
	      <img src="../images/recipe/${dto.rc_title}/${dto.img_file}"  alt="Chania">
	      <div class="carousel-caption">
	        <h3>${dto.img_cont}</h3>
	      </div>
	    </div>
  	</c:when>
  	<c:otherwise> <!-- else -->
	    <div class="item">
	      <img src="../images/recipe/${dto.rc_title}/${dto.img_file}"  alt="Chania">
	      <div class="carousel-caption">
	        <h3>${dto.img_cont}</h3>
	      </div>
	    </div>
  	</c:otherwise>
  	</c:choose>
   </c:forEach>
  </div>

  <!-- Left and right controls -->
  <a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
    <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
    <span class="sr-only">Previous</span>
  </a>
  <a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
    <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
    <span class="sr-only">Next</span>
  </a>
</div>
</br>
		<table class="table table-bordered">
			<tr>
			    <th>재료명</th>
			</tr>
 			<c:forEach var="material" items="${recipe_material}">
 				<tr> 
				    <td>${material.rt_cont}</td>
				</tr> 		
			</c:forEach>
		</table>
		
		<table class="table-recipe-material">
			<tr>
				<th>재료명</th>
				<th>가격</th>
				<th>이미지</th>
			</tr>
			<%
				long count = 1;
				pageContext.setAttribute("count", count);
			%>
			<c:forEach var="food" items="${recipe_food}">
 				<tr> 
				    <td>${food.f_name}</td>
				    <td>${food.f_price}</td>
				    <td><img src="../images/food/${food.f_type}/${food.f_img}" height="25%" width="25%"></td>
					<c:if test="${! empty loginUser}">
					<td>
						<button data-toggle="modal" data-target="#modalFood_${count}">장바구니 담기</button>
					</td>
					</c:if>
				</tr> 		
				
				<!-- Modal -->
			<div id="cartcnt_${count}">
				<div class="modal fade" id="modalFood_${count}" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
				  <div class="modal-dialog modal-dialog-centered" role="document">
				    <div class="modal-content">
				      <div class="modal-header">
				        <h5 class="modal-title" id="exampleModalLongTitle">장바구니 담기</h5>
				        <button type="button" class="close" data-dismiss="modal" aria-label="close">
				          <span aria-hidden="true">&times;</span>
				        </button>
				      </div>
				      <div class="modal-body">
				      	<image src="../images/food/${food.f_type}/${food.f_img}" width="70%" height="70%"/><br/><br/>
						<span>${food.f_name}</span><br/>
						<button id="count_minus_${count}" value="${count}" onclick="minusFunc(this.value)">-</button>
						<span id="count_value_${count}">1</span><input type="hidden" name="cart_count" id="cart_count_${count}" value="1">
						<button id="count_plus_${count}"  value="${count}" onclick="plusFunc(this.value)">+</button>
				      </div>
				      <div class="modal-footer">
				        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
				        <button type="button" value="${food.f_name}" class="btn btn-primary" onclick="cartIntoFunc(this.value, ${count})">재료 담기</button>
				      </div>
				    </div>
				  </div>
				</div>
			</div>
				<%
					count++;
					pageContext.setAttribute("count", count);
				%>
			</c:forEach>
		</table>
		<p>-------------- 댓글 -------------</p>
		
		<div class="container">
	
		<!-- <select class='btn btn-primary' id='listCount' name='listCount' onchange='listCnt();'>
			<option value='5' >등록일수</option>
			<option value='10'>조회많은 순</option>
			
		</select> -->
		
		<table class="table table-bordered" id="reply_tb">
			<tr>
			    <th>번호</th>
				<th>작성자</th>
				<th>제목</th>
				<th>작성일</th>
				<c:if test="${!empty loginUser}"> 
					<th>삭제</th>
				</c:if>
			</tr>
 			<c:forEach var="dto" items="${reply_list}">
 				<tr> 
				    <td>${dto.reply_idx}</td> 
  					<td><a class="change_name">${dto.user_name}</td> 
  					
  					<td><a class="toggle_review_sub" href="#reply_tb"><input class="hdn_rvNum" type="hidden" value="${dto.reply_sub}"><input type="hidden" value="${dto.reply_idx}">${dto.reply_sub}</a></td>
  					
  					
  					<td>${dto.reply_date}</td> 
					 
  					<c:choose>
						<c:when test="${loginUser.email eq dto.email}"><!-- eq EQual / == -->
							<td><a href="del.do?rc_idx=${dto.rc_idx}&reply_idx=${dto.reply_idx}&rc_title=${recipe.rc_title}">삭제</a></td>
						</c:when>
						<c:when test="${empty loginUser}">
						</c:when>
						<c:when test="${loginUser.email ne dto.email}"><!-- ne = Not Equal / != -->
							<td></td>
						</c:when>
					</c:choose>
					 
					<%-- <td>${dto.rv_date}</td>
					<td id="readNum_${dto.rv_idx}">${dto.rv_num}</td>
 					<td><a href="del.do?rv_idx=${dto.rv_idx}">삭제</a></td>  --%>
				</tr>

				<tr class="show_review_tr" id="tr_head_${dto.reply_idx}">
					<td>${dto.reply_cont}</td>
					<td><img src="../resources/images/recipe/${recipe_detail[0].rc_title}/${dto.reply_img}"></td>
				</tr>
				<tr class="show_review_tr" id="tr_body_${dto.reply_idx}">
				</tr> 				
			</c:forEach>
		</table>
	
		<!-- 5. paging view -->	
		<ul class="pagination" id="pagination">
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
 		<form action="recipe_detail.do#pagination" method="post" id='frmPaging'>
 			<!-- 출력할 페이지번호, 출력할 페이지 시작 번호, 출력할 리스트 갯수 -->
			<input type='hidden' name='index' id='index' value='${p.index}'>
			<input type='hidden' name='rc_idx' id='ttt' value='${rc_idx}'>
			<input type='hidden' name='pageStartNum' id='pageStartNum' value='${p.pageStartNum}'>
			<input type='hidden' name='listCnt' id='listCnt' value='${p.listCnt}'>	
 		</form>
<!-- 		<a href='write.do'>글쓰기</a> -->
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

	<c:if test="${!empty loginUser}">
	<form name="input" method="post" action="write.do" enctype="multipart/form-data">
	   <table border="0" width="600" align="center"  cellpadding="3" cellspacing="1" bordercolor="gray">
	   	<input type="hidden" name="write_gubun" value="MANAGER">
	   	<input type="hidden" name="rc_idx" value="${rc_idx}">
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
	</c:if>
	</font>
	</div>
<script>
//처음과 마지막 슬라이드의 화살표를 제거해주기(첫페이지 는 마지막페이지로 가는 화살표 제거, 마지막페이지는 첫페이지로 가는 화살표를 제거)

	$("#myCarousel").on('slid', '', checkitem); //on carousel move

	$('#myCarousel').on('slid.bs.carousel', '', checkitem);

$(document).ready(function(){
    checkitem();
    
    
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

function checkitem(){

    var $this = $('#myCarousel');
    console.log($this);
	console.log($('.carousel-inner .item:first'));
    // console.log($this);

    if($('.carousel-inner .item:first').hasClass('active')){
        $this.children('.left.carousel-control').hide();
        $this.children('.right.carousel-control').show();
    }
    else if($('.carousel-inner .item:last').hasClass('active')){
        $this.children('.left.carousel-control').show();
        $this.children('.right.carousel-control').hide();
    }
    else{
        $this.children('.carousel-control').show();
    }
}

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
//	     alert(document.getElementById("change_name").innerHTML);
	}

function cartIntoFunc(val, count){
	console.log(val);
//		console.log(count);
//		console.log($("#cartcnt_" + count +""));
//		console.log($("#cartcnt_" + count +"").find("#count_value_" + count));
	console.log($("#cartcnt_" + count +"").find("#count_value_" + count).text());
	var cartcount = $("#cartcnt_" + count +"").find("#count_value_" + count).text();
	
	$.ajax({
		url:'../food/listCartInsert.do',
		type: 'get',
		data: {cart_count: cartcount,
			f_name : val},
		success: function(result){
			if(result == "true"){
				alert('해당 재료가 담겼습니다');
				location.reload();
			}
			else{
				alert('해당 재료를 담는데 문제가 생김');
				location.reload();
			}

		},
		error: function(err){
			alert('재료 담기 실패');				
		}
	});
}

//replaceAll prototype 선언
String.prototype.replaceAll = function(org, dest) {
    return this.split(org).join(dest);
}

function minusFunc(val){
		console.log(val);
		var countStr = $('#count_value_' +val).text();
		console.log($('#count_value_' +val));
		console.log(countStr);
		var countNum = parseInt(countStr,10);
		countNum--;
//			var priceStr = $('#price').text();
//			var price = parseInt(priceStr,10);
//			var totalNum = countNum*price;
		
		if(countNum<=0){
			alert('최소 구매수량은 1개 입니다.');
			countNum = 1;
//				totalNum = ${read.f_price};
		}
		$('#count_value_' + val).text(countNum);
//			$('#total_price').text(totalNum);
		$('#cart_count_' + val).attr('value', countNum);

}

function plusFunc(val){
		console.log(val);
		var countStr = $('#count_value_' + val).text();
		console.log($('#count_value_' +val));
		console.log(countStr);
		var countNum = parseInt(countStr,10);
		countNum++;
//			var priceStr = $('#price').text();
//			var price = parseInt(priceStr,10);
//			var totalNum = countNum*price;
		
//			if(countNum>5){
//				alert('최대 구매수량은 5개 입니다.');
//				countNum = 5;
//			}
		$('#count_value_' + val).text(countNum);
//			$('#total_price').text(totalNum);
		$('#cart_count_' + val).attr('value', countNum);

}

</script>
</body>
</html>