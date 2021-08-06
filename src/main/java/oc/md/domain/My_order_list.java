package oc.md.domain;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class My_order_list {
	private String order_idx;
	private Date order_date;
	private long use_point;
	private String delivery_state;
	private String order_idx_1;
	private String email;
	private Date pay_date;
	private long pay_price;
	private String pay_type;
	private String sale_type;
	
	
}
