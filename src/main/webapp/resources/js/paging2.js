// 4. Javascript
//submit
function frmPaging2() {
	document.getElementById("frmPaging2").submit();
}
// 이전 페이지 index
function pagePre2(index, pageCnt) {
	if (0 < index - pageCnt) {
		index -= pageCnt;
		document.getElementById("posts_pageStartNum").value = index;
		document.getElementById("posts_index").value = index - 1;
		frmPaging2();
	}
}
// 다음 페이지 index
function pageNext2(index, total, listCnt, pageCnt) {
	var totalPageCnt = Math.ceil(total / listCnt);
	var max = Math.ceil(totalPageCnt / pageCnt);
	if (max * pageCnt > index + pageCnt) {
		index += pageCnt;
		document.getElementById("posts_pageStartNum").value = index;
		document.getElementById("posts_index").value = index - 1;
		frmPaging2();
	}
}
// 마지막 페이지 index
function pageLast2(index, total, listCnt, pageCnt) {
	var totalPageCnt = Math.ceil(total / listCnt);
	var max = Math.ceil(totalPageCnt / pageCnt);
	while (max * pageCnt > index + pageCnt) {
		index += pageCnt;
	}
	var remainListCnt = total - listCnt * (index - 1);
	var remainPageCnt = Math.floor(remainListCnt / listCnt);
	if (remainListCnt % listCnt != 0) {
		remainPageCnt++;
	}
	var pageLastNum = 0;
	if (remainListCnt <= listCnt) {
		pageLastNum = index;
	} else if (remainPageCnt <= pageCnt) {
		pageLastNum = remainPageCnt + index - 1;
	} else {
		pageLastNum = pageCnt + index - 1;
	}
	document.getElementById("posts_pageStartNum").value = index;
	document.getElementById("posts_index").value = pageLastNum - 1;
	frmPaging2();
}
// index 리스트 처리
function pageIndex2(pageStartNum) {
	document.getElementById("posts_index").value = pageStartNum - 1;
	frmPaging2();
}
// 리스트출력개수 처리
function listCnt2() {
	document.getElementById("posts_index").value = 0;
	document.getElementById("posts_pageStartNum").value = 1;
	document.getElementById("posts_listCnt").value = document.getElementById("listCount").value;
	frmPaging2();
}
window.onload = function() {
	// 현재번호 active
	var index = document.getElementById("posts_index").value;
	var pageIndex = document.querySelector('.pageIndex2'+(Number(index)+1));
	pageIndex.setAttribute("class", "active");
	// 리스트갯수 selected 처리
	$("#listCount > option").each(function () {
		if ($(this).val() == $('#posts_listCnt').val()) {
			$(this).prop("selected", true);
		}
	});
}