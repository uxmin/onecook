package oc.md.domain;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Recipe {
	private long rc_idx;
	private String email;
	private String user_type;
	private String rc_title;
	private String rc_type;
	private long rc_num;
	private Date rc_date;
	private String rc_img;
	private long g_count;
	//
	private String good_email;
	private String kakao_email;
}
