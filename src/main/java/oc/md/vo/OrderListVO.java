package oc.md.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class OrderListVO {
	private long list_idx;
	private String order_idx;
	private String f_name;
	private long totalcount;
	private String f_type;
	private long f_price;
	private long f_count;
	private String f_sales;
	private String f_weight;
	private String f_origin;
	private String f_package;
	private Date f_date;
	private String f_img;
	private long order_price;
	private long use_point;
}
