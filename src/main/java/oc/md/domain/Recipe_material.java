package oc.md.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Recipe_material {
	private int rt_idx;
	private int rc_idx;
	private String f_name;
	private String rt_cont;
}
