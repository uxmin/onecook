package oc.md.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class MyGoodVo {
	private String user_email;
	private long rc_idx;
	private Date good_date;
	private String user_name;
	private long rc_idx_1;
	private String email;
	private String user_type;
	private String rc_title;
	private String rc_type;
	private String rc_num;
	private Date rc_date;
	private String rc_img;
}
