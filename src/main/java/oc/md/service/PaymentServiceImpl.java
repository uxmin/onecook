package oc.md.service;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import oc.md.domain.Cart;
import oc.md.domain.Food;
import oc.md.domain.User_tb;
import oc.md.mapper.PaymentMapper;
import oc.md.vo.FoodCartVO;
import oc.md.vo.OrderListVO;
import oc.md.vo.PaymentAddVO;

@Service
public class PaymentServiceImpl implements PaymentService {
	@Autowired
	private PaymentMapper pmapper;
	
	@Override
	public List<Cart> showPaymentPageS(User_tb ut) {
		return pmapper.showPaymentPage(ut);
	}
	@Override
	public void userPointDecreaseS(long use_point, String email) {
		HashMap<String, Object> query = new HashMap<String, Object>();
		query.put("email", email);
		query.put("use_point", use_point);
		
		pmapper.userPointDecrease(query);
	}
	@Override
	public boolean fcountDecreaseS(Cart cart) {
		return pmapper.fcountDecrease(cart);
	}
	@Override
	public long fcountSelectS(Cart cart) {
		return pmapper.fcountSelect(cart);
	}
	@Override
	public void updateCartCountS(long cidxarr, long cararr) {
		HashMap<String, Object> query = new HashMap<String, Object>();
		query.put("cidxarr", cidxarr);
		query.put("cararr", cararr);
		
		pmapper.updateCartCount(query);
	}
	@Override
	@Transactional
	public boolean paymentOkS(PaymentAddVO payment, String email) {
		boolean delivery_flag = pmapper.insertDelivery(payment);
		
		if(delivery_flag) {
			boolean orderM_flag = pmapper.insertOrderMain(payment);
			
			if(orderM_flag) {
				boolean payment_flag = pmapper.insertPayment(payment);
				
				if(payment_flag) {
					
					for(int i=0; i<payment.getFood().size(); i++) {
						System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ payment.getFood().get(i) : " + payment.getFood().get(i));
						pmapper.insertOrderList(payment.getFood().get(i));
						//후기 유무 테이블에 insert
						pmapper.insertPostScriptList(payment.getFood().get(i));	
						// 주문시 장바구니도 비워주는 쿼리
						payment.getFood().get(i).setEmail(email);	//email세팅
						pmapper.deleteCartList(payment.getFood().get(i));
					}
					return true;
				}
				else {
					return false;
				}
			}
			else {
				return false;
			}
		}
		else {
			return false;
		}

	}
	//장바구니
	@Override
	public List<Cart> listS(String email) {
		return pmapper.list(email);
	}
	
	@Override
	public boolean delEachS(long cart_idx) {
		return pmapper.delEach(cart_idx);
	}
	@Override
	public boolean delAllS() {
		return pmapper.delAll();
	}
	
	@Override
	public void insertCartS(Cart cart) {
		pmapper.insertCart(cart);
	}
	@Override
	public void updateCartS(Cart cart) {
		pmapper.updateCart(cart);
	}
	
	@Override
	public HashMap<String, FoodCartVO> getPaymentS(long[] cidxarr){
		HashMap<String, FoodCartVO> query = new HashMap<String, FoodCartVO>();
		List<FoodCartVO> list = new ArrayList<FoodCartVO>();
		List<Map<String, Object>> maplist = new ArrayList<Map<String, Object>>();
		
		for(int i=0; i<cidxarr.length; i++) {
			query.put(Long.toString(i), pmapper.getPayment(cidxarr[i]));
//			list = pmapper.getPayment(cidxarr[i]);
			
//			maplist.add(query);
		}
		
		Collection k = query.values();
		Iterator itr = k.iterator();
		while(itr.hasNext()) {
			System.out.println("##################@@@@@@@@@@@@@@@@@@@ hasNext : " + itr.next());
		}
		
		System.out.println("##################@@@@@@@@@@@@@@@@@@@ query : " + query);
		System.out.println("##################@@@@@@@@@@@@@@@@@@@ list : " + list);
		
		return query;
	}
	
	@Override
	public List<OrderListVO> paymentResultS(String order_idx){
		return pmapper.paymentResult(order_idx);
	}
	
	@Override
	public long selectUserPointS(String email) {
		return pmapper.selectUserPoint(email);
	}

}
