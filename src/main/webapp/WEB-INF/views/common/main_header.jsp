<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css" rel="stylesheet">
<!--CDN 링크 -->
<script type="text/javascript" language="javascript"
  src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
<script>
// 	$(document).ready(function(){
// 		$(".food_menu").click(function(){
// 			console.log($(this)[0].childNodes[0].value);
// 			var cat = $(this)[0].childNodes[0].value;
// 		 	$.ajax({
// 				url: "food/category.do",
// 				type: "GET",
// 				data: {category : cat},
// 				success: function(result){
// 					$("body").html(result);
// 					$("#frmPaging").attr("action", "category.do");
// // 					$("#c_"+val).attr("selected", "selected");
// 				}
// 			});	
// 		});
// 	});
</script>

<nav class="navbar navbar-custom navbar-fixed-top" role="navigation">
  <div class="container">
    <!-- 타이틀 -->
    <div class="navbar-header">
      <button class="navbar-toggle" type="button" data-toggle="collapse" data-target="#custom-collapse"><span
          class="sr-only">Toggle navigation</span><span class="icon-bar"></span><span class="icon-bar"></span><span
          class="icon-bar"></span></button><a class="navbar-brand" href="./">ONECOOK</a>
    </div>

    <div class="collapse navbar-collapse" id="custom-collapse">
      <ul class="nav navbar-nav navbar-left">
        <!-- 해당 레시피를 가는 부분 페이징이 먹는지 테스트를 해봐야함!!!!!!!!!!!!!!!!!!!!!  -->
        <!--               <li class="dropdown"><a class="dropdown" href="../recipe/list_manage_cat.do?category=3000원대">3000원대 <i class="fas fa-utensils"></i></a></li> -->

        <!--               <li class="dropdown"><a class="dropdown" href="../recipe/list_manage_cat.do?category=5000원대">5000원대 <i class="fas fa-utensils"></i></a></li> -->

        <!--               <li class="dropdown"><a class="dropdown" href="../recipe/list_manage_cat.do?category=7000원대">7000원대 <i class="fas fa-utensils"></i></a></li> -->

        <li class="dropdown"><a class="dropdown" href="recipe/list_manage.do">원쿡레시피 <i class="fas fa-utensils"></i></a>
        </li>
        <li class="dropdown"><a class="dropdown" href="recipe/list_user.do">쿡커레시피 <i class="fas fa-utensils"></i></a>
        </li>

        <!--재료 -->
        <li class="dropdown" style="margin-right: 10px;"><a class="dropdown-toggle" href="food/food_list.do"
            data-toggle="dropdown">원쿡마트</a>
          <ul class="dropdown-menu">
            <!--                 <form method="post" action="../food/food_list_menu.do"> -->
            <!--                   <li><a href="#">채소</a></li> -->
            <!--                   <input type="hidden" name="category" value="채소"/> -->
            <!--                 </form>  -->
            <li><a href="food/food_list_menu.do?category=채소" class="food_menu"><input type="hidden" name="category"
                  value="채소" />채소</a></li>
            <li><a href="food/food_list_menu.do?category=정육_계란" class="food_menu"><input type="hidden" name="category"
                  value="정육_계란" />정육/계란</a></li>
            <li><a href="food/food_list_menu.do?category=수산_해산_건어물" class="food_menu"><input type="hidden" name="category"
                  value="수산_해산_건어물" />수산/해산/건어물</a></li>
            <li><a href="food/food_list_menu.do?category=면_양념_오일" class="food_menu"><input type="hidden" name="category"
                  value="면_양념_오일" />면/양념 /오일</a></li>
            <li><a href="food/food_list_menu.do?category=기타재료" class="food_menu"><input type="hidden" name="category"
                  value="기타재료" />기타재료</a></li>
          </ul>
        </li>
      </ul>
      
      <ul class="nav navbar-nav navbar-right">
      	<!--회원가입 -->
        <li class="dropdown"><a class="btn btn-y" id="login_btn" href="login_admission/admission.do"
            title="회원가입">회원가입</a></li>

        <c:if test="${empty loginUser}">
          <li class="dropdown"><a class="btn btn-y" id="login_btn" href="login_admission/login.do">로그인</a></li>
        </c:if>

        <c:if test="${!empty loginUser}">
          <li class="dropdown"><a class="btn btn-y" id="login_btn" href="login_admission/logout.do">로그아웃</a></li>
        </c:if>
        
      	<!-- 마이페이지 -->
        <c:if test="${loginUser.user_type == 'MEMBER'}">
       	 <li class="dropdown"><a class="dropdown"><span style="color:rgb(255,223,96);">${loginUser.user_name}</span>님</a></li>
          <li class="dropdown"><a class="dropdown-toggle" href="mypage/mypageMain.do" data-toggle="dropdown"><i
                class="fas fa-user-alt"></i></a>
            <ul class="dropdown-menu">
              <li><a href="mypage/order_list.do">주문내역</a></li>
              <li><a href="mypage/mypage.do">정보수정</a></li>
              <li><a href="mypage/recipe_list.do">마이레시피</a></li>
              <li><a href="mypage/good_manager.do">원쿡레시피</a></li>
              <li><a href="mypage/good_user.do">쿡커레시피</a></li>
            </ul>
          </li>
        </c:if>
        <c:if test="${empty loginUser}">
          <li class="dropdown"><a class="dropdown"><span style="color:rgb(255,223,96);">guest</span>님</a></li>
          <li class="dropdown"><a class="dropdown" href="login_admission/login.do"><i class="fas fa-user-alt"></i></a>
        </c:if>

        <!-- 관리자 -->
        <c:if test="${loginUser.user_type == 'MANAGER'}">
          <li class="dropdown"><a class="dropdown"><span style="color:rgb(255,223,96);">onecook</span>님</a></li>
          <li class="dropdown"><a class="dropdown-toggle" href="manage/salesChart.do"><i
                class="fas fa-user-cog"></i></a>
            <ul class="dropdown-menu">
              <li><a href="food/foodAdd.do">재료 등록하기</a></li>
              <li><a href="recipe/managerRecipeAdd.do">레시피 등록하기</a></li>
              <li><a href="manage/salesChart.do">관리자 페이지</a></li>
            </ul>
          </li>
        </c:if>
        
        <!--쇼핑카트 -->
        <c:if test="${loginUser.user_type == 'MEMBER'}">
          <li class="dropdown"><a class="dropdown" href="pay/cart_list.do"><i class="fas fa-shopping-cart"></i></a></li>
        </c:if>
        <c:if test="${empty loginUser}">
          <li class="dropdown"><a class="dropdown" href="login_admission/login.do"><i
                class="fas fa-shopping-cart"></i></a></li>
        </c:if>
      </ul>
    </div>
  </div>
</nav>