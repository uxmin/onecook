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
	//��� ���
	public boolean FoodInsert(FoodAddVo foodAddVo);
	public boolean FoodExplainInsert(FoodAddVo foodAddVo);
	public boolean FoodDetailInsert(@Param("fd_f_name") String fd_f_name, @Param("fd_fd_sub") String fd_fd_sub, @Param("fd_fd_cont") String fd_fd_cont);
	//��ǰ ����Ʈ
	public List<Food> page(FoodPagingVO foodPagingVO);
	public long count();
	public List<Food> categoryPage(FoodPagingVO foodPagingVO);
	public long categoryCount(String category);
	public List<Food> searchPage(FoodPagingVO foodPagingVO);
	public long searchCount(String f_name);
	public List<Food> priceHighPage(FoodPagingVO foodPagingVO);
	public List<Food> priceLowPage(FoodPagingVO foodPagingVO);
	//��ǰ ��������
	public Food read(String f_name);
	//��ǰ����
	public List<QNA> pageQNA(PagingVO pagingVO);
	public long countQNA(PagingVO pagingVO);
	public boolean updateQNA(QNA qna);
	public void insertQNA(QNA qna);
	//�ı⸮��Ʈ
	public List<Review> postScriptSelectPerPage(PagingVO2 pagingVO2);
	public long postScriptSelectCount(String f_name);
	public void postScriptInsertImage(Review review);
	//�ı��ۼ��� �̹����� ���� ��� ����Ʈ ������Ʈ
	public void imageUserPoint(String email);
	//�ı��ۼ� �Ϸ�� ���¸� 1�� ������Ʈ
	public void postScriptExistUpdate(HashMap<String, Object> hs);
	public void postScriptInsertNoimage(Review review);
	//�ı��ۼ��� �̹����� ���� ��� ����Ʈ ������Ʈ
	public void noImageUserPoint(String email);
	//��(����)�߰�
	public void postScriptInsertStar(Review review);
	public Review postScriptSelectBySeq(long rv_idx);	
	public void postScriptCountUpdate(Review review);
	//������
	public List<Food_detail> selectByFood_detail(String f_name);
	public List<OrderList> bestFoodSelect();
	public long reviewCount(String f_name);
	public long averageStarCount(String f_name);
	//�ı��ۼ� ����
	public Postscript checkPostscript(Postscript script);
	//�󼼼���(explain)
	public List<Food_explain> explainRead(String f_name);
	//��� ���� ����Ʈ���� ��� ���� Ȯ��
	public String existFnameSelect(Cart ct);
	public boolean updateCartCount(Cart ct);
	public boolean insertCartCount(Cart ct);
	
	public void postscriptDelete(Review review);
	public void qnaDelete(QNA qna);
}
