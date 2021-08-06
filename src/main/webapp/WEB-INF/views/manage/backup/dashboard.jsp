<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">

<head>
  <meta charset="utf-8" />
  <link rel="apple-touch-icon" sizes="76x76" href="../assets/img/apple-icon.png">
  <link rel="icon" type="image/png" href="../assets/img/favicon.png">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
  <title>
    MANAGER MAIN
  </title>
  <meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0, shrink-to-fit=no' name='viewport' />
  <!--     Fonts and icons     -->
  <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700,200" rel="stylesheet" />
  <link href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" rel="stylesheet">
  <!-- CSS Files -->
  <link href="../assets/css/bootstrap.min.css" rel="stylesheet" />
  <link href="../assets/css/paper-dashboard.css?v=2.0.1" rel="stylesheet" />
  <!-- CSS Just for demo purpose, don't include it in your project -->
  <link href="../assets/demo/demo.css" rel="stylesheet" />
  <style>
  #chartContainer2{
  	position: relative;
  	height: 25em;
  	z-index:9999;
  }
  #chartContainer{
  	position: relative;
  	height: 25em;
  	z-index:9999;
  }
  #varMonthChart_div{
    position: relative;
  	height: 20em;
  	z-index:9999;
  }
  #varDatePaymentChart_div{
    position: relative;
  	height: 20em;
  	z-index:9999;
  }
  </style>
</head>

<body class="">
  <div class="wrapper ">
    <div class="sidebar" data-color="white" data-active-color="danger">
      <div class="logo">
        <a href="https://www.creative-tim.com" class="simple-text logo-mini">
          <div class="logo-image-small">
            <img src="../assets/img/logo-small.png">
          </div>
          <!-- <p>CT</p> -->
        </a>
        <a href="https://www.creative-tim.com" class="simple-text logo-normal">
          ONECOOK
          <!-- <div class="logo-image-big">
            <img src="../assets/img/logo-big.png">
          </div> -->
        </a>
      </div>
      <div class="sidebar-wrapper">
        <ul class="nav">
          <li class="active ">
            <a href="./icons.html">
              <i class="nc-icon nc-chart-pie-36"></i>
              <p>관리자 메인</p>
            </a>
          </li> 
          <li>
            <a href="./dashboard.html">
              <i class="nc-icon nc-app"></i>
              <p>재고확인</p>
            </a>
          </li>
          <li>
            <a href="./icons.html">
              <i class="nc-icon nc-chat-33"></i>
              <p>1대1 문의</p>
            </a>
          </li>
          <li>
            <a href="./icons.html">
              <i class="nc-icon nc-delivery-fast"></i>
              <p>주문취소/배송중 확인</p>
            </a>
          </li>                 
        </ul>
      </div>
    </div>
    <div class="main-panel">
      <!-- Navbar -->
      <nav class="navbar navbar-expand-lg navbar-absolute fixed-top navbar-transparent">
        <div class="container-fluid">
          <div class="navbar-wrapper">
            <div class="navbar-toggle">
              <button type="button" class="navbar-toggler">
                <span class="navbar-toggler-bar bar1"></span>
                <span class="navbar-toggler-bar bar2"></span>
                <span class="navbar-toggler-bar bar3"></span>
              </button>
            </div>
            <a class="navbar-brand" href="salesChart.do">관리자 메인 페이지</a>
          </div>
