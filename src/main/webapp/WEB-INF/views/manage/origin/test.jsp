<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en-US" dir="ltr">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
	
	<style type="text/css">
	#modul{
		padding-top: 50px;
	}
	#order_state{
		margin-top: 10px;
	}
	#order_state_comment{
		margin-top: 20px;
    	text-align: center !important;
    	font-size: small;
    	padding-top: 5%;
    	font-size: 14px;	
    	padding: 10% 5% 10% 7%;
    	background-color: rgb(233,233,233);
    	clear : both;
    	display : inline-block;
    	width : 100%;
	}
	#refund{
    	text-align: right;	
	}
	#button1,
	#button2,
	#button3{
		background-color: rgb(233,233,233);
    	border: 0;
    	float:left;	
	}
	#yellow_btn{
      background: rgba(255, 219, 79, 0.9) !important;
      color: rgba(17, 17, 17, 0.8);
      font-size: 13px;
      width: 15%;
      margin-left: 85%;
    }

    #yellow_btn:hover,
    #yellow_btn:focus {
      background: rgba(255, 219, 79, 0.5) !important;
       color: rgba(17, 17, 17, 0.5);
    }
    #col-sm-8 {
    	margin-left : 0%;
    }
    #arrow{
    	float: left;
    	margin-top: 2%;
    }
	</style>
    
    <title>MyPage</title>
<%-- 	<%@ include file="../common/head_link.jsp"%> <!-- css 링크를 include --> --%>

	</head>
	<body data-spy="scroll" data-target=".onpage-navigation" data-offset="60">
    <main>
      <div class="page-loader">
        <div class="loader">Loading...</div>
      </div>
      
<%--       <%@ include file="../common/header.jsp"%> <!-- 상단에 메뉴를 include --> --%>
      
    <div class="main">
    <section class="module-small">  
		<div class="container">
			<div class="row multi-columns-row">
				<div class="col-sm-6 col-md-3 col-lg-3">
					<div class="count-item mb-sm-40">
						<h1 class="count-title font-serif">${loginUser.user_name} 님 </h1>
						<h5 class="count-title font-serif">ONECOOK을 이용해주셔서 감사합니다.</h5> 
					</div>
            	</div>
            	<div class="col-sm-6 col-md-3 col-lg-3">
                	<div class="count-item mb-sm-40">
                  		<div class="count-icon"><span class="icon-pencil"></span></div>
                  		<h3 class="count-to font-alt" data-countto="${recipe_list_count}"></h3>
                  		<h5 class="count-title font-serif">작성한 레시피</h5>
                	</div>
				</div>
              		<div class="col-sm-6 col-md-3 col-lg-3">
                		<div class="count-item mb-sm-40">
                  			<div class="count-icon"><span class="icon-wallet"></span></div>
                  			<h3 class="count-to font-alt" data-countto="${loginUser.point}"></h3>
                  			<h5 class="count-title font-serif">보유 포인트</h5>
                		</div>
					</div>
              
              		<div class="col-sm-6 col-md-3 col-lg-3">
                		<div class="count-item mb-sm-40">
                  			<div class="count-icon"><span class="icon-gift"></span></div>
                  			<h3 class="count-to font-alt" data-countto="${all_payment}"></h3>
                  			<h5 class="count-title font-serif">총 주문횟수</h5>
                		</div>
              		</div>
            	</div>
          	</div>
        </section>
		
		<section class="module"  id="modul">
		<div class="container">
            <div class="row">
				<div class="col-sm-4 col-md-3 sidebar">
					<div class="widget">
                  		<h4 class="comment-title font-alt">MyPage</h4>
                  		<ul class="icon-list">
                    		<li><a href="#">주문내역확인</a></li>
                    		<li><a href="#">회원정보수정</a></li>                    
                    		<li><a href="#">관리자 레시피 좋아요 확인</a></li>
                    		<li><a href="#">유저 레시피 좋아요 확인</a></li>
                    		<li><a href="#">작성 레시피 확인</a></li>
                  		</ul>
					</div>
				</div>
		
		<div class="col-sm-8 col-sm-offset-1" id="col-sm-8">
			<div class="comments" id="order_state">
				<h4 class="comment-title font-alt">주문 처리 현황</h4>
					
		
		<div class="comments" id="order_state_comment">
		<%
			long d_count = 1;
			pageContext.setAttribute("d_count", d_count);
		%>
		
		<c:forEach var="delivery" items="${delivery_state}">
     	 <c:choose>
         <c:when test = "${d_count <= 4}">
<%--        		<button onclick="location.href='#'">${delivery.key}<br/>${delivery.value}</button> --%>
			
       		<button id="button1" onclick="location.href='#'">${delivery.key}<br/>${delivery.value}</button>
			<div id="arrow">&nbsp;&nbsp;&nbsp;<i class="fas fa-chevron-right"></i>&nbsp;&nbsp;&nbsp;</div>
         </c:when>
         <c:when test = "${d_count >= 5 && d_count<6}">
       		<button id="button2" onclick="location.href='#'">${delivery.key}<br/>${delivery.value}</button>
