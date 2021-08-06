package oc.md.mapper;

import java.util.List;

import oc.md.domain.Food;
import oc.md.domain.Recipe;

public interface IndexMapper {
	public List<Recipe> mainRecipeList();
	public List<Food> mainFoodList();
}
