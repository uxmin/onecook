package oc.md.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

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
import oc.md.filesetting.Path;
import oc.md.mapper.RecipeMapper;
import oc.md.vo.FoodPagingVO;
import oc.md.vo.PagingVO;
import oc.md.vo.RecipeAddVO;

@Service
@Log4j
public class RecipeServiceImpl implements RecipeService {
	@Autowired
	private RecipeMapper rmapper;
	
	@Override
	public List<Food> categorySelectS(String category) {
		return rmapper.categorySelect(category);
	}
	//유저 레시피 등록
	@Override
	@Transactional
	public boolean userRecipeAddOkS(RecipeAddVO recipeAddVO, String user_name) {
		MultipartFile f = recipeAddVO.getRc_img_file();
		String gubun = "recipe_user";	//이미지 업로드 구분을 위한 명칭주기
		String recipe_title = recipeAddVO.getEmail();
		
		String recipeMainImage = saveStore(f, recipe_title, gubun , recipeAddVO.getRc_title());
		recipeAddVO.setRc_img(recipe_title + "/" + recipeAddVO.getRc_title()  + "/"+recipeMainImage);	//레시피 메인이미지명 셋 해주기
		
		boolean recipeFlag = rmapper.userRecipeInsert(recipeAddVO);
		long get_idx = recipeAddVO.getRc_idx();
		
		if(recipeFlag) {
			boolean user_content = rmapper.userRecipeCountInsert(recipeAddVO);
			
			if(user_content) {
				return true;
			}
			else {
				return false;
			}
		}
		else {
			return false;
		}
	}
	// 관리자 레시피 등록
	@Override
	@Transactional
	public boolean managerRecipeAddOkS(RecipeAddVO recipeAddVO) {
		MultipartFile f = recipeAddVO.getRc_img_file();
		String gubun = "recipe_main";	//이미지 업로드 구분을 위한 명칭주기
		System.out.println("##################### f : " + f);
		System.out.println("##################### f : " + recipeAddVO);
		System.out.println("##################### f : " + recipeAddVO.getRc_title());
		String recipe_title = recipeAddVO.getRc_title();
		
		String recipeMainImage = saveStore(f, recipe_title, gubun);
		recipeAddVO.setRc_img(recipeMainImage);	//레시피 메인이미지명 셋 해주기
		
		boolean recipeFlag = rmapper.recipeInsert(recipeAddVO);
		long get_idx = recipeAddVO.getRc_idx();
		System.out.println("############### rc_idx : " + get_idx);
		
		if(recipeFlag) {
			int img_count = recipeAddVO.getImage_tb_file().size();
			gubun = "recipe_img";
			List<MultipartFile> lf = recipeAddVO.getImage_tb_file();
			// 레시피 설명과 이미지를 반복하면서 db에 기록 및 서버에 이미지 파일 저장
			for(int i=0; i<img_count; i++) {
				recipeMainImage = saveStore(lf.get(i), recipe_title, gubun);
				recipeAddVO.setImage_tb_file_nm(recipeMainImage);
				recipeAddVO.setGet_img_cont(recipeAddVO.getImg_cont().get(i));
				System.out.println("#################### for문 안의 recipeAddVO : " + recipeAddVO);
				rmapper.recipeImageInsert(recipeAddVO);
			}
			// 재료를 반복하면서 db에 기록
			int material_count = recipeAddVO.getRt_cont().size();
			System.out.println("#################### material_count size : " + material_count);
			for(int j=0; j<material_count; j++) {
				recipeAddVO.setGet_rt_cont(recipeAddVO.getRt_cont().get(j));
				
				if(recipeAddVO.getF_name().isEmpty()) {
					// f_name(해당 재료)가 없을 경우 아무 실행하지 않고 넘어가도록
				}
				else {
					if(!recipeAddVO.getF_name().get(j).isEmpty()) {
						recipeAddVO.setGet_f_name(recipeAddVO.getF_name().get(j));
					}else {			
						recipeAddVO.setGet_f_name(recipeAddVO.getF_name().get(j));
					}
				}

				System.out.println("################### for문 안의 material 확인 : " + recipeAddVO);
				rmapper.recipeMaterialInsert(recipeAddVO);			
			}
			
			//영양소 추가
//			rmapper.recipeNutrientInsert(recipeAddVO);
			for(int k=0; k<recipeAddVO.getNutrient_nm().size(); k++) {
				System.out.println("################### 전 : " + recipeAddVO);
				recipeAddVO.setGet_nutrient_nm(recipeAddVO.getNutrient_nm().get(k));
				recipeAddVO.setGet_rate(recipeAddVO.getRate().get(k));
				rmapper.recipeNutrientInsert(recipeAddVO);
				System.out.println("################### 후 : " + recipeAddVO);
			}
			
			return true;
		}
		else {
			return false;
		}

	}

