package oc.md.vo;

import lombok.NoArgsConstructor;

@NoArgsConstructor
public class PagingVO {
	private String f_name;		////////////// 재료명을 받기 위한 변수 
	private String select;		////////////// 관리자 주문상태에서 카테고리 선택을 위한 변수 
	
	private int pageCnt;		// 출력할 페이지번호 갯수 (변경해볼것)
	private int index;			// 출력할 페이지번호
	private long pageStartNum;	// 출력할 페이지 시작 번호
	private int listCnt;		// 출력할 리스트 갯수
	private long total;			// 리스트 총 갯수
	//추가
	private String category;
	private String sort;
	private String email;
	private String rc_title;	
	// 좋아요
	private String good_email;
	{
		pageCnt = 10; 
		index = 0;
		pageStartNum = 1;
		listCnt = 5;
	}
	
	public int getStart() {
		return index*listCnt+1;
	}
	public int getLast() {
		return (index*listCnt)+listCnt;
	}
	public long getPageLastNum() {
		long remainListCnt = total-listCnt*(pageStartNum-1);
		long remainPageCnt = remainListCnt/listCnt;
		if(remainListCnt%listCnt != 0) {
			remainPageCnt++; //게시물이 존재하지 않아서 띄울 페이지 번호가 없을 때, 총 페이지번호를 1로 증가시켜서 기본적으로 페이지 1이 띄워질 수 있도록 하는 코드 
		}
		long pageLastNum = 0L;
		if(remainListCnt <= listCnt) {
			pageLastNum = pageStartNum; //게시물이 띄우려고 설정해둔 숫자(listCnt)보다 적을 때 시작 페이지와 마지막 페이지가 1로 동일하게 설정하여 1만 띄워지게 함
		}else if(remainPageCnt <= pageCnt) {
			pageLastNum = remainPageCnt+pageStartNum-1; //페이지가 10개가 되지 않을 때 나옴
		}else {
			pageLastNum = pageCnt+pageStartNum-1; //페이지가 10개가 넘어갈 때
		}
		return pageLastNum;
	}
	public boolean getLastChk() { //> >> 띄워주는것
		int n = (int)Math.ceil((double)total/listCnt);
		return getPageLastNum()==n ? false : n==0 ? false : true;
	}
	
	public int getPageCnt() {
		return pageCnt;
	}
	public void setPageCnt(int pageCnt) {
		this.pageCnt = pageCnt;
	}
	public int getIndex() {
		return index;
	}
	public void setIndex(int index) {
		this.index = index;
	}
	public long getPageStartNum() {
		return pageStartNum;
	}
	public void setPageStartNum(long pageStartNum) {
		this.pageStartNum = pageStartNum;
	}
	public int getListCnt() {
		return listCnt;
	}
	public void setListCnt(int listCnt) {
		this.listCnt = listCnt;
	}
	public long getTotal() {
		return total;
	}
	public void setTotal(long total) {
		this.total = total;
	}
	
	public String getF_name() {
		return f_name;
	}
	public void setF_name(String f_name) {
		this.f_name = f_name;
	}
	
	@Override
	public String toString() {
		return "PagingVO [pageCnt=" + pageCnt + ", index=" + index + ", pageStartNum=" + pageStartNum + ", listCnt="
				+ listCnt + ", total=" + total + "]";
	}
	
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getSort() {
		return sort;
	}
	public void setSort(String sort) {
		this.sort = sort;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getRc_title() {
		return rc_title;
	}
	public void setRc_title(String rc_title) {
		this.rc_title = rc_title;
	}
	
	public String getGood_email() {
		return good_email;
	}
	public void setGood_email(String good_email) {
		this.good_email = good_email;
	}
	public String getSelect() {
		return select;
	}
	public void setSelect(String select) {
		this.select = select;
	}
}
