package dao;

import bean.meals;
import java.util.List;

public abstract interface MealDao 
{
	//创建接口数据库的查询
	public abstract int add_meals(meals meal)throws Exception;
	public abstract int del_meals(String id)throws Exception;
	public abstract List<meals> que_meals(String info)throws Exception;
	public abstract int upd_meals(meals meal)throws Exception;
	public abstract List<meals> main_meals()throws Exception;
}