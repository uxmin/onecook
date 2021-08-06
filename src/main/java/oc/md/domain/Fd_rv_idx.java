package oc.md.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Fd_rv_idx {
	private long fd_rv_idx;
	private long rv_idx;
	private String f_name;
	private String email;
	private long star;
}
