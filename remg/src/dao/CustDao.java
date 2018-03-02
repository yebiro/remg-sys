package dao;

import java.util.List;

import bean.customers;

public abstract interface CustDao 
{
	//创建接口数据库的查询
	public abstract int add_customers(customers cust)throws Exception;
	public abstract int del_customers(String id)throws Exception;
	public abstract List<customers> que_customers(String info)throws Exception;
	public abstract int upd_customers(customers cust)throws Exception;
	public abstract List<customers> main_customers()throws Exception;
}

