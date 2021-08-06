package oc.md.controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.junit.Ignore;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import lombok.extern.log4j.Log4j;
import oc.md.domain.Cart;
import oc.md.domain.Food;
import oc.md.domain.Food_detail;
import oc.md.domain.Food_explain;
import oc.md.domain.OrderList;
import oc.md.domain.Postscript;
import oc.md.domain.QNA;
import oc.md.domain.Review;
import oc.md.domain.User_tb;
import oc.md.filesetting.Path;
import oc.md.service.FoodService;
import oc.md.vo.FoodAddVo;
import oc.md.vo.FoodPagingVO;
import oc.md.vo.PagingVO;
import oc.md.vo.PagingVO2;


@Controller
@Log4j
@RequestMapping("/food/*")
public class FoodController {
	@Autowired
	private FoodService fservice;

	//재료등록페이지로 가기
	@RequestMapping("foodAdd.do")
	public String foodAddPg() {
		return "food/foodAdd";
//		return "food/forms";
	}
	//재료등록 완료  
	@PostMapping("fooAddOk.do")
	public String foodAddOk(FoodAddVo foodvo) {
		log.info("########################### foodvo : " + foodvo);
		
		boolean flag = fservice.FoodAddS(foodvo);
		
		if(flag) {
			return "food/foodAddMessage";
		}
		else {
			return null;
		}
		
	}
	//summernote에서 이미지 업로드(서버에 이미지 저장 및 이미지명칭을 변환해서 리턴)
	@RequestMapping(value = "ImageAdd.do", method = { RequestMethod.GET, RequestMethod.POST }, produces = {MediaType.APPLICATION_JSON_UTF8_VALUE})	//Map으로 변경
    @ResponseBody
    public Map<String, String> uploadSummernoteImageFile(@RequestParam("file") MultipartFile multipartFile){
		
    	log.info("################### multipartFile : " + multipartFile);
        JsonObject jsonObject = new JsonObject();

        String fileRoot = Path.SUMMERNOTE_IMG_STORE;	//저장될 파일 경로
        String originalFileName = multipartFile.getOriginalFilename();	//오리지날 파일명
        String extension = originalFileName.substring(originalFileName.lastIndexOf("."));	//파일 확장자
        log.info("################## origin : " + originalFileName);
        log.info("#################@ extension : " + extension);
        
        // 랜덤 UUID+확장자로 저장될 savedFileName
        String savedFileName = UUID.randomUUID() + extension;	
        log.info("#################@ savedFileName : " + savedFileName);
        
        File targetFile = new File(fileRoot + savedFileName);

        try {
            InputStream fileStream = multipartFile.getInputStream();
            FileUtils.copyInputStreamToFile(fileStream, targetFile);	//파일 저장
            jsonObject.addProperty("url", Path.SUMMERNOTE_IMG_STORE + savedFileName);
            jsonObject.addProperty("responseCode", "success");
            
        } catch (IOException e) {
            FileUtils.deleteQuietly(targetFile);	// 실패시 저장된 파일 삭제
            jsonObject.addProperty("responseCode", "error");
            e.printStackTrace();
        }

        log.info("############# jsonObject : " + jsonObject);

        log.info("################## getAsJsonObject : " + jsonObject.getAsJsonObject().get("url"));
        
        //Map으로 변경?
		Map<String, String> result = new HashMap<>();
//		result.put("url", Path.SUMMERNOTE_IMG_STORE + savedFileName);
		result.put("url", "../resources/images/tmp/" + savedFileName);
		result.put("responseCode", "success");
		
		return result;
    }
	
	//상품리스트+세부리스트
	@RequestMapping("food_list.do")
	public ModelAndView list(FoodPagingVO foodPagingVO) {
		List<Food> list = fservice.pageS(foodPagingVO);
		long total = fservice.countS();
		foodPagingVO.setTotal(total);
		
//		ModelAndView mv = new ModelAndView("food/shop_product_col_4");
		ModelAndView mv = new ModelAndView("food/food_list");
		mv.addObject("list", list);
		mv.addObject("p", foodPagingVO);
		
		return mv;
	}
	
