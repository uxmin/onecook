package oc.md.domain;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Order_main {
	private String order_idx;
	private long delivery_idx;
	private Date order_date;
	private long order_price;
	private long use_point;
	private long order_state;
	private String order_addr;
	//Ãß°¡
	private String email;
	private Date pay_date;
	private String delivery_state;
	private long delivery_num;
}
