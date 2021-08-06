package oc.md.service;

import java.util.List;

import oc.md.domain.Delivery;
import oc.md.domain.Order_main;
import oc.md.domain.QNA;
import oc.md.domain.Stock_check;
import oc.md.vo.PagingVO;
import oc.md.vo.SalesChkVO;

public interface ManageService {
	// ���� 1��1 ����
	List<QNA> selectInquiryPageS(PagingVO pagingVO);
	long inquiryCountS();
	// ī�װ� �˻� 1��1 ����
	List<QNA> selectCategoryInquiryS(PagingVO pagingVO);
	long inquiryCatCountS(PagingVO pagingVO);
	SalesChkVO todayPayCountS();
	SalesChkVO todayPayAmountS();
	SalesChkVO userRefundCountS();
	SalesChkVO qnaIsNullCountS();
	//����Ȯ��(���ϳ� �ִ� ���� ��� Ȯ��)
	List<SalesChkVO> todayMostSalesS();
	//����Ȯ��(���ϳ� �ִ� ���� ��� �� ��Ÿ��� ��)
	List<SalesChkVO> etcFoodS();
	//���� ���Ϻ� ���� �� Ȯ��(���)
	List<SalesChkVO> thsMonthMostSalesS();
	//���ϳ� �� �Ǹűݾ�
	long todayAllPaymentS();
	//���� ���Ϻ� Ư�� ���� �������� �� Ȯ��(where ���� Ư�� ���� �Է�)
	List<SalesChkVO> vartMonthMostSalesS(String vardate);
	//Ư�� ���� ���� �ݾ� Ȯ���ϱ�(where ���� Ư�� ���� �Է�)
	List<SalesChkVO> varDatePaymentMostSalesS(String vardate);
	//Ư��  �ְ� ���� �ݾ� Ȯ��
	List<SalesChkVO> varWeekPaymentMostSalesS(String vardate);
	List<SalesChkVO> varWeekMostSalesS(String vardate);
	//���Ȯ��
	List<Stock_check> selectByFood_stock_checkS(PagingVO pagingVO);
	long selectCountS();
	// �ֹ� ���� Ȯ�� �� ����
	List<Order_main> orderListS(PagingVO pagingVO);
	long countS();
	List<Order_main> orderListSelectS(PagingVO pagingVO);
	long countSelectS(String select);
	boolean updateDeliveryS(Delivery delivery);
	boolean updateRefundS(long delivery_idx);
	//����������
	List<Stock_check> selectByFood_stock_checkS_asc(PagingVO pagingVO);
	List<Stock_check> selectByFood_stock_checkS_desc(PagingVO pagingVO);
}