<!-- 			<span>&nbsp;&nbsp;&nbsp;<i class="fas fa-chevron-right"></i>&nbsp;&nbsp;&nbsp;</span> -->
			<div id="arrow">&nbsp;&nbsp;&nbsp;<i class="fas fa-chevron-right"></i>&nbsp;&nbsp;&nbsp;</div>
         </c:when>
         <c:when test = "${d_count >= 6}">
			<button id="button3" onclick="location.href='#'">${delivery.key}<br/>${delivery.value}</button>
         </c:when>
         </c:choose>
		<%
			d_count++;
			pageContext.setAttribute("d_count", d_count);
		%>
		</c:forEach>
		</div>
		 

		<div class="comments">
			<h4 class="comment-title font-alt">최근 주문내역(1개월)</h4>
			<table class="table table-hover" id="last_order_id" >
			
			<tr>
				<th>주문번호</th>
				<th>주문날짜</th>
				<th>주소</th>
				<th>사용 포인트</th>
				<th>주문 금액</th>
				<th>주문상태</th>
			</tr>

			<c:forEach var="lst" items="${lastlist}">
				<tr>
					<td><a onclick="orderFunc(this.target)" target="${lst.order_idx}">${lst.order_idx}</a></td>
					<td>${lst.order_date}</td>
					<td>${lst.order_addr}</td>
					<td>${lst.use_point}</td>
					<td>${lst.pay_price}</td>
					<td>${lst.delivery_state}</td>
				</tr>
				<c:forEach var="olst" items="${orderlist}">
					<%
						long count =0;
						pageContext.setAttribute("count", count);
					%>
					
					<c:forEach var="ol" items="${olst}">
						
						<c:if test="${ol.order_idx == lst.order_idx}">
						<tbody class="${lst.order_idx}" style="display:none" >
						<c:if test="${count == 0}">
							<tr>
								<td>주문번호</td>
								<td>주문날짜</td>
								<td>재료명</td>
								<td>재료이미지</td>
								<td>주문수량</td>
								<td>가격</td>
							</tr>
						</c:if>
						<tr>
							<td>${ol.order_idx}</td>
							<td>${ol.order_date}</td>
							<td>${ol.f_name}</td>
							<td><img src="../resources/images/food/${ol.f_type}/${ol.f_img}" width="100px"></td>
							<td>${ol.totalcount}</td>
							<td>${ol.f_price}</td>
						</tr>
						</tbody>
						</c:if>
						<%
							count++;
							pageContext.setAttribute("count", count);
						%>

					</c:forEach>
					
				</c:forEach>
				<c:if test="${lst.delivery_state == '결제완료' || lst.delivery_state == '배송중'}">
				<tr class="${lst.order_idx}" style="display:none">
					<td colspan="6" id="refund"><button class="form-control" id="yellow_btn" onclick="cancelFunc(this.value)" value="${lst.order_idx}">환불요청</button></td>
				</tr>
				</c:if>
			</c:forEach>
		</table>
		<br/><br/><br/>
	</div>
	</div>
	</div>
	</div>
	</section>
	
	
	<script>
	$(document).ready(function(){
		$(".side_order").css("display", "none");
	});
	

	function orderFunc(val){
// 		console.log(val);
		var el = $("."+ val+"");
// 		console.log($("#last_order_id").find(el));
		$("#last_order_id").find(el).toggle("slow");
	}
	//결제완료,배송중인 품목을 환불요청으로 변경
	function cancelFunc(val){
		console.log(val);
		var conlog = confirm("환불요청을 하시겠습니까?");
		
		if(conlog){
		    $.ajax({
		    	url:'refund_request.do',
		    	Type:'get',
		    	data:{order_idx : val},
		    	success: function(result){
		    		console.log(result);
		    		if(result == "true"){
		    			setTimeout(function() {
		    				swal({
		    					title : "환불요청 완료",
		    					text : "마이페이지에서 확인해주세요.",
		    					icon : "success"
		    				}).then(function() {
		    					location.reload();
		    				});
		    			}, 1000);
		    		}
		    		else{
		    			swal({
	    					title : "환불요청 실패",
	    					text : "다시 시도해주세요.",
	    					icon : "error"
		    			});
		    		}
		    	},
		    	error: function(err){
		    		console.log(err);
		    	}
		    	
		    });
		}else{
			swal('홥불요청 취소');
		}
	}
	</script>
	
<%-- 		<%@ include file="../common/footer.jsp" %> --%>
        
        <hr class="divider-d">
        
      </div>
      <div class="scroll-up"><a href="#totop"><i class="fa fa-angle-double-up"></i></a></div>
    </main>
    
<%--     <%@ include file="../common/js_link.jsp" %> --%>
	
</body>
</html>