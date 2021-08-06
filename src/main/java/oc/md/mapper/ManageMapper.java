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
	// 카테고리 검색 1대1 문의
	public List<QNA> selectCategoryInquiry(PagingVO pagingVO);
	public long inquiryCatCount(PagingVO pagingVO);
	public SalesChkVO todayPayAmount();
	public SalesChkVO userRefundCount();
	public SalesChkVO qnaIsNullCount();
	public SalesChkVO todayPayCount();
	//매출확인(당일날 최대 매출 재료 확인)
	public List<SalesChkVO> todayMostSales();
	//월별 요일별 매출 수 확인(당월)
	public List<SalesChkVO> thsMonthMostSales();
	//당일날 총 판매금액
	public long todayAllPayment();
	//매출확인(당일날 최대 매출 재료 의 기타등등 수)
	public List<SalesChkVO> etcFood();
	//월별 요일별 특정 월의 월별매출 수 확인(where 절로 특정 월을 입력)
	public List<SalesChkVO> vartMonthMostSales(String vardate);
	public List<SalesChkVO> varDatePaymentMostSales(String vardate);
	//특정 주간 매출 확인
	public List<SalesChkVO> varWeekPaymentMostSales(String vardate);
	public List<SalesChkVO> varWeekMostSales(String vardate);
	//재고확인
	public List<Stock_check> selectByFood_stock_check(PagingVO pagingVO);
	public long selectCount();
	// 주문 상태 확인 및 변경
	public List<Order_main> orderList(PagingVO pagingVO);
	public long count();
	//주문상태 카테고리 선택
	public List<Order_main> orderListSelect(PagingVO pagingVO);
	public long countSelect(String select);
	//배송완료 버튼선택
	public boolean updateDelivery(Delivery delivery);
	//환불요청 버튼선택
	public boolean updateRefundOrder(long delivery_idx);
	public boolean updateRefundDeli(long delivery_idx);
	
	public List<Stock_check> selectByFood_stock_checkS_asc(PagingVO pagingVO);
	public List<Stock_check> selectByFood_stock_checkS_desc(PagingVO pagingVO);
}
