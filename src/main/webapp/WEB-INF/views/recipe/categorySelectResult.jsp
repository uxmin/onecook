<%@page contentType="text/html;charset=utf-8"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<%@ include file="../common/head_link.jsp" %>
    <%@ include file="../common/js_link.jsp" %>
    
	<select class="form-control" id="f_name_result" name="f_name">
		<option value="">선택</option>
		<!--  셀렉트 결과 option으로 추가하기 -->
		<c:forEach items="${categoryList}" var="cat">
			<option value="${cat.f_name}">${cat.f_name}</option>
		</c:forEach>
	</select>
