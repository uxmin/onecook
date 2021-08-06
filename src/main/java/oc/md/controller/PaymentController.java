package oc.md.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import lombok.extern.log4j.Log4j;
import net.sf.json.JSON;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import oc.md.domain.Cart;
import oc.md.domain.Food;
import oc.md.domain.User_tb;
import oc.md.service.PaymentService;
import oc.md.vo.FoodCartVO;
import oc.md.vo.OrderListVO;
import oc.md.vo.PaymentAddVO;

@Controller
@Log4j
@RequestMapping("/pay/*")
public class PaymentController {
	@Autowired
	private PaymentService pservice;
	
	//�ٷ� ���� ������
	@GetMapping("paymentPage.do")
	public ModelAndView paymentPageGet(FoodCartVO foodCartVO, HttpSession session) {	//���Ŀ� ��ٱ���, �ٷ� ������ �ؼ� �Ѿ ��� �ش� ������ ������ ��� �Ķ���͸� �޾ƿ���  �κ��� �߰��ۼ� ������Ѵ�
		User_tb ut = (User_tb)session.getAttribute("loginUser");
		
		log.info("################# loginUser : " + ut);
		log.info("################# FoodCartVO : " +foodCartVO);
		
		List<FoodCartVO> flist = new ArrayList<FoodCartVO>();
		flist.add(foodCartVO);
		long all_price = 0;	//�� ������ ����ֱ� ���� ����
	
		ModelAndView mv = new ModelAndView("pay/paymentPage");
		mv.addObject("foodCart", flist);
		mv.addObject("all_price", all_price);
		
		return mv;
	}

//	//��ٱ��� ���� ������
//	@PostMapping("paymentPage.do")
//	@ResponseBody
//	public ModelAndView paymentPagePost(@RequestBody String food, HttpSession session) {
////	public ModelAndView paymentPagePost(@RequestBody  Map<String, Object> param) {
//		log.info("###################### json FoodCartVO Ȯ�� : " + food);
//		
//		
//		JsonParser jsonParse = new JsonParser();
//		JsonObject jsonObj = (JsonObject) jsonParse.parse(food);
//		//JSONObject���� PersonsArray�� get�Ͽ� JSONArray�� �����Ѵ�. 
//		JsonArray personArray = (JsonArray) jsonObj.get("food");
//		log.info("####################### JsonArray : " + personArray);
//
//		for(int i=0; i < personArray.size(); i++) { 
//			System.out.println("======== food : " + i + " ========"); 
//			JsonObject personObject = (JsonObject) personArray.get(i);
//			System.out.println(personObject.get("f_name")); 
//			System.out.println(personObject.get("f_type")); 
//			System.out.println(personObject.get("f_img")); 
//			System.out.println(personObject.get("f_price")); 
//			System.out.println(personObject.get("cart_count")); 		
//
//		}
//		ModelAndView mv = new ModelAndView("pay/paymentPage");
////		mv.addObject("foodCart", personArray);
//		
//
//		return mv;
//	}
	
