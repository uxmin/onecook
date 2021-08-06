package oc.md.service;

import java.util.HashMap;
import java.util.List;

import oc.md.domain.Cart;
import oc.md.domain.Food;
import oc.md.domain.User_tb;
import oc.md.vo.FoodCartVO;
import oc.md.vo.OrderListVO;
import oc.md.vo.PaymentAddVO;

public interface PaymentService {
	List<Cart> showPaymentPageS(User_tb ut);
	boolean paymentOkS(PaymentAddVO payment, String email);
	// 장바구니
	List<Cart> listS(String email);
	boolean delEachS(long cart_idx);
	boolean delAllS();
	void insertCartS(Cart cart);
	void updateCartS(Cart cart);
	
	HashMap<String, FoodCartVO> getPaymentS(long[] cidxarr);
	List<OrderListVO> paymentResultS(String order_idx);
	void userPointDecreaseS(long use_point, String email);
	boolean fcountDecreaseS(Cart cart);
	long fcountSelectS(Cart cart);
	long selectUserPointS(String email);
	void updateCartCountS(long cidxarr, long cararr);
}
