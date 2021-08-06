package oc.md.service;

import java.util.HashMap;
import java.util.List;

import oc.md.domain.My_order_list;
import oc.md.domain.OrderList;
import oc.md.domain.Recipe_list;
import oc.md.domain.User_tb;
import oc.md.vo.LastPayDateVO;
import oc.md.vo.MyGoodVo;
import oc.md.vo.OrderListDetailVO;
import oc.md.vo.PagingVO;

public interface MypageService {
	long userPaymentCountS(String email);
	HashMap<String , Object> myDeliveryStates(String email);
	List<LastPayDateVO> lastListPayments(String email);
	List<LastPayDateVO> orderListPaymentS(OrderListDetailVO odetail);
	List<Recipe_list> selectByFood_recipe_listS(PagingVO pagingVo, String email);
	long recipe_list_countS(String email);
	//회원정보수정
	User_tb MypageS(String email);
	void updateS(User_tb user_tb);
	//관리자레시피 좋아요 리스트
	List<MyGoodVo> Good_ManagerS(PagingVO pagingVo, String user_email);
	List<MyGoodVo> Good_Manager_SearchS(PagingVO pagingVo);
	long selectCount_Search(PagingVO pagingVo);
	List<MyGoodVo> Good_Manager_categoryS(PagingVO pagingVo);
	long selectCount_category(PagingVO pagingVo);
	//유저레시피 좋아요 리스트
	List<MyGoodVo> Good_UserS(PagingVO pagingVo, String user_email);
	
	//유저레시피 좋아요 검색 프론트하면서 추가
	List<MyGoodVo> Good_User_SearchS(PagingVO pagingVo);
	long userSelectCount_User_SearchS(PagingVO pagingVo);
	
	//주문리스트
	//추가
	List<My_order_list> MyOrderListS(PagingVO pagingVo, String email);
	List<OrderList> MyOrderList_DetailS(OrderListDetailVO orderlistdetailVo);
	long checkPostscriptCountS(OrderListDetailVO orderlistdetailVo);
	
	// 주문내역 날짜선택
	List<LastPayDateVO> MyOrderListSelectMonthS(PagingVO pagingVo, String email, long month);
	//환불요청
	long selectDeliveryIdxS(String order_idx);
	boolean refundRequestS(long delivery_idx);
	void updateOrderStateS(String order_idx);
}