	//상품리스트+세부리스트(메뉴에서 가도록?)
	@RequestMapping("food_list_menu.do")
	public ModelAndView food_list_menu(FoodPagingVO foodPagingVO, String category) {
		foodPagingVO.setCategory(category);
		foodPagingVO.getCategory();
		
		List<Food> list = fservice.categoryPageS(foodPagingVO);
		long total = fservice.categoryCountS(category);
		foodPagingVO.setTotal(total);
		
		ModelAndView mv = new ModelAndView("food/food_list2");
//		ModelAndView mv = new ModelAndView("food/food_list");
		mv.addObject("list", list);
		mv.addObject("p", foodPagingVO);
		
		return mv;
	}
	//카테고리 선택(ex)수산/정육/...)
	@RequestMapping("category.do")
	public ModelAndView categoryList(FoodPagingVO foodPagingVO, String category) {
//		foodPagingVO.setCategory(category);
//		foodPagingVO.getCategory();
		
		List<Food> list = fservice.categoryPageS(foodPagingVO);
		long total = fservice.categoryCountS(category);
		foodPagingVO.setTotal(total);
		
		ModelAndView mv = new ModelAndView("food/food_list");
		mv.addObject("list", list);
		mv.addObject("p", foodPagingVO);
		
		return mv;
	}
	//재료 검색
	@ResponseBody
	@PostMapping(value="search_name", produces={MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ModelAndView searchList(HttpServletResponse response, FoodPagingVO foodPagingVO, String f_name) {
		foodPagingVO.setF_name(f_name);
		foodPagingVO.getF_name();
		
		List<Food> list = fservice.searchPageS(foodPagingVO);
		long total = fservice.searchCountS(f_name);
		foodPagingVO.setTotal(total);
		
		ModelAndView mv = new ModelAndView("food/food_list");
		mv.addObject("list", list);
		mv.addObject("p", foodPagingVO);
		
		return mv;
	}
	//가격순으로 정렬
	@RequestMapping("price.do")
	public ModelAndView priceList(FoodPagingVO foodPagingVO, String sort) {
		foodPagingVO.setSort(sort);
		foodPagingVO.getSort();
		
		
		List<Food> list = null;
		if(sort.equals("high")) {
			list = fservice.priceHighPageS(foodPagingVO);
		}else if(sort.equals("low")){
			list = fservice.priceLowPageS(foodPagingVO);
		}
		long total = fservice.countS();
		foodPagingVO.setTotal(total);
		
		ModelAndView mv = new ModelAndView("food/food_list");
		mv.addObject("list", list);
		mv.addObject("p", foodPagingVO);
		
		return mv;
	}
	//재료 상세페이지 
	@RequestMapping("content.do")
	public ModelAndView read(PagingVO pagingVO, PagingVO2 pagingVO2 , String f_name, HttpSession session){
		log.info("################# pagingVO : " + pagingVO);
		log.info("################# pagingVO2 : " + pagingVO2);

		Food read = fservice.readS(f_name);
		List<Food_explain> fexplain = fservice.explainReadS(f_name);
		List<Food_detail> list = fservice.selectByFood_detailS(f_name);
//		log.info("####################### list controller : " + list);
		FoodPagingVO foodPagingVO = new FoodPagingVO();
		foodPagingVO.setCategory(read.getF_type());
		foodPagingVO.getCategory();
		
		List<Food> flist = fservice.categoryPageS(foodPagingVO);
		
		pagingVO.setF_name(f_name);
		List<QNA> qnaList = fservice.pageQNAS(pagingVO);
		long total = fservice.countQNAS(pagingVO);
		pagingVO.setTotal(total);
		
		pagingVO2.setF_name(f_name);
		List<Review> postScriptList = fservice.postScriptSelectPerPageS(pagingVO2);
		long totalCount = fservice.postScriptSelectCountS(f_name);
		pagingVO2.setPosts_total(totalCount);
		
		log.info("########################################### explain : " + fexplain);
		
		List<OrderList> bestFood = fservice.bestFoodSelectS();
		long review_count = fservice.reviewCountS(f_name);
		long avg_star = fservice.averageStarCountS(f_name);
		
		
		ModelAndView mv = new ModelAndView("food/food_list_detail");
//		ModelAndView mv = new ModelAndView("food/shop_single_product"); 
		mv.addObject("read", read);
		mv.addObject("explain", fexplain);
		mv.addObject("detail", list);
		mv.addObject("list", qnaList);
		mv.addObject("p", pagingVO);
		mv.addObject("postScript", postScriptList);
		mv.addObject("fp", pagingVO2);
		mv.addObject("flist", flist);
		mv.addObject("bestFood", bestFood);
		mv.addObject("review_count", review_count);
		mv.addObject("avg_star", avg_star);
		
		return mv;
	}
		
	//Q&A 상품문의
	@RequestMapping("qna_list.do")
	public ModelAndView qnaList(PagingVO pagingVO, String f_name){
//		log.info("###########################         " + pagingVO);
//		return null;
		pagingVO.setF_name(f_name);
		List<QNA> list = fservice.pageQNAS(pagingVO);
		long total = fservice.countQNAS(pagingVO);
		pagingVO.setTotal(total);
		
		ModelAndView mv = new ModelAndView("food/food_list_detail");
		mv.addObject("list", list);
		mv.addObject("p", pagingVO);
		
		return mv;
	}
	//상품문의 답글 작성
	@ResponseBody
	@RequestMapping(value="reply", produces= {MediaType.APPLICATION_JSON_UTF8_VALUE})
	public QNA qna(HttpServletResponse response, QNA qna, long q_idx, String q_reply) {
		qna.setQ_idx(q_idx);
		qna.setQ_reply(q_reply);
		fservice.updateQNAS(qna);
		return qna;
	}
	//후기게시판
//	@RequestMapping("postScript_list.do")
//	public ModelAndView list(PagingVO pagingVo) {
//		List<Review> list = fservice.postScriptSelectPerPageS(pagingVo);
//		
//		long totalCount = fservice.postScriptSelectCountS();
//		pagingVo.setTotal(totalCount);
//		
//		ModelAndView mv = new ModelAndView("food/postScript_list");
//		mv.addObject("list", list);
//		log.info("##########()"+list);
//		mv.addObject("p", pagingVo);
//		log.info("##########()"+ pagingVo);
//		return mv;
//	}
	// 후기게시판 작성 페이지
	@GetMapping("postScript_write.do")
	public ModelAndView write(String f_name) {
		return new ModelAndView("food/postScript_write", "f_name", f_name);
//		return "food/postScript_write";
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
		return "redirect:content.do?f_name="+ encode_f_name;
	}
	// 조회수 증가
	@ResponseBody
	@GetMapping("update")
	@Transactional
	public Review update(Review review) {
		fservice.postScriptCountUpdateS(review);
		Review rv = fservice.postScriptSelectBySeqS(review.getRv_idx());
		//ModelAndView mv = new ModelAndView("food/content", "review", rv);
		return rv;
	}
	// 조회수 감소
	@ResponseBody
	@GetMapping("update_noReadNum")
	@Transactional
	public Review updateNoReadNum(Review review) {
		Review rv = fservice.postScriptSelectBySeqS(review.getRv_idx());
		//ModelAndView mv = new ModelAndView("food/content", "review", rv);
		return rv;
	}
	
	@RequestMapping("food_detail")
	public ModelAndView list(String f_name) {
		log.info("############## f_name :" + f_name);
		List<Food_detail> list = fservice.selectByFood_detailS(f_name);
		return new ModelAndView("food/food_detail", "Food_detail", list);
	}	
	
	@GetMapping("qna_insert.do")
	public ModelAndView qnaInsert(String f_name) {
		return new ModelAndView("food/qna_insert", "f_name", f_name);
//		return "food/qna_insert";
	}
	@PostMapping("qna_insert.do")
	public String qnaInsert(QNA qna, HttpSession session) throws UnsupportedEncodingException {
		String email = (String) session.getAttribute("email");
		qna.setEmail(email);
		
//		log.info("######################## QNA : " + qna);
//		return null;
		System.out.println(qna);
		User_tb usrtb = (User_tb)session.getAttribute("loginUser");
		qna.setUser_name(usrtb.getUser_name());
		fservice.insertQNAS(qna);
		
		String encode_f_name = URLEncoder.encode(qna.getF_name(), "UTF-8");
		return "redirect:content.do?f_name="+ encode_f_name;
	}
	// 재료 리스트에서 장바구니 바로 담기
	@GetMapping("listCartInsert.do")
	@ResponseBody
	public String listCartInsert(long cart_count, String f_name, HttpSession session) {
		log.info("################################ cart_count : " + cart_count);
		log.info("################################ f_name : " + f_name);
		
		User_tb ut = (User_tb)session.getAttribute("loginUser");
		String email = ut.getEmail();
		
		Cart ct = new Cart();
		ct.setEmail(email);
		ct.setF_name(f_name);
		ct.setCart_count(cart_count);
		String exist_fname = fservice.existFnameSelectS(ct);	//현재 담고자 하는 재료가 있는지 확인

		if(exist_fname != null) {
			boolean up_flag = fservice.updateCartCountS(ct);
			
			if(up_flag) {
				return "true";
			}
			else {
				return "false";
			}
		}
		else {
			boolean in_flag = fservice.insertCartCountS(ct);
			
			if(in_flag) {
				return "true";
			}
			else {
				return "false";
			}		
		}
		
	}
	
	@RequestMapping("postScript_del.do")
	public String postscriptDelete(Review review) throws UnsupportedEncodingException {
		log.info("############# testest : " + review);
		
		fservice.postscriptDeleteS(review);
		
		String encode_f_name = URLEncoder.encode(review.getF_name(), "UTF-8");
		return "redirect:content.do?f_name="+ encode_f_name;
	}
	
	@RequestMapping("qna_del.do")
	public String qnaDelete(QNA qna) throws UnsupportedEncodingException {
		log.info("############# qna testest : " + qna);
		
		fservice.qnaDeleteS(qna);
		
		String encode_f_name = URLEncoder.encode(qna.getF_name(), "UTF-8");
		return "redirect:content.do?f_name="+ encode_f_name;
	}
	
}
