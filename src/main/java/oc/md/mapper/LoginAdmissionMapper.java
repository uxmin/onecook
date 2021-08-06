package oc.md.mapper;

import oc.md.domain.User_tb;

public interface LoginAdmissionMapper {
	public String selectCheckEmail(String email);
	public boolean admissionOkUser(User_tb usertb);
	public User_tb selectUserTb(User_tb usertb);
	public User_tb selectKakaoUserTb(String email);
	public String getKakaoUser(String email);
	public boolean kAdmissionOkUser(User_tb usertb);
}
