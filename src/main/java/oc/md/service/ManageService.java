package oc.md.service;

import java.util.List;

import oc.md.domain.Delivery;
import oc.md.domain.Order_main;
import oc.md.domain.QNA;
import oc.md.domain.Stock_check;
import oc.md.vo.PagingVO;
import oc.md.vo.SalesChkVO;

public interface ManageService {
	// 메인 1대1 문의
	List<QNA> selectInquiryPageS(PagingVO pagingVO);
	long inquiryCountS();
	// 카테고리 검색 1대1 문의
	List<QNA> selectCategoryInquiryS(PagingVO pagingVO);
	long inquiryCatCountS(PagingVO pagingVO);
	SalesChkVO todayPayCountS();
	SalesChkVO todayPayAmountS();
	SalesChkVO userRefundCountS();
	SalesChkVO qnaIsNullCountS();
	//매출확인(당일날 최대 매출 재료 확인)
	List<SalesChkVO> todayMostSalesS();
	//매출확인(당일날 최대 매출 재료 의 기타등등 수)
	List<SalesChkVO> etcFoodS();
	//월별 요일별 매출 수 확인(당월)
	List<SalesChkVO> thsMonthMostSalesS();
	//당일날 총 판매금액
	long todayAllPaymentS();
	//월별 요일별 특정 월의 월별매출 수 확인(where 절로 특정 월을 입력)
	List<SalesChkVO> vartMonthMostSalesS(String vardate);
	//특정 달의 매출 금액 확인하기(where 절로 특정 월을 입력)
	List<SalesChkVO> varDatePaymentMostSalesS(String vardate);
	//특정  주간 매출 금액 확인
	List<SalesChkVO> varWeekPaymentMostSalesS(String vardate);
	List<SalesChkVO> varWeekMostSalesS(String vardate);
	//재고확인
	List<Stock_check> selectByFood_stock_checkS(PagingVO pagingVO);
	long selectCountS();
	// 주문 상태 확인 및 변경
	List<Order_main> orderListS(PagingVO pagingVO);
	long countS();
	List<Order_main> orderListSelectS(PagingVO pagingVO);
	long countSelectS(String select);
	boolean updateDeliveryS(Delivery delivery);
	boolean updateRefundS(long delivery_idx);
	//재고수량정렬
	List<Stock_check> selectByFood_stock_checkS_asc(PagingVO pagingVO);
	List<Stock_check> selectByFood_stock_checkS_desc(PagingVO pagingVO);
}
