package com.kh.hsfs.impl;

import java.util.List;

import com.kh.base.impl.BaseDaoImpl;
import com.kh.hsfs.dao.ChartDao;
import com.kh.util.DicUtil;
import com.kh.util.PageUtil;

public class ChartImpl implements ChartDao{
	private BaseDaoImpl bdi;
	public PageUtil getlist(int currpage,int count,String sql){		
		PageUtil pu=bdi.findBySqlPage(currpage, count, sql);
		return pu;
	}
	
	public List yszl(String proname, String insql) {
		return bdi.chartCount(proname, insql);
	}
	
	
	/**
	 * 获得接种疫苗
	 */
	public List getJzym(){
		return bdi.getByJdbcSQL(DicUtil.immunity);
	}
	
	public List selfwjl(String sql){
		return bdi.getByJdbcSQL(sql);
	}
	//资金到账情况统计
	public List account(String orgcode,String buryear){
		String sql="select offer_money,balance_money from hsfs_account t where org_code='"+orgcode+"' and buryear='"+buryear+"' ";
//		System.out.println(sql);
		return bdi.getByJdbcSQL(sql);
	}
	//十二项服务 各使用情况
	public List account_services(String orgareaid,String buryear){
		String sql="select t.name,t2.money from hsfs_servtype_setting t  left join ( select t3.serv_code,sum(t3.money) money from hsfs_fund_apply_detail t3, hsfs_fund_apply_form t,hsfs_org_base_info t2 where t3.apply_id=t.id and t.offer_state <> 2 and  t.org_code=t2.org_code and t2.org_areaid like '"+orgareaid+"%' and t.buryear='"+buryear+"' group by t3.serv_code ) t2 on t.code=t2.serv_code  where buryear='"+buryear+"'";
//		System.out.println(sql);
		return bdi.getByJdbcSQL3(sql);
	}
	//十二项服务 各使用情况
		public List account_servicesuser(String orgareaid,String buryear){
			String sql="select t.name,t2.money from hsfs_servtype_setting t  left join ( select t3.serv_code,sum(t3.money) money from hsfs_fund_apply_detail t3, hsfs_fund_apply_form t,hsfs_org_base_info t2 where t3.apply_id=t.id and t.offer_state <> 2 and  t.org_code=t2.org_code and t2.org_code ='"+orgareaid+"' and t.buryear='"+buryear+"' group by t3.serv_code ) t2 on t.code=t2.serv_code  where buryear='"+buryear+"'";
			//System.out.println(sql);
			return bdi.getByJdbcSQL3(sql);
		}
	public List account_obj(String sql){
		return bdi.getByJdbcSQL3(sql);
	}
	public List account_use(String sql){
		return bdi.getByJdbcSQL(sql);
	}

	public BaseDaoImpl getBdi() {
		return bdi;
	}

	public void setBdi(BaseDaoImpl bdi) {
		this.bdi = bdi;
	}

	
	
}
