package oc.md.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Recipe_detail {
	private long img_idx;
	private long rc_idx;
	private String f_name;
	private String img_file;
	private String img_cont;
	private String rc_title;
}
