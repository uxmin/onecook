<%@page contentType="text/html;charset=utf-8"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script>
	   setTimeout(function() {
			swal({
				title : "재료 등록완료!",
				text : "재료가 성공적으로 등록되었습니다.",
				icon : "success"
			}).then(function() {
				location.reload();
				location.href = "food_list.do";
			});
		}, 1000);
</script>
