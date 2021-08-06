package oc.md.domain;

import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Review {
	private long rv_idx;
	private String email;
	private String f_name;
	private Date rv_date;
	private String rv_cont;
	private String rv_sub;
	private MultipartFile rv_img_file;
	private String rv_img;
	private long rv_num;
	//
	private String user_name;
	//별(평점)추가
	private long star;
}