	//레시피 메인 이미지명 추출
	public String saveStore(MultipartFile f, String recipe_title, String gubun) {
		// TODO Auto-generated method stub
		String ofname = f.getOriginalFilename();
		int idx = ofname.lastIndexOf(".");
		String ofheader = ofname.substring(0, idx);
		String ext = ofname.substring(idx);
		long ms = System.currentTimeMillis();
		StringBuilder sb = new StringBuilder();
		sb.append(ofheader);
		sb.append("_");
		sb.append(ms);
		sb.append(ext);
		String saveFileName = sb.toString();
		long fsize = f.getSize();
		
		System.out.println("ofname : " + ofname + ", fname : " + saveFileName + ", fsize : " + fsize);
		
		boolean flag = writeFile(f, saveFileName, recipe_title, gubun);
		if(flag) {
			log.info("업로드 성공");
		}else {
			log.info("업로드 실패");
		}
		return saveFileName;
	}
	//레시피 유저 파일의 업로드 
	//레시피 메인 이미지명 추출
	public String saveStore(MultipartFile f, String recipe_title, String gubun, String recipe_sub_title) {
		// TODO Auto-generated method stub
		String ofname = f.getOriginalFilename();
		int idx = ofname.lastIndexOf(".");
		String ofheader = ofname.substring(0, idx);
		String ext = ofname.substring(idx);
		long ms = System.currentTimeMillis();
		StringBuilder sb = new StringBuilder();
		sb.append(ofheader);
		sb.append("_");
		sb.append(ms);
		sb.append(ext);
		String saveFileName = sb.toString();
		long fsize = f.getSize();
		
		System.out.println("ofname : " + ofname + ", fname : " + saveFileName + ", fsize : " + fsize);
		
		boolean flag = writeFile(f, saveFileName, recipe_title, gubun, recipe_sub_title);
		if(flag) {
			log.info("업로드 성공");
		}else {
			log.info("업로드 실패");
		}
		return saveFileName;
	}
	
	//레시피 메인 이미지 파일 업로드
	public boolean writeFile(MultipartFile f, String saveFileName, String recipe_title, String gubun) {	
		//인터페이스 메소드는 무조껀 public임		
		String path = "";
		if(gubun.equals("recipe_main")) {
			path = Path.RECIPE_PATH + recipe_title + "/";
		}
		else if(gubun.equals("recipe_img")){
			path = Path.RECIPE_PATH + recipe_title + "/";
		}
		else if(gubun.equals("recipe_reply")) {
			path = Path.RECIPE_PATH + recipe_title + "/";
		}
		else if(gubun.equals("recipe_user")) {
			path = Path.USER_RECIPE_PATH + recipe_title + "/";
		}
//		System.out.println("############### writeFile path : " + path);
//		System.out.println("############### writeFile saveFileName : " + saveFileName);
		File dir = new File(path);
		
		if(!dir.exists()) dir.mkdirs();
		
		FileOutputStream fos = null;
		try {
			byte data[] = f.getBytes();
			fos = new FileOutputStream(path + saveFileName);
			fos.write(data);
			fos.flush();
			
			return true;
		}
		catch(IOException ie) {
			return false;
		}
		finally {
			try {
				fos.close();
			}
			catch(IOException ie) {}
		}
	}	
	// 유저레시피 이미지 업로드
	//레시피 메인 이미지 파일 업로드
	public boolean writeFile(MultipartFile f, String saveFileName, String recipe_title, String gubun, String recipe_sub_title) {	
		//인터페이스 메소드는 무조껀 public임		
		String path = "";
		if(gubun.equals("recipe_main")) {
			path = Path.RECIPE_PATH + recipe_title + "/";
		}
		else if(gubun.equals("recipe_img")){
			path = Path.RECIPE_PATH + recipe_title + "/";
		}
		else if(gubun.equals("recipe_reply")) {
			path = Path.RECIPE_PATH + recipe_title + "/" + recipe_sub_title + "/";
		}
		else if(gubun.equals("recipe_user")) {
			path = Path.USER_RECIPE_PATH + recipe_title + "/" + recipe_sub_title + "/";
		}
//		System.out.println("############### writeFile path : " + path);
//		System.out.println("############### writeFile saveFileName : " + saveFileName);
		File dir = new File(path);
		
		if(!dir.exists()) dir.mkdirs();
		
		FileOutputStream fos = null;
		try {
			byte data[] = f.getBytes();
			fos = new FileOutputStream(path + saveFileName);
			fos.write(data);
			fos.flush();
			
			return true;
		}
		catch(IOException ie) {
			return false;
		}
		finally {
			try {
				fos.close();
			}
			catch(IOException ie) {}
		}
	}	
	
