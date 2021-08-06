package oc.md.domain;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Good {
	private long good_idx;
	private String email;
	private long rc_idx;
	private Date good_date;
}
