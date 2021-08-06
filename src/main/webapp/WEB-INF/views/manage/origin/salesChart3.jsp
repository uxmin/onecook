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
				text: month + "월 매출 수 확인(당월)"
			},
			axisY :{
				title: month + "월 판매수",
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
			title: {
				text: "오늘의 판매 베스트 수"
			},
			subtitles: [{
				text: year + '/' + month + '/' + date,
				fontSize: 16
			}],
			data: [{
				type: "pie",
				indexLabelFontSize: 18,
				radius: 1000,
				indexLabel: "{label} - {y}",
				yValueFormatString: "### 개",
				click: explodePie,
				dataPoints: [
					<c:forEach var="item" items="${tlist}">
						{y: ${item.sales_fcount}, label: "${item.f_name}"},
					</c:forEach>
						{y: ${etc.sum_price}, label: "기타재료"}
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
</head>
<body>
    <div style="text-align:center">
        <h1>관리자 매출 확인</h1> 
		<div id="chartContainer" style="height: 370px; width: 100%;"></div>
		
		<div id="chartContainer2" style="height: 370px; width: 100%;"></div>
		<br/>
		<h3>특정 달의 매출 수 확인</h3>
		<div>
			특정 달 선택 : <input type="month" name="vardate" onchange="varDateFunc(this.value)"/>
			<div id="varMonthChart_div" style="height: 370px; width: 100%;"></div>
<!-- 			<div id="chartContainer" style="height: 370px; width: 100%;"></div> -->
		</div>
		<br/>
		<div>
			<h3>* 오늘 판매 금액 확인 : <b>${today_allpay}</b> *</h3>
		</div>
		<br/>
		<h3>특정 달의 매출 금액 확인</h3>
		<div>
			특정 달 선택 : <input type="month" name="varDatePayment" onchange="varDatePaymentFunc(this.value)"/>
			<div id="varDatePaymentChart_div" style="height: 370px; width: 100%;">
			</div>
			<h3 class="varDatePaymentChart_div"></h3>
		</div>
		<br/>
		<h3>특정  주간 매출 금액 확인</h3>
		<h4>- 확인하고자하는 주차의 날짜를 선택해주세요</h4>
		<div>
			주간 선택 : <input type="date" name="varWeekPayment" onchange="varWeekPaymentFunc(this.value)"/>
			<div id="varWeekPaymentChart_div" style="height: 370px; width: 100%;"></div>
			<h3 class="varWeekPaymentChart_div"></h3>
		<br/><br/>
	</div>
	
<!-- 	<div id="chartContainer2" style="height: 370px; width: 100%;"></div> -->
</body>
</html>
