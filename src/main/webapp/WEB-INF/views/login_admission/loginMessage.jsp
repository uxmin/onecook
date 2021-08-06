<%@page contentType="text/html;charset=utf-8"
	import="oc.md.service.LoginSet"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script>
	if (${ passCheck } == <%=LoginSet.NO_EMAIL %>) {
		setTimeout(function () {
			swal({
				text: "존재하지 않는 아이디에요. 다시 확인해주세요.",
			}).then(function () {
				location.href = "./login.do";
			});
		}, 1000);
	}else if (${ passCheck } == <%=LoginSet.NO_PW %> ) {
		setTimeout(function () {
			swal({
				text: "비밀번호가 맞지 않아요. 다시 확인해주세요.",
			}).then(function () {
				location.href = "./login.do";
			});
		}, 1000);
	}else {
		setTimeout(function () {
			swal({
				title: "로그인 완료",
				text: "반가워요, ${sessionScope.loginUser.user_name}님. 원쿡이 기다리고 있었어요.",
				icon: "success"
			}).then(function () {
				location.href = "../";
			});
		}, 1000);
	}
</script>