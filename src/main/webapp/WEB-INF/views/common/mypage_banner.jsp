<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <style>
    #mypage_banner{
    	background: url('../assets/images/showcase_bg.jpg');
    	background-repeat: no-repeat;
    	color:white;
    }
    </style>
    
    <section id="mypage_banner" class="module-small bg-dark-30">  
		<div class="container">
			<div class="row multi-columns-row">
				<div class="col-sm-12 col-md-4 col-lg-offset-1 col-md-offset-1 col-lg-4">
					<div class="count-item mb-sm-40">
						<h1 class="count-title">${loginUser.user_name} 님</h1>
						<h5 class="count-title">ONECOOK을 이용해주시는 회원님, 반갑습니다.</h5> 
					</div>
            	</div>
            	<div class="col-xs-4 col-sm-4 col-md-2 col-lg-2">
                	<div class="count-item mb-sm-40">
                  		<div class="count-icon"><i class="fas fa-pen"></i></div>
                  		<h3 class="count-to font-alt" data-countto="${recipe_list_count}"></h3>
                  		<h5 class="count-title">작성한 레시피</h5>
                	</div>
				</div>
              		<div class="col-xs-4 col-sm-4 col-md-2 col-lg-2">
                		<div class="count-item mb-sm-40">
                  			<div class="count-icon"><i class="fas fa-star-of-life"></i></div>
                  			<h3 class="count-to font-alt" data-countto="${loginUser.point}"></h3>
                  			<h5 class="count-title">보유 포인트</h5>
                		</div>
					</div>
              
              		<div class="col-xs-4 col-sm-4 col-md-2 col-lg-2">
                		<div class="count-item mb-sm-40">
                  			<div class="count-icon"><i class="fas fa-wallet"></i></div>
                  			<h3 class="count-to font-alt" data-countto="${all_payment}"></h3>
                  			<h5 class="count-title">총 주문횟수</h5>
                		</div>
              		</div>
            	</div>
          	</div>
        </section>