package oc.md.vo;

import lombok.NoArgsConstructor;

@NoArgsConstructor
public class PagingVO2 {
	private String f_name;		////////////// 재료명을 받기 위한 변수 
	
	private int posts_pageCnt;		// 출력할 페이지번호 갯수 (변경해볼것)
	private int posts_index;			// 출력할 페이지번호
	private long posts_pageStartNum;	// 출력할 페이지 시작 번호
	private int posts_listCnt;		// 출력할 리스트 갯수
	private long posts_total;			// 리스트 총 갯수
	
	{
		posts_pageCnt = 10; 
		posts_index = 0;
		posts_pageStartNum = 1;
		posts_listCnt = 5;
	}
	
	public int getStart() {
		return posts_index*posts_listCnt+1;
	}
	public int getLast() {
		return (posts_index*posts_listCnt)+posts_listCnt;
	}
	public long getPageLastNum() {
		long remainposts_listCnt = posts_total-posts_listCnt*(posts_pageStartNum-1);
		long remainPageCnt = remainposts_listCnt/posts_listCnt;
		if(remainposts_listCnt%posts_listCnt != 0) {
			remainPageCnt++; //게시물이 존재하지 않아서 띄울 페이지 번호가 없을 때, 총 페이지번호를 1로 증가시켜서 기본적으로 페이지 1이 띄워질 수 있도록 하는 코드 
		}
		long pageLastNum = 0L;
		if(remainposts_listCnt <= posts_listCnt) {
			pageLastNum = posts_pageStartNum; //게시물이 띄우려고 설정해둔 숫자(posts_listCnt)보다 적을 때 시작 페이지와 마지막 페이지가 1로 동일하게 설정하여 1만 띄워지게 함
		}else if(remainPageCnt <= posts_pageCnt) {
			pageLastNum = remainPageCnt+posts_pageStartNum-1; //페이지가 10개가 되지 않을 때 나옴
		}else {
			pageLastNum = posts_pageCnt+posts_pageStartNum-1; //페이지가 10개가 넘어갈 때
		}
		return pageLastNum;
	}
	public boolean getLastChk() { //> >> 띄워주는것
		int n = (int)Math.ceil((double)posts_total/posts_listCnt);
		return getPageLastNum()==n ? false : n==0 ? false : true;
	}
	
	public int getPosts_pageCnt() {
		return posts_pageCnt;
	}
	public void setPosts_pageCnt(int posts_pageCnt) {
		this.posts_pageCnt = posts_pageCnt;
	}

	public long getPosts_pageStartNum() {
		return posts_pageStartNum;
	}
	public void setPosts_pageStartNum(long posts_pageStartNum) {
		this.posts_pageStartNum = posts_pageStartNum;
	}
	public int getPosts_listCnt() {
		return posts_listCnt;
	}
	public void setPosts_listCnt(int posts_listCnt) {
		this.posts_listCnt = posts_listCnt;
	}
	public long getPosts_total() {
		return posts_total;
	}
	public void setPosts_total(long posts_total) {
		this.posts_total = posts_total;
	}
	
	public String getF_name() {
		return f_name;
	}
	public void setF_name(String f_name) {
		this.f_name = f_name;
	}
	
	public int getPosts_index() {
		return posts_index;
	}
	public void setPosts_index(int posts_index) {
		this.posts_index = posts_index;
	}
	
	@Override
	public String toString() {
		return "PagingVO2 [posts_pageCnt=" + posts_pageCnt + ", posts_index=" + posts_index + ", posts_pageStartNum=" + posts_pageStartNum + ", posts_listCnt="
				+ posts_listCnt + ", posts_total=" + posts_total + "]";
	}


	
}
