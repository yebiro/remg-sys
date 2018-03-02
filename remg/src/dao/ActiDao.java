package dao;

import java.util.List;

import bean.activities;

public abstract interface ActiDao {
	    //创建接口数据库的查询
		public abstract int add_activities(activities acti)throws Exception;
		public abstract int del_activities(String id)throws Exception;
		public abstract List<activities> que_activities(String info)throws Exception;
		public abstract int upd_activities(activities acti)throws Exception;
		public abstract List<activities> main_activities()throws Exception;
}
