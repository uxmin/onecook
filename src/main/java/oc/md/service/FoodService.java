package oc.md.service;

import java.util.List;

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

public interface FoodService {
	//�����
	public boolean FoodAddS(FoodAddVo foodAddVo);
	//��ǰ ����Ʈ
	List<Food> pageS(FoodPagingVO foodPagingVO);
	long countS();
	List<Food> categoryPageS(FoodPagingVO foodPagingVO);
	long categoryCountS(String category);
	List<Food> searchPageS(FoodPagingVO foodPagingVO);
	long searchCountS(String f_name);
	List<Food> priceHighPageS(FoodPagingVO foodPagingVO);
	List<Food> priceLowPageS(FoodPagingVO foodPagingVO);
	//��ǰ ��������
	Food readS(String f_name);
	List<OrderList> bestFoodSelectS();
	long reviewCountS(String f_name);
	long averageStarCountS(String f_name);
	Postscript checkPostscriptS(Postscript script);
	//��ǰ����
	List<QNA> pageQNAS(PagingVO pagingVO);
	long countQNAS(PagingVO pagingVO);
	boolean updateQNAS(QNA qna);
	void insertQNAS(QNA qna);
	//�ı� ����Ʈ
	List<Review> postScriptSelectPerPageS(PagingVO2 pagingVO2);
	long postScriptSelectCountS(String f_name);
	void postScriptInsertS(Review review, String order_idx);
	Review postScriptSelectBySeqS(long rv_idx);
	void postScriptCountUpdateS(Review review);
	//������
	List<Food_detail> selectByFood_detailS(String f_name);
	//�󼼼���(explain)
	List<Food_explain> explainReadS(String f_name);
	// ��� ���� ����Ʈ���� ��� ���� Ȯ��
	String existFnameSelectS(Cart ct);
	boolean updateCartCountS(Cart ct);
	boolean insertCartCountS(Cart ct);
	
	void postscriptDeleteS(Review review);
	void qnaDeleteS(QNA qna);
	
}
