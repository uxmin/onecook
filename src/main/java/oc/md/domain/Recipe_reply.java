package oc.md.domain;

import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Recipe_reply {
	private long reply_idx;
	private String email;
	private String user_name;
	private long rc_idx;
	private String reply_cont;
	private Date reply_date;
	private MultipartFile reply_img_file;
	private String reply_img;
	private String reply_sub;
	//레시피 구분 추가
	private String write_gubun;
}
