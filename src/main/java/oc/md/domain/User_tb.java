package oc.md.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class User_tb {
	private String email;
	private String pw;
	private String user_name;
	private String phone; 		
	private String addr;
	private String addr_no1;
	private String addr_no2;
	private String user_type;
	private long point;
	//카카오 이메일
	private String kakao_email;
}
