package oc.md.mapper;

import java.util.HashMap;
import java.util.List;

import oc.md.domain.Cart;
import oc.md.domain.Food;
import oc.md.domain.User_tb;
import oc.md.vo.FoodCartVO;
import oc.md.vo.FoodPagingVO;
import oc.md.vo.OrderListVO;
import oc.md.vo.PaymentAddVO;

public interface PaymentMapper {
	public List<Cart> showPaymentPage(User_tb ut);
	public void updateCartCount(HashMap<String, Object> query);
	public boolean insertDelivery(PaymentAddVO payment);
	public boolean insertOrderMain(PaymentAddVO payment);
	public boolean insertPayment(PaymentAddVO payment);
	public void insertOrderList(Cart cart);
	//후기 유무 추가
	public void insertPostScriptList(Cart cart);
	public void deleteCartList(Cart cart);
	//장바구니
	public List<Cart> list(String email);
	public boolean delEach(long cart_idx);
	public boolean delAll();
	public void insertCart(Cart cart);
	public void updateCart(Cart cart);
	
	public FoodCartVO getPayment(long cidxarr);
	//결제 결과 페이지
	public List<OrderListVO> paymentResult(String order_idx);
	public void userPointDecrease(HashMap<String, Object> query);
	public boolean fcountDecrease(Cart cart);
	public long fcountSelect(Cart cart);
	public long selectUserPoint(String email);
}
