package oc.md.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Recipe_food {
	private String f_name;
	private long f_price;
	private String f_img;
	private long rc_idx;
	private String f_type;
}
