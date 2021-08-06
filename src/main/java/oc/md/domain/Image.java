package oc.md.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Image {
	private int img_idx;
	private int rc_idx;
	private String f_name;
	private String img_file;
	private String img_cont;
}
