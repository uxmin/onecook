package oc.md.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class LastPayDateVO {
	private long list_idx;
	private long totalcount;
	private String order_idx;
	private String f_name;
	private Date order_date;
	private String order_addr;
	private long use_point;
	private String delivery_state;
	private String email;
	private long f_price;
	private long pay_price;
	private String f_img;
	private String f_type;
	private long month;
}
