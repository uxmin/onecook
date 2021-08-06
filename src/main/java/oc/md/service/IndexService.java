package oc.md.service;

import java.util.List;

import oc.md.domain.Food;
import oc.md.domain.Recipe;

public interface IndexService {
	List<Recipe> mainRecipeListS();
	List<Food> mainFoodListS();
}
