package oc.md.service;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.log4j.Log4j;
import oc.md.domain.User_tb;
import oc.md.mapper.LoginAdmissionMapper;

@Service
@Log4j
public class LoginAdmissionServiceImpl implements LoginAdmissionService {
	@Autowired
	private LoginAdmissionMapper laMapper;
	
	@Override
	public boolean selectCheckEmailS(String email) {
		String chkEmail = laMapper.selectCheckEmail(email);
		
		if(chkEmail == null) {
			return true;
		}
		else {
			return false;
		}
	}
	@Override
	public boolean admissionOkS(User_tb usertb) {
		System.out.println("######### usertb 서비스임플 확인 " + usertb);
		boolean flag = laMapper.admissionOkUser(usertb);
		
		return flag;
	}
	
	@Override
	public int loginChkS(User_tb usertb) {
		User_tb ut = laMapper.selectUserTb(usertb);
		
		if(ut == null) {
			return LoginSet.NO_EMAIL;
		}
		else {
			boolean hashPw = BCrypt.checkpw(usertb.getPw(), ut.getPw());
			if(hashPw == true) {
				return LoginSet.PASS_USER;
			}
			else {
				return LoginSet.NO_PW;
			}
		}
	}
	
	@Override
	public User_tb getUserInfo(User_tb usertb) {
		return laMapper.selectUserTb(usertb);
	}
	
	@Override
	public User_tb getKakaoUserInfo(String email) {
		return laMapper.selectKakaoUserTb(email);
	}
	
	@Override
	public String getKakaoUserExist(String email) {
		return laMapper.getKakaoUser(email);
	}
	
	@Override
	public boolean kAdmissionOkS(User_tb usertb) {
		boolean flag = laMapper.kAdmissionOkUser(usertb);
		
		return flag;
	}

}
