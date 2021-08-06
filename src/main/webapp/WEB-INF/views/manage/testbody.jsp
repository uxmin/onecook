<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 

<body>
  <div class="wrapper ">
    <div class="sidebar" data-color="white" data-active-color="danger">
      <div class="logo">
        <a href="https://www.creative-tim.com" class="simple-text logo-mini">
          <div class="logo-image-small">
            <img src="../assets/img/logo-small.png">
          </div>
          <!-- <p>CT</p> -->
        </a>
        <a href="../" class="simple-text logo-normal">
          ONECOOK
          <!-- <div class="logo-image-big">
            <img src="../assets/img/logo-big.png">
          </div> -->
        </a>
      </div>
      <div class="sidebar-wrapper">
        <ul class="nav">
          <li>
            <a href="salesChart.do">
              <i class="nc-icon nc-chart-pie-36"></i>
              <p>관리자 메인</p>
            </a>
          </li> 
          <li>
            <a href="stock_check.do">
              <i class="nc-icon nc-app"></i>
              <p>재고확인</p>
            </a>
          </li>
          <li >
            <a href="oneInquiry.do">
              <i class="nc-icon nc-chat-33"></i>
              <p>1대1 문의</p>
            </a>
          </li>
          <li class="active ">
            <a href="order_check.do">
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
          <div class="col-md-12">
            <div class="card">
              <div class="card-header">
              <h4 class="card-title">주문취소 / 배송중 확인</h4>
               <input id="s_hdn_id" type="hidden" value="${p.select}">
         
              <form id="cat_form_id" action="one_cat_form.do" method="post">
              <div class="row">
              <div class="col-sm-3">
				<select id="selectBox" class="form-control" onchange="select(this.value);">
					<option id="all" value="all">전체</option>
					<option id="s_결제완료" value="결제완료">결제완료</option>
					<option id="s_배송중" value="배송중">배송중</option>
					<option id="s_배송완료" value="배송완료">배송완료</option>
					<option id="s_환불요청중" value="환불요청중">환불요청중</option>
					<option id="s_환불완료" value="환불완료">환불완료</option>
				</select>
			</div>
			<div class="col-sm-6">
				<input type="hidden" id="allDelivery" value="일괄배송" onclick="allDeli()">
				<input type="hidden" id="allRefund" value="일괄환불" onclick="allRe()">	
			</div>
			<div class="col-sm-3">
<!-- 					<button type="submit" id="search_id" class="btn btn-primary" style="margin:0; width:100%">검색</button> -->
			</div>
		
			</div>
			</form>		
	
                
              </div>
              <div class="card-body">
                <div class="table-responsive">
                  <table class="table">
                    <thead class=" text-primary">
						<tr>
							<th>주문번호</th>
							<th>주문일자</th>
							<th>유저이름</th>
							<th>주문상태</th>
							<th>배송번호</th>
							<th style="text-align:right">버튼</th>
						</tr>
                    </thead>
                    <tbody>
						<c:forEach var="od" items="${list}">
				 			<tr bgcolor="#f5eedc" class="tr">
			
				  			 	<td>${od.order_idx}</td>
				  			 	<td><fmt:formatDate value="${od.order_date}" pattern="yyyy-MM-dd"/></td>
				  			 	<td>${od.email}</td>
								<td class="td" id="state_${od.delivery_idx}">${od.delivery_state}</td>
								<c:choose>
									<c:when test="${od.delivery_num eq 0}">
										<td id="num_${od.delivery_idx}">-</td>
									</c:when>
									<c:otherwise>
										<td id="num_${od.delivery_idx}">${od.delivery_num}</td>	
									</c:otherwise>
								</c:choose>
								
								<c:choose>
									<c:when test="${od.delivery_state eq '결제완료'}">
										<td style="text-align:right"><input type="button" id="${od.delivery_idx}" class="btn btn-success" onclick="pay(this.id)" value="배송하기"></td>
									</c:when>
									<c:when test="${od.delivery_state eq '환불요청중'}">
										<td style="text-align:right"><input type="button" id="${od.delivery_idx}" class="btn btn-success" onclick="refund(this.id)" value="환불하기"></td>
									</c:when>
									
									<c:otherwise>
										<td></td>	
									</c:otherwise>
								</c:choose>
							</tr>
						</c:forEach>
                    </tbody>
                  </table>
                </div>
              </div>
            </div>
          </div>   
          
        <!-- 5. paging view -->	
        <div class="row_paging_class">
		<!-- 5. paging view	 -->
		<ul class="pagination">
			<c:if test="${p.pageStartNum ne 1}">
				<!-- 맨 첫페이지 이동 -->
				<li><a onclick='pagePre(${p.pageCnt+1},${p.pageCnt});'>&laquo;</a></li>
				<!-- 이전 페이지 이동 -->
				<li><a onclick='pagePre(${p.pageStartNum},${p.pageCnt});'>&lsaquo;</a></li>
			</c:if>
			
			<!--페이지번호 -->
			<c:forEach var='i' begin="${p.pageStartNum}" end="${p.pageLastNum}" step="1">
				<li class='pageIndex${i}'><a onclick='pageIndex(${i});'>${i}</a></li>
			</c:forEach>
			
			<c:if test="${p.lastChk}">
				<!-- 다음 페이지 이동 -->
				<li><a onclick='pageNext(${p.pageStartNum},${p.total},${p.listCnt},${p.pageCnt});'>&rsaquo;</a></li>
				<!-- 마지막 페이지 이동 -->
				<li><a onclick='pageLast(${p.pageStartNum},${p.total},${p.listCnt},${p.pageCnt});'>&raquo;</a></li>
			</c:if>
		</ul>
		</div>
		
 		<form method="post" id='frmPaging'>
 			<!-- 출력할 페이지번호, 출력할 페이지 시작 번호, 출력할 리스트 갯수 -->
			<input type='hidden' name='index' id='index' value='${p.index}'>
			<input type='hidden' name='pageStartNum' id='pageStartNum' value='${p.pageStartNum}'>
			<input type='hidden' name='listCnt' id='listCnt' value='${p.listCnt}'>
			<input type='hidden' name='select' id='select' value='${p.select}'>
 		</form>
 		
 		

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

</body>