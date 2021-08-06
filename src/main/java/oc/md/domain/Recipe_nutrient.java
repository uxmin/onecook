package oc.md.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Recipe_nutrient {
	private long rn_idx;
	private long rc_idx;
	private String nutrient_nm;
	private long rate;
}
