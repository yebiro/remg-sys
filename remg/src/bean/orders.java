package bean;

public class orders {

	private String oid;
	private String cid;
	private String eid;
	private String sid;
	private String mid;
	private String aid;
	private String staid;
	private String qty;
	private String otime;
	private String a_discount;
	private String final_price;
	private String level;
	private String mname;
	private String staname;
	
	//实现customers对象set、get的基本方法
	public String get_oid(){return this.oid;}
	public String get_cid(){return this.cid;}
	public String get_eid(){return this.eid;}
	public String get_sid(){return this.sid;}
	public String get_mid(){return this.mid;}
	public String get_aid(){return this.aid;}
	public String get_staid(){return this.staid;}
	public String get_qty(){return this.qty;}
	public String get_otime(){return this.otime;}
	public String get_a_discount(){return this.a_discount;}
	public String get_final_price(){return this.final_price;}
	public String get_level(){return this.level;}
	public String get_mname(){return this.mname;}
	public String get_staname(){return this.staname;}
	
	public void set_oid(String oid){this.oid=oid;}
	public void set_cid(String cid){this.cid=cid;}
	public void set_eid(String eid){this.eid=eid;}
	public void set_sid(String sid){this.sid=sid;}
	public void set_mid(String mid){this.mid=mid;}
	public void set_aid(String aid){this.aid=aid;}
	public void set_staid(String staid){this.staid=staid;}
	public void set_qty(String qty){this.qty=qty;}
	public void set_otime(String otime){this.otime=otime;}
	public void set_a_discount(String a_discount){this.a_discount=a_discount;}
	public void set_final_price(String final_price){this.final_price=final_price;}
	public void set_level(String level){this.level=level;}
	public void set_mname(String mname){this.mname=mname;}
	public void set_staname(String staname){this.staname=staname;}
}