<!--           <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navigation" aria-controls="navigation-index" aria-expanded="false" aria-label="Toggle navigation"> -->
<!--             <span class="navbar-toggler-bar navbar-kebab"></span> -->
<!--             <span class="navbar-toggler-bar navbar-kebab"></span> -->
<!--             <span class="navbar-toggler-bar navbar-kebab"></span> -->
<!--           </button> -->
          
        </div>
      </nav>
      <!-- End Navbar -->
      <div class="content">
        <div class="row">
          <div class="col-lg-3 col-md-6 col-sm-6">
            <div class="card card-stats">
              <div class="card-body ">
                <div class="row">
                  <div class="col-5 col-md-4">
                    <div class="icon-big text-center icon-warning">
                      <i class="nc-icon nc-box-2 text-warning"></i>
                    </div>
                  </div>
                  <div class="col-7 col-md-8">
                    <div class="numbers">
                      <p class="card-category">금일 상품 주문</p>
                      <p class="card-title">150 건</p>
                    </div>
                  </div>
                </div>
              </div>
              <div class="card-footer ">
                <hr>
                <div class="stats">
                  <i class="fa fa-refresh"></i>
                  Update Now
                </div>
              </div>
            </div>
          </div>
          <div class="col-lg-3 col-md-6 col-sm-6">
            <div class="card card-stats">
              <div class="card-body ">
                <div class="row">
                  <div class="col-5 col-md-4">
                    <div class="icon-big text-center icon-warning">
                      <i class="nc-icon nc-money-coins text-success"></i>
                    </div>
                  </div>
                  <div class="col-7 col-md-8" style="padding-left:0">
                    <div class="numbers">
                      <p class="card-category">오늘의 매출</p>
                      <p class="card-title">1,3423335 &#8361;<p>
                    </div>
                  </div>
                </div>
              </div>
              <div class="card-footer ">
                <hr>
                <div class="stats">
                  <i class="fa fa-calendar-o"></i>
                  Last day
                </div>
              </div>
            </div>
          </div>
          <div class="col-lg-3 col-md-6 col-sm-6">
            <div class="card card-stats">
              <div class="card-body ">
                <div class="row">
                  <div class="col-5 col-md-4">
                    <div class="icon-big text-center icon-warning">
                      <i class="nc-icon nc-refresh-69 text-danger"></i>
                    </div>
                  </div>
                  <div class="col-7 col-md-8">
                    <div class="numbers">
                      <p class="card-category">환불요청 수</p>
                      <p class="card-title">23<p>
                    </div>
                  </div>
                </div>
              </div>
              <div class="card-footer ">
                <hr>
                <div class="stats">
                  <i class="fa fa-clock-o"></i>
                  In the last hour
                </div>
              </div>
            </div>
          </div>
          <div class="col-lg-3 col-md-6 col-sm-6">
            <div class="card card-stats">
              <div class="card-body ">
                <div class="row">
                  <div class="col-5 col-md-4">
                    <div class="icon-big text-center icon-warning">
                      <i class="nc-icon nc-zoom-split text-primary"></i>
                    </div>
                  </div>
                  <div class="col-7 col-md-8">
                    <div class="numbers">
                      <p class="card-category">오늘의 문의 수</p>
                      <p class="card-title">45<p>
                    </div>
                  </div>
                </div>
              </div>
              <div class="card-footer ">
                <hr>
                <div class="stats">
                  <i class="fa fa-refresh"></i>
                  Update now
                </div>
              </div>
            </div>
          </div>
        </div>
        
         
        <!-- 부분 넓이 그래프 -->
        <div class="row">
        <!-- 4 영역 -->
          <div class="col-md-5">
            <div class="card ">
              <div class="card-header ">
                <h5 class="card-title" style="margin: 10px 0 0 0">오늘의 베스트 판매재료</h5>
                <p class="card-category" id="piechart_subtit"></p>
              </div>
             
              <div class="card-body">
<%--                 <canvas id="chartEmail"></canvas> --%>
				<div id="chartContainer2"></div>
              </div>
              <div class="card-footer ">
<!--                 <div class="legend"> -->
<!--                   <i class="fa fa-circle text-primary"></i> Opened -->
<!--                   <i class="fa fa-circle text-warning"></i> Read -->
<!--                   <i class="fa fa-circle text-danger"></i> Deleted -->
<!--                   <i class="fa fa-circle text-gray"></i> Unopened -->
<!--                 </div> -->
                <hr>
                <div class="stats">
                  <i class="fa fa-calendar"></i> Number of emails sent
                </div>
              </div>
            </div>
          </div>
          <!-- 8 영역 -->
          <div class="col-md-7">
          	
<!--           <div id="chartContainer" class="chartMain" width="400" height="100"></div> -->
            <div class="card card-chart">
              <div class="card-header">
                <h5 class="card-title" id="today_main_line"></h5>
                <p class="card-category">이번 달 매출 현황</p>
              </div>
              <div class="card-body">
            	<div id="chartContainer"></div>  	
