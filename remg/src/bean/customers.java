package bean;

public class customers 
{
	private String cid;
	private String cname;
	private String sex;
	private String level;
	private String integral;
	private String register_time;
	private String last_visit_time;
	private String visits_made;
	private String telephone_no;
	private String birthdate;
	
	//实现customers对象set、get的基本方法
	public String get_cid(){return this.cid;}
	public String get_cname(){return this.cname;}
	public String get_sex(){return this.sex;}
	public String get_level(){return this.level;}
	public String get_integral(){return this.integral;}
	public String get_register_time(){return this.register_time;}
	public String get_last_visit_time(){return this.last_visit_time;}
	public String get_visits_made(){return this.visits_made;}
	public String get_telephone_no(){return this.telephone_no;}
	public String get_birthdate(){return this.birthdate;}
	
	public void set_cid(String cid){this.cid=cid;}
	public void set_cname(String cname){this.cname=cname;}
	public void set_sex(String sex){this.sex=sex;}
	public void set_level(String level){this.level=level;}
	public void set_integral(String integral){this.integral=integral;}
	public void set_register_time(String register_time){this.register_time=register_time;}
	public void set_last_visit_time(String last_visit_time){this.last_visit_time=last_visit_time;}
	public void set_visits_made(String visits_made){this.visits_made=visits_made;}
	public void set_telephone_no(String telephone_no){this.telephone_no=telephone_no;}
	public void set_birthdate(String birthdate){this.birthdate=birthdate;}
}

