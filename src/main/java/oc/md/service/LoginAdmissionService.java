package oc.md.service;

import oc.md.domain.User_tb;

public interface LoginAdmissionService {
	public boolean selectCheckEmailS(String email);
	public boolean admissionOkS(User_tb usertb);
	public int loginChkS(User_tb usertb);
	public User_tb getUserInfo(User_tb usertb);
	public User_tb getKakaoUserInfo(String email);
	public String getKakaoUserExist(String email);
	public boolean kAdmissionOkS(User_tb usertb);
}
