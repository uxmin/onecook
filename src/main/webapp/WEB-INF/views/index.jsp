<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko" dir="ltr">

<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css" rel="stylesheet">
  <!--CDN 링크 -->
  <style type="text/css">
    #yellow_btn {
      background: rgba(255, 219, 79, 0.9) !important;
      color: rgba(17, 17, 17, 0.8);
      font-size: 13px;
    }

    #yellow_btn:hover,
    #yellow_btn:focus {
      background: rgba(255, 219, 79, 0.5) !important;
      color: rgba(17, 17, 17, 0.5);
    }
  </style>
  <script type="text/javascript" language="javascript"
    src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
  <!--  
    Document Title
    =============================================
    -->
  <title>ONECOOK</title>
  <%@ include file="common/main_head_link.jsp"%>
  <!-- css 링크를 include -->

</head>

<body data-spy="scroll" data-target=".onpage-navigation" data-offset="60">
  <main>
    <div class="page-loader">
      <div class="loader">Loading...</div>
    </div>

    <%@ include file="common/main_header.jsp"%>
    <!-- 상단에 메뉴를 include -->

    <section class="home-section home-full-height" id="home">
      <div class="hero-slider">
        <ul class="slides">
          <li class="bg-dark-30 restaurant-page-header bg-dark"
            style="background-image:url(&quot;assets/images/restaurant/slider1.jpg&quot;);">
            <div class="titan-caption">
              <div class="caption-content">
                <div class="font-alt mb-30 titan-title-size-1">1인 가구를 위한 다양한 레시피, 원쿡입니다.</div>
                <div class="font-alt mb-40 titan-title-size-4">We are onecook</div><a
                  class="section-scroll btn btn-border-w btn-round" href="recipe/list_manage.do">레시피 보러가기</a>
              </div>
            </div>
          </li>
          <li class="bg-dark-30 restaurant-page-header bg-dark"
            style="background-image:url(&quot;assets/images/restaurant/slider2.jpg&quot;);">
            <div class="titan-caption">
              <div class="caption-content">
                <div class="font-alt mb-30 titan-title-size-1">레시피를 위해 원쿡이 준비한 신선한 재료, 마음껏 즐기세요.
                </div>
                <div class="font-alt mb-30 titan-title-size-4">We are onecook</div><a class="btn btn-border-w btn-round"
                  href="food/food_list.do">재료 보러가기</a>
              </div>
            </div>
          </li>

        </ul>
      </div>
    </section>
    <div class="main">
      <section class="module" id="services">
        <div class="container">
          <div class="row">
            <div class="col-sm-2 col-sm-offset-5">
              <div class="alt-module-subtitle"><span class="holder-w"></span>
                <h5 class="font-serif">Give you our recipe</h5><span class="holder-w"></span>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-sm-8 col-sm-offset-2">
              <h2 class="module-title font-alt">Our Services</h2>
            </div>
          </div>
          <div class="row multi-columns-row">
            <div class="col-sm-6 col-md-3 col-lg-3">
              <div class="features-item">
                <div class="features-icon"><span class="icon-profile-male"></span></div>
                <h3 class="features-title font-alt">1인 가구를 위한</h3>'나 홀로 가구', 1인 가구는 시대변화의 흐름입니다. 바쁜 일상 속, 제대로
                된 끼니를 해결하기엔 좋은 아이디어가 생각나지 않죠. 우리 원쿡은 그런 고객들에게 제공합니다.
              </div>
            </div>
            <div class="col-sm-6 col-md-3 col-lg-3">
              <div class="features-item">
                <div class="features-icon"><span class="icon-clipboard"></span></div>
                <h3 class="features-title font-alt">원쿡의 레시피</h3>오늘은 어떤 것을 먹어야 할지 고민하지 않아도 됩니다. 3000원대, 5000원대, 7000원대
                다양한 가격대로 원쿡이 제공해드리고 있으니까요. 선택하시고, 경험하세요.
              </div>
            </div>
            <div class="col-sm-6 col-md-3 col-lg-3">
              <div class="features-item">
                <div class="features-icon"><span class="icon-pencil"></span></div>
                <h3 class="features-title font-alt">함께 공유하는 레시피</h3>원쿡 레시피도 좋지만, 나만의 톡톡 튀는 아이디어로 만들어진 레시피를 공유하고 싶으신가요?
                원쿡은 고객님들과 함께 만들어갑니다. 원쿡 가족분들의 다양한 레시피를 제공해드립니다.
              </div>
            </div>
            <div class="col-sm-6 col-md-3 col-lg-3">
              <div class="features-item">
                <div class="features-icon"><span class="icon-basket"></span></div>
                <h3 class="features-title font-alt">레시피를 위한 쇼핑</h3>원쿡의 레시피, 원쿡 가족들의 레시피. 다양한 재료... 걱정하지 마세요. 원쿡은 고객님들에게
                저렴한 가격으로 신선한 재료들을 구매할 수 있도록 제공합니다. 레시피에 맞는 재료들을 구매하세요.
              </div>
            </div>
          </div>
        </div>
      </section>
      <Br /><Br />
    </div>
    <hr class="divider-w">
    <Br /><Br />

    <!-- 메인 레시피 -->
    <section class="module">
      <div class="container">
        <div class="row">
          <div class="col-sm-6 col-sm-offset-3">
            <h2 class="module-title font-alt">ONECOOK RECIPE</h2>
            <div class="module-subtitle font-alt">3000원대, 5000원대, 7000원대<br/>다양한 가격대의 원쿡 레시피들을 보여드립니다.</div>
          </div>
        </div>
        <div class="row">
          <div class="owl-carousel text-center" data-items="5" data-pagination="false" data-navigation="false">
            <c:forEach var="recipe" items="${rlist}">
              <div class="owl-item">
                <div class="col-sm-12">
                  <div class="ex-product"><a href="recipe/recipe_detail.do?rc_idx=${recipe.rc_idx}"><img
                        src="resources/images/recipe/${recipe.rc_title}/${recipe.rc_img}" alt="이미지 X" /></a>
                    <h4 class="shop-item-title font-alt"><a href="recipe/recipe_detail.do?rc_idx=${recipe.rc_idx}">${recipe.rc_title}</a></h4>${recipe.rc_type}
                  </div>
                </div>
              </div>
            </c:forEach>
          </div>
        </div>
        <div class="row">
          <div class="col-sm-2 col-sm-offset-5 mt-80" style="text-align: center;">
            <button id="yellow_btn" type="button" class="btn btn-b btn-round" onclick="location.href='recipe/list_manage.do'">더보기</button>
          </div>
        </div>
      </div>
    </section>

    <!--         <section class="module module-video bg-dark-30" data-background="assets/images/restaurant/coffee_bg.png"> -->
    <!--           <div class="container"> -->
    <!--             <div class="row"> -->
    <!--               <div class="col-sm-6 col-sm-offset-3"> -->
    <!--                 <h2 class="module-title font-alt mb-0">The Best Restaurant In Town. Enjoy Your Meal</h2> -->
    <!--               </div> -->
    <!--             </div> -->
    <!--           </div> -->

    <!--            <div class="video-player" data-property="{videoURL:'https://www.youtube.com/watch?v=i_XV7YCRzKo', containment:'.module-video', startAt:3, mute:true, autoPlay:true, loop:true, opacity:1, showControls:false, showYTLogo:false, vol:25}"></div> -->
    <!--           <div class="video-player" data-property="{videoURL:'assets/video/Food-24999.mp4', containment:'.module-video', startAt:3, mute:true, autoPlay:true, loop:true, opacity:1, showControls:false, showYTLogo:false, vol:25}"></div> -->
    <!--         </section> -->

    <div class="video_wrap test mt-40 mb-80">
      <video src='http://127.0.0.1:8080/OneCook/assets/video/Food-24999.mp4' width='400' muted autoplay loop>
      </video>
      <div class="text">Show your recipe in our ONECOOK</div>
    </div>

    <!-- 메인 재료 -->
    <section class="module-small">
      <div class="container">
        <div class="row">
          <div class="col-sm-6 col-sm-offset-3">
            <h2 class="module-title font-alt">ONECOOK MART</h2>
            <div class="module-subtitle font-alt">매일매일 신선한 재료들을 우리 집 앞으로!<br/>레시피를 위한 다양한 재료들을 원쿡이 준비했어요.</div>
          </div>
        </div>
        <div class="row multi-columns-row">
          <c:forEach var="food" items="${flist}">
            <div class="col-sm-6 col-md-3 col-lg-3">
              <div class="shop-item">
                <div class="shop-item-image"><img src="resources/images/food/${food.f_type}/${food.f_img}"
                    alt="#" style=""/>
                  <div class="shop-item-detail"><a id="yellow_btn" class="btn btn-round btn-b"
                      href="food/content.do?f_name=${food.f_name}"><i class="fas fa-search"></i>&nbsp;상세보기</a></div>
                </div>
                <h4 class="shop-item-title font-alt"><a href="food/content.do?f_name=${food.f_name}">${food.f_name}</a>
                </h4>${food.f_price} &#8361;
              </div>
            </div>
          </c:forEach>
        </div>

        <div class="row mt-30">
          <div class="col-sm-12 align-center"><button id="yellow_btn" type="button" class="btn btn-b btn-round" onclick="location.href='food/food_list.do'">
              더보기</a></div>
        </div>
      </div>
    </section>
    <br /><br /><br /><br /><br /><br />

    <%@ include file="common/main_footer.jsp" %>

    <hr class="divider-d">
    </div>
    <div class="scroll-up"><a href="#totop"><i class="fa fa-angle-double-up"></i></a></div>
  </main>

  <%@ include file="common/main_js_link.jsp" %>

</body>

</html>