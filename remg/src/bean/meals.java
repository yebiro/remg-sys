package bean;

public class meals {

	private String mid;
	private String mname;
	private String mprice;
	private String meal_integral;
	private String qoh;
	private String qoh_threshold;
	
	//实现customers对象set、get的基本方法
	public String get_mid(){return this.mid;}
	public String get_mname(){return this.mname;}
	public String get_mprice(){return this.mprice;}
	public String get_meal_integral(){return this.meal_integral;}
	public String get_qoh(){return this.qoh;}
	public String get_qoh_threshold(){return this.qoh_threshold;}
	
	public void set_mid(String mid){this.mid=mid;}
	public void set_mname(String mname){this.mname=mname;}
	public void set_mprice(String mprice){this.mprice=mprice;}
	public void set_meal_integral(String meal_integral){this.meal_integral=meal_integral;}
	public void set_qoh(String qoh){this.qoh=qoh;}
	public void set_qoh_threshold(String qoh_threshold){this.qoh_threshold=qoh_threshold;}
}
