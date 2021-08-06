<%@page contentType="text/html;charset=utf-8"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script>
	   setTimeout(function() {
			swal({
				title : "이런...",
				text : "상품의 재고 수량이 부족해요.",
				icon : "warning"
			}).then(function() {
				location.href="cart_list.do";
			});
		}, 1000);
</script>
