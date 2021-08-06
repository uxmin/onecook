<%@page contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script>
	setTimeout(function() {
		swal({
			title : "로그아웃 완료",
			text : "매일매일 업데이트 되는 레시피! 원쿡에 다시 놀러오세요.",
			icon : "success"
		}).then(function() {
			location.href = "../";
		});
	}, 1000);
</script>
