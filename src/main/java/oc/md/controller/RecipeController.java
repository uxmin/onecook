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

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.JsonObject;

import lombok.extern.log4j.Log4j;
import oc.md.domain.Food;
import oc.md.domain.Good;
import oc.md.domain.Image;
import oc.md.domain.Recipe;
import oc.md.domain.Recipe_detail;
import oc.md.domain.Recipe_food;
import oc.md.domain.Recipe_material;
import oc.md.domain.Recipe_nutrient;
import oc.md.domain.Recipe_reply;
import oc.md.domain.User_tb;
import oc.md.filesetting.Path;
import oc.md.service.RecipeService;
import oc.md.vo.FoodPagingVO;
import oc.md.vo.PagingVO;
import oc.md.vo.RecipeAddVO;

@Controller
@Log4j
@RequestMapping("/recipe/*")
public class RecipeController {
	@Autowired
	private RecipeService rservice;
	// 관리자 레시피 등록 페이지
	@RequestMapping("managerRecipeAdd.do")
	public String manageRecipeAddPg() {
		return "recipe/managerRecipeAdd";
	}
	// 유저 레시피 등록 페이지
	@RequestMapping("userRecipeAdd.do")
	public String userRecipeAddPg() {
		return "recipe/userRecipeAdd";
	}
	// 레시피 등록시 카테고리 검색 결과
	@GetMapping("category_sel.do")
	public ModelAndView categorySelect(String category) {
//		log.info("#################### category : " + category);
		List<Food> categoryList = rservice.categorySelectS(category);
		ModelAndView mv = new ModelAndView("recipe/categorySelectResult", "categoryList", categoryList);
		
		return mv;
	}
	// 매니저 레시피 등록 완료
	@PostMapping("managerRecipeAddOk.do")
	public String managerRecipeAddOk(RecipeAddVO recipeAddVO, HttpSession session) {
		User_tb ut = (User_tb)session.getAttribute("loginUser");
		recipeAddVO.setEmail(ut.getEmail());
		recipeAddVO.setUser_type(ut.getUser_type());
		log.info("######################## recipeAddVo : " +  recipeAddVO);
		
		boolean flag = rservice.managerRecipeAddOkS(recipeAddVO);
//		return null;
		if(flag) {
			return "recipe/managerAddMessage";
		}
		else {
			return null;
		}		

	}
	// 관리자 레시피 페이지
	@RequestMapping("list_manage.do")
	public ModelAndView recipeList(FoodPagingVO foodPagingVO, HttpSession session) {
		if(session.getAttribute("loginUser") == null) {
			foodPagingVO.setGood_email("");
			List<Recipe> list = rservice.recipePageS(foodPagingVO);
			long total = rservice.recipeCountS();
			foodPagingVO.setTotal(total);
			ModelAndView mv = new ModelAndView("recipe/list_manage");
			mv.addObject("list", list);
			mv.addObject("p", foodPagingVO);
			
			return mv;
		}
		else {
			User_tb ut = (User_tb) session.getAttribute("loginUser");
			String email = ut.getEmail();
			foodPagingVO.setGood_email(email);
			List<Recipe> list = rservice.recipePageS(foodPagingVO);
			long total = rservice.recipeCountS();
			foodPagingVO.setTotal(total);
			ModelAndView mv = new ModelAndView("recipe/list_manage");
			mv.addObject("list", list);
			mv.addObject("p", foodPagingVO);
			
			return mv;
		}
		
	}
	// 관리자 레시피 카테고리 분류
	@RequestMapping("list_manage_cat.do")
	public ModelAndView recipeCatList(FoodPagingVO foodPagingVO, String category, HttpSession session) {
		if(session.getAttribute("loginUser") == null) {
			foodPagingVO.setGood_email("");
			foodPagingVO.setCategory(category);
			List<Recipe> list = rservice.recipeCatPageS(foodPagingVO);
			long total = rservice.recipeCatCountS(category);
			foodPagingVO.setTotal(total);
			ModelAndView mv = new ModelAndView("recipe/list_manage");
			mv.addObject("list", list);
			mv.addObject("p", foodPagingVO);
			
			return mv;
			
		}else {
			User_tb ut = (User_tb) session.getAttribute("loginUser");
			String email = ut.getEmail();
			foodPagingVO.setGood_email(email);
			foodPagingVO.setCategory(category);
			List<Recipe> list = rservice.recipeCatPageS(foodPagingVO);
			long total = rservice.recipeCatCountS(category);
			foodPagingVO.setTotal(total);
			ModelAndView mv = new ModelAndView("recipe/list_manage");
			mv.addObject("list", list);
			mv.addObject("p", foodPagingVO);
			
			return mv;
		}

	}
	// 관리자 레시피 정렬 페이지
	@RequestMapping("list_manage_sort.do")
	public ModelAndView recipeSortList(FoodPagingVO foodPagingVO, String sort, String category, HttpSession session) {
		if(session.getAttribute("loginUser") == null) {
			foodPagingVO.setGood_email("");
			foodPagingVO.setSort(sort);
			foodPagingVO.setCategory(category);
			
			List<Recipe> list = null;
			if(sort.equals("new")) {
				if(category.equals("전체")) {
					list = rservice.recipeAllNewPageS(foodPagingVO);
				}else {
					list = rservice.recipeCatNewPageS(foodPagingVO);
				}
			}else if(sort.equals("good")) {
				if(category.equals("전체")) {
					list = rservice.recipeAllGoodPageS(foodPagingVO);
				}else {
					list = rservice.recipeCatGoodPageS(foodPagingVO);
				}
			}else if(sort.equals("view")) {
				if(category.equals("전체")) {
					list = rservice.recipeAllViewPageS(foodPagingVO);
				}else {
					list = rservice.recipeCatViewPageS(foodPagingVO);
				}
			}
			long total = rservice.recipeCatCountS(category);
			foodPagingVO.setTotal(total);
			
			ModelAndView mv = new ModelAndView("recipe/list_manage");
			mv.addObject("list", list);
			mv.addObject("p", foodPagingVO);
			
			return mv;
		}
		else {
			User_tb ut = (User_tb) session.getAttribute("loginUser");
			String email = ut.getEmail();
			foodPagingVO.setGood_email(email);
			foodPagingVO.setSort(sort);
			foodPagingVO.setCategory(category);
			
			List<Recipe> list = null;
			if(sort.equals("new")) {
				if(category.equals("전체")) {
					list = rservice.recipeAllNewPageS(foodPagingVO);
				}else {
					list = rservice.recipeCatNewPageS(foodPagingVO);
				}
			}else if(sort.equals("good")) {
				if(category.equals("전체")) {
					list = rservice.recipeAllGoodPageS(foodPagingVO);
				}else {
					list = rservice.recipeCatGoodPageS(foodPagingVO);
				}
			}else if(sort.equals("view")) {
				if(category.equals("전체")) {
					list = rservice.recipeAllViewPageS(foodPagingVO);
				}else {
					list = rservice.recipeCatViewPageS(foodPagingVO);
				}
			}
			long total = rservice.recipeCatCountS(category);
			foodPagingVO.setTotal(total);
			
			ModelAndView mv = new ModelAndView("recipe/list_manage");
			mv.addObject("list", list);
			mv.addObject("p", foodPagingVO);
			
			return mv;
		}

	}
	// 관리자 레시피 검색
	@ResponseBody
	@PostMapping(value="search_name", produces={MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ModelAndView searchList(HttpServletResponse response, FoodPagingVO foodPagingVO, String rc_title, HttpSession session) {
		if(session.getAttribute("loginUser") == null) {
			foodPagingVO.setGood_email("");
			foodPagingVO.setF_name(rc_title);
			
			List<Recipe> list = rservice.searchPageS(foodPagingVO);
			long total = rservice.searchCountS(rc_title);
			foodPagingVO.setTotal(total);
			
			ModelAndView mv = new ModelAndView("recipe/list_manage");
			mv.addObject("list", list);
			mv.addObject("p", foodPagingVO);
			
			return mv;
		}
		else {
			User_tb ut = (User_tb) session.getAttribute("loginUser");
			String email = ut.getEmail();
			foodPagingVO.setGood_email(email);
			foodPagingVO.setF_name(rc_title);
			
			List<Recipe> list = rservice.searchPageS(foodPagingVO);
			long total = rservice.searchCountS(rc_title);
			foodPagingVO.setTotal(total);
			
			ModelAndView mv = new ModelAndView("recipe/list_manage");
			mv.addObject("list", list);
			mv.addObject("p", foodPagingVO);
			
			return mv;
		}

	}
	// 유저 레시피 페이지
	@RequestMapping("list_user.do")
	public ModelAndView recipeUserList(PagingVO pagingVO, HttpSession session) {
		if(session.getAttribute("loginUser") == null) {
			pagingVO.setGood_email("");
			pagingVO.setListCnt(6);
			List<Recipe> list = rservice.recipeUserTopS(pagingVO);
			List<Recipe> list_line = rservice.recipeUserPageS(pagingVO);
			long total = rservice.recipeUserCountS();
			pagingVO.setTotal(total);
			
			log.info("############################### list_line no email : " + list_line);
			ModelAndView mv = new ModelAndView("recipe/list_user");
			mv.addObject("list", list);
			mv.addObject("list_line", list_line);
			mv.addObject("p", pagingVO);
			
			return mv;
		}
		else {
			User_tb ut = (User_tb) session.getAttribute("loginUser");
			String email = ut.getEmail();
			log.info("############################### email yes email : " + email);
			pagingVO.setGood_email(email);
			pagingVO.setListCnt(6);
			List<Recipe> list = rservice.recipeUserTopS(pagingVO);
			List<Recipe> list_line = rservice.recipeUserPageS(pagingVO);
			long total = rservice.recipeUserCountS();
			pagingVO.setTotal(total);
			
			log.info("############################### list_line yes email : " + list_line);
			ModelAndView mv = new ModelAndView("recipe/list_user");
			mv.addObject("list", list);
			mv.addObject("list_line", list_line);
			mv.addObject("p", pagingVO);
			
			return mv;
		}

	}
	// 유저 레시피 정렬 페이지
	@RequestMapping("list_user_sort.do")
	public ModelAndView recipeUserSortList(PagingVO pagingVO, String sort, HttpSession session) {
		if(session.getAttribute("loginUser") == null) {
			pagingVO.setGood_email("");
			pagingVO.setSort(sort);
			pagingVO.setListCnt(6);
			List<Recipe> list = rservice.recipeUserTopS(pagingVO);
			List<Recipe> list_line = null;
			if(sort.equals("good")) {
				list_line = rservice.recipeUserSortGoodPageS(pagingVO);
			}else if(sort.equals("view")) {
				list_line = rservice.recipeUserSortViewPageS(pagingVO);
			}
			long total = rservice.recipeUserCountS();
			pagingVO.setTotal(total);
			
			ModelAndView mv = new ModelAndView("recipe/list_user");
			mv.addObject("list", list);
			mv.addObject("list_line", list_line);
			mv.addObject("p", pagingVO);
			
			return mv;			
		}
		else {
			User_tb ut = (User_tb) session.getAttribute("loginUser");
			String email = ut.getEmail();
			pagingVO.setGood_email(email);
			pagingVO.setSort(sort);
			pagingVO.setListCnt(6);
			List<Recipe> list = rservice.recipeUserTopS(pagingVO);
			List<Recipe> list_line = null;
			if(sort.equals("good")) {
				list_line = rservice.recipeUserSortGoodPageS(pagingVO);
			}else if(sort.equals("view")) {
				list_line = rservice.recipeUserSortViewPageS(pagingVO);
			}
			long total = rservice.recipeUserCountS();
			pagingVO.setTotal(total);
			
			ModelAndView mv = new ModelAndView("recipe/list_user");
			mv.addObject("list", list);
			mv.addObject("list_line", list_line);
			mv.addObject("p", pagingVO);
			
			return mv;	
		}
		

	}
	// 유저레시피 제목순으로 검색
	@ResponseBody
	@PostMapping(value="search_title", produces={MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ModelAndView searchUserTitle(HttpServletResponse response, PagingVO pagingVO, String rc_title, String category, HttpSession session) {
		if(session.getAttribute("loginUser") == null) {
			pagingVO.setGood_email("");
			pagingVO.setRc_title(rc_title);
			pagingVO.setCategory(category);
			pagingVO.setListCnt(6);
			List<Recipe> list = rservice.recipeUserTopS(pagingVO);
			List<Recipe> list_line = rservice.searchUserTitlePageS(pagingVO);
			long total = rservice.searchUserTitleCountS(rc_title);
			pagingVO.setTotal(total);
			
			ModelAndView mv = new ModelAndView("recipe/list_user");
			mv.addObject("list", list);
			mv.addObject("list_line", list_line);
			mv.addObject("p", pagingVO);
			
			return mv;
		}
		else {
			User_tb ut = (User_tb) session.getAttribute("loginUser");
			String email = ut.getEmail();
			pagingVO.setGood_email(email);
			pagingVO.setRc_title(rc_title);
			pagingVO.setCategory(category);
			pagingVO.setListCnt(6);
			List<Recipe> list = rservice.recipeUserTopS(pagingVO);
			List<Recipe> list_line = rservice.searchUserTitlePageS(pagingVO);
			long total = rservice.searchUserTitleCountS(rc_title);
			pagingVO.setTotal(total);
			
			ModelAndView mv = new ModelAndView("recipe/list_user");
			mv.addObject("list", list);
			mv.addObject("list_line", list_line);
			mv.addObject("p", pagingVO);
			
			return mv;
		}

	}
	// 유저레시피 이메일로 검색
	@ResponseBody
	@PostMapping(value="search_email", produces={MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ModelAndView searchUserWriter(HttpServletResponse response, PagingVO pagingVO, String email, String category, HttpSession session) {
		if(session.getAttribute("loginUser") == null) {
			pagingVO.setGood_email("");
			pagingVO.setEmail(email);
			pagingVO.setCategory(category);
			pagingVO.setListCnt(6);
			List<Recipe> list = rservice.recipeUserTopS(pagingVO);
			List<Recipe> list_line = rservice.searchUserWriterPageS(pagingVO);
			long total = rservice.searchUserWriterCountS(email);
			pagingVO.setTotal(total);
			
			ModelAndView mv = new ModelAndView("recipe/list_user");
			mv.addObject("list", list);
			mv.addObject("list_line", list_line);
			mv.addObject("p", pagingVO);
			
			return mv;
		}
		else {
			User_tb ut = (User_tb) session.getAttribute("loginUser");
			String session_email = ut.getEmail();
			pagingVO.setGood_email(session_email);
			pagingVO.setEmail(email);
			pagingVO.setCategory(category);
			pagingVO.setListCnt(6);
			List<Recipe> list = rservice.recipeUserTopS(pagingVO);
			List<Recipe> list_line = rservice.searchUserWriterPageS(pagingVO);
			long total = rservice.searchUserWriterCountS(email);
			pagingVO.setTotal(total);
			
			ModelAndView mv = new ModelAndView("recipe/list_user");
			mv.addObject("list", list);
			mv.addObject("list_line", list_line);
			mv.addObject("p", pagingVO);
			
			return mv;
		}

	}	
	// 유저 레시피 상세 페이지
	@RequestMapping("user_recipe_detail.do")
	public ModelAndView user_recipe_detail(PagingVO pagingVo, long rc_idx, HttpSession session) {
		if(session.getAttribute("loginUser") == null) {
			rservice.updateRecipeCountS(rc_idx);
			Recipe rc = new Recipe();
			rc.setGood_email("");
			rc.setRc_idx(rc_idx);
			Recipe rc2 = rservice.selectUserRecipeS(rc);
			log.info("########################## recipe 화긴 :" + rc2);
			Image user_result = rservice.selectUserRecipeResultS(rc_idx);
			List<Recipe_reply> reply_list = rservice.selectPerPageS(pagingVo, Long.toString(rc_idx));
			long totalCount = rservice.selectCountS(rc_idx);
			pagingVo.setTotal(totalCount);
			
			ModelAndView mv = new ModelAndView("recipe/user_recipe_detail");
			mv.addObject("recipe", rc2);
			mv.addObject("user_result", user_result);
			mv.addObject("reply_list", reply_list);
			mv.addObject("p", pagingVo);
			mv.addObject("rc_idx", rc_idx);
			
			return mv;
		}
		else {
			rservice.updateRecipeCountS(rc_idx);
			User_tb ut = (User_tb) session.getAttribute("loginUser");
			String session_email = ut.getEmail();
			Recipe rc = new Recipe();

			rc.setGood_email(session_email);
			rc.setRc_idx(rc_idx);
			Recipe rc2 = rservice.selectUserRecipeS(rc);
			Image user_result = rservice.selectUserRecipeResultS(rc_idx);
			List<Recipe_reply> reply_list = rservice.selectPerPageS(pagingVo, Long.toString(rc_idx));
			long totalCount = rservice.selectCountS(rc_idx);
			pagingVo.setTotal(totalCount);
			
			
			ModelAndView mv = new ModelAndView("recipe/user_recipe_detail");
			mv.addObject("recipe", rc2);
			mv.addObject("user_result", user_result);
			mv.addObject("reply_list", reply_list);
			mv.addObject("p", pagingVo);
			mv.addObject("rc_idx", rc_idx);
			
			return mv;
		}

	}
	// 레시피 상세 페이지
	@RequestMapping("recipe_detail.do")
	public ModelAndView list(PagingVO pagingVo, long rc_idx, HttpSession session) {
		if(session.getAttribute("loginUser") == null) {
			rservice.updateRecipeCountS(rc_idx);
			Recipe rc = new Recipe();
			rc.setGood_email("");
			rc.setRc_idx(rc_idx);
			Recipe rc2 = rservice.selectManagerRecipeS(rc);
			List<Recipe_detail> list = rservice.selectByRecipe_detailS(rc_idx);
			List<Recipe_material> material = rservice.selectByRecipe_materialS(rc_idx);
			List<Recipe_food> food = rservice.selectByRecipe_foodS(rc_idx);
			List<Recipe_reply> reply_list = rservice.selectPerPageS(pagingVo, Long.toString(rc_idx));
			long totalCount = rservice.selectCountS(rc_idx);
			pagingVo.setTotal(totalCount);
			//영양소 추가
			List<Recipe_nutrient> nutrient = rservice.selectByRecipe_nutrientS(rc_idx);
			log.info("########################## nutrient 확인 :" + nutrient);
			
			ModelAndView mv = new ModelAndView("recipe/recipe_detail");
			mv.addObject("recipe", rc2);
			mv.addObject("recipe_detail", list);
			mv.addObject("recipe_material", material);
			mv.addObject("recipe_food", food);
			mv.addObject("reply_list", reply_list);
			mv.addObject("nutrient", nutrient);
			mv.addObject("p", pagingVo);
			mv.addObject("rc_idx", rc_idx);
			
			return mv;
		}
		else {
			rservice.updateRecipeCountS(rc_idx);
			User_tb ut = (User_tb) session.getAttribute("loginUser");
			String session_email = ut.getEmail();
			Recipe rc = new Recipe();

			rc.setGood_email(session_email);
			rc.setRc_idx(rc_idx);
			Recipe rc2 = rservice.selectManagerRecipeS(rc);
			List<Recipe_detail> list = rservice.selectByRecipe_detailS(rc_idx);
			List<Recipe_material> material = rservice.selectByRecipe_materialS(rc_idx);
			List<Recipe_food> food = rservice.selectByRecipe_foodS(rc_idx);
			List<Recipe_reply> reply_list = rservice.selectPerPageS(pagingVo, Long.toString(rc_idx));
			long totalCount = rservice.selectCountS(rc_idx);
			pagingVo.setTotal(totalCount);
			//영양소 추가
			List<Recipe_nutrient> nutrient = rservice.selectByRecipe_nutrientS(rc_idx);
			log.info("########################## nutrient 확인 :" + nutrient);
			
			ModelAndView mv = new ModelAndView("recipe/recipe_detail");
			mv.addObject("recipe", rc2);
			mv.addObject("recipe_detail", list);
			mv.addObject("recipe_material", material);
			mv.addObject("recipe_food", food);
			mv.addObject("reply_list", reply_list);
			mv.addObject("nutrient", nutrient);
			mv.addObject("p", pagingVo);
			mv.addObject("rc_idx", rc_idx);
			
			return mv;
		}

	}
	// 레시피 댓글
	@RequestMapping("list.do")
	public ModelAndView list(String rc_idx, PagingVO pagingVo) {
		List<Recipe_reply> list = rservice.selectPerPageS(pagingVo, rc_idx);
		
		long long_rc_idx = Long.parseLong(rc_idx);
		
		long totalCount = rservice.selectCountS(long_rc_idx);
		pagingVo.setTotal(totalCount);
		
		ModelAndView mv = new ModelAndView("recipe/list");
		mv.addObject("list", list);
		log.info("##########()"+list);
		mv.addObject("p", pagingVo);
		mv.addObject("rc_idx", rc_idx);
		log.info("##########()"+ pagingVo);
		return mv;
	}
	// 레시피 댓글 작성 완료
	@PostMapping("write.do")
	public String write(Recipe_reply recipe_reply, HttpSession session) {
		User_tb ut = (User_tb)session.getAttribute("loginUser");
		recipe_reply.setEmail(ut.getEmail());
		recipe_reply.setUser_name(ut.getUser_name());
		
		long rc_idx = rservice.insertS(recipe_reply);
		log.info("#> write() rc_idx2"+rc_idx); 
		if(recipe_reply.getWrite_gubun().equals("MANAGER")){
			return "redirect:recipe_detail.do?rc_idx="+rc_idx;	
		}
		else {
			return "redirect:user_recipe_detail.do?rc_idx="+rc_idx;	
		}
		
	}
	@GetMapping("write.do")
	public String write() {
		return "recipe/write";
	}
	@GetMapping("content.do")
	public ModelAndView content(long reply_idx) {
		Recipe_reply recipe_reply = rservice.selectBySeqS(reply_idx);
		ModelAndView mv = new ModelAndView("recipe/content","recipe_reply",recipe_reply);
		return mv;
	}
	
	//summernote에서 이미지 업로드(서버에 이미지 저장 및 이미지명칭을 변환해서 리턴)
	@RequestMapping(value = "userRecipeImageAdd.do", method = { RequestMethod.GET, RequestMethod.POST }, produces = {MediaType.APPLICATION_JSON_UTF8_VALUE})	//Map으로 변경
    @ResponseBody
    public Map<String, String> uploadSummernoteImageFile(@RequestParam("file") MultipartFile multipartFile, HttpSession session){
    	User_tb ut = (User_tb) session.getAttribute("loginUser");
		log.info("################### multipartFile : " + multipartFile);
        JsonObject jsonObject = new JsonObject();

        String fileRoot = Path.USER_RECIPE_PATH + "/" + ut.getEmail() + "_" + ut.getUser_name() + "/";	//저장될 파일 경로(유저이메일_유저닉네임)
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
            jsonObject.addProperty("url", fileRoot + savedFileName);
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
		result.put("url", "../resources/images/recipe/"+  ut.getEmail() + "_" + ut.getUser_name() + "/" + savedFileName);
		result.put("responseCode", "success");
		
		return result;
    }
	
	@PostMapping("userRecipeAddOk.do")
	public String userRecipeAddOk(RecipeAddVO recipeAddVO, HttpSession session) {
		// 세션안하면 nullpointException이 뜸
		User_tb ut = (User_tb)session.getAttribute("loginUser");
		recipeAddVO.setEmail(ut.getEmail());
		recipeAddVO.setUser_type(ut.getUser_type());
		String user_name = ut.getUser_name();
		
		log.info("######################## userRecipeAddOk 의  recipeAddVo : " +  recipeAddVO);
		boolean flag = rservice.userRecipeAddOkS(recipeAddVO, user_name);
		
		if(flag) {
			return "recipe/recipeAddMessage";
		}
		else {
			return null;
		}	
	}
	
	//관리자 레시피 좋아요 버튼 클릭 시
	// gubun값으로 현재 위치에 맞게 페이지를 전환
	@GetMapping("listGoodClick.do")
	public String listGoodClick(Good gd, String gubun, HttpSession session) throws UnsupportedEncodingException {
		if(session.getAttribute("loginUser") == null) {
			gd.setEmail("");
			boolean flag = rservice.listGoodClickS(gd);
			String encode_rc_idx = URLEncoder.encode(Long.toString(gd.getRc_idx()), "UTF-8");
			
			if(flag) {
				if(gubun.equals("list")) {
					return "redirect:list_manage.do";
				}
				else {
					return "redirect:recipe_detail.do?rc_idx=" + encode_rc_idx;
				}
			}
			else {
				return null;
			}
		}
		else {
			User_tb ut = (User_tb)session.getAttribute("loginUser");
			gd.setEmail(ut.getEmail());
			log.info("######################## listGoodClick.do gd : " +  gd);
			log.info("######################## gubun : " + gubun);
//			return null;
			boolean flag = rservice.listGoodClickS(gd);
			String encode_rc_idx = URLEncoder.encode(Long.toString(gd.getRc_idx()), "UTF-8");
			
			if(flag) {
				if(gubun.equals("list")) {
					return "redirect:list_manage.do";
				}
				else {
					return "redirect:recipe_detail.do?rc_idx=" + encode_rc_idx;
				}
			}
			else {
				return null;
			}
		}

	}
	//관리자 좋아요 버튼 클릭 취소 시
	@GetMapping("listUnGoodClick.do")
	public String listUnGoodClick(Good gd, String gubun, HttpSession session) throws UnsupportedEncodingException  {
		if(session.getAttribute("loginUser") == null) {
			gd.setEmail("");
			boolean flag = rservice.listUnGoodClickS(gd);
			String encode_rc_idx = URLEncoder.encode(Long.toString(gd.getRc_idx()), "UTF-8");
			if(flag) {
				if(gubun.equals("list")) {
					return "redirect:list_manage.do";
				}
				else {
					return "redirect:recipe_detail.do?rc_idx=" + encode_rc_idx;
				}
				
			}
			else {
				return null;
			}
		}
		else {
			User_tb ut = (User_tb)session.getAttribute("loginUser");
			gd.setEmail(ut.getEmail());
			boolean flag = rservice.listUnGoodClickS(gd);
			String encode_rc_idx = URLEncoder.encode(Long.toString(gd.getRc_idx()), "UTF-8");
			if(flag) {
				if(gubun.equals("list")) {
					return "redirect:list_manage.do";
				}
				else {
					return "redirect:recipe_detail.do?rc_idx=" + encode_rc_idx;
				}
			}
			else {
				return null;
			}
		}
	}
	//유저 좋아요 버튼 클릭 취소 시
	@GetMapping("UserUnGoodClick.do")
	public String UserUnGoodClick(Good gd, String gubun, HttpSession session) throws UnsupportedEncodingException {
		if(session.getAttribute("loginUser") == null) {
			gd.setEmail("");
			boolean flag = rservice.listUnGoodClickS(gd);
			String encode_rc_idx = URLEncoder.encode(Long.toString(gd.getRc_idx()), "UTF-8");
			
			if(flag) {
				if(gubun.equals("list")) {
					return "redirect:list_user.do";
				}
				else {
					return "redirect:user_recipe_detail.do?rc_idx=" + encode_rc_idx;
				}
			}
			else {
				return null;
			}
		}
		else {
			User_tb ut = (User_tb)session.getAttribute("loginUser");
			gd.setEmail(ut.getEmail());
			boolean flag = rservice.listUnGoodClickS(gd);
			String encode_rc_idx = URLEncoder.encode(Long.toString(gd.getRc_idx()), "UTF-8");
			
			if(flag) {
				if(gubun.equals("list")) {
					return "redirect:list_user.do";
				}
				else {
					return "redirect:user_recipe_detail.do?rc_idx=" + encode_rc_idx;
				}
			}
			else {
				return null;
			}
		}
	}
	//유저 좋아요 버튼 클릭 시
	@GetMapping("UserGoodClick.do")
	public String UserGoodClick(Good gd, String gubun, HttpSession session) throws UnsupportedEncodingException {
		if(session.getAttribute("loginUser") == null) {
			gd.setEmail("");
			boolean flag = rservice.listGoodClickS(gd);
			String encode_rc_idx = URLEncoder.encode(Long.toString(gd.getRc_idx()), "UTF-8");
			
			if(flag) {
				if(gubun.equals("list")) {
					return "redirect:list_user.do";
				}
				else {
					return "redirect:user_recipe_detail.do?rc_idx=" + encode_rc_idx;
				}
			}
			else {
				return null;
			}
		}
		else {
			User_tb ut = (User_tb)session.getAttribute("loginUser");
			gd.setEmail(ut.getEmail());
			log.info("######################## listGoodClick.do gd : " +  gd);
			boolean flag = rservice.listGoodClickS(gd);
			String encode_rc_idx = URLEncoder.encode(Long.toString(gd.getRc_idx()), "UTF-8");
			
			if(flag) {
				if(gubun.equals("list")) {
					return "redirect:list_user.do";
				}
				else {
					return "redirect:user_recipe_detail.do?rc_idx=" + encode_rc_idx;
				}
			}
			else {
				return null;
			}
		}
	}
	
	// 관리자 레시피 후기 삭제
	@GetMapping("del.do")
	public String Managerdelete(String rc_title, long reply_idx, long rc_idx, HttpSession session) throws UnsupportedEncodingException {
		User_tb usrtb = (User_tb)session.getAttribute("loginUser");
		usrtb.setEmail(usrtb.getEmail());
		
		String reply_img = rservice.ManagerdeleteImage(reply_idx);
		log.info("###################### 이미지 확인 : " + reply_img);
		if(reply_img != null) {
			File file = new File(Path.RECIPE_PATH + "/" + rc_title, reply_img);
			file.delete();
		}

		rservice.ManagerdeleteS(reply_idx);
		log.info("######################" + rc_idx);
		return "redirect:recipe_detail.do?rc_idx=" + rc_idx;
	}
	// 유저 레시피 후기 삭제
	@GetMapping("userdel.do")
	public String Userdelete(String rc_title, String email, long reply_idx, long rc_idx, HttpSession session) throws UnsupportedEncodingException {
		User_tb usrtb = (User_tb)session.getAttribute("loginUser");
		usrtb.setEmail(usrtb.getEmail());
		
		String reply_img = rservice.ManagerdeleteImage(reply_idx);
		log.info("###################### 이미지 확인 : " + reply_img);
		if(reply_img != null) {
			File file = new File(Path.RECIPE_PATH + "/" + email + "/" + rc_title, reply_img);
			file.delete();
		}

		rservice.ManagerdeleteS(reply_idx);
		log.info("######################" + rc_idx);
		return "redirect:user_recipe_detail.do?rc_idx=" + rc_idx;
	}
	
	// 유저 레시피 삭제
	@GetMapping("user_recipe_del.do")
	public ModelAndView userRecipeDel(long rc_idx) {
		
		rservice.userRecipeDelS(rc_idx);
		
		
		ModelAndView mv = new ModelAndView("recipe/userRecipeDelMessage");
		return mv;
	}
	
	@GetMapping("manager_recipe_del.do")
	public ModelAndView managerRecipeDel(long rc_idx) {
		
		rservice.managerRecipeDelS(rc_idx);
		
		ModelAndView mv = new ModelAndView("recipe/managerRecipeDelMessage");
		return mv;
	}
}
