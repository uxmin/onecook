package oc.md.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class OrderListDetailVO {
	private String order_idx;
	private String email;
	private String f_type;

}