	// 관리자 레시피
	@Override
	public void updateRecipeCountS(long rc_idx) {
		rmapper.updateRecipeCount(rc_idx);
	}
	
	@Override
	public List<Recipe> recipePageS(FoodPagingVO foodPagingVO) {
		return rmapper.recipePage(foodPagingVO);
	}
	@Override
	public long recipeCountS() {
		return rmapper.recipeCount();
	}
	
	@Override
	public List<Recipe> recipeCatPageS(FoodPagingVO foodPagingVO) {
		return rmapper.recipeCatPage(foodPagingVO);
	}
	@Override
	public long recipeCatCountS(String category) {
		return rmapper.recipeCatCount(category);
	}
	
	@Override
	public List<Recipe> recipeAllNewPageS(FoodPagingVO foodPagingVO) {
		return rmapper.recipeAllNewPage(foodPagingVO);
	}
	@Override
	public List<Recipe> recipeAllGoodPageS(FoodPagingVO foodPagingVO) {
		return rmapper.recipeAllGoodPage(foodPagingVO);
	}
	@Override
	public List<Recipe> recipeAllViewPageS(FoodPagingVO foodPagingVO) {
		return rmapper.recipeAllViewPage(foodPagingVO);
	}
	@Override
	public List<Recipe> recipeCatNewPageS(FoodPagingVO foodPagingVO) {
		return rmapper.recipeCatNewPage(foodPagingVO);
	}
	@Override
	public List<Recipe> recipeCatGoodPageS(FoodPagingVO foodPagingVO) {
		return rmapper.recipeCatGoodPage(foodPagingVO);
	}
	@Override
	public List<Recipe> recipeCatViewPageS(FoodPagingVO foodPagingVO) {
		return rmapper.recipeCatViewPage(foodPagingVO);
	}
	
	@Override
	public List<Recipe> searchPageS(FoodPagingVO foodPagingVO) {
		return rmapper.searchPage(foodPagingVO);
	}
	@Override
	public long searchCountS(String rc_title) {
		return rmapper.searchCount(rc_title);
	}
	// 유저 레시피
	@Override
	public List<Recipe> recipeUserTopS(PagingVO pagingVO){
		return rmapper.recipeUserTop(pagingVO);
	}
	
	@Override
	public List<Recipe> recipeUserPageS(PagingVO pagingVO) {
		return rmapper.recipeUserPage(pagingVO);
	}
	@Override
	public long recipeUserCountS() {
		return rmapper.recipeUserCount();
	}
	
	@Override
	public List<Recipe> recipeUserSortGoodPageS(PagingVO pagingVO) {
		return rmapper.recipeUserSortGoodPage(pagingVO);
	}
	@Override
	public List<Recipe> recipeUserSortViewPageS(PagingVO pagingVO) {
		return rmapper.recipeUserSortViewPage(pagingVO);
	}
	
	@Override
	public List<Recipe> searchUserTitlePageS(PagingVO pagingVO){
		return rmapper.searchUserTitlePage(pagingVO);
	}
	@Override
	public long searchUserTitleCountS(String rc_title) {
		return rmapper.searchUserTitleCount(rc_title);
	}
	@Override
	public List<Recipe> searchUserWriterPageS(PagingVO pagingVO){
		return rmapper.searchUserWriterPage(pagingVO);
	}
	@Override
	public long searchUserWriterCountS(String email) {
		return rmapper.searchUserWriterCount(email);
	}
	// 관리자 레시피 상세페이지
	public Recipe selectManagerRecipeS(Recipe rc) {
		return rmapper.selectManagerRecipe(rc);
	}
	
	// 유저 레시피 상세 페이지
	@Override
	public Recipe selectUserRecipeS(Recipe rc) {
		return rmapper.selectUserRecipe(rc);
	}
	@Override
	public Image selectUserRecipeResultS(long rc_idx) {
		return rmapper.selectUserRecipeResult(rc_idx);
	}
	// 레시피 상세 페이지
	@Override
	public List<Recipe_detail> selectByRecipe_detailS(long rc_idx) {
		List<Recipe_detail> list = rmapper.selectByRecipe_detail(rc_idx);
		return list;
	}
	@Override
	public List<Recipe_material> selectByRecipe_materialS(long rc_idx){
		List<Recipe_material> material = rmapper.selectByRecipe_material(rc_idx);
		return material;
	}
	@Override
	public List<Recipe_food> selectByRecipe_foodS(long rc_idx){
		List<Recipe_food> food = rmapper.selectByRecipe_food(rc_idx);
		return food;
	}
	// 레시피 댓글
	@Override
	public List<Recipe_reply> selectPerPageS(PagingVO pagingVo, String rc_idx) {
		log.info("#>test : "+rc_idx);
		HashMap<String, Object> query = new HashMap<String, Object>();
		query.put("rc_idx", rc_idx);
		query.put("page", pagingVo);
		List<Recipe_reply> list = rmapper.selectPerPage(query);
		log.info("#>2");
		return list;
	}

