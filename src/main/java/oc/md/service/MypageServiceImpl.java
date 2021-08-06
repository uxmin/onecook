package oc.md.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import oc.md.domain.My_order_list;
import oc.md.domain.OrderList;
import oc.md.domain.Recipe_list;
import oc.md.domain.User_tb;
import oc.md.mapper.MypageMapper;
import oc.md.vo.LastPayDateVO;
import oc.md.vo.MyGoodVo;
import oc.md.vo.OrderListDetailVO;
import oc.md.vo.PagingVO;

@Service
public class MypageServiceImpl implements MypageService {	
	@Autowired
	private MypageMapper mapper;
	
	@Override
	public long userPaymentCountS(String email) {
		return mapper.userPaymentCount(email);
	}
	
	@Override
	public HashMap<String , Object> myDeliveryStates(String email){
		//상태값에 해당하는 결과 수를 담아주기 위한 hashmap
		HashMap<String, Object> query = new HashMap<String, Object>();
		//상태값을 넣어서 sql select
		List<String> delivery_st_name = new ArrayList<String>();
		delivery_st_name.add("결제완료");
		delivery_st_name.add("상품준비중");
		delivery_st_name.add("배송중");
		delivery_st_name.add("배송완료");
		delivery_st_name.add("환불요청중");
		delivery_st_name.add("환불완료");
		
		for(int i=0; i<delivery_st_name.size(); i++) {
			HashMap<String, Object> h = new HashMap<String, Object>();
			h.put("delivery_state", delivery_st_name.get(i));
			h.put("email", email);
			long delivery_st_count = mapper.myDeliveryState(h);
			query.put((i+1)+"."+ delivery_st_name.get(i), delivery_st_count);
		}
		
		return query;
	}
	
	@Override
	public List<LastPayDateVO> lastListPayments(String email){
		return mapper.lastListPayment(email);
	}
	
	@Override
	public List<LastPayDateVO> orderListPaymentS(OrderListDetailVO odetail){
		return mapper.orderListPayment(odetail);
	}
	
	@Override
	public List<Recipe_list> selectByFood_recipe_listS(PagingVO pagingVo, String email) {
		HashMap<String, Object> query = new HashMap<String, Object>();
		query.put("email", email.trim());
		query.put("page", pagingVo);
		pagingVo.setTotal(mapper.selectCount(query));
		List<Recipe_list> list = mapper.selectByFood_recipe_list(query);
		return list;
	}
	//내가 쓴 레시피 리스트 카운트
	@Override
	public long recipe_list_countS(String email) {
		return mapper.recipe_list_count(email);
	}
	//회원정보수정
	@Override
	public User_tb MypageS(String email) {
		return mapper.Mypage(email);
	}
	@Override
	public void updateS(User_tb user_tb) {
		mapper.update(user_tb);
	}
	//관리자레시피 좋아요 리스트
	@Override
	public List<MyGoodVo> Good_ManagerS(PagingVO pagingVo, String user_email) {
		HashMap<String, Object> query = new HashMap<String, Object>();
		query.put("user_email", user_email.trim());
		query.put("page", pagingVo);
		pagingVo.setTotal(mapper.GdManagerSelectCount(query));
		System.out.println("$$$$$$$$$$$$$$$$"+query);
		List<MyGoodVo> list = mapper.Good_Manager(query);
		System.out.println("^^^^^^^^^^^^^^^^^^^^^"+list);
		return list;
	}
	//검색
	@Override
	public List<MyGoodVo> Good_Manager_SearchS(PagingVO pagingVo){
		return mapper.Good_Manager_Search(pagingVo);
	}
	@Override
	public long selectCount_Search(PagingVO pagingVo) {
		return mapper.selectCount_Search(pagingVo);
	}
	//카테고리
	@Override
	public List<MyGoodVo> Good_Manager_categoryS(PagingVO pagingVo){
		return mapper.Good_Manager_category(pagingVo);
	}
	@Override
	public long selectCount_category(PagingVO pagingVo) {
		return mapper.selectCount_category(pagingVo);
	}
	//유저레시피 좋아요 리스트
	@Override
	public List<MyGoodVo> Good_UserS(PagingVO pagingVo, String user_email) {
		HashMap<String, Object> query = new HashMap<String, Object>();
		query.put("user_email", user_email.trim());
		query.put("page", pagingVo);
		pagingVo.setTotal(mapper.GdUserSelectCount(query));
		List<MyGoodVo> list = mapper.Good_User(query);
		return list;
	}
	
	//유저레시피 좋아요 검색 (프론트하면서 추가)
	@Override
	public List<MyGoodVo> Good_User_SearchS(PagingVO pagingVo){
		return mapper.Good_User_Search(pagingVo);
	}	
	@Override
	public long userSelectCount_User_SearchS(PagingVO pagingVo) {
		return mapper.userSelectCount_User_Search(pagingVo);
	}
	
	//주문리스트
	//추가
	@Override
	public List<My_order_list> MyOrderListS(PagingVO pagingVo, String email) {
		HashMap<String, Object> query = new HashMap<String, Object>();
		query.put("email", email.trim());
		query.put("page", pagingVo);
		pagingVo.setTotal(mapper.selectCount_MyOrderlist(query));
		List<My_order_list> list = mapper.MyOrderList(query);
		return list;
	}
	@Override
	public List<OrderList> MyOrderList_DetailS(OrderListDetailVO orderlistdetailVo){
		List<OrderList> detail = mapper.MyOrderList_Detail(orderlistdetailVo);
		return detail;
	}
	// 후기작성 확인(1달이내)
	@Override
	public long checkPostscriptCountS(OrderListDetailVO orderlistdetailVo) {
		return mapper.checkPostscriptCount(orderlistdetailVo);
	}

	// 주문내역 날짜선택
	@Override
	public List<LastPayDateVO> MyOrderListSelectMonthS(PagingVO pagingVo, String email, long month){
		HashMap<String, Object> query = new HashMap<String, Object>();
		query.put("email", email.trim());
		query.put("page", pagingVo);
		query.put("month", month);
		pagingVo.setTotal(mapper.selectCountMonth(query));
		List<LastPayDateVO> list = mapper.MyOrderListSelectMonth(query);
		return list;		
	}

	//환불요청
	@Override
	public long selectDeliveryIdxS(String order_idx) {
		return mapper.selectDeliveryIdx(order_idx);
	}
	@Override
	public boolean refundRequestS(long delivery_idx) {
		return mapper.refundRequest(delivery_idx);
	}
	@Override
	public void updateOrderStateS(String order_idx) {
		mapper.udateOrderState(order_idx);
	}
}
