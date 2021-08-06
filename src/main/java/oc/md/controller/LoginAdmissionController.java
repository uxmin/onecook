package oc.md.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import javax.inject.Inject;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.junit.runner.Request;
import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import oc.md.domain.User_tb;
import oc.md.service.LoginAdmissionService;
import oc.md.service.LoginSet;


@Controller
@Log4j
@RequestMapping("/login_admission/*")
@AllArgsConstructor
public class LoginAdmissionController {
	static String chkDice = "";	//인증번호 비교를 위한 변수 선언
	
	private LoginAdmissionService laService;

	@RequestMapping("admission.do")
	public String admissionPg() {
		return "login_admission/admission";
	}
	
	@GetMapping("checkEmail.do")
	public @ResponseBody String checkEmail(String email) {
		email = email.trim();
		boolean flag = laService.selectCheckEmailS(email);
		if(flag) {
			return "emailCheckOk";
		}
		else {
			return "emailCheckFail";
		}
	}
	
	@Inject
	JavaMailSender mailSender;
	
	@GetMapping("auth.do")
	public ModelAndView mailSending(HttpServletRequest request, String email, HttpServletResponse response_email) throws IOException {
//	public String mailSending(HttpServletRequest request, String email, HttpServletResponse response_email) throws IOException {
		Random r = new Random();
		int dice = r.nextInt(4589362) + 49311; //이메일로 받는 인증코드 부분 (난수)
		//log.info("################# dice" + dice);
        String setfrom = "onecook93@gmail.com";
        String tomail = request.getParameter("email"); // 받는 사람 이메일
        String title = "회원가입 인증 이메일 입니다."; // 제목
        String content =
	        System.getProperty("line.separator")+ //한줄씩 줄간격을 두기위해 작성 
	        System.getProperty("line.separator")+    
	        "안녕하세요 회원님 onecook을 찾아주셔서 감사합니다"
	        +System.getProperty("line.separator")+
	        System.getProperty("line.separator")+
	        " 인증번호는 " +dice+ " 입니다. "
	        +System.getProperty("line.separator")+
	        System.getProperty("line.separator")+
	        "받으신 인증번호를 홈페이지에 입력해 주시면 됩니다."; // 내용
        
        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
            messageHelper.setFrom(setfrom); // 보내는사람 생략하면 정상작동을 안함
            messageHelper.setTo(tomail); // 받는사람 이메일
            messageHelper.setSubject(title); // 메일제목은 생략이 가능하다
            messageHelper.setText(content); // 메일 내용
            
            mailSender.send(message);
        } 
        catch (Exception e) {
            System.out.println(e);
        }   
        
        ModelAndView mv = new ModelAndView("login_admission/admission", "dice", dice);
        chkDice = Integer.toString(dice);
        
        System.out.println("mv : "+mv);
	
        response_email.setContentType("text/html; charset=UTF-8");
        PrintWriter out_email = response_email.getWriter();
        out_email.println("swal('이메일이 발송되었어요. 인증번호를 입력해주세요.');");
        out_email.flush();
           
