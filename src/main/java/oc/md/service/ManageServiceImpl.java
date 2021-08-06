package oc.md.service;

import java.util.List;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import oc.md.domain.Delivery;
import oc.md.domain.Order_main;
import oc.md.domain.QNA;
import oc.md.domain.Stock_check;
import oc.md.mapper.ManageMapper;
import oc.md.vo.PagingVO;
import oc.md.vo.SalesChkVO;

@Service
public class ManageServiceImpl implements ManageService {
	@Autowired
	private ManageMapper mapper;
	
	@Override
	public List<QNA> selectInquiryPageS(PagingVO pagingVO) {
		return mapper.selectInquiryPage(pagingVO);
	}
	
	@Override
	public long inquiryCountS() {
		return mapper.inquiryCount();
	}
	
	@Override
	public 	List<QNA> selectCategoryInquiryS(PagingVO pagingVO){
		return mapper.selectCategoryInquiry(pagingVO);
	}
	
	@Override
	public long inquiryCatCountS(PagingVO pagingVO) {
		return mapper.inquiryCatCount(pagingVO);
	}
	@Override
	public SalesChkVO todayPayAmountS() {
		return mapper.todayPayAmount();
	}
	@Override
	public SalesChkVO userRefundCountS() {
		return mapper.userRefundCount();
	}
	@Override
	public SalesChkVO qnaIsNullCountS() {
		return mapper.qnaIsNullCount();
	}
	@Override
	public SalesChkVO todayPayCountS() {
		return mapper.todayPayCount();
	}
	
	@Override
	public List<SalesChkVO> todayMostSalesS(){
		return mapper.todayMostSales();
	}
	//월별 요일별 매출 수 확인(당월)
	@Override
	public List<SalesChkVO> thsMonthMostSalesS(){
		return mapper.thsMonthMostSales();
	}
	//당일날 총 판매금액
	public long todayAllPaymentS() {
		return mapper.todayAllPayment();
	}
	//매출확인(당일날 최대 매출 재료 의 기타등등 수)
	public List<SalesChkVO> etcFoodS() {
		return mapper.etcFood();
	}
	//월별 요일별 특정 월의 월별매출 수 확인(where 절로 특정 월을 입력)
	public List<SalesChkVO> vartMonthMostSalesS(String vardate){
		return mapper.vartMonthMostSales(vardate);
	}
	//특정 달의 매출 금액 확인하기(where 절로 특정 월을 입력)
	public List<SalesChkVO> varDatePaymentMostSalesS(String vardate){
		return mapper.varDatePaymentMostSales(vardate);
	}
	//특정  주간 매출 금액 확인
	public List<SalesChkVO> varWeekPaymentMostSalesS(String vardate){
		return mapper.varWeekPaymentMostSales(vardate);
	}
	public List<SalesChkVO> varWeekMostSalesS(String vardate){
		return mapper.varWeekMostSales(vardate);
	}
	//재고확인
	@Override
	public List<Stock_check> selectByFood_stock_checkS(PagingVO pagingVO) {
		List<Stock_check> list = mapper.selectByFood_stock_check(pagingVO);
		return list;
	}

	@Override
	public long selectCountS() {
		return mapper.selectCount();
	}
	// 주문 상태 확인 및 변경
	@Override
	public List<Order_main> orderListS(PagingVO pagingVO){
		return mapper.orderList(pagingVO);
	}
	@Override
	public long countS(){
		return mapper.count();
	}
	
	@Override
	public List<Order_main> orderListSelectS(PagingVO pagingVO){
		return mapper.orderListSelect(pagingVO);
	}
	@Override
	public long countSelectS(String select){
		return mapper.countSelect(select);
	}
	
	@Override
	public boolean updateDeliveryS(Delivery delivery) {
		Random rd = new Random();
		int rdInt = rd.nextInt(99999999);
		long rdLong = (long)rdInt;
		
		delivery.setDelivery_num(rdLong);
		delivery.setDelivery_state("배송중");
		
		return mapper.updateDelivery(delivery);
	}
	
	@Override
	public boolean updateRefundS(long delivery_idx) {
		mapper.updateRefundOrder(delivery_idx);
		mapper.updateRefundDeli(delivery_idx);
		return true;
	}
	
	@Override
	public List<Stock_check> selectByFood_stock_checkS_asc(PagingVO pagingVO){
		List<Stock_check> listASC = mapper.selectByFood_stock_checkS_asc(pagingVO);
		return listASC;
	}
	@Override
	public List<Stock_check> selectByFood_stock_checkS_desc(PagingVO pagingVO){
		List<Stock_check> listDESC = mapper.selectByFood_stock_checkS_desc(pagingVO);
		return listDESC;
	}
}
