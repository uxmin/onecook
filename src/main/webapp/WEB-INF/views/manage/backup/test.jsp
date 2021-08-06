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
/* 		margin-top: 20px; */
    	text-align: center !important;
    	font-size: small;
/*     	padding-top: 5%; */
    	font-size: 14px;	
/*     	padding: 10% 5% 10% 7%; */
/*     	background-color: rgb(233,233,233); */
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
    /* 차트 */
    .chartMain{
    	height: 40rem; 
   		 width: 100%;
    }
    .selectChart{
    	height: 30rem; 
   		 width: 100%;
    }
    #graph_td{
    	border-top:hidden;
    	border-left:hidden;
    	border-bottom:hidden;
    	padding:0;
    }
    td{
     	width:10px !important; 
    }
	</style>
    
    <title>MANAGER MAIN</title>
<%-- 	<%@ include file="../common/head_link.jsp"%> <!-- css 링크를 include --> --%>

	</head>
	<body data-spy="scroll" data-target=".onpage-navigation" data-offset="60">
    <main>
      <div class="page-loader">
        <div class="loader">Loading...</div>
      </div>
      
<%--       <%@ include file="../common/header.jsp"%> <!-- 상단에 메뉴를 include --> --%>
      
    <div class="main">	
		<section class="module"  id="modul">
		<div class="container">
            <div class="row">
				<div class="col-sm-4 col-md-3 sidebar">
					<div class="widget">
                  		<h4 class="comment-title font-alt">관리자 페이지</h4>
                  		<ul class="icon-list">
                    		<li><a href="oneInquiry.do">재고 확인</a></li>
                    		<li><a href="stock_check.do">1 대 1 문의</a></li>                    
                    		<li><a href="order_check.do">주문취소 / 배송중</a></li>
                  		</ul>
					</div>
				</div>
		
		<div class="col-sm-8 col-sm-offset-1" id="col-sm-8">
			
			<div class="comments" id="order_state">
				<h4 class="comment-title font-alt" style="margin:0">일일 도표</h4>
					
		
		<div class="comments" id="order_state_comment" style="margin:0">
			<h3>* 오늘 판매 금액 확인 : <b>${today_allpay} &#8361;</b> *</h3>
			<br/>
			<table class="table table-border checkout-table">
                  <tbody> 
                    <tr>
                    	<td class="col-sm-1" id="graph_td"><div class="features-item">
                   		<div class="features-icon"><span class="icon-clipboard" aria-hidden="true"></span></div></td>
						<td class="col-sm-2" style="background-color:rgb(233,233,233)"></td>
						<td class="col-sm-2"></td>
						<td class="col-sm-2" style="background-color:rgb(233,233,233)"></td>
						<td class="col-sm-2"></td>
						<td class="col-sm-2" style="background-color:rgb(233,233,233)"></td>
						<td class="col-sm-2"></td>
                    </tr>
                    
                    <tr>
<!--                      	<td class="col-sm-2" style="border-top:hidden;border-left:hidden;border-bottom:hidden"><i class="fas fa-users fa-3x"></i></td> -->
						<td class="col-sm-1" id="graph_td"> <div class="features-item">
                    	<div class="features-icon"><span class="icon-profile-male" aria-hidden="true"></span></div></td>
						<td class="col-sm-2" style="background-color:rgb(233,233,233)"></td>
						<td class="col-sm-2"></td>
						<td class="col-sm-2" style="background-color:rgb(233,233,233)"></td>
						<td class="col-sm-2"></td>
						<td class="col-sm-2" style="background-color:rgb(233,233,233)"></td>
						<td class="col-sm-2"></td>
                    </tr>
                  </tbody>
                </table>
      
			<div id="chartContainer" class="chartMain"></div>
			<br/>
			<div id="chartContainer2" class="chartMain"></div>
			

		</div>
		 

		<div class="comments">
			<p class="comment-title font-alt">매출 확인</p>
			<div class="form-group">
				<p class="font-alt">특정 달의 매출 수 확인</p>
				<div>
					특정 달 선택 : <input type="month" name="vardate" onchange="varDateFunc(this.value)"/>
					<div id="varMonthChart_div" class="selectChart"></div>
		<!-- 			<div id="chartContainer" style="height: 370px; width: 100%;"></div> -->
				</div>
			<div class="col-sm-6">
				<h3>특정 달의 매출 금액 확인</h3>
			</div>
			</div>
		</div>
	</div>
	</div>
	</div>
	</section>
	
	
<%-- 		<%@ include file="../common/footer.jsp" %> --%>
        
        <hr class="divider-d">
        
      </div>
      <div class="scroll-up"><a href="#totop"><i class="fa fa-angle-double-up"></i></a></div>
    </main>
    
<%--     <%@ include file="../common/js_link.jsp" %> --%>
    <script src="https://canvasjs.com/assets/script/jquery.canvasjs.min.js"></script>
    
