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
		//���°��� �ش��ϴ� ��� ���� ����ֱ� ���� hashmap
		HashMap<String, Object> query = new HashMap<String, Object>();
		//���°��� �־ sql select
		List<String> delivery_st_name = new ArrayList<String>();
		delivery_st_name.add("�����Ϸ�");
		delivery_st_name.add("��ǰ�غ���");
		delivery_st_name.add("�����");
		delivery_st_name.add("��ۿϷ�");
		delivery_st_name.add("ȯ�ҿ�û��");
		delivery_st_name.add("ȯ�ҿϷ�");
		
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
	//���� �� ������ ����Ʈ ī��Ʈ
	@Override
	public long recipe_list_countS(String email) {
		return mapper.recipe_list_count(email);
	}
	//ȸ����������
	@Override
	public User_tb MypageS(String email) {
		return mapper.Mypage(email);
	}
	@Override
	public void updateS(User_tb user_tb) {
		mapper.update(user_tb);
	}
	//�����ڷ����� ���ƿ� ����Ʈ
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
	//�˻�
	@Override
	public List<MyGoodVo> Good_Manager_SearchS(PagingVO pagingVo){
		return mapper.Good_Manager_Search(pagingVo);
	}
	@Override
	public long selectCount_Search(PagingVO pagingVo) {
		return mapper.selectCount_Search(pagingVo);
	}
	//ī�װ�
	@Override
	public List<MyGoodVo> Good_Manager_categoryS(PagingVO pagingVo){
		return mapper.Good_Manager_category(pagingVo);
	}
	@Override
	public long selectCount_category(PagingVO pagingVo) {
		return mapper.selectCount_category(pagingVo);
	}
	//���������� ���ƿ� ����Ʈ
	@Override
	public List<MyGoodVo> Good_UserS(PagingVO pagingVo, String user_email) {
		HashMap<String, Object> query = new HashMap<String, Object>();
		query.put("user_email", user_email.trim());
		query.put("page", pagingVo);
		pagingVo.setTotal(mapper.GdUserSelectCount(query));
		List<MyGoodVo> list = mapper.Good_User(query);
		return list;
	}
	
	//���������� ���ƿ� �˻� (����Ʈ�ϸ鼭 �߰�)
	@Override
	public List<MyGoodVo> Good_User_SearchS(PagingVO pagingVo){
		return mapper.Good_User_Search(pagingVo);
	}	
	@Override
	public long userSelectCount_User_SearchS(PagingVO pagingVo) {
		return mapper.userSelectCount_User_Search(pagingVo);
	}
	
	//�ֹ�����Ʈ
	//�߰�
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
	// �ı��ۼ� Ȯ��(1���̳�)
	@Override
	public long checkPostscriptCountS(OrderListDetailVO orderlistdetailVo) {
		return mapper.checkPostscriptCount(orderlistdetailVo);
	}

	// �ֹ����� ��¥����
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

	//ȯ�ҿ�û
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
