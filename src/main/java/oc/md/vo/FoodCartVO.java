package oc.md.vo;

import java.util.Date;
import java.util.List;

import lombok.NoArgsConstructor;

import lombok.AllArgsConstructor;

import lombok.Data;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class FoodCartVO {
	private String f_name;
	private String f_type;
	private long f_price;
	private long f_count;
	private String f_sales;
	private String f_weight;
	private String f_origin;
	private String f_package;
	private Date f_date;
	private String f_img;
	//cart
	private long cart_idx;
	private String email;
	private long cart_count;
}