	//���� �Ϸ� ajax
	@PostMapping("paymentOk.do")
	@ResponseBody	
	public PaymentAddVO paymentOk(@RequestBody PaymentAddVO payment, Model model, HttpSession session) {
		PaymentAddVO pvo = new PaymentAddVO();
		
		log.info("###################### json paymentAddVO Ȯ�� : " + payment);
		User_tb ut = (User_tb) session.getAttribute("loginUser");
		String email = ut.getEmail();
		payment.setEmail(email);
		
		for(int i=0; i<payment.getFood().size(); i++) {
			payment.getFood().get(i).setOrder_idx(payment.getOrder_idx());
		}
		//������ �ֹ��� ��ǰ�� ��� ������ update������ ����� ������ ���� ��Ű��(��� ������ ���  ���� X)
		for(int j=0; j<payment.getFood().size(); j++) {
			//���� ����� ������ ���� Ȯ��(foodCount)
			long foodCount = pservice.fcountSelectS(payment.getFood().get(j));
			//����� ��� ���� < �ֹ��� ������ ���� �ϰ�� return null
			if(foodCount < payment.getFood().get(j).getCart_count()) {
				pvo.setOrder_state("��ǰ�� ��� ������ �����մϴ�.");
				return pvo;
			}
			
			boolean fcount_flag = pservice.fcountDecreaseS(payment.getFood().get(j));
			if(fcount_flag == false) {
				pvo.setOrder_state("��ǰ�� ��� ������ �����մϴ�.");
				return pvo;
			}
		}
		// delivery,order_main,order_list,payment���̺� insert
		boolean flag = pservice.paymentOkS(payment, email);
		
		//������ �������Ʈ ������ update������ ������ ���� ����Ʈ ���� ��Ű��
		if(payment.getUse_point() != 0) {
			pservice.userPointDecreaseS(payment.getUse_point(), email);
			long user_point = pservice.selectUserPointS(email);
			//������Ʈ �� ������ ����Ʈ�� ���ǿ� ����ֱ�
			ut.setPoint(user_point);
			session.setAttribute("loginUser", ut);
		}
		
//		ModelAndView mv = new ModelAndView();
//		mv.addObject("order_idx", payment.getOrder_idx());
		
		pvo.setOrder_idx(payment.getOrder_idx());
		
		if(flag) {
			return pvo;
//			return mv;
		}
		else {
			return null;
		}	
	}
	// ��� -> ��ٱ��ϸ� ���� ��
	@PostMapping("cart_list.do")
	public String cartList(String f_name, long cart_count, HttpSession session) throws UnsupportedEncodingException {
		log.info("### f_name : " + f_name);
		log.info("### cart_count : " + cart_count);
		User_tb usrtb = (User_tb)session.getAttribute("loginUser");
		String email = usrtb.getEmail();
		
		Cart c = new Cart();
		c.setF_name(f_name);
		c.setCart_count(cart_count);
		c.setEmail(email);
		
		boolean updateflag = false;
		List<Cart> preList = pservice.listS(email);
		for(int i=0; i<preList.size(); i++) {
			if(preList.get(i).getF_name().equals(f_name)) {
				updateflag = true;
				c.setCart_idx(preList.get(i).getCart_idx());
			}
		}
		if(updateflag == true) {
			pservice.updateCartS(c);
		}
		else {
			pservice.insertCartS(c);
		}
		
		return "redirect:cart_list.do";
	}
	@GetMapping("cart_list.do")
	public ModelAndView cartList(HttpSession session) throws UnsupportedEncodingException {
		User_tb usrtb = (User_tb)session.getAttribute("loginUser");
		String email = usrtb.getEmail();
		
		List<Cart> list = pservice.listS(email);
		ModelAndView mv = new ModelAndView("pay/cart_list");
		mv.addObject("list", list);
		
		return mv;
	}
	// X��ư Ŭ���� �ش� ��� ����
	@ResponseBody
	@PostMapping(value="del_each", produces={MediaType.APPLICATION_JSON_UTF8_VALUE})
	public boolean cartDelEach(HttpServletResponse response, long cart_idx) {
		pservice.delEachS(cart_idx);
		return true;
	}
	// ��ü ����
	@ResponseBody
	@PostMapping(value="del_all", produces={MediaType.APPLICATION_JSON_UTF8_VALUE})
	public boolean cartDelAll(HttpServletResponse response) {
		pservice.delAllS();
		return true;
	}
	// ���� ����
	@ResponseBody
	@PostMapping("del_select.do")
	public boolean cartDelSelect(HttpServletResponse response, long[] cart_idx) {
		for(int i=0; i<cart_idx.length; i++) {
			pservice.delEachS(cart_idx[i]);
		}
		return true;
	}
	
	
//	@ResponseBody
//	@PostMapping(value="order", produces={MediaType.APPLICATION_JSON_UTF8_VALUE})
////	public List<Map<String, Object>> orderList(HttpServletResponse response, String order, HttpSession session) {
////	@PostMapping("order")
//	public ModelAndView orderList(HttpServletResponse response, String order, HttpSession session) {
//		User_tb ut = (User_tb)session.getAttribute("loginUser");
//		log.info("########################### order : " + order);
//		Map<String, Object> result = new HashMap<String, Object>();
//		Map<String, Object> paramMap = new HashMap<String, Object>();
//		JSONArray arr = JSONArray.fromObject(order);
//		List<Map<String, Object>> resultList = new ArrayList<Map<String, Object>>();
//		
//		for(int i=0; i<arr.size(); i++) {
//			JSONObject obj = (JSONObject)arr.get(i);
//			Map<String, Object> resultMap = new HashMap<String, Object>();
//			resultMap.put("f_name", obj.get("f_name"));
//			resultMap.put("cart_count", obj.get("cart_count"));
//			resultMap.put("f_price", obj.get("f_price"));
////			resultMap.put("f_numPrice", obj.get("f_numPrice"));
//			resultMap.put("f_type", obj.get("f_type"));
//			
//			resultList.add(resultMap);
//		}
//		paramMap.put("resultList", resultList);
//		System.out.println("######################################################"+paramMap);
//		
////		return resultList;
//		
//		
//		ModelAndView mv = new ModelAndView();
//		mv.setView(new MappingJackson2JsonView());
//		mv.addObject("foodCart", resultList);
//		return mv;
////		ModelAndView mv = new ModelAndView("pay/payment");
////		mv.addObject("foodCart", resultList);
////		
////		return mv;
////		return "pay/paymentPage";
//	
//	}
	
