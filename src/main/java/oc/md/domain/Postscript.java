package oc.md.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Postscript {
	private long pc_idx;
	private long list_idx;
	private String order_idx;
	private String f_name;
	private long ps_exist;
	//
	private String email;
}
