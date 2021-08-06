<%@page contentType="text/html;charset=utf-8"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script>
	setTimeout(function(){
		  swal({
			  title: "로그인 완료",
			  text: "반가워요, ${sessionScope.loginUser.user_name}님! 원쿡이 기다리고 있었어요.",
			  icon: "success"
		  }).then(function(){
			  location.href="../";
		  });
	  },1000);
</script>