	// ������������ �̵�
	@PostMapping("getPayment.do")
	public ModelAndView getPayment(long[] cidxarr, String[] farr, long[] cararr, long[] fparr, long[] numparr, String[] f_type, String[] fiarr, HttpSession session) {
//	public ModelAndView getPayment(FoodCartVO[] foodCartVO, HttpSession session) {		
		
		for(int i=0; i<cidxarr.length; i++) {
			Cart cart = new Cart();
			
			log.info("#################### cidxarr["+i+"] : " + cidxarr[i]);
			log.info("#################### farr["+i+"] : " + farr[i]);
			log.info("#################### cararr["+i+"] : " + cararr[i]);
			log.info("#################### fparr["+i+"] : " + fparr[i]);
			log.info("#################### numparr["+i+"] : " + numparr[i]);
			log.info("#################### f_type["+i+"] : " + f_type[i]);
			log.info("#################### fiarr["+i+"] : " + fiarr[i]);
			
			cart.setF_name(farr[i]);
			long foodCount = pservice.fcountSelectS(cart);
			if(foodCount < cararr[i]) {
				ModelAndView mv2 = new ModelAndView("pay/cartMessage");
				return mv2;
			}
			
			pservice.updateCartCountS(cidxarr[i], cararr[i]);
		}
		User_tb ut = (User_tb)session.getAttribute("loginUser");

		
		HashMap<String, FoodCartVO> query = pservice.getPaymentS(cidxarr);
		
		ModelAndView mv = new ModelAndView("pay/paymentPage");
		mv.addObject("query", query);
		
		return mv;

	}
	// ���� �Ϸ� Ȯ�� �������� �̵�
	@GetMapping("paymentResult.do")
	public ModelAndView paymentResult(String order_idx) {
		log.info("####################### order_idx " + order_idx);
		
		List<OrderListVO> olist = pservice.paymentResultS(order_idx);
		log.info("####################### olist " + olist);
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("pay/paymentResult");
		mv.addObject("olist", olist);
		
		return mv;
	}
}
