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
	//���� ���Ϻ� ���� �� Ȯ��(���)
	@Override
	public List<SalesChkVO> thsMonthMostSalesS(){
		return mapper.thsMonthMostSales();
	}
	//���ϳ� �� �Ǹűݾ�
	public long todayAllPaymentS() {
		return mapper.todayAllPayment();
	}
	//����Ȯ��(���ϳ� �ִ� ���� ��� �� ��Ÿ��� ��)
	public List<SalesChkVO> etcFoodS() {
		return mapper.etcFood();
	}
	//���� ���Ϻ� Ư�� ���� �������� �� Ȯ��(where ���� Ư�� ���� �Է�)
	public List<SalesChkVO> vartMonthMostSalesS(String vardate){
		return mapper.vartMonthMostSales(vardate);
	}
	//Ư�� ���� ���� �ݾ� Ȯ���ϱ�(where ���� Ư�� ���� �Է�)
	public List<SalesChkVO> varDatePaymentMostSalesS(String vardate){
		return mapper.varDatePaymentMostSales(vardate);
	}
	//Ư��  �ְ� ���� �ݾ� Ȯ��
	public List<SalesChkVO> varWeekPaymentMostSalesS(String vardate){
		return mapper.varWeekPaymentMostSales(vardate);
	}
	public List<SalesChkVO> varWeekMostSalesS(String vardate){
		return mapper.varWeekMostSales(vardate);
	}
	//���Ȯ��
	@Override
	public List<Stock_check> selectByFood_stock_checkS(PagingVO pagingVO) {
		List<Stock_check> list = mapper.selectByFood_stock_check(pagingVO);
		return list;
	}

	@Override
	public long selectCountS() {
		return mapper.selectCount();
	}
	// �ֹ� ���� Ȯ�� �� ����
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
		delivery.setDelivery_state("�����");
		
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
