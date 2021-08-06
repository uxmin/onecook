<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="../js/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="../js/paging.js"></script>
<script src="../js/bootstrap.min.js"></script>
<script type="text/javascript" language="javascript" 
		     src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
<link rel="stylesheet" href="../css/bootstrap.min.css">
<link rel="stylesheet" href="../css/bootstrap-theme.min.css">
<style>
.list{
	width: 80%;
	margin: 10px auto;
}
.list_box{
	border: 1px solid black;
	float: left;
	width: 33.33333%;
	box-sizing: border-box;
}
</style>
<script>
	$(document).ready(function(){
		var hdn = $("#cat_hdn").val();
		$("#pirce_"+hdn).attr("selected", "selected");
		var sort_hdn = $("#sort_hdn").val();
		$("#s_"+sort_hdn).attr("selected", "selected");
		var search_hdn = $("#search_hdn").val();
		$("#recipe_search").attr("value", search_hdn);
		
		$("#recipe_search_button").on("click", function(){
			$.ajax({
				url: "search_name.json",
				type: "POST",
				data: {rc_title: $("#recipe_search").val()},
				success: function(data){
					if(!data) return false;
					$("body").html(data);
					$("#frmPaging").attr("action", "search_name");
				}
			});
		});
	});
	function enterKey(e){
        if(event.keyCode == 13){
        	$.ajax({
				url: "search_name.json",
				type: "POST",
				data: {rc_title: $("#recipe_search").val()},
				success: function(data){
					if(!data) return false;
					$("body").html(data);
					$("#frmPaging").attr("action", "search_name");
				}
			});
        }
	}
	function category(val){
		var category_val = $("#recipe_type option:selected").val();
		
		if(category_val == "전체"){
			$.ajax({
				url: "list_manage.do",
				type: "GET",
				success: function(result){
					$("body").html(result);
					$("#frmPaging").attr("action", "list_manage.do");
				}
			});
		}else{
			$.ajax({
				url: "list_manage_cat.do",
				type: "GET",
				data: {category : val},
				success: function(result){
					$("body").html(result);
					$("#frmPaging").attr("action", "list_manage_cat.do");
				}
			});	
		}
	}
	
	function sort(val){
		var category_val = $("#recipe_type option:selected").val();
		var sort_val = $("#range_type option:selected").val();
		
		if(sort_val == "new"){
			$.ajax({
				url: "list_manage_sort.do",
				type: "GET",
				data: {sort: $("#s_new").val(), category: category_val},
				success: function(result){
					$("body").html(result);
					$("#frmPaging").attr("action", "list_manage_sort.do");
				}
			});
		}else if(sort_val == "good"){
			$.ajax({
				url: "list_manage_sort.do",
				type: "GET",
				data: {sort: $("#s_good").val(), category: category_val},
				success: function(result){
					$("body").html(result);
					$("#frmPaging").attr("action", "list_manage_sort.do");
				}
			});
		}else{
			$.ajax({
				url: "list_manage_sort.do",
				type: "GET",
				data: {sort: $("#s_view").val(), category: category_val},
				success: function(result){
					$("body").html(result);
					$("#frmPaging").attr("action", "list_manage_sort.do");
				}
			});
		}
	}
	//좋아요 눌림
	function goodInFunc(val){
		console.log(val);
		$.ajax({
			url:'listGoodClick.do',
			type: 'get',
			data:{rc_idx : val, gubun : 'list'},
			success: function(result){
				console.log(val);
				console.log($("#list_box_"+val));
// 				$("#list_box_"+val)[0].childNodes[9].innerText = '조아요눌림';
				console.log($("#list_box_"+val).find(".gd_btn_"+val));
				$("#list_box_"+val).find(".gd_btn_"+val).text("조아요눌림");
// 				$("#list_box_"+val).find(".gd_btn_"+val).css('background-color', 'CYAN');
				$("#list_box_"+val).find(".gd_btn_"+val).attr('onclick', 'goodDelFunc(this.value)');
				console.log($("#list_box_"+val).find("span"));
				console.log($("#list_box_"+val).find("span").text());
				var goodCnt = $("#list_box_"+val).find("span").text();
				goodCnt= parseFloat(goodCnt);
				$("#list_box_"+val).find("span").text(goodCnt+1);
			},
			error: function(err){
				console.log(err);
			}
		});
	}
	// 좋아요취소
	function goodDelFunc(val){
		console.log(val);
		
		$.ajax({
			url:'listUnGoodClick.do',
			type: 'get',
			data:{rc_idx : val, gubun : 'list'},
			success: function(result){
				console.log(val);
				console.log($("#list_box_"+val));
// 				$("#list_box_"+val)[0].childNodes[9].innerText = '조아요눌림';
				console.log($("#list_box_"+val).find(".gd_btn_"+val));
				$("#list_box_"+val).find(".gd_btn_"+val).text("조아요");
			
				$("#list_box_"+val).find(".gd_btn_"+val).attr('onclick', 'goodInFunc(this.value)');
				console.log($("#list_box_"+val).find("span"));
				console.log($("#list_box_"+val).find("span").text());
				var goodCnt = $("#list_box_"+val).find("span").text();
				goodCnt= parseFloat(goodCnt);
				$("#list_box_"+val).find("span").text(goodCnt-1);
			},
			error: function(err){
				console.log(err);
			}
		});
	}
