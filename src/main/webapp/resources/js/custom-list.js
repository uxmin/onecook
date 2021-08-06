/**
 * 
 */
	  var reviewNum;
	  var reviewFname;
	     $(document).ready(function(){
	    	 $(".show_review_tr").css("display", "none");
	    	 
			 var clicks=0;
	    	 $(".toggle_review_sub").click(function(){
	    		 //alert(clicks);
	    		 reviewNum = $(this)[0].childNodes[0].value; 
	    		 reviewFname = $(this)[0].childNodes[1].value;
					
	    		$("#tr_head_"+reviewNum).toggle("slow");
	    		$("#tr_body_"+reviewNum).toggle("slow");
	    	if(clicks==0){
	    		openDetailWithCountReadNum();
	    		clicks++;
    		 } else {
    			openDetailWithoutReadNum();
    			clicks--;
    		 }
	  	   });
	     });
	     
	     function openDetailWithCountReadNum(){
	    		$.ajax({
	    			url:"update.json",
	    			type:"get",
	    			data: {rv_idx : reviewNum, f_name : reviewFname},
	    			success: function(result){
	    				console.log("##1"+result.rv_idx);
	    				console.log("##2"+result.rv_cont);
	    				console.log("##3"+result.rv_sub);
	    				console.log("##4"+result.rv_img);
	    				//$("body").html(result);
			
	    				var th = "";
	    				th += "<th>제목</th>"
	    					+ "<th colspan='2'>내용</th>"
	    					+ "<th colspan='2'>이미지</th>";
	    					
	    				var tr = "";	
	    				tr += "<td>"+result.rv_sub+"</td>"
	    					+ "<td colspan='2'>"+result.rv_cont+"</td>";
	    				if(result.rv_img == null){
	    					tr += "<td colspan='2'>이미지 없음</td>";
	    				}else{
	    					tr += "<td colspan='2'><img src='../resources/images/food/postScript/"+result.rv_img+"'></td>";
	    				}
	    				
	    				$("#tr_head_"+result.rv_idx).html(th);
	    				$("#tr_body_"+result.rv_idx).html(tr);
	    				
						/*document.querySelector('#readNum_'+result.rv_idx).firstChild = "hi";
	    				var test =document.querySelector('#readNum_'+result.rv_idx).firstChild;
	    				alert(">"+test);
	    				$('#readNum_'+result.rv_idx).append(test); 
	    				*/
	    			} //end ajax
		   	 	 });	    	 
	     }
	     function openDetailWithoutReadNum(){
	    		$.ajax({
	    			url:"update_noReadNum.json",
	    			type:"get",
	    			data: {rv_idx : reviewNum, f_name : reviewFname},
	    			success: function(result){
	    				console.log("##1"+result.rv_idx);
	    				console.log("##2"+result.rv_cont);
	    				console.log("##3"+result.rv_sub);
	    				console.log("##4"+result.rv_img);
//	    				$("body").html(result);
			
	    				var th = "";
	    				th += "<th>제목</th>"
	    					+ "<th colspan='2'>내용</th>"
	    					+ "<th colspan='2'>이미지</th>";
	    					
	    				var tr = "";	
	    				tr += "<td>"+result.rv_sub+"</td>"
	    					+ "<td colspan='2'>"+result.rv_cont+"</td>";
	    				if(result.rv_img == null){
	    					tr += "<td colspan='2'>이미지 없음</td>";
	    				}else{
	    					tr += "<td colspan='2'><img src='../resources/images/food/postScript/"+result.rv_img+"'></td>";
	    				}
	    				
	    				$("#tr_head_"+result.rv_idx).html(th);
	    				$("#tr_body_"+result.rv_idx).html(tr);
	    				
	    				
	    				
						/*document.querySelector('#readNum_'+result.rv_idx).firstChild = "hi";
	    				var test =document.querySelector('#readNum_'+result.rv_idx).firstChild;
	    				alert(">"+test);
	    				$('#readNum_'+result.rv_idx).append(test); 
	    				*/
	    			} //end ajax
		   	 	 });	    
	     }
