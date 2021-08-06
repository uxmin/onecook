package oc.md.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import lombok.extern.log4j.Log4j;
import oc.md.domain.Food;
import oc.md.domain.Recipe;
import oc.md.service.IndexService;

@Controller
@Log4j
public class IndexController {
	@Autowired
	private IndexService iservice;
	
	@RequestMapping(value="index_test.do" , method=RequestMethod.GET)
	public String index_test() {
		return "index_test";
	}
	
	@RequestMapping(value="/", method=RequestMethod.GET)
	public ModelAndView index() {
		List<Recipe> rlist = iservice.mainRecipeListS();
		List<Food> flist = iservice.mainFoodListS();
	
		ModelAndView mv = new ModelAndView();
		mv.setViewName("index");
		mv.addObject("rlist", rlist);
		mv.addObject("flist", flist);
		
		return mv;
	}
}
