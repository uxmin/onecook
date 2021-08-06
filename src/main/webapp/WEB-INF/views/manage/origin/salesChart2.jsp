<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
<title>Google Chart API</title>

<script src="https://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
	 <script src="http://code.jquery.com/jquery-1.12.4.min.js" ></script>
    <script src="../js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="../css/bootstrap.min.css">
	<link rel="stylesheet" href="../css/bootstrap-theme.min.css">
	
	<script src="https://canvasjs.com/assets/script/jquery-1.11.1.min.js"></script>
<script src="https://canvasjs.com/assets/script/jquery.canvasjs.min.js"></script>
	
<script type="text/javascript">    
	$(document).ready(function(){
				// 오늘 재료 매출 확인
				google.charts.load('current', {'packages': ['corechart']});
				google.charts.setOnLoadCallback(todayChart);
				 
				var tArr = new Array();
				<c:forEach var="item" items="${tlist}">
					tArr.push({f_name: "${item.f_name}",
						sales_fcount: ${item.sales_fcount}
					});
				</c:forEach>
				
				function todayChart(){
					var dataChart = [['재료명', '구매수']];
					if(tArr.length != 0){
						for(var i=0; i<tArr.length; i++){
							dataChart.push([tArr[i].f_name, tArr[i].sales_fcount]);
						}
					}
					else{
						dataChart.push(['데이터 없음', 0]);
					}

			    	
			    	var data = google.visualization.arrayToDataTable(dataChart);
			    	var view = new google.visualization.DataView(data);
			    	var options = {
			    		 title: "일별 최다 재료 매출 확인", 
			    		 width: 600,  
			    		 height: 300 
			    	};
			    	var chart1 = new google.visualization.PieChart(document.getElementById('todayChart_div'));
		            chart1.draw(view, options);
				} 

				// 일별 최다 재료 매출 확인
				google.charts.load('current', {'packages': ['corechart']});
				google.charts.setOnLoadCallback(thsMonthChart);
				 
				var tmArr = new Array();
				<c:forEach var="item" items="${tmlist}">
				tmArr.push({thsdate: "${item.thsdate}",
					thscount: ${item.thscount}
					});
				</c:forEach>
				
				function thsMonthChart(){
					var dataChart = [['날짜', '구매수']];
					if(tmArr.length != 0){
						for(var i=0; i<tmArr.length; i++){
							dataChart.push([tmArr[i].thsdate, tmArr[i].thscount]);
						}
					}
					else{
						dataChart.push(['데이터 없음', 0]);
					}

			    	var data = google.visualization.arrayToDataTable(dataChart);
			    	var view = new google.visualization.DataView(data);
			    	var options = {
			    		 title: "월별 요일별 매출 수 확인(당월)", 
			    		 width: 600,  
			    		 height: 300,
// 			    	      vAxis: {minValue:0, maxValue:10},
			    	      animation: {
			    	    	"startup" : true,
			    	        duration: 700,
			    	        easing: 'in'
			    	      }
			    	};
			    	var chart2 = new google.visualization.LineChart(document.getElementById('thsMonthChart_div'));
		            chart2.draw(view, options);
				} 
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
				 google.charts.load('current', {'packages': ['corechart']});
				 google.charts.setOnLoadCallback(varMonthChart);
				 
				 function varMonthChart(){
						var dataChart = [['날짜', '구매 수']];
					 	if(list.length != 0){
					    	$.each(list, function(i, item){
					    			dataChart.push([item.vardate, item.varcount]);
					    	});
				    	}
					 	else{
				    		dataChart.push(['데이터 없음', 0]);
				    	}
				    	
				    	var data = google.visualization.arrayToDataTable(dataChart);
				    	var view = new google.visualization.DataView(data);
				    	var options = {
				    		 title: "특정 월의 월별매출 수 확인", 
				    		 width: 600,  
				    		 height: 300 
				    	};
				    	
				    	var chart3 = new google.visualization.BarChart(document.getElementById('varMonthChart_div'));   
				  		chart3.draw(view, options);
				  		location.href="#varMonthChart_div";
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
				 google.charts.load('current', {'packages': ['corechart']});
				 google.charts.setOnLoadCallback(varDatePayment);
				 
				 function varDatePayment(){
						var dataChart = [['날짜', '판매된 금액']];
					 	if(list.length != 0){
					    	$.each(list, function(i, item){
					    			dataChart.push([item.vardate, item.sum_price]);
					    	});
				    	}
					 	else{
				    		dataChart.push(['데이터 없음', 0]);
				    	}
				    	
				    	var data = google.visualization.arrayToDataTable(dataChart);
				    	var view = new google.visualization.DataView(data);
				    	var options = {
				    		 title: "특정 달의 총 매출 금액", 
				    		 width: 600,  
				    		 height: 300 
				    	};
				    	
				    	var chart3 = new google.visualization.BarChart(document.getElementById('varDatePaymentChart_div'));   
				  		chart3.draw(view, options);
				  		location.href="#varDatePaymentChart_div";
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
				 google.charts.load('current', {'packages': ['corechart']});
				 google.charts.setOnLoadCallback(varWeekPayment);
				 
				 function varWeekPayment(){
						var dataChart = [['날짜', '판매된 금액']];
					 	if(list.length != 0){
					    	$.each(list, function(i, item){
					    			dataChart.push([item.thsdate, item.sum_price]);
					    			console.log(dataChart);
					    	});
				    	}
					 	else{
				    		dataChart.push(['데이터 없음', 0]);
				    	}
				    	
				    	var data = google.visualization.arrayToDataTable(dataChart);
				    	var view = new google.visualization.DataView(data);
				    	var options = {
				    		 title: "주간 총 매출 금액", 
				    		 width: 600,  
				    		 height: 300 
				    	};
				    	
				    	var chart3 = new google.visualization.BarChart(document.getElementById('varWeekPaymentChart_div'));   
				  		chart3.draw(view, options);
				  		location.href="#varWeekPaymentChart_div";
					 }
				} 
			});
	}

	window.onload = function () {
		var tmArr = new Array();
		<c:forEach var="item" items="${tmlist}">
		tmArr.push({thsdate: "${item.thsdate}",
			thscount: ${item.thscount}
			});
		</c:forEach>
		
// 		for(var i=0; i<tmArr.length; i++){
			
// 		}
		
		var chart = new CanvasJS.Chart("chartContainer", {
			theme:"light1",
			animationEnabled: true,
			title:{
				text: "Game of Thrones Viewers of the First Airing on HBO"
			},
			axisY :{
				title: "Number of Viewers",
				suffix: "mn"
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
				yValueFormatString: "##.00mn",
				name: "Season 1",
// 				dataPoints: [
// 					for(var i=0; i<tmArr.length; i++){
						
// 					}
// 					{ label: tmArr[0].thsdate, y: 2.22 },
// 					{ label: "Ep. 2", y: 2.20 },
// 					{ label: "Ep. 3", y: 2.44 },
// 					{ label: "Ep. 4", y: 2.45 },
// 					{ label: "Ep. 5", y: 2.58 },
// 					{ label: "Ep. 6", y: 2.44 },
// 					{ label: "Ep. 7", y: 2.40 },
// 					{ label: "Ep. 8", y: 2.72 },
// 					{ label: "Ep. 9", y: 2.66 },
// 					{ label: "Ep. 10", y: 3.04 }
// 				]
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
</script>
</head>
<body>
    <div style="text-align:center">
        <h1>관리자 매출 확인</h1> 

		<div id="todayChart_div"></div>
		<div id="thsMonthChart_div"></div>
		<br/>
		<h3>특정 달의 매출 수 확인</h3>
		<div>
			특정 달 선택 : <input type="month" name="vardate" onchange="varDateFunc(this.value)"/>
			<div id="varMonthChart_div"></div>
		</div>
		<br/>
		<div>
			<h3>* 오늘 판매 금액 확인 : <b>${today_allpay}</b> *</h3>
		</div>
		<br/>
		<h3>특정 달의 매출 금액 확인</h3>
		<div>
			특정 달 선택 : <input type="month" name="varDatePayment" onchange="varDatePaymentFunc(this.value)"/>
			<div id="varDatePaymentChart_div"></div>
		</div>
		<br/>
		<h3>특정  주간 매출 금액 확인</h3>
		<h4>- 확인하고자하는 주차의 날짜를 선택해주세요</h4>
		<div>
			주간 선택 : <input type="date" name="varWeekPayment" onchange="varWeekPaymentFunc(this.value)"/>
			<div id="varWeekPaymentChart_div"></div>
		</div>
		<br/><br/>
	</div>
	
	<div id="chartContainer" style="height: 370px; width: 100%;"></div>
	
<!-- 	<div id="chartContainer2" style="height: 370px; width: 100%;"></div> -->
</body>
</html>
