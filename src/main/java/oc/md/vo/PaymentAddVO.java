package oc.md.vo;

import java.sql.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import oc.md.domain.Cart;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class PaymentAddVO {
	private String order_idx;
	private String email;
	private Date pay_date;	
	private long pay_price;
	private String pay_type;
	private String sale_type;
	private long order_price;
	private long use_point;
	private String order_state;
	private String order_addr;
	private List<Cart> food;	//주문한 재료명칭과 재료의 개수를 담아준다
	//배송 PK 번호
	private long delivery_idx;
}
