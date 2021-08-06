package oc.md.domain;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class OrderList {
	private String order_idx;
	private long list_idx;
	private String f_name;
	private long totalcount;
	private long f_price;
	private String email;
	private Date pay_date;
	private long pay_price;
	private String f_img;
	private long delivery_idx;
	private long delivery_idx_1;
	private Date delivery_date;
	private long delivery_num;
	private String delivery_state;
	
	private String f_type;
	//
	private long ps_exist;
}
