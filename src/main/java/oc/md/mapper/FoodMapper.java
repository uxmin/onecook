package oc.md.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.junit.runners.Parameterized.Parameters;

import oc.md.domain.Cart;
import oc.md.domain.Food;
import oc.md.domain.Food_detail;
import oc.md.domain.Food_explain;
import oc.md.domain.OrderList;
import oc.md.domain.Postscript;
import oc.md.domain.QNA;
import oc.md.domain.Review;
import oc.md.vo.FoodAddVo;
import oc.md.vo.FoodPagingVO;
import oc.md.vo.PagingVO;
import oc.md.vo.PagingVO2;

public interface FoodMapper {
	//재료 등록
	public boolean FoodInsert(FoodAddVo foodAddVo);
	public boolean FoodExplainInsert(FoodAddVo foodAddVo);
	public boolean FoodDetailInsert(@Param("fd_f_name") String fd_f_name, @Param("fd_fd_sub") String fd_fd_sub, @Param("fd_fd_cont") String fd_fd_cont);
	//상품 리스트
	public List<Food> page(FoodPagingVO foodPagingVO);
	public long count();
	public List<Food> categoryPage(FoodPagingVO foodPagingVO);
	public long categoryCount(String category);
	public List<Food> searchPage(FoodPagingVO foodPagingVO);
	public long searchCount(String f_name);
	public List<Food> priceHighPage(FoodPagingVO foodPagingVO);
	public List<Food> priceLowPage(FoodPagingVO foodPagingVO);
	//상품 상세페이지
	public Food read(String f_name);
	//상품문의
	public List<QNA> pageQNA(PagingVO pagingVO);
	public long countQNA(PagingVO pagingVO);
	public boolean updateQNA(QNA qna);
	public void insertQNA(QNA qna);
	//후기리스트
	public List<Review> postScriptSelectPerPage(PagingVO2 pagingVO2);
	public long postScriptSelectCount(String f_name);
	public void postScriptInsertImage(Review review);
	//후기작성시 이미지가 있을 경우 포인트 업데이트
	public void imageUserPoint(String email);
	//후기작성 완료시 상태를 1로 업데이트
	public void postScriptExistUpdate(HashMap<String, Object> hs);
	public void postScriptInsertNoimage(Review review);
	//후기작성시 이미지가 없을 경우 포인트 업데이트
	public void noImageUserPoint(String email);
	//별(평점)추가
	public void postScriptInsertStar(Review review);
	public Review postScriptSelectBySeq(long rv_idx);	
	public void postScriptCountUpdate(Review review);
	//상세정보
	public List<Food_detail> selectByFood_detail(String f_name);
	public List<OrderList> bestFoodSelect();
	public long reviewCount(String f_name);
	public long averageStarCount(String f_name);
	//후기작성 유무
	public Postscript checkPostscript(Postscript script);
	//상세설명(explain)
	public List<Food_explain> explainRead(String f_name);
	//재료 메인 리스트에서 재료 존재 확인
	public String existFnameSelect(Cart ct);
	public boolean updateCartCount(Cart ct);
	public boolean insertCartCount(Cart ct);
	
	public void postscriptDelete(Review review);
	public void qnaDelete(QNA qna);
}