	@Override
	public long selectCountS(long long_rc_idx) {
		return rmapper.selectCount(long_rc_idx);
	}
	//영양소 추가
	@Override
	public List<Recipe_nutrient> selectByRecipe_nutrientS(long rc_idx){
		return rmapper.selectByRecipe_nutrient(rc_idx);
	}
	
	@Override
	public long insertS(Recipe_reply recipe_reply) {
		Recipe_reply recipe_reply2 = null;
		String gubun = "recipe_reply";	//이미지 업로드 구분을 위한 명칭주기
		long get_rc_idx = recipe_reply.getRc_idx(); //나중에 이부분을 레시피 번호를 받아오는것으로 변경해주기
		String recipe_title = rmapper.selectRecipeName(get_rc_idx); 
		System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! : " + recipe_title);
		
		if(recipe_reply.getReply_img_file().getOriginalFilename().trim().equals("")) {
			recipe_reply2 = new Recipe_reply(-1L, recipe_reply.getEmail(), recipe_reply.getUser_name() , recipe_reply.getRc_idx(), recipe_reply.getReply_cont(), recipe_reply.getReply_date(), null, null, recipe_reply.getReply_sub(), null);
			rmapper.insertNoImage(recipe_reply2);
		}else {
			if(recipe_reply.getWrite_gubun().equals("MEMBER")) {
				String recipe_email = rmapper.selectRecipeUserEmail(get_rc_idx);
				String ofname = saveStore(recipe_reply.getReply_img_file(), recipe_email, gubun, recipe_title);
				recipe_reply2 = new Recipe_reply(-1L, recipe_reply.getEmail(), recipe_reply.getUser_name() , recipe_reply.getRc_idx(), recipe_reply.getReply_cont(), recipe_reply.getReply_date(), null, ofname, recipe_reply.getReply_sub(), null);
				System.out.println("####################################### log recipe_reply2 : " + recipe_reply2);
				rmapper.insertImage(recipe_reply2);
			}
			else if(recipe_reply.getWrite_gubun().equals("MANAGER")) {
				String ofname = saveStore(recipe_reply.getReply_img_file(), recipe_title, gubun);
				recipe_reply2 = new Recipe_reply(-1L, recipe_reply.getEmail(), recipe_reply.getUser_name() , recipe_reply.getRc_idx(), recipe_reply.getReply_cont(), recipe_reply.getReply_date(), null, ofname, recipe_reply.getReply_sub(), null);
				System.out.println("####################################### log recipe_reply2 : " + recipe_reply2);
				rmapper.insertImage(recipe_reply2);
			}
		
		}
		return recipe_reply2.getRc_idx();
	}
	
	@Override
	public Recipe_reply selectBySeqS(long reply_idx) {
		return rmapper.selectBySeq(reply_idx);
	}
	// 좋아요 클릭
	@Override
	public boolean listGoodClickS(Good gd) {
		return rmapper.listGoodClick(gd);
	}
	@Override
	public boolean listUnGoodClickS(Good gd) {
		return rmapper.listUnGoodClick(gd);
	}
	// 관리자 레시피 댓글 삭제
	@Override
	public void ManagerdeleteS(long reply_idx) {
		rmapper.Managerdelete(reply_idx);
	}
	@Override
	public String ManagerdeleteImage(long reply_idx) {
		return rmapper.ManagerdeleteImage(reply_idx);
	}
	// 유저 레시피 댓글 삭제
//	@Override
//	public void UserdeleteS(long reply_idx) {
//		rmapper.Userdelete(reply_idx);
//	}
//	@Override
//	public String UserdeleteImage(long reply_idx) {
//		return rmapper.UserdeleteImage(reply_idx);
//	}
	@Override
	@Transactional
	public void userRecipeDelS(long rc_idx) {
		rmapper.userRecipeImageDel(rc_idx);
		rmapper.userRecipeGoodDel(rc_idx);
		rmapper.userRecipeReplyDel(rc_idx);
		rmapper.userRecipeDel(rc_idx);
	}
	//관리자레시피 삭제
	@Override
	@Transactional
	public void managerRecipeDelS(long rc_idx) {
		rmapper.managerNutrientDel(rc_idx);
		rmapper.managerMaterialDel(rc_idx);
		
		rmapper.userRecipeImageDel(rc_idx);
		rmapper.userRecipeGoodDel(rc_idx);
		rmapper.userRecipeReplyDel(rc_idx);
		rmapper.userRecipeDel(rc_idx);
	}
}
