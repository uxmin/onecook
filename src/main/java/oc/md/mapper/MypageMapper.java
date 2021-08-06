package oc.md.mapper;

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

public interface MypageMapper {
	public long userPaymentCount(String email);
	public long myDeliveryState(HashMap<String, Object> h);
	public List<LastPayDateVO> lastListPayment(String email);
	public List<LastPayDateVO> orderListPayment(OrderListDetailVO odetails);
	//������������ ���
	public List<Recipe_list> selectByFood_recipe_list(HashMap<String, Object> query);
	//<Recipe_list> selectByFood_recipe_listS(@Param(value = "start") String start, @Param(value = "end") String end, @Param(value = "email") String email);
	public long selectCount(HashMap<String, Object> query);
	public long recipe_list_count(String email);
	//ȸ����������
	public User_tb Mypage(String email);
	public void update(User_tb user_tb);
	//�����ڷ����� ���ƿ�
	public List<MyGoodVo> Good_Manager(HashMap<String, Object> query);
	public long GdManagerSelectCount(HashMap<String, Object> query);
	public List<MyGoodVo> Good_Manager_Search(PagingVO pagingVo);
	public long selectCount_Search(PagingVO pagingVo);
	public List<MyGoodVo> Good_Manager_category(PagingVO pagingVo);
	public long selectCount_category(PagingVO pagingVo);
	//���������� ���ƿ�
	public List<MyGoodVo> Good_User(HashMap<String, Object> query);
	public long GdUserSelectCount(HashMap<String, Object> query);
	
	
	//���� ������ ���ƿ� �˻� ����Ʈ�ϸ鼭 �߰�
	public List<MyGoodVo> Good_User_Search(PagingVO pagingVo);
	long userSelectCount_User_Search(PagingVO pagingVo);
	
	//�ֹ�����Ʈ
	//2�� �߰�
	public List<My_order_list> MyOrderList(HashMap<String, Object> query);
	long selectCount_MyOrderlist(HashMap<String, Object> query);
	//�ֹ��󼼸���Ʈ
	public List<OrderList> MyOrderList_Detail(OrderListDetailVO orderlistdetailVo);
	public long checkPostscriptCount(OrderListDetailVO orderlistdetailVo);

	//�ֹ����� ��¥����
	public List<LastPayDateVO> MyOrderListSelectMonth(HashMap<String, Object> query);
	public long selectCountMonth(HashMap<String, Object> query);
	
	//ȯ�ҿ�û
	public long selectDeliveryIdx(String order_idx);
	public boolean refundRequest(long delivery_idx);
	public void udateOrderState(String order_idx);
}
