<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Spring Board</title>
<style>
table, th, td {
	border: 1px solid black;
	border-collapse: collapse;
}

th, td {
	padding: 5px;
}

a {
	text-decoration: none
}
input[type="text"]:focus {
	border-color: rgb(111, 186, 44);
	box-shadow: 0 0 8px 0 rgb(111, 186, 44);
}
</style>
<script language="javascript">
	   function check()
	   {
	       for(var i=0; i<2; i++)
		   {
		      if(document.input.elements[i].value == "")
			  {
// 			     alert("모든 값을 입력 하셔야 합니다. ");
			     swal("모든 값을 입력하셔야 합니다.");
				 return false;
			  }
		   }
		   document.input.submit();
       }
	</script>
</head>
<body>
	<font color="gray" size='4' face="휴먼편지체">
		<center>
			<hr width="600" size='2' color="gray" noshade>
			<h3>Spring Board ( Spring5 + MyBatis )</h3>
			<font color="gray" size="3" face="휴먼편지체"> <a href='list.do'>리스트</a>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href='../'>인덱스</a>
			</font>
			<hr width="600" size="2" color="gray" noshade>
		</center>

		<form name="input" method="post" action="postScript_write.do"
			enctype="multipart/form-data">
			<input type="hidden" name="f_name" value="${f_name}">
			<table border="0" width="600" align="center" cellpadding="3"
				cellspacing="1" bordercolor="gray">
				<!-- <tr>
		     <td width="30%" align="center">WRITER</td>
			 <td><input type="text" name="writer" size="60"></td>
		  </tr> -->
				<!-- 		  <tr> -->
				<!-- 		     <td align="center">EMAIL</td> -->
				<!-- 			 <td><input type="text" name="email" size="60"></td> -->
				<!-- 		  </tr> -->
				<tr>
					<td align="center">SUBJECT</td>
					<td><input type="text" name="rv_sub" size="60"></td>
				</tr>
				<tr>
					<td align="center">CONTENT</td>
					<td><textarea name="rv_cont" rows="15" cols="70"></textarea></td>
				</tr>

				<tr>
					<td></td>
					<td><input type="file" name="rv_img_file"></td>
				</tr>


				<!-- 		   <tr> -->
				<!-- 		  	<td></td> -->
				<!-- 		  	<td><input type="file" name="files"></td> -->
				<!-- 		  </tr> -->
				<!-- 		  <tr> -->
				<!-- 		  	<td></td> -->
				<!-- 		  	<td><input type="file" name="files"></td> -->
				<!-- 		  </tr>  -->
				<tr>
					<td colspan="2" align="center"><input type="button" value="전송"
						onclick="check()"> <!-- 				<input type="button" value="전송"> -->
						<input type="reset" value="다시입력" onclick="input.writer.focus()">
					</td>
				</tr>
			</table>
			<hr width="600" size="2" color="gray" noshade>
		</form>
	</font>
</body>
</html>