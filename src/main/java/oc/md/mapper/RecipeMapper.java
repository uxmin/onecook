package oc.md.mapper;

import java.util.HashMap;
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

public interface RecipeMapper {
	public List<Food> categorySelect(String category);
	public boolean userRecipeInsert(RecipeAddVO recipeAddVO);
	public boolean userRecipeCountInsert(RecipeAddVO recipeAddVO);
	public boolean recipeInsert(RecipeAddVO recipeAddVO);
	public void recipeImageInsert(RecipeAddVO recipeAddVO);
	public void recipeMaterialInsert(RecipeAddVO recipeAddVO);
	//������ ����� �߰�
	public void recipeNutrientInsert(RecipeAddVO recipeAddVO);
	//������ ������
	public void updateRecipeCount(long rc_idx);
	public List<Recipe> recipePage(FoodPagingVO foodPagingVO);
	public long recipeCount();
	public List<Recipe> recipeCatPage(FoodPagingVO foodPagingVO);
	public long recipeCatCount(String category);
	public List<Recipe> recipeAllNewPage(FoodPagingVO foodPagingVO);
	public List<Recipe> recipeAllGoodPage(FoodPagingVO foodPagingVO);
	public List<Recipe> recipeAllViewPage(FoodPagingVO foodPagingVO);
	public List<Recipe> recipeCatNewPage(FoodPagingVO foodPagingVO);
	public List<Recipe> recipeCatGoodPage(FoodPagingVO foodPagingVO);
	public List<Recipe> recipeCatViewPage(FoodPagingVO foodPagingVO);
	public List<Recipe> searchPage(FoodPagingVO foodPagingVO);
	public long searchCount(String rc_title);
	
	//���� ������
	public List<Recipe> recipeUserTop(PagingVO pagingVO);
	public List<Recipe> recipeUserPage(PagingVO pagingVO);
	public long recipeUserCount();
	//����-���Ǻ�����Ʈ
	public List<Recipe> recipeUserSortGoodPage(PagingVO pagingVO);
	public List<Recipe> recipeUserSortViewPage(PagingVO pagingVO);
	//����-�˻�
	public List<Recipe> searchUserTitlePage(PagingVO pagingVO);
	public long searchUserTitleCount(String rc_title);
	public List<Recipe> searchUserWriterPage(PagingVO pagingVO);
	public long searchUserWriterCount(String email);
	//������ �� ������
	public Recipe selectUserRecipe(Recipe rc);
	public Recipe selectManagerRecipe(Recipe rc);
	public Image selectUserRecipeResult(long rc_idx);
	public List<Recipe_detail> selectByRecipe_detail(long rc_idx);
	public List<Recipe_material> selectByRecipe_material(long rc_idx);
	public List<Recipe_food> selectByRecipe_food(long rc_idx);
	//������ ���
	public String selectRecipeName(long get_rc_idx);
	public String selectRecipeUserEmail(long get_rc_idx);
	public List<Recipe_reply> selectPerPage(HashMap<String, Object> query);
	public long selectCount(long long_rc_idx);
	//����� �߰�
	public List<Recipe_nutrient> selectByRecipe_nutrient(long rc_idx);
	public void insertImage(Recipe_reply recipe_reply);
	public void insertNoImage(Recipe_reply recipe_reply);
	public Recipe_reply selectBySeq(long reply_idx);
	//���ƿ�
	public boolean listGoodClick(Good gd);
	public boolean listUnGoodClick(Good gd);
	//������ ������ ��� ����
	public void Managerdelete(long reply_idx);
	public String ManagerdeleteImage(long reply_idx);
	// ���� ������ ��� ����
//	public void Userdelete(long reply_idx);
//	public String UserdeleteImage(long reply_idx);	
	//���������� ����
	public void userRecipeImageDel(long rc_idx);
	public void userRecipeGoodDel(long rc_idx);
	public void userRecipeReplyDel(long rc_idx);
	public void userRecipeDel(long rc_idx);
	//������ ������ ���� �߰�
	public void managerNutrientDel(long rc_idx);
	public void managerMaterialDel(long rc_idx);
	
}
