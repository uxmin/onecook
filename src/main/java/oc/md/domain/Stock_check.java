package oc.md.domain;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Stock_check {
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
	
}
