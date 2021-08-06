package oc.md.domain;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Delivery {
	private long delivery_idx;
	private Date delivery_date;
	private long delivery_num;
	private String delivery_state;
}
