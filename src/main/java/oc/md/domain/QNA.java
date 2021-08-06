package oc.md.domain;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class QNA {
	private long q_idx;
	private String email;
	private String f_name;
	private Date q_date;
	private String q_sub;
	private String q_cont;
	private String q_type;
	private String q_reply;
	//
	private String user_name;
}