</script>
</head>
<body>
<div style="text-align: center">
	<h1>레시피 리스트</h1>
	<input id="cat_hdn" type="hidden" value="${p.category}">
	<input id="sort_hdn" type="hidden" value="${p.sort}">
	<input id="search_hdn" type="hidden" value="${p.rc_title}">
	
	<select name="recipe_type" id="recipe_type" onchange="category(this.value);">
		<option id="all" value="전체">전체</option>
		<option id="pirce_3000원대" value="3000원대">~ 3000 won</option>
		<option id="pirce_5000원대" value="5000원대">~ 5000 won</option>
		<option id="pirce_7000원대" value="7000원대">~ 7000 won</option>
	</select>
	<select name="range_type" id="range_type" onchange="sort(this.value);">
		<option id="s_new" value="new">신상품순</option>
		<option id="s_good" value="good">좋아요순</option>
		<option id="s_view" value="view">조회수순</option>
	</select>
	<br/>
	
	<input id="recipe_search" type="search" size="30%" onkeydown="enterKey(this)"/>
	<button id="recipe_search_button">검색</button>
	<br/><br/>
	
	<div class="list">
	<c:forEach var="dto" items="${list}">
	<input id="rc_idx" type="hidden" value="${dto.rc_idx}">
	
	<div id="list_box_${dto.rc_idx}" class="list_box">
		<image src="../images/recipe/${dto.rc_title}/${dto.rc_img}" width="80%" height="80%"/><br/>
		<a href="recipe_detail.do?rc_idx=${dto.rc_idx}">${dto.rc_title}</a><br/>
		조회수: ${dto.rc_num} <br/>
		좋아요: <span>${dto.g_count}</span>
		<c:if test="${!empty dto.good_email}">
<%-- 			<button style="background-color:CYAN" onclick="location.href='listUnGoodClick.do?rc_idx=${dto.rc_idx}&gubun=list'">좋아요 눌림</button> --%>
			<button class="gd_btn_${dto.rc_idx}" value="${dto.rc_idx}" style="background-color:CYAN" onclick="goodDelFunc(this.value)">좋아요 눌림</button>
		</c:if>
		<c:if test="${empty dto.good_email}">
			<c:if test="${ !empty loginUser}">
<%-- 				<button onclick="location.href='listGoodClick.do?rc_idx=${dto.rc_idx}&gubun=list'">조아효</button> --%>
				<button class="gd_btn_${dto.rc_idx}" value="${dto.rc_idx}" onclick="goodInFunc(this.value)">조아효</button>
			</c:if>
			<c:if test="${ empty loginUser}">
				<button class="gd_btn_${dto.rc_idx}">조아효</button>
			</c:if>
		</c:if>
	</div>
	</c:forEach>
	
	
	<ul class="pagination">
		<c:if test="${p.pageStartNum ne 1}">
			<li><a onclick='pagePre(${p.pageStartNum},${p.pageCnt});'>이전</a></li>
		</c:if>
		
		<c:forEach var='i' begin="${p.pageStartNum}" end="${p.pageLastNum}" step="1">
			<li class='pageIndex${i}'><a onclick='pageIndex(${i});'>${i}</a></li>
		</c:forEach>
		
		<c:if test="${p.lastChk}">
			<li><a onclick='pageNext(${p.pageStartNum},${p.total},${p.listCnt},${p.pageCnt});'>이후</a></li>
		</c:if>
	</ul>
	
	<form method="post" id='frmPaging'>
		<input type='hidden' name='index' id='index' value='${p.index}'>
		<input type='hidden' name='pageStartNum' id='pageStartNum' value='${p.pageStartNum}'>
		<input type='hidden' name='listCnt' id='listCnt' value='${p.listCnt}'>
		<input type='hidden' name='category' id='category' value='${p.category}'>
		<input type='hidden' name='sort' id='sort' value='${p.sort}'>
		<input type='hidden' name='rc_title' id='rc_title' value='${p.rc_title}'>
	</form>
	</div>
</div>
</body>
</html>