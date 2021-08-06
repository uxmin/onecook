package oc.md.mapper;

import java.util.List;

import oc.md.domain.Delivery;
import oc.md.domain.Order_main;
import oc.md.domain.QNA;
import oc.md.domain.Stock_check;
import oc.md.vo.PagingVO;
import oc.md.vo.SalesChkVO;

public interface ManageMapper {
	public List<QNA> selectInquiryPage(PagingVO pagingVO); 
	public long inquiryCount();
	// ī�װ� �˻� 1��1 ����
	public List<QNA> selectCategoryInquiry(PagingVO pagingVO);
	public long inquiryCatCount(PagingVO pagingVO);
	public SalesChkVO todayPayAmount();
	public SalesChkVO userRefundCount();
	public SalesChkVO qnaIsNullCount();
	public SalesChkVO todayPayCount();
	//����Ȯ��(���ϳ� �ִ� ���� ��� Ȯ��)
	public List<SalesChkVO> todayMostSales();
	//���� ���Ϻ� ���� �� Ȯ��(���)
	public List<SalesChkVO> thsMonthMostSales();
	//���ϳ� �� �Ǹűݾ�
	public long todayAllPayment();
	//����Ȯ��(���ϳ� �ִ� ���� ��� �� ��Ÿ��� ��)
	public List<SalesChkVO> etcFood();
	//���� ���Ϻ� Ư�� ���� �������� �� Ȯ��(where ���� Ư�� ���� �Է�)
	public List<SalesChkVO> vartMonthMostSales(String vardate);
	public List<SalesChkVO> varDatePaymentMostSales(String vardate);
	//Ư�� �ְ� ���� Ȯ��
	public List<SalesChkVO> varWeekPaymentMostSales(String vardate);
	public List<SalesChkVO> varWeekMostSales(String vardate);
	//���Ȯ��
	public List<Stock_check> selectByFood_stock_check(PagingVO pagingVO);
	public long selectCount();
	// �ֹ� ���� Ȯ�� �� ����
	public List<Order_main> orderList(PagingVO pagingVO);
	public long count();
	//�ֹ����� ī�װ� ����
	public List<Order_main> orderListSelect(PagingVO pagingVO);
	public long countSelect(String select);
	//��ۿϷ� ��ư����
	public boolean updateDelivery(Delivery delivery);
	//ȯ�ҿ�û ��ư����
	public boolean updateRefundOrder(long delivery_idx);
	public boolean updateRefundDeli(long delivery_idx);
	
	public List<Stock_check> selectByFood_stock_checkS_asc(PagingVO pagingVO);
	public List<Stock_check> selectByFood_stock_checkS_desc(PagingVO pagingVO);
}
