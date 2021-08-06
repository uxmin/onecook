package oc.md.service;

import java.util.List;

import oc.md.domain.Food;
import oc.md.domain.Good;
import oc.md.domain.Image;
import oc.md.domain.Recipe;
import oc.md.domain.Recipe_detail;
import oc.md.domain.Recipe_food;
import oc.md.domain.Recipe_material;
import oc.md.domain.Recipe_nutrient;
import oc.md.domain.Recipe_reply;
import oc.md.vo.FoodPagingVO;
import oc.md.vo.PagingVO;
import oc.md.vo.RecipeAddVO;

public interface RecipeService {
	List<Food> categorySelectS(String category);
	boolean managerRecipeAddOkS(RecipeAddVO recipeAddVO);
	boolean userRecipeAddOkS(RecipeAddVO recipeAddVO, String user_name);
	Recipe selectUserRecipeS(Recipe rc);
	Recipe selectManagerRecipeS(Recipe rc);
	public Image selectUserRecipeResultS(long rc_idx);
	//관리자 레시피
	void updateRecipeCountS(long rc_idx);
	List<Recipe> recipePageS(FoodPagingVO foodPagingVO);
	long recipeCountS();
	List<Recipe> recipeCatPageS(FoodPagingVO foodPagingVO);
	long recipeCatCountS(String category);
	List<Recipe> recipeAllNewPageS(FoodPagingVO foodPagingVO);
	List<Recipe> recipeAllGoodPageS(FoodPagingVO foodPagingVO);
	List<Recipe> recipeAllViewPageS(FoodPagingVO foodPagingVO);
	List<Recipe> recipeCatNewPageS(FoodPagingVO foodPagingVO);
	List<Recipe> recipeCatGoodPageS(FoodPagingVO foodPagingVO);
	List<Recipe> recipeCatViewPageS(FoodPagingVO foodPagingVO);
	List<Recipe> searchPageS(FoodPagingVO foodPagingVO);
	long searchCountS(String rc_title);
	//영양소 추가
	List<Recipe_nutrient> selectByRecipe_nutrientS(long rc_idx);
	
	//유저 레시피
	List<Recipe> recipeUserTopS(PagingVO pagingVO);
	List<Recipe> recipeUserPageS(PagingVO pagingVO);
	long recipeUserCountS();
	List<Recipe> recipeUserSortGoodPageS(PagingVO pagingVO);
	List<Recipe> recipeUserSortViewPageS(PagingVO pagingVO);
	List<Recipe> searchUserTitlePageS(PagingVO pagingVO);
	long searchUserTitleCountS(String rc_title);
	List<Recipe> searchUserWriterPageS(PagingVO pagingVO);
	long searchUserWriterCountS(String email);
	// 레시피 상세 페이지
	List<Recipe_detail> selectByRecipe_detailS(long rc_idx);
	List<Recipe_material> selectByRecipe_materialS(long rc_idx);
	List<Recipe_food> selectByRecipe_foodS(long rc_idx);
	
	// 레시피 댓글
	List<Recipe_reply> selectPerPageS(PagingVO pagingVo, String rc_idx);
	long selectCountS(long long_rc_idx);
	long insertS(Recipe_reply recipe_reply);
	Recipe_reply selectBySeqS(long reply_idx);
	
	// 좋아요
	boolean listGoodClickS(Good gd);
	boolean listUnGoodClickS(Good gd);
	// 관리자,유저 레시피 댓글 삭제
	void ManagerdeleteS(long reply_idx);
	String ManagerdeleteImage(long reply_idx);
	// 유저 레시피 댓글 삭제
//	void UserdeleteS(long reply_idx);
//	String UserdeleteImage(long reply_idx);
	//유저레시피 삭제
	void userRecipeDelS(long rc_idx);
	//관리자레시피 삭제
	void managerRecipeDelS(long rc_idx);
}
