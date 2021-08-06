package oc.md.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Cart {
	private long cart_idx;
	private String email;
	private String f_name;
	private long cart_count;
	//
	private String order_idx;
	//
	private long f_price;
	private String f_type;
	private String f_img;
}
