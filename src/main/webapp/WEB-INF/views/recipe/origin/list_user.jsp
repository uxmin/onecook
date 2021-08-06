<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
	width: 85%;
	margin: 10px auto;
}
.list_box{
	border: 1px solid black;
	float: left;
	width: 20%;
	box-sizing: border-box;
}
</style>
<script>
	$(document).ready(function(){
		var sort_hdn = $("#sort_hdn").val();
		$("#s_"+sort_hdn).attr("selected", "selected");
		var hdn = $("#cat_hdn").val();
		$("#c_"+hdn).attr("selected", "selected");
		var s_email_hdn = $("#s_email_hdn").val();
		$("#r_user_search").attr("value", s_email_hdn);
		var s_title_hdn = $("#s_title_hdn").val();
		$("#r_user_search").attr("value", s_title_hdn);
		
		$("#r_user_search_btn").on("click", function(){
			var i = $("select[name = search_cat]").val();
			if(i == "title"){
				$.ajax({
					url: "search_title.json",
					type: "POST",
					data: {rc_title: $("#r_user_search").val(), category: i},
					success: function(data){
						if(!data) return false;
						$("body").html(data);
						$("#frmPaging").attr("action", "search_title");
					}
				});
			}else if(i == "writer"){
				$.ajax({
					url: "search_email.json",
					type: "POST",
					data: {email: $("#r_user_search").val(), category: i},
					success: function(data){
						if(!data) return false;
						$("body").html(data);
						$("#frmPaging").attr("action", "search_email");
					}
				});
			}
		});
	});
	function enterKey(e){
        if(event.keyCode == 13){
        	var i = $("select[name = search_cat]").val();
			if(i == "title"){
				$.ajax({
					url: "search_title.json",
					type: "POST",
					data: {rc_title: $("#r_user_search").val(), category: i},
					success: function(data){
						if(!data) return false;
						$("body").html(data);
						$("#frmPaging").attr("action", "search_title");
					}
				});
			}else if(i == "writer"){
				$.ajax({
					url: "search_email.json",
					type: "POST",
					data: {email: $("#r_user_search").val(), category: i},
					success: function(data){
						if(!data) return false;
						$("body").html(data);
						$("#frmPaging").attr("action", "search_email");
					}
				});
			}
        }
	}
	function sort(val){
		var sort_val = $("#range_type option:selected").val();
		
		if(sort_val == "new"){
			$.ajax({
				url: "list_user.do",
				type: "GET",
				success: function(result){
					$("body").html(result);
					$("#frmPaging").attr("action", "list_user.do");
				}
			});
		}else if(sort_val == "good"){
			$.ajax({
				url: "list_user_sort.do",
				type: "GET",
				data: {sort: $("#s_good").val()},
				success: function(result){
					$("body").html(result);
					$("#frmPaging").attr("action", "list_user_sort.do");
				}
			});
		}else{
			$.ajax({
				url: "list_user_sort.do",
				type: "GET",
				data: {sort: $("#s_view").val()},
				success: function(result){
					$("body").html(result);
					$("#frmPaging").attr("action", "list_user_sort.do");
				}
			});
		}
	}
</script>
</head>
<body>
<div style="text-align: center">
	<h1>회원 레시피 리스트</h1>
	<br/>
	<input id="sort_hdn" type="hidden" value="${p.sort}">
	<input id="cat_hdn" type="hidden" value="${p.category}">
	<input id="s_email_hdn" type="hidden" value="${p.email}">
	<input id="s_title_hdn" type="hidden" value="${p.rc_title}">
	
	<h3>♥ 우수 레시피 ♥</h3>
	<div class="list">
	<c:forEach var="dto" items="${list}">
		<div class="list_box">
			<image src="../images/recipe/${dto.rc_img}" width="85%" height="85%"/><br/>
			<a href="#">${dto.rc_title}</a><br/>
			조회수: ${dto.rc_num} <br/>
			좋아요: ${dto.g_count}
			<c:if test="${!empty dto.good_email}">
				<button disabled="" style="background-color:CYAN">좋아요 눌림</button>
			</c:if>
			<c:if test="${empty dto.good_email}">
				<button>조아효</button>
			</c:if>
		</div>
	</c:forEach>
	<br/><br/><br/>
	
	<select name="range_type" id="range_type" onchange="sort(this.value);">
		<option id="s_new" value="new">신상품순</option>
		<option id="s_good" value="good">좋아요순</option>
		<option id="s_view" value="view">조회수순</option>
	</select>
	
	<select name="search_cat" id="search_cat">
		<option id="c_title" value="title">제목</option>
		<option id="c_writer" value="writer">작성자</option>
	</select>
	
	<input id="r_user_search" type="search" size="30%" onkeydown="enterKey(this)"/>
	<button id="r_user_search_btn">검색</button>
	<br/><br/>
	
	<h3>원쿡 가족들 레시피</h3>
	<div class="container">
		<table class="table table-bordered">
			<tr>
			    <th>번호</th>
			    <th>좋아요 버튼</th>
				<th>이미지</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
				<th>조회수</th>
				<th>좋아요</th>
			</tr>
			<c:forEach var="line" items="${list_line}">
			<tr>
				<th>${line.rc_idx}</th>
				<th>
				<c:if test="${!empty line.good_email}">
					<button style="background-color:CYAN" onclick="location.href='UserUnGoodClick.do?rc_idx=${line.rc_idx}&gubun=list'">좋아요 눌림</button>
				</c:if>
				<c:if test="${empty line.good_email}">
					<c:if test="${ !empty loginUser}">
						<button onclick="location.href='UserGoodClick.do?rc_idx=${line.rc_idx}&gubun=list'">조아효</button>
					</c:if>
					<c:if test="${ empty loginUser}">
						<button>조아효</button>
					</c:if>
				</c:if>
				</th>
				<th><image src="../images/recipe/${line.rc_img}" width="25%" height="25%"/></th>
				<th><a href="user_recipe_detail.do?rc_idx=${line.rc_idx}">${line.rc_title}</a></th>
				<th>${line.email}</th>
				<th><fmt:formatDate value="${line.rc_date}" pattern="yyyy-MM-dd"/></th>
				<th>${line.rc_num}</th>
				<th>${line.g_count}</th>
			</tr>
			</c:forEach>
		</table>
	</div>
	
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
		<input type='hidden' name='email' id='email' value='${p.email}'>
		<input type='hidden' name='rc_title' id='rc_title' value='${p.rc_title}'>
	</form>
	
	</div>
</div>
</body>
</html>