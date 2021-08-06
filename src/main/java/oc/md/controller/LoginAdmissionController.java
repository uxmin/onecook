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
	static String chkDice = "";	//������ȣ �񱳸� ���� ���� ����
	
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
		int dice = r.nextInt(4589362) + 49311; //�̸��Ϸ� �޴� �����ڵ� �κ� (����)
		//log.info("################# dice" + dice);
        String setfrom = "onecook93@gmail.com";
        String tomail = request.getParameter("email"); // �޴� ��� �̸���
        String title = "ȸ������ ���� �̸��� �Դϴ�."; // ����
        String content =
	        System.getProperty("line.separator")+ //���پ� �ٰ����� �α����� �ۼ� 
	        System.getProperty("line.separator")+    
	        "�ȳ��ϼ��� ȸ���� onecook�� ã���ּż� �����մϴ�"
	        +System.getProperty("line.separator")+
	        System.getProperty("line.separator")+
	        " ������ȣ�� " +dice+ " �Դϴ�. "
	        +System.getProperty("line.separator")+
	        System.getProperty("line.separator")+
	        "������ ������ȣ�� Ȩ�������� �Է��� �ֽø� �˴ϴ�."; // ����
        
        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
            messageHelper.setFrom(setfrom); // �����»�� �����ϸ� �����۵��� ����
            messageHelper.setTo(tomail); // �޴»�� �̸���
            messageHelper.setSubject(title); // ���������� ������ �����ϴ�
            messageHelper.setText(content); // ���� ����
            
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
        out_email.println("swal('�̸����� �߼۵Ǿ����. ������ȣ�� �Է����ּ���.');");
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
		ut.setPw(BCrypt.hashpw(usertb.getPw().trim(), BCrypt.gensalt()));	//Bcrypt����
		ut.setUser_name(usertb.getUser_name().trim());
		ut.setPhone(usertb.getPhone().trim());
		ut.setAddr(usertb.getAddr_no1() + " " + usertb.getAddr_no2());
		ut.setUser_type("MEMBER");
		ut.setPoint(0);
		
		log.info("############## ut ��Ʈ�ѷ� Ȯ�� : " + ut);
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
		//�α��� ����
		if(passCheck == LoginSet.PASS_USER) {
			ModelAndView mv = new ModelAndView("login_admission/loginMessage", "passCheck", passCheck);
			
			HttpSession session = request.getSession();
			User_tb ut = laService.getUserInfo(usertb);
			session.setAttribute("loginUser", ut);
			session.setAttribute("email", ut.getEmail());
			
			return mv;
		}
		// ���̵� ���� Ȥ�� ��й�ȣ Ʋ�� 
		else {
			return new ModelAndView("login_admission/loginMessage", "passCheck", passCheck);
		}
	}
	
	@PostMapping("kakaoLoginChk.do")
	public ModelAndView kakaoLoginChk(String kakao, HttpSession session) {
		JsonParser parser = new JsonParser();
		JsonElement element = parser.parse(kakao); //īī���α����� ������ json������ element
		JsonObject jObj = (JsonObject)element;	//īī���α����� ������ json������ object
		ModelAndView mv = new ModelAndView();
		
//		log.info("####################### parser : " + parser);
//		log.info("####################### element : " + element);
//		log.info("####################### jObj : " + jObj);
		log.info("####################### kakao_account : "+ jObj.getAsJsonObject("kakao_account"));
		log.info("####################### properties : "+ jObj.getAsJsonObject("properties"));
//		log.info("####################### jObj.id : "+  jObj.getAsJsonObject().get("id"));
		
		// �α����� ������ īī�� ���̵�(���°� ���ڷ� �Ҵ�Ǿ� �ִ�.)
		String k_userId = jObj.getAsJsonObject().get("id").getAsString();	
		
		String kakaoExist = laService.getKakaoUserExist(k_userId);
		log.info("############## kakaoExist : " + kakaoExist);
		//īī�� ���̵� �������� ���� ���
		if(kakaoExist == null) {
			//log.info("################### k_userId : "+ kakaoExist);
			mv = new ModelAndView("login_admission/kakaoAdmission", "jObj", jObj);
			return mv;
		}
		//īī�� ���̵� ������ ���
		else {
			log.info("########### ���̵� ���� : " + kakaoExist);
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
		
		log.info("############## ut ��Ʈ�ѷ� Ȯ�� : " + ut);
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
