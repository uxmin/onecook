package oc.md.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import oc.md.domain.Food;
import oc.md.domain.Recipe;
import oc.md.mapper.IndexMapper;

@Service
public class IndexServiceImpl implements IndexService {
	@Autowired
	private IndexMapper imapper;
	
	@Override
	public List<Recipe> mainRecipeListS() {
		return imapper.mainRecipeList();
	}
	
	@Override
	public List<Food> mainFoodListS(){
		return imapper.mainFoodList();
	}

}