        return mv;
	}
	@GetMapping("auth_check.do")
	public @ResponseBody String mailSendingOk(String email_inCode) {
		//log.info("################ chkdice : " + chkDice);
		//log.info("################ email_incode : " + email_inCode);
		if(email_inCode.equals(chkDice)) {
			chkDice = null;
			return "email_incode_ok";
		}
		else{
			return "email_incode_fail";
		}
	}
	@PostMapping("admission_ok.do")
	public String admissionOk(User_tb usertb) {
		//log.info("################## User_tb : " + usertb);
		User_tb ut = usertb;
		ut.setEmail(usertb.getEmail().trim());
		ut.setPw(BCrypt.hashpw(usertb.getPw().trim(), BCrypt.gensalt()));	//Bcrypt세팅
		ut.setUser_name(usertb.getUser_name().trim());
		ut.setPhone(usertb.getPhone().trim());
		ut.setAddr(usertb.getAddr_no1() + " " + usertb.getAddr_no2());
		ut.setUser_type("MEMBER");
		ut.setPoint(0);
		
		log.info("############## ut 컨트롤러 확인 : " + ut);
		boolean flag = laService.admissionOkS(ut);
		
		if(flag) {
			return "redirect:login.do";
		}
		else {
			return null;
		}
	}
	
	@RequestMapping("login.do")
	public String loginPg(){
		return "login_admission/login";
	}
	
	@PostMapping("loginChk.do")
	public ModelAndView loginChk(User_tb usertb, HttpServletRequest request) {
		//log.info("################ loginChk controller " + usertb);
		int passCheck = laService.loginChkS(usertb);
		//로그인 성공
		if(passCheck == LoginSet.PASS_USER) {
			ModelAndView mv = new ModelAndView("login_admission/loginMessage", "passCheck", passCheck);
			
			HttpSession session = request.getSession();
			User_tb ut = laService.getUserInfo(usertb);
			session.setAttribute("loginUser", ut);
			session.setAttribute("email", ut.getEmail());
			
			return mv;
		}
		// 아이디 없음 혹은 비밀번호 틀림 
		else {
			return new ModelAndView("login_admission/loginMessage", "passCheck", passCheck);
		}
	}
	
	@PostMapping("kakaoLoginChk.do")
	public ModelAndView kakaoLoginChk(String kakao, HttpSession session) {
		JsonParser parser = new JsonParser();
		JsonElement element = parser.parse(kakao); //카카오로그인한 유저의 json형태의 element
		JsonObject jObj = (JsonObject)element;	//카카오로그인한 유저의 json형태의 object
		ModelAndView mv = new ModelAndView();
		
//		log.info("####################### parser : " + parser);
//		log.info("####################### element : " + element);
//		log.info("####################### jObj : " + jObj);
		log.info("####################### kakao_account : "+ jObj.getAsJsonObject("kakao_account"));
		log.info("####################### properties : "+ jObj.getAsJsonObject("properties"));
//		log.info("####################### jObj.id : "+  jObj.getAsJsonObject().get("id"));
		
		// 로그인한 유저의 카카오 아이디(형태가 숫자로 할당되어 있다.)
		String k_userId = jObj.getAsJsonObject().get("id").getAsString();	
		
		String kakaoExist = laService.getKakaoUserExist(k_userId);
		log.info("############## kakaoExist : " + kakaoExist);
		//카카오 아이디가 존재하지 않을 경우
		if(kakaoExist == null) {
			//log.info("################### k_userId : "+ kakaoExist);
			mv = new ModelAndView("login_admission/kakaoAdmission", "jObj", jObj);
			return mv;
		}
		//카카오 아이디가 존재할 경우
		else {
			log.info("########### 아이디 존재 : " + kakaoExist);
			User_tb ut = laService.getKakaoUserInfo(k_userId);

			session.setAttribute("loginUser", ut);
			session.setAttribute("email", ut.getEmail());
			mv = new ModelAndView("login_admission/loginMessageKakao");
			
			return mv;
		}	
	}
	@PostMapping("kAdmission_ok.do")
	public String kAdmissionOk(User_tb usertb, String hdn_jObj) {
		log.info("############## usertb : " + usertb);
		log.info("############## hdn_jObj : " + hdn_jObj);
//		log.info("####################### k jObj : " + (JsonObject)hdn_jObj);
		
		JsonParser parser = new JsonParser();
		JsonElement element = parser.parse(hdn_jObj);
		JsonObject jObj = (JsonObject)element;
		
		log.info("####################### k parser : " + parser);
		log.info("####################### k element : " + element);
		log.info("####################### k jObj : " + jObj);
		log.info("####################### jObj.id : "+  jObj.getAsJsonObject().get("id"));
		log.info("####################### k jObj.nickname : " + jObj.getAsJsonObject("properties").get("nickname").getAsString());
		String k_email = jObj.getAsJsonObject().get("id").getAsString();
		String k_nickname = jObj.getAsJsonObject("properties").get("nickname").getAsString();
		
		User_tb ut = usertb;
		ut.setEmail(k_email.trim());
		ut.setUser_name(k_nickname.trim());
		ut.setPhone(usertb.getPhone().trim());
		ut.setAddr(usertb.getAddr_no1() + " " + usertb.getAddr_no2());
		ut.setUser_type("MEMBER");
		ut.setPoint(0);
		ut.setKakao_email(usertb.getKakao_email());
		
		log.info("############## ut 컨트롤러 확인 : " + ut);
		boolean flag = laService.kAdmissionOkS(ut);
		
		if(flag) {
			return "redirect:login.do";
		}
		else {
			return null;
		}
	}
	@RequestMapping("logout.do")
	public String logout(HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.removeAttribute("loginUser");
		
		return "login_admission/logoutMessage";
	}
}