<script type="text/javascript">    
	//replaceAll prototype 선언
	String.prototype.replaceAll = function(org, dest) {
	    return this.split(org).join(dest);
	}
	
	function varDateFunc(val){
		//날짜 문자열 치환 밑 자르기
		console.log(val);
		val = val.substring(2,val.length);
		val = val.replaceAll("-", "/");
		console.log(val);
		val = val + "/01";
		console.log(val);
		
		$.ajax({
			url:"varMonthChart",
			dataType:'json',
			type: 'post',
			data: {vardate : val},
			success: function(list){
				console.log(list);
				if(list.length == 0){
					console.log("데이터 없음");
					$("#varMonthChart_div").empty();
					$("#varMonthChart_div").text("데이터가 없음");
				}
				else{
					var tArr = new Array();
	
			    	$.each(list, function(i, item){
						tArr.push({label: item.vardate,
							y: item.varcount
						});
			    	});
			    	console.log(tArr);
			    	// 표 컬러 지정
			        CanvasJS.addColorSet("greenShades",
			                [//colorSet Array
			                	"#6fba2c"              
			                ]);
			        
						var tmArr = new Array();
						var chart = new CanvasJS.Chart("varMonthChart_div", {
							theme:"light1",
							animationEnabled: true,
							colorSet : "greenShades",	//지정한 컬러 사용
// 							title:{
// 								text: "월 매출 수 확인"
// 							},
							axisY :{
								title: "월 판매수",
								suffix: " sales"
							},
							toolTip: {
								shared: "true"
							},
							legend:{
								cursor:"pointer",
								itemclick : toggleDataSeries
							},
							data: [{
								type: "spline",
								visible: true,
								showInLegend: true,
		//		 				yValueFormatString: "##.00mn",
								name: "month sales",
	// 							dataPoints: [
	// 								{ label: list[0].vardate, y: list[0].varcount},
	// 								{ label: list[1].vardate, y: list[1].varcount}
	// 							]
								dataPoints: tArr
							}]
						});
						
						chart.render();
						
						function toggleDataSeries(e) {
							if (typeof(e.dataSeries.visible) === "undefined" || e.dataSeries.visible ){
								e.dataSeries.visible = false;
							} else {
								e.dataSeries.visible = true;
							}
							chart.render();
						}
								
					} 
				}
			});
	}
	//특정 달의 매출 금액 확인하기
	function varDatePaymentFunc(val){
		//날짜 문자열 치환 밑 자르기
		val = val.substring(2,val.length);
		val = val.replaceAll("-", "/");
		console.log(val);
		val = val + "/01";
		console.log(val);
		
		$.ajax({
			url:"varDatePayment",
			dataType:'json',
			type: 'post',
			data: {vardate : val},
			success: function(list){
				console.log(list);
				if(list.length == 0){
					console.log("데이터 없음");
					$("#varDatePaymentChart_div").empty();
					$(".varDatePaymentChart_div").empty();
					$("#varDatePaymentChart_div").text("데이터가 없음");
				}
				else{
					var tArr = new Array();
					var monthAllPrice = 0;
					
			    	$.each(list, function(i, item){
						tArr.push({label: item.vardate,
							y: item.sum_price
						});
						monthAllPrice += item.sum_price;
			    	});
			    	console.log(tArr);
			    	// 표 컬러 지정
			        CanvasJS.addColorSet("yellowShades",
			                [//colorSet Array
			                	"#030303"              
			                ]);
			        
						var tmArr = new Array();
						var chart = new CanvasJS.Chart("varDatePaymentChart_div", {
							theme:"light1",
							animationEnabled: true,
							colorSet : "yellowShades",	//지정한 컬러 사용
// 							title:{
// 								text: "월 매출 수 확인"
// 							},
							axisY :{
								title: "월 판매금액",
								suffix: " won"
							},
							toolTip: {
								shared: "true"
							},
							legend:{
								cursor:"pointer",
								itemclick : toggleDataSeries
							},
							data: [{
								type: "spline",
								visible: true,
								showInLegend: true,
		//		 				yValueFormatString: "##.00mn",
								name: "month sales won",
	// 							dataPoints: [
	// 								{ label: list[0].vardate, y: list[0].varcount},
	// 								{ label: list[1].vardate, y: list[1].varcount}
	// 							]
								dataPoints: tArr
							}]
						});
						
						chart.render();
						
						function toggleDataSeries(e) {
							if (typeof(e.dataSeries.visible) === "undefined" || e.dataSeries.visible ){
								e.dataSeries.visible = false;
							} else {
								e.dataSeries.visible = true;
							}
							chart.render();
						}

						$(".varDatePaymentChart_div").text('* 해당월의 판매 금액 :' + monthAllPrice +' *');
					}
				} 
			});
	}
	
	//특정  주간 매출 금액 확인
	function varWeekPaymentFunc(val){
		//날짜 문자열 치환 밑 자르기
		console.log(val);
		val = val.substring(2,val.length);
		val = val.replaceAll("-", "/");
		console.log(val);

		
		$.ajax({
			url:"varWeekPayment",
			dataType:'json',
			type: 'post',
			data: {vardate : val},
			success: function(list){
				console.log(list);
				if(list.length == 0){
					console.log("데이터 없음");
					$("#varWeekPaymentChart_div").empty();
					$(".varWeekPaymentChart_div").empty();
					$("#varWeekPaymentChart_div").text("데이터가 없음");
				}
				else{
					var tArr = new Array();
					var monthAllPrice = 0;
					
			    	$.each(list, function(i, item){
			    		var split_date = item.thsdate;
			    		split_date = split_date.split(" ");
// 			    		console.log(split_date);
			    		
						tArr.push({label: split_date[0],
							y: item.sum_price
						});
						monthAllPrice += item.sum_price;
			    	});
			    	console.log(tArr);
			    	// 표 컬러 지정
			        CanvasJS.addColorSet("redShades",
			                [//colorSet Array
			                	"#030303"              
			                ]);
			        
						var tmArr = new Array();
						var chart = new CanvasJS.Chart("varWeekPaymentChart_div", {
							theme:"light1",
							animationEnabled: true,
							colorSet : "redShades",	//지정한 컬러 사용
// 							title:{
// 								text: "월 매출 수 확인"
// 							},
							axisY :{
								title: "주간 판매금액",
								suffix: " won"
							},
							toolTip: {
								shared: "true"
							},
							legend:{
								cursor:"pointer",
								itemclick : toggleDataSeries
							},
							data: [{
								type: "spline",
								visible: true,
								showInLegend: true,
		//		 				yValueFormatString: "##.00mn",
								name: "week sales won",
	// 							dataPoints: [
	// 								{ label: list[0].vardate, y: list[0].varcount},
	// 								{ label: list[1].vardate, y: list[1].varcount}
	// 							]
								dataPoints: tArr
							}]
						});
						
						chart.render();
						
						function toggleDataSeries(e) {
							if (typeof(e.dataSeries.visible) === "undefined" || e.dataSeries.visible ){
								e.dataSeries.visible = false;
							} else {
								e.dataSeries.visible = true;
							}
							chart.render();
						}

						$(".varWeekPaymentChart_div").text('* 해당  주의 판매 금액 :' + monthAllPrice +' *');
					}
				} 
			});
	}

