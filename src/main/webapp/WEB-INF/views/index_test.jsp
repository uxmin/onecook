<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>Controller with Spring5 Index</title>
	<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
	<script>
		$(document).ready(function(){
			//pay/paymentPage.do?f_name=케찹 300g&f_type=면_양념_오일&f_img=20200731_201059.png&f_price=1380&cart_count=2
			var obj = new Object;
			var objArr = new Array();
			var subObj = new Object();
			
			subObj.f_name = '케찹 300g';
			subObj.f_type='면_양념_오일';
			subObj.f_img='20200731_201059.png';
			subObj.f_price=1380;
			subObj.cart_count=2;
			
			objArr.push(subObj);
			subObj = {};
			
			console.log(subObj);
			subObj.f_name = '생돌김가루 35g';
			subObj.f_type = '기타재료';
			subObj.f_img ='20200802_004302.png';
			subObj.f_price =4500;
			subObj.cart_count = 3;

// 			var data = {"f_name": "케찹 300g", "f_type":"면_양념_오일", "f_img":"20200731_201059.png", "f_price":1380, "cart_count":2,
// 					"f_name": "생돌김가루 35g", "f_type":"기타재료", "f_img":"20200802_004302.png", "f_price":4500, "cart_count":3};

// 			var result = [];
			
// 			for(var i in data)
// 				result.push([i, data[i]]);
// 			console.log(JSON.stringify(result));
			
			objArr.push(subObj);
			obj.food = objArr;
			
			var jsonData = JSON.stringify(obj);
			console.log(jsonData);
			
			$("#test_post").click(function(){	
				$.ajax({
			    	url: "pay/paymentPage.do",
			    	type: "POST",
			    	contentType: 'application/json',
			    	dataType: 'json',
			    	data: jsonData,
			    	success: function(result){
//  							location.href="pay/paymentPage.do";
							$("body").html(result);
	
			    	},
					error:function(request,status,error){
						console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
					}
				});
			});
		});
	</script>

	</head>
	<body style="text-align:center">
		<h1>바로가기</h1>
		<a href="login_admission/admission.do">회원가입</a>
		<br/>
		<c:if test="${ empty loginUser}">
			<a href="login_admission/login.do">로그인</a>
		</c:if>
		<c:if test="${ !empty loginUser}">
			<a href="login_admission/logout.do">로그아웃</a>
		</c:if>
		<br/>
		<a href="https://accounts.kakao.com/weblogin/account/info">카카오 로그아웃 페이지</a>
		<br/>
		<c:if test="${loginUser.user_type eq 'MANAGER'}">
			<a href="food/foodAdd.do">재료 등록 페이지</a>
			<br/>
		</c:if>
		<a href="food/food_list.do">상품리스트+세부리스트</a>
		<br>
		<a href="food/qna_list.do?f_name=당근 1개">Q&A 상품문의</a>
		<br/>
		<a href="food/postScript_list.do">후기게시판</a>
		</br>
		<a href="food/food_detail.do?f_name=튀김가루 1kg">상세정보</a>
		<br/>
		<a href="recipe/managerRecipeAdd.do">관리자 레시피 등록</a>
		<br/>
		<a href="recipe/userRecipeAdd.do">유저 레시피 등록</a>
		<br/>
		<a href="recipe/list_manage.do">레시피 관리자 리스트</a>
		<br/>
		<a href="recipe/list_user.do">레시피 유저 리스트</a>
		<br/>
	    <a href="recipe/recipe_detail.do?rc_idx=1">레시피 상세보기</a>
	    </br>
	    <a href="recipe/list.do?rc_idx=1">레시피 댓글</a>
	    <br/>
	    <a href="pay/paymentPage.do?f_name=케찹 300g&f_type=면_양념_오일&f_img=20200731_201059.png&f_price=1380&cart_count=2">결제 페이지</a>
	    <br/>
		<button id="test_post">결제 페이지(POST)</button>
		<br/>
		<a href="mypage/mypageMain.do">마이페이지 메인</a>
		<br/>
		<a href="manage/oneInquiry.do">1대1문의</a>
		<br/>
		<a href="manage/salesChart.do">매출 확인(관리자 메인페이지)</a>
		<br/>
		<a href="mypage/recipe_list.do">내가쓴 글 목록</a>
		</br>
		<a href="mypage/mypage.do">마이페이지</a>
		</br>
		<a href="manage/stock_check.do">재고확인</a>
		</br>
		<a href="mypage/order_list.do">주문리스트</a>
		</br>
		<a href="mypage/good_manager.do">관리자 레시피 좋아요</a>
		</br>
		<a href="mypage/good_user.do">유저 레시피 좋아요</a>
		<br/>
		<a href="pay/cart_list.do">장바구니</a>
		<br/>
		<a href="manage/order_check.do">관리자 페이지: 주문조회</a>
		<br/>
	</body>
</html>