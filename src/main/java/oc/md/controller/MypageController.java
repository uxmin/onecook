package oc.md.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.TreeMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import lombok.extern.log4j.Log4j;
import oc.md.domain.My_order_list;
import oc.md.domain.OrderList;
import oc.md.domain.Recipe_list;
import oc.md.domain.Review;
import oc.md.domain.User_tb;
import oc.md.service.FoodService;
import oc.md.service.MypageService;
import oc.md.vo.LastPayDateVO;
import oc.md.vo.MyGoodVo;
import oc.md.vo.OrderListDetailVO;
import oc.md.vo.PagingVO;

@Controller
@Log4j
@RequestMapping("/mypage/*")
public class MypageController {
	@Autowired
	private MypageService mservice;
	
	@Autowired
	private FoodService fservice;

	@RequestMapping("mypageMain.do")
	public ModelAndView mypageMain(HttpSession session) {
		User_tb ut = (User_tb)session.getAttribute("loginUser");
		String email = ut.getEmail();
		
		long all_payment = mservice.userPaymentCountS(email);
		long recipe_list_count = mservice.recipe_list_countS(email);
		HashMap<String, Object> delivery_state = mservice.myDeliveryStates(email);
		TreeMap<String,Object> tm = new TreeMap<String,Object>(delivery_state);
		// 현재 주문처리 현황을 순서별로 정렬하기 위한 과정
		Iterator<String> iteratorKey = tm.keySet( ).iterator( );   //키값 오름차순 정렬(기본)
        //Iterator<String> iteratorKey = tm.descendingKeySet().iterator(); //키값 내림차순 정렬
		log.info("############# iteratorKey :" + iteratorKey);
		while(iteratorKey.hasNext()){
			String key = iteratorKey.next();
			log.info("############# 나옴 :" + key+","+tm.get(key));
		}
		
		List<LastPayDateVO> lastlist = mservice.lastListPayments(email);
		
		//주문번호에 해당하는 재료 품목 리스트 담기
		List<List<LastPayDateVO>> orderlist = new ArrayList<List<LastPayDateVO>>();

		for(int i=0; i<lastlist.size(); i++) {
			OrderListDetailVO odetail = new OrderListDetailVO();
			odetail.setEmail(email);
			odetail.setOrder_idx(lastlist.get(i).getOrder_idx());
			List<LastPayDateVO> lvo = mservice.orderListPaymentS(odetail);
			log.info("################################### lvo :" + lvo);
			orderlist.add(lvo);
		}
		log.info("################################### orderlist :" + orderlist);
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("mypage/mypageMain");
		mv.addObject("all_payment", all_payment);
		mv.addObject("delivery_state", tm);
		mv.addObject("lastlist", lastlist);
		mv.addObject("orderlist", orderlist);
		mv.addObject("recipe_list_count", recipe_list_count);
		
		return mv;
	}
	
	@RequestMapping("recipe_list.do")
	public ModelAndView selectByFood_recipe_list(PagingVO pagingVo, HttpSession session) {
		User_tb usrtb = (User_tb)session.getAttribute("loginUser");
		usrtb.setEmail(usrtb.getEmail());
		usrtb.setUser_name(usrtb.getUser_name());
		long all_payment = mservice.userPaymentCountS(usrtb.getEmail());
		long recipe_list_count = mservice.recipe_list_countS(usrtb.getEmail());
		
		List<Recipe_list> list = mservice.selectByFood_recipe_listS(pagingVo, usrtb.getEmail());
		log.info("#################3 list : " + list);
		ModelAndView mv = new ModelAndView("mypage/recipe_list");
		mv.addObject("recipe_list",list);
		mv.addObject("p", pagingVo);
		mv.addObject("all_payment", all_payment);
		mv.addObject("recipe_list_count", recipe_list_count);
		
		log.info("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
		log.info("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
		log.info("@@@@@@@@@@@@@@@ pageVo : "+pagingVo.toString());
		return mv;
	}
	// 회원정보수정
	@GetMapping("mypage.do")
	public ModelAndView mypage(HttpSession session) {
		User_tb usrtb = (User_tb)session.getAttribute("loginUser");
		User_tb user_send = mservice.MypageS(usrtb.getEmail());
		long all_payment = mservice.userPaymentCountS(usrtb.getEmail());
		long recipe_list_count = mservice.recipe_list_countS(usrtb.getEmail());
		
		session.setAttribute("loginUser", user_send);
		log.info("######################3 change session : " + session.getAttribute("loginUser"));
		
		ModelAndView mv = new ModelAndView("mypage/mypage");
		mv.addObject("mypage", user_send);
		mv.addObject("all_payment", all_payment);
		mv.addObject("recipe_list_count", recipe_list_count);
		
		return mv;
	}
	//회원정보수정완료
	@PostMapping("mypage.do")
	public String update(User_tb user_tb, HttpSession session) {
		User_tb usrtb = (User_tb)session.getAttribute("loginUser");
		log.info("############################### user_tb : " + user_tb);
		User_tb ut = user_tb;
		ut.setEmail(usrtb.getEmail());
		log.info("############################### ut : " + ut);
		log.info("############################### usrtb : " + usrtb);
		if(ut.getAddr_no1() != "" || ut.getAddr_no2() != "") {
			log.info("어디1");
			ut.setAddr(user_tb.getAddr_no1() + " " + user_tb.getAddr_no2());
		}
		else {
			log.info("어디2");
			ut.setAddr(usrtb.getAddr());
		}
		log.info("@@@@@@@@@@@@@@@@@@@@@@@@@@@");
		mservice.updateS(ut);
		return "redirect:../";
	}
	//관리자레시피 중에서 좋아요한 리스트
	@RequestMapping("good_manager.do")
	public ModelAndView Good_ManagerS(PagingVO pagingVo, HttpSession session) {
		pagingVo.setListCnt(6);
		User_tb usrtb = (User_tb)session.getAttribute("loginUser");
		usrtb.setEmail(usrtb.getEmail());
		//Good good = new Good();
		//good.setUser_email(usrtb.getEmail());
		long all_payment = mservice.userPaymentCountS(usrtb.getEmail());
		long recipe_list_count = mservice.recipe_list_countS(usrtb.getEmail());

		List<MyGoodVo> list = mservice.Good_ManagerS(pagingVo, usrtb.getEmail());
		log.info("@@@@@@@@@@@@@@@ list : " + list);
		ModelAndView mv = new ModelAndView("mypage/good_manager");
		mv.addObject("good_manager", list);
		mv.addObject("p", pagingVo);
		mv.addObject("all_payment", all_payment);
		mv.addObject("recipe_list_count", recipe_list_count);
		
		return mv;
	}
	//검색
	@ResponseBody
	@PostMapping(value="manager_search_name", produces={MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ModelAndView Good_Manager_SearchS(PagingVO pagingVo, HttpSession session, MyGoodVo mygoodVo) {
		User_tb usrtb = (User_tb)session.getAttribute("loginUser");
		usrtb.setEmail(usrtb.getEmail());
		
		String user_email = usrtb.getEmail();
		pagingVo.setEmail(usrtb.getEmail());
		mygoodVo.setUser_email(usrtb.getEmail());
		
		log.info("&&&&&&&&&&&&&&&&&&&&&&&& mygoodVo : " + mygoodVo);
		log.info("&&&&&&&&&&&&&&&&&&&&&&&& pagingVo : " + pagingVo);
		
		List<MyGoodVo> list = mservice.Good_Manager_SearchS(pagingVo);
		long total = mservice.selectCount_Search(pagingVo);
		pagingVo.setTotal(total);
		
		log.info("!!!!!!!!!!!!!!!!!!!!!" + list);
		ModelAndView mv = new ModelAndView("mypage/good_manager");
		mv.addObject("good_manager", list);
		mv.addObject("p", pagingVo);
		return mv;
	}
	//카테고리
	@RequestMapping("manager_category.do")
	public ModelAndView Good_Manager_categoryS(PagingVO pagingVo, HttpSession session, MyGoodVo mygoodVo) {
		pagingVo.setListCnt(6);
		User_tb usrtb = (User_tb)session.getAttribute("loginUser");
		usrtb.setEmail(usrtb.getEmail());
		
		String user_email = usrtb.getEmail();
		pagingVo.setEmail(usrtb.getEmail());
		mygoodVo.setUser_email(usrtb.getEmail());
		
		List<MyGoodVo> list = mservice.Good_Manager_categoryS(pagingVo);
		long total = mservice.selectCount_category(pagingVo);
		pagingVo.setTotal(total);
		
		ModelAndView mv = new ModelAndView("mypage/good_manager");
		mv.addObject("good_manager", list);
		mv.addObject("p", pagingVo);
		return mv;
	}
	
	//유저레시피 중에서 좋아요한 리스트
	@RequestMapping("good_user.do")
	public ModelAndView Good_UserS(PagingVO pagingVo, HttpSession session) {
		pagingVo.setListCnt(6);
		User_tb usrtb = (User_tb)session.getAttribute("loginUser");
		usrtb.setEmail(usrtb.getEmail());
		long all_payment = mservice.userPaymentCountS(usrtb.getEmail());
		long recipe_list_count = mservice.recipe_list_countS(usrtb.getEmail());
		
		List<MyGoodVo> list = mservice.Good_UserS(pagingVo, usrtb.getEmail());
		ModelAndView mv = new ModelAndView("mypage/good_user");
		mv.addObject("good_user", list);
		mv.addObject("p", pagingVo);
		mv.addObject("all_payment", all_payment);
		mv.addObject("recipe_list_count", recipe_list_count);
		return mv;
	}
	@PostMapping("good_user_search.do")
	public ModelAndView Good_User_SearchS(PagingVO pagingVo, String cat_nm, String cat_text, HttpSession session) {
		log.info("###################### cat_nm : " + cat_nm + ", cat_text : " + cat_text);
		pagingVo.setListCnt(6);
		User_tb usrtb = (User_tb)session.getAttribute("loginUser");
		usrtb.setEmail(usrtb.getEmail());
		pagingVo.setEmail(usrtb.getEmail());
		//long all_payment = mservice.userPaymentCountS(usrtb.getEmail());
		//long recipe_list_count = mservice.recipe_list_countS(usrtb.getEmail());
		
		pagingVo.setCategory(cat_nm);
		pagingVo.setSort(cat_text);
		List<MyGoodVo> list = mservice.Good_User_SearchS(pagingVo);
		long total = mservice.userSelectCount_User_SearchS(pagingVo);
		pagingVo.setTotal(total);
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("mypage/good_user");
		mv.addObject("good_user", list);
		mv.addObject("p", pagingVo);
		
		return mv;
	}
	
	//주문리스트
	//추가
	@RequestMapping("order_list.do")
	public ModelAndView MyOrderList(PagingVO pagingVo, HttpSession session) {
		User_tb usrtb = (User_tb)session.getAttribute("loginUser");
		usrtb.setEmail(usrtb.getEmail());
		long all_payment = mservice.userPaymentCountS(usrtb.getEmail());
		long recipe_list_count = mservice.recipe_list_countS(usrtb.getEmail());
		
		List<My_order_list> list = mservice.MyOrderListS(pagingVo, usrtb.getEmail());
		log.info("#############################"+list);
				
		ModelAndView mv = new ModelAndView("mypage/order_list");
		mv.addObject("order_list", list);
		mv.addObject("p", pagingVo);
		mv.addObject("all_payment", all_payment);
		mv.addObject("recipe_list_count", recipe_list_count);
		return mv;
	}
	
	// 입력 받은 개월 수로 주문내역 확인
	@RequestMapping("select_month.do")
	public ModelAndView MySelectMonth(PagingVO pagingVo, long month,  HttpSession session) {
		User_tb usrtb = (User_tb)session.getAttribute("loginUser");
		usrtb.setEmail(usrtb.getEmail());
		long all_payment = mservice.userPaymentCountS(usrtb.getEmail());
		long recipe_list_count = mservice.recipe_list_countS(usrtb.getEmail());
		
//		List<LastPayDateVO> list = mservice.MyOrderList_OnemomthS(pagingVo, usrtb.getEmail());
		List<LastPayDateVO> list = mservice.MyOrderListSelectMonthS(pagingVo, usrtb.getEmail(), month);
		
		ModelAndView mv = new ModelAndView("mypage/select_month");
		mv.addObject("one_month", list);
		mv.addObject("p", pagingVo);
		mv.addObject("all_payment", all_payment);
		mv.addObject("recipe_list_count", recipe_list_count);
		return mv;
	}
	
	
	@RequestMapping("order_list_detail.do")
	public ModelAndView detail(OrderListDetailVO orderlistdetailVo, HttpSession session) {
		User_tb usrtb = (User_tb)session.getAttribute("loginUser");
		orderlistdetailVo.setEmail(usrtb.getEmail());
		long all_payment = mservice.userPaymentCountS(usrtb.getEmail());
		long recipe_list_count = mservice.recipe_list_countS(usrtb.getEmail());
		
		List<OrderList> detail = mservice.MyOrderList_DetailS(orderlistdetailVo);
		log.info("@@@@@@@@@@@@@@@@@@@@"+detail);
		long chk_ps = mservice.checkPostscriptCountS(orderlistdetailVo);
			
		ModelAndView mv = new ModelAndView("mypage/order_list_detail");
		mv.addObject("order_list_detail", detail);
		mv.addObject("all_payment", all_payment);
		mv.addObject("recipe_list_count", recipe_list_count);
		mv.addObject("chk_ps", chk_ps);
		return mv;
	}
	@GetMapping("refund_request.do")
	@ResponseBody
	public String refundRequest(String order_idx) {
		log.info("################################## order_idx : " + order_idx);
		
		long delivery_idx = mservice.selectDeliveryIdxS(order_idx);
		
		boolean order_flag = mservice.refundRequestS(delivery_idx);
		mservice.updateOrderStateS(order_idx);
		
		if(order_flag) {
			return "true";
		}
		else {
			return "false";
		}
	}

	// 후기게시판 작성완료
	@PostMapping("postScript_write.do")
	public String write(Review review, String order_idx, HttpSession session) throws UnsupportedEncodingException {
		log.info("#####################@@@@ review :" + review);
		log.info("#####################@@@@ order_idx :" + order_idx);
//		log.info("#####################@@@@ review.getF_name :" + review.getF_name());
//		return null;
		
//		log.info("################ : " + session.getAttribute("loginUser.email"));
//		log.info("################ id2 : " + session.getAttribute("email"));
		
		review.setEmail((String)session.getAttribute("email"));
		User_tb usrtb = (User_tb)session.getAttribute("loginUser");
		review.setUser_name(usrtb.getUser_name());
		
		fservice.postScriptInsertS(review, order_idx);
		
		String encode_f_name = URLEncoder.encode(review.getF_name(), "UTF-8");
		return "redirect:../food/content.do?f_name="+ encode_f_name;
	}
}
