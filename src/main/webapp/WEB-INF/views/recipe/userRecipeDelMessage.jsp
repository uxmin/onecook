<%@page contentType="text/html;charset=utf-8"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script>
	   setTimeout(function() {
			swal({
				title : "레시피 삭제완료",
				icon : "success"
			}).then(function() {
				location.reload();
				location.href = "list_user.do";
			});
		}, 1000);
</script>