<%--                 <canvas id="speedChart" width="400" height="100"></canvas> --%>
<%-- 				<canvas id="chartContainer" class="chartMain" width="400" height="100"></canvas> --%>
              </div>
              <div class="card-footer">
                <hr />
                <div class="stats">
                  <i class="fa fa-check"></i> Data information certified
                </div>
              </div>
            </div>
          </div>
          
        </div>
        
        <!-- 전체넓이 그래프 -->
        <div class="row">
          <div class="col-md-12">
            <div class="card ">
              <div class="card-header ">
                <h5 class="card-title">특정 달의 매출 수 확인</h5>
                <p class="card-category">특정 달 선택 : <input type="month" name="vardate" onchange="varDateFunc(this.value)"/></p>
              </div>
              
              <div class="row card-body">
              <!-- 표1 -->
              <div class="col-md-6" style="margin:0">
<%--                 <canvas id=chartHours width="400" height="100"></canvas> --%>
				<div id="varMonthChart_div"></div>
              </div>
              <!-- 표2 -->
              <div class="col-md-6">
                <canvas id="speedChart" width="400" height="100"></canvas>
              </div>
              </div>
              

              
              <div class="card-footer ">
                <hr>
                <div class="stats">
                  <i class="fa fa-history"></i> Updated 3 minutes ago
                </div>
              </div>
      
            </div>
          </div>
          
        </div>
        

        
      </div>
      
      <footer class="footer footer-black  footer-white ">
        <div class="container-fluid">
          <div class="row">
            <nav class="footer-nav">
              <ul>
                <li><a href="https://www.creative-tim.com" target="_blank">Creative Tim</a></li>
                <li><a href="https://www.creative-tim.com/blog" target="_blank">Blog</a></li>
                <li><a href="https://www.creative-tim.com/license" target="_blank">Licenses</a></li>
              </ul>
            </nav>
            <div class="credits ml-auto">
              <span class="copyright">
                © <script>
                  document.write(new Date().getFullYear())
                </script>, made with <i class="fa fa-heart heart"></i> by Creative Tim
              </span>
            </div>
          </div>
        </div>
      </footer>
    </div>
  </div>
  <!--   Core JS Files   -->
  <script src="../assets/js/core/jquery.min.js"></script>
  <script src="../assets/js/core/popper.min.js"></script>
  <script src="../assets/js/core/bootstrap.min.js"></script>
  <script src="../assets/js/plugins/perfect-scrollbar.jquery.min.js"></script>
  <!--  Google Maps Plugin    -->
  <script src="https://maps.googleapis.com/maps/api/js?key=YOUR_KEY_HERE"></script>
  <!-- Chart JS -->
  <script src="../assets/js/plugins/chartjs.min.js"></script>
  <!--  Notifications Plugin    -->
  <script src="../assets/js/plugins/bootstrap-notify.js"></script>
  <!-- Control Center for Now Ui Dashboard: parallax effects, scripts for the example pages etc -->
  <script src="../assets/js/paper-dashboard.min.js?v=2.0.1" type="text/javascript"></script><!-- Paper Dashboard DEMO methods, don't include it in your project! -->
  <script src="../assets/demo/demo.js"></script>
  
<%--   <%@ include file="../common/js_link.jsp" %> --%>
  <script src="https://canvasjs.com/assets/script/jquery.canvasjs.min.js"></script>
 
  <script>
    $(document).ready(function() {
      // Javascript method's body can be found in assets/assets-for-demo/js/demo.js
      demo.initChartsPages();
    });
    
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
		$("#today_main_line").text(month +"월 매출 수 확인(당월)");
		
		var tmArr = new Array();
		var chart = new CanvasJS.Chart("chartContainer", {
			theme:"light1",
			animationEnabled: true,
// 			title:{
// 				text: month + "월 매출 수 확인(당월)",
// 				fontSize: 15
// 			},
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
		$("#piechart_subtit").text(year + '/' + month + '/' + date);
		var tArr = new Array();
		var chart2 = new CanvasJS.Chart("chartContainer2", {
			theme: "light2",
			animationEnabled: true,
// 			backgroundColor: "#F5DEB3",
			title: {
// 				text: "오늘의 판매 베스트 수",
				fontSize: 15
			},
			subtitles: [{
// 				text: year + '/' + month + '/' + date,
				fontSize: 12
			}],
			data: [{
				type: "pie",
				indexLabelFontSize: 12,
				radius: 80,
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