window.onload = function () {
		let today = new Date();
		let year = today.getFullYear(); // 년도
		let month = today.getMonth() + 1;  // 월
		let date = today.getDate();  // 날짜
		let day = today.getDay();  // 요일
		// 당월 매출수 확인
		var tmArr = new Array();
		var chart = new CanvasJS.Chart("chartContainer", {
			theme:"light1",
			animationEnabled: true,
			title:{
				text: month + "월 매출 수 확인(당월)",
				fontSize: 15
			},
			axisY :{
				title: month + "월 판매수",
				suffix: " sales",
				titleFontSize: 15
			},
			toolTip: {
				shared: "true"
			},
			legend:{
				cursor:"pointer",
				itemclick : toggleDataSeries
			},
			data: [{
				type: "spline",
				visible: true,
				showInLegend: true,
// 				yValueFormatString: "##.00mn",
				name: "month sales",
				dataPoints: [
					<c:forEach var="item" items="${tmlist}">
						{label: "${item.thsdate}", y : ${item.thscount}},
					</c:forEach>

				]
			}]
		});
		
		chart.render();
		
		function toggleDataSeries(e) {
			if (typeof(e.dataSeries.visible) === "undefined" || e.dataSeries.visible ){
				e.dataSeries.visible = false;
			} else {
				e.dataSeries.visible = true;
			}
			chart.render();
		}
			
		// 일별 판매된 재료 수 확인
		
		var tArr = new Array();
		var chart2 = new CanvasJS.Chart("chartContainer2", {
			theme: "light2",
			animationEnabled: true,
// 			backgroundColor: "#F5DEB3",
			title: {
				text: "오늘의 판매 베스트 수",
				fontSize: 15
			},
			subtitles: [{
				text: year + '/' + month + '/' + date,
				fontSize: 12
			}],
			data: [{
				type: "pie",
				indexLabelFontSize: 12,
				radius: 1000,
				indexLabel: "{label} - {y}",
				yValueFormatString: "### 개",
				click: explodePie,
				dataPoints: [
					<c:forEach var="item" items="${tlist}">
						{y: ${item.sales_fcount}, label: "${item.f_name}"},
					</c:forEach>
					<c:if test="${etc[0].sum_price == 0 && empty tlist}">
						{y: 1, label: '오늘의 판매 재료 없음'}
					</c:if>		
					<c:if test="${etc[0].sum_price != 0}">
						{y: ${etc[0].sum_price}, label: '기타재료'}
					</c:if>		
// 					{ y: 42, label: "Gas" },
// 					{ y: 21, label: "Nuclear"},
// 					{ y: 24.5, label: "Renewable" },
// 					{ y: 9, label: "Coal" },
// 					{ y: 3.1, label: "Other Fuels" }
				]
			}]
		});
		chart2.render();
		
		function explodePie(e) {
			for(var i = 0; i < e.dataSeries.dataPoints.length; i++) {
				if(i !== e.dataPointIndex)
					e.dataSeries.dataPoints[i].exploded = false;
			}
		}

	}
</script>
</body>
</html>