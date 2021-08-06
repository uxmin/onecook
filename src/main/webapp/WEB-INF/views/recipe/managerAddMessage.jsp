<%@page contentType="text/html;charset=utf-8"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script>
	   setTimeout(function() {
			swal({
				title : "레시피 등록완료",
				text : "작성한 레시피를 확인해보세요.",
				icon : "success"
			}).then(function() {
				location.reload();
				location.href = "list_manage.do";
			});
		}, 1000);
</script>
