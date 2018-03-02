package bean;

public class activities {
	
	private String aid;
	private String aname;
	private String begin_time;
	private String end_time;
	
	//实现customers对象set、get的基本方法
	public String get_aid(){return this.aid;}
	public String get_aname(){return this.aname;}
	public String get_begin_time(){return this.begin_time;}
	public String get_end_time(){return this.end_time;}
	
	public void set_aid(String aid){this.aid=aid;}
	public void set_aname(String aname){this.aname=aname;}
	public void set_begin_time(String begin_time){this.begin_time=begin_time;}
	public void set_end_time(String end_time){this.end_time=end_time;}

}
