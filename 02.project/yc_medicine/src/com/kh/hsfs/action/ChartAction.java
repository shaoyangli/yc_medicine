package com.kh.hsfs.action;

import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.kh.hsfs.dao.ChartDao;
import com.kh.hsfs.model.HsfsOrgBaseInfo;
import com.kh.util.PageUtil;
import com.kh.util.RetrunAreaId;
import com.kh.util.ToExcel;
import com.opensymphony.xwork2.ActionSupport;

/**
 * highcharts 统计 13.1.28 gcl
 */
public class ChartAction extends ActionSupport implements ServletRequestAware,
        ServletResponseAware {

    private HttpServletRequest request;
    private HttpServletResponse response;
    private ChartDao chartdao;
    private String buryear;
    private String orgcode;// 机构编号

    private String type;// 统计图 类型
    private String servtype;// 考核项目类型
    private String servname;// 考核项目名称
    private String servcheck;// 考核指标编码
    private String areaid;
    private String areaname;// 辖区名称
    private String i_code;// 疫苗编码
    private String orglevel;// 机构级别
    private String seltype; // 查询类型
    private String date1;
    private String date2;
    private String ym;
    private List list;
    private List list2;
    private List list3;
    private List list4;
    private List list5;
    private List list6;
    private List list7;
    private List list8;
    private List list9;
    private int currPage;
    private int totalPages;
    private PageUtil page;
    private String jigou;
    private String result;
    // private String data;
    private String[] info;

    public String[] getInfo() {
        return info;
    }

    public void setInfo(String[] info) {
        this.info = info;
    }

    public String getAreaname() {
        return areaname;
    }

    public void setAreaname(String areaname) {
        this.areaname = areaname;
    }

    public String getI_code() {
        return i_code;
    }

    public void setI_code(String i_code) {
        this.i_code = i_code;
    }

    public String accountpie2() throws Exception {
        response.setCharacterEncoding("utf-8");
        // StringBuffer results=new StringBuffer();
        /*
		 * results.append("{\"name\":\"资金下拨\",\"size\":\"5400000\"},");
		 * results.append("{\"name\":\"资金剩余\",\"size\":\"6850000\"},");
		 * results.append("{\"name\":\"待拨资金\",\"size\":\"20000\"}");
		 * System.out.println("[" + results.toString() + "]");
		 * response.getWriter().write("[" + results.toString() + "]"); return
		 * null;
		 */
        list2 = new ArrayList();
        list = chartdao.account(orgcode, buryear);
        String s1 = "资金下拨,", s2 = "资金剩余,";
        if (list.size() > 0) {
            List l = (List) list.get(0);
            s1 += "" + l.get(0);
            s2 += "" + l.get(1);
        } else {
            s1 += "0";
            s2 += "0";
        }
        list2.add(s1);
        list2.add(s2);
        // list2.add("资金下拨,5400000");
        // list2.add("资金剩余,6850000");
        return "accountpie";
    }

    // 县看到 十二项分类各使用资金情况
    public String accountpie5() throws Exception {
        // 获得当前用户级别
        HttpSession session = request.getSession();
        HsfsOrgBaseInfo organ = (HsfsOrgBaseInfo) session.getAttribute("org");
        String organarea = RetrunAreaId.callAreaid(organ);// 机构所在区域
        // 用户是 三级以上 统计全县的 二级 统计整个乡镇的 一级 统计村室
        list5 = new ArrayList();
        list5 = chartdao.account_services(organarea, buryear);
        return "accountpie";
    }

    // 县看到 十二项分类各使用资金情况
    public String accountpieUser() throws Exception {
        // 获得当前用户级别
        // 用户是 三级以上 统计全县的 二级 统计整个乡镇的 一级 统计村室
        list5 = new ArrayList();
        list5 = chartdao.account_servicesuser(orgcode, buryear);
        return "accountpie";
    }

    // 各级用户看到 自己以及下面所管辖机构 当前年的资金使用情况 对比
    public String accountpie8() throws Exception {
        response.setCharacterEncoding("utf-8");
        list8 = new ArrayList();

        HttpSession session = request.getSession();
        HsfsOrgBaseInfo organ = (HsfsOrgBaseInfo) session.getAttribute("org");
        String orgareaid = RetrunAreaId.callAreaid(organ);// 机构所在区域
        int orglevel = Integer.parseInt(organ.getOrgLevel());

        String sql = "select * from (select a.org_name,(select b.expect_money from hsfs_org_extend_info b where b.org_code = a.org_code and b.buryear = '" + buryear + "') emoney," +
                "  (select c.balance_money from hsfs_account c where c.org_code = a.org_code and c.buryear = '" + buryear + "') bmoney," +
                " (select sum(d.allmoney) from hsfs_fund_apply_form d where d.org_code = a.org_code and d.buryear = '" + buryear + "' and d.gatterflag = '0') smoney" +
                " from hsfs_org_base_info a  where a.org_areaid like '" + orgareaid + "%' ";
        System.out.println(orglevel);
        if (orglevel == 3) {
            sql += " and a.org_level in (2,3)";
        }
        sql += " order by a.org_areaid,a.org_level desc,a.org_code) where rownum <= 12";
        list = chartdao.account_use(sql);
        String s = "area,";
        String s2 = "资金申请总额,";
        String s3 = "实际到帐总额,";
        String s4 = "服务量上报总额,";
        list8.add("机构价值评估对比,,金额(元),体检人数");
        for (int i = 0; i < list.size(); i++) {
            List l = (ArrayList) list.get(i);
            s += l.get(0);
            s2 += l.get(1) == null ? "0" : l.get(1);
            s3 += l.get(2) == null ? "0" : l.get(2);
            s4 += l.get(3) == null ? "0" : l.get(3);
            if (i != list.size() - 1) {
                s += ",";
                s2 += ",";
                s3 += ",";
                s4 += ",";
            }
        }
        list8.add(s);
        list8.add(s2);
        list8.add(s3);
        list8.add(s4);

        return "accountpie";
//		String sql = "select w.org_name,w2.allmoney from hsfs_org_base_info w  left join (select w2.org_code,sum(allmoney) allmoney from hsfs_fund_apply_form w2 where w2.offer_state <> 2 and w2.gatterflag='0' and w2.buryear='"
//				+ buryear
//				+ "' group by w2.org_code ) w2  on w.org_code = w2.org_code  where w.org_areaid like '"
//				+ orgareaid
//				+ "%'   and w.org_level in ("
//				+ (orglevel - 1)
//				+ ", " + orglevel + ") and rownum<12 order by w.org_areaid";
////		 System.out.println("="+sql);
//		list = chartdao.account_use(sql);
//		String s = "area,";
//		String s2 = "资金使用,";
//		if (list.size() == 1) {
//			list8.add("服务机构资金使用情况,,金额(元),体检人数");
//		} else {
//			list8.add("服务机构资金使用对比,,金额(元),体检人数");
//		}
//		for (int i = 0; i < list.size(); i++) {
//			List l = (ArrayList) list.get(i);
//			s += l.get(0);
//			s2 += l.get(1) == null ? "0" : l.get(1);
//			if (i != list.size() - 1) {
//				s += ",";
//				s2 += ",";
//			}
//		}
//		list8.add(s);
//		list8.add(s2);

        // list8.add("area,县卫生局, 城关镇卫生院, 灵山镇卫生院, 庐山镇卫生院,洋楼镇卫生院");
        // list8.add("资金使用,15000,8500,7500,3250,5000");

        // StringBuffer results=new StringBuffer();
        // results.append("各服务机构资金使用对比,,金额,体检人数;");// 标题 x y 轴设置
        // results.append("area,县卫生局, 城关镇卫生院, 灵山镇卫生院, 庐山镇卫生院,洋楼镇卫生院;");
        // results.append("资金使用,15000,8500,7500,3250,5000");
        // response.getWriter().print(results.toString());
        // return null;
    }

    // 各级用户看到 自己以及下面所管辖机构 当前年的资金使用情况 对比
    public String orgCapitalCompare1() throws Exception {
        response.setCharacterEncoding("utf-8");
        list8 = new ArrayList();
        HttpSession session = request.getSession();
        HsfsOrgBaseInfo organ = (HsfsOrgBaseInfo) session.getAttribute("org");
        String orgareaid = RetrunAreaId.callAreaid(organ);// 机构所在区域
        int orglevel = Integer.parseInt(organ.getOrgLevel());

        // String
        // sql="select w.org_name,w2.allmoney from hsfs_org_base_info w  left join (select w2.org_code,sum(allmoney) allmoney from hsfs_fund_apply_form w2 where w2.offer_state <> 2 and w2.gatterflag='0' and w2.buryear='"+buryear+"' group by w2.org_code ) w2  on w.org_code = w2.org_code  where w.org_areaid like '"+orgareaid+"%'   and w.org_level in ("+(orglevel-1)+", "+orglevel+") and rownum<12 order by w.org_areaid";
        // System.out.println("="+sql);

        String sql = "select w.org_name,w2.allmoney from hsfs_org_base_info w  left join (select w2.org_code,sum(allmoney) allmoney from hsfs_fund_apply_form w2 "
                + "where w2.offer_state <> 2 and w2.gatterflag='0' and w2.buryear='"
                + buryear
                + "' group by w2.org_code ) w2  "
                + "on w.org_code = w2.org_code  where w.org_areaid like '"
                + areaid + "%'   " + "and w.org_level in (";
        // 县用户的时候只统计3,2级别机构
        if (areaid.length() == 6) {
            sql += "2,3)";
        }

        if (areaid.length() == 8) {
            sql += "1,2)";
        }
        if (areaid.length() == 10) {
            sql += "1)";
        }
        sql += " and rownum<12 order by w.org_areaid";
        // System.out.println(sql);
        list = chartdao.account_use(sql);
        String s = "area,";
        String s2 = "资金使用,";
        if (list.size() == 1) {
            list8.add("服务机构资金使用情况,,金额(元),体检人数");
        } else {
            list8.add("服务机构资金使用对比,,金额(元),体检人数");
        }
        for (int i = 0; i < list.size(); i++) {
            List l = (ArrayList) list.get(i);
            s += l.get(0);
            s2 += l.get(1) == null ? "0" : l.get(1);
            if (i != list.size() - 1) {
                s += ",";
                s2 += ",";
            }
        }
        list8.add(s);
        list8.add(s2);


        return "accountpie";
    }

    /**
     * 机构资金使用对比
     */
    public String orgCapitalCompare() throws Exception {
        String sql = "select w.org_name,w2.allmoney from hsfs_org_base_info w  left join (select w2.org_code,sum(allmoney) allmoney from hsfs_fund_apply_form w2 "
                + "where w2.offer_state <> 2 and w2.gatterflag='0' and w2.buryear='"
                + buryear
                + "' group by w2.org_code ) w2  "
                + "on w.org_code = w2.org_code  where w.org_areaid like '"
                + areaid + "%'   " + "and w.org_level in (";
        // 县用户的时候只统计3,2级别机构
        if (areaid.length() == 6) {
            sql += "2,3)";
        }

        if (areaid.length() == 8) {
            sql += "1,2)";
        }
        if (areaid.length() == 10) {
            sql += "1)";
        }
        sql += " order by w.org_areaid";
        // System.out.println("--"+sql);
        //list = chartdao.account_use(sql);
        if (currPage > totalPages) {
            currPage = totalPages;
        }
        if (currPage == 0) {
            currPage = 1;
        }
        page = chartdao.getlist(currPage, 10, sql);
        return "accountpie";
    }

    /**
     * 实际帐户余额对比分析
     */
    public String fundCompare() throws Exception {
        String sql = "select k.org_name,t.balance_money,t.OFFER_MONEY from hsfs_account t,hsfs_org_base_info k "
                + "where t.org_code = k.org_code and k.org_areaid like '"
                + areaid
                + "%' and t.buryear = '"
                + buryear
                + "' order by k.org_areaid";
        if (currPage > totalPages) {
            currPage = totalPages;
        }
        if (currPage == 0) {
            currPage = 1;
        }
        // System.out.println(sql);
        page = chartdao.getlist(currPage, 10, sql);
        return "accountpie";
    }

    /**
     * 实际帐户余额对比分析 导出
     */
    public String dCfundCompare() throws Exception {

        SimpleDateFormat dateformat = new SimpleDateFormat("yyyy-MM-dd");
        response.reset();
        String date = dateformat.format(new Date());
        StringBuffer s = new StringBuffer("attachment;filename=服务机构资金实际拨付量对比("
                + date + ").xls");
        try {
            response.setHeader("Content-Disposition", new String(s.toString()
                    .getBytes("GBK"), "ISO8859-1"));
        } catch (UnsupportedEncodingException e1) {
            e1.printStackTrace();
        }
        response.setContentType("application/vnd.ms-excel;charset=GBK");
        String[] tlist = {"机构名称", "实际帐户金额(元)", "拨出金额(元)"};
        String sql = "select k.org_name,t.balance_money,t.offer_money from hsfs_account t,hsfs_org_base_info k "
                + "where t.org_code = k.org_code and k.org_areaid like '"
                + areaid
                + "%' and t.buryear = '"
                + buryear
                + "' order by k.org_areaid";
        //System.out.println("--" + sql);
        //System.out.println(list2.size());
        list = chartdao.account_use(sql);
        List list20 = new ArrayList();
        ToExcel.exportExcel(tlist, list, s.toString(), response
                .getOutputStream(), list20);
        return null;
    }


    /**
     * 资金申请对比分析
     */

    public String fundCompare1() throws Exception {
        String sql = "select k.org_name,t.expect_money from hsfs_org_extend_info t,hsfs_org_base_info k " +
                "where t.org_code = k.org_code and t.areaid like '" + areaid + "%' and t.buryear = '" + buryear + "' order by t.areaid";
        if (currPage > totalPages) {
            currPage = totalPages;
        }
        if (currPage == 0) {
            currPage = 1;
        }
        page = chartdao.getlist(currPage, 10, sql);
        //System.out.println(sql);

        return "accountpie";
    }

    /**
     * 资金申请对比分析导出
     */

    public String dCfundCompare1() throws Exception {

        SimpleDateFormat dateformat = new SimpleDateFormat("yyyy-MM-dd");
        response.reset();
        String date = dateformat.format(new Date());
        StringBuffer s = new StringBuffer("attachment;filename=资金申请对比("
                + date + ").xls");
        try {
            response.setHeader("Content-Disposition", new String(s.toString()
                    .getBytes("GBK"), "ISO8859-1"));
        } catch (UnsupportedEncodingException e1) {
            e1.printStackTrace();
        }
        response.setContentType("application/vnd.ms-excel;charset=GBK");
        String[] tlist = {"机构名称", "资金申请总额(元)"};
        String sql = "select k.org_name,t.expect_money from hsfs_org_extend_info t,hsfs_org_base_info k " +
                "where t.org_code = k.org_code and t.areaid like '" + areaid + "%' and t.buryear = '" + buryear + "' order by t.areaid";
        //System.out.println("--" + sql);
        //System.out.println(list2.size());
        list = chartdao.account_use(sql);
        List list20 = new ArrayList();
        ToExcel.exportExcel(tlist, list, s.toString(), response
                .getOutputStream(), list20);
        return null;
    }

    /**
     * 服务价值评估
     */

    public String fundCompare2() throws Exception {
        String sql = "select max(k.org_name), sum(t.allmoney),k.org_areaid from hsfs_fund_apply_form t, hsfs_org_base_info k "
                + " where t.org_code = k.org_code and k.org_areaid like '"
                + areaid
                + "%' "
                + "and t.buryear = '"
                + buryear
                + "' and  t.gatterflag=0 group by "
                + "t.org_code,k.org_areaid order by k.org_areaid ";
        //System.out.println(sql);
        if (currPage > totalPages) {
            currPage = totalPages;
        }
        if (currPage == 0) {
            currPage = 1;
        }
        page = chartdao.getlist(currPage, 10, sql);

        return "accountpie";
    }

    /**
     * 机构服务价值评估对比分析(2013.10.21)
     */
    public String orgFundCompare() throws Exception {
        String sql = "select a.org_name,(select b.expect_money from hsfs_org_extend_info b where b.org_code = a.org_code and b.buryear = '" + buryear + "') emoney," +
                "  (select c.balance_money from hsfs_account c where c.org_code = a.org_code and c.buryear = '" + buryear + "') bmoney," +
                " (select sum(d.allmoney) from hsfs_fund_apply_form d where d.org_code = a.org_code and d.buryear = '" + buryear + "' and d.gatterflag = '0') smoney" +
                " from hsfs_org_base_info a  where a.org_areaid like '" + areaid + "%' order by a.org_areaid";
        if (currPage > totalPages) {
            currPage = totalPages;
        }
        if (currPage == 0) {
            currPage = 1;
        }
        //System.out.println(sql);
        page = chartdao.getlist(currPage, 10, sql);
        return "accountpie";
    }

    /**
     * 机构服务价值评估对比分析_统计图 10.21
     */
    public String orgFundCompareTjt() throws Exception {
        response.setCharacterEncoding("utf-8");
        list8 = new ArrayList();
        String sql = "select * from (select a.org_name,(select b.expect_money from hsfs_org_extend_info b where b.org_code = a.org_code and b.buryear = '" + buryear + "') emoney," +
                "  (select c.balance_money from hsfs_account c where c.org_code = a.org_code and c.buryear = '" + buryear + "') bmoney," +
                " (select sum(d.allmoney) from hsfs_fund_apply_form d where d.org_code = a.org_code and d.buryear = '" + buryear + "' and d.gatterflag = '0') smoney" +
                " from hsfs_org_base_info a  where a.org_areaid like '" + areaid + "%' ";
        if (areaid.length() == 6) {
            sql += " and a.org_level in (2,3)";
        }
        sql += " order by a.org_areaid,a.org_level desc,a.org_code) where rownum <= 12";
        list = chartdao.account_use(sql);
        String s = "area,";
        String s2 = "资金申请总额,";
        String s3 = "实际到帐总额,";
        String s4 = "服务量上报总额,";
        list8.add("机构价值评估对比,,金额(元),体检人数");
        for (int i = 0; i < list.size(); i++) {
            List l = (ArrayList) list.get(i);
            s += l.get(0);
            s2 += l.get(1) == null ? "0" : l.get(1);
            s3 += l.get(2) == null ? "0" : l.get(2);
            s4 += l.get(3) == null ? "0" : l.get(3);
            if (i != list.size() - 1) {
                s += ",";
                s2 += ",";
                s3 += ",";
                s4 += ",";
            }
        }
        list8.add(s);
        list8.add(s2);
        list8.add(s3);
        list8.add(s4);

        return "accountpie";
    }

    /**
     * 服务价值评估导出
     */

    public String dCfundCompare2() throws Exception {

        SimpleDateFormat dateformat = new SimpleDateFormat("yyyy-MM-dd");
        response.reset();
        String date = dateformat.format(new Date());
        StringBuffer s = new StringBuffer("attachment;filename=服务价值对比("
                + date + ").xls");
        try {
            response.setHeader("Content-Disposition", new String(s.toString()
                    .getBytes("GBK"), "ISO8859-1"));
        } catch (UnsupportedEncodingException e1) {
            e1.printStackTrace();
        }
        response.setContentType("application/vnd.ms-excel;charset=GBK");
        String[] tlist = {"机构名称", "服务价值(元)", "地区编号"};
        String sql = "select max(k.org_name), sum(t.allmoney),k.org_areaid from hsfs_fund_apply_form t, hsfs_org_base_info k "
                + " where t.org_code = k.org_code and k.org_areaid like '"
                + areaid
                + "%' "
                + "and t.buryear = '"
                + buryear
                + "' and t.gatterflag=0 group by "
                + "t.org_code,k.org_areaid order by k.org_areaid ";
        //System.out.println("--" + sql);
        //System.out.println(list2.size());
        list = chartdao.account_use(sql);
        List list20 = new ArrayList();
        ToExcel.exportExcel(tlist, list, s.toString(), response
                .getOutputStream(), list20);
        return null;
    }


    /**
     * 实际帐户余额条形图对比
     */

    public String fundCompareTjt() throws Exception {
        response.setCharacterEncoding("utf-8");
        list8 = new ArrayList();
        String sql = "select k.org_name,t.balance_money from hsfs_account t,hsfs_org_base_info k " +
                "where t.org_code = k.org_code and k.org_areaid like '" + areaid + "%' " +
                "and t.buryear = '" + buryear + "'";
        if (areaid.length() == 6) {
            sql += " and k.org_level in (2,3)";
        }
        sql += " and rownum<12 order by k.org_areaid";

        list = chartdao.account_use(sql);
        String s = "area,";
        String s2 = "实际接收量,";
        list8.add("服务机构资金实际接收量对比,,金额(元),体检人数");
        for (int i = 0; i < list.size(); i++) {
            List l = (ArrayList) list.get(i);
            s += l.get(0);
            s2 += l.get(1) == null ? "0" : l.get(1);
            if (i != list.size() - 1) {
                s += ",";
                s2 += ",";
            }
        }
        list8.add(s);
        list8.add(s2);
        return "accountpie";
    }

    /**
     * 资金申请条形图对比分析
     */
    public String fundCompareTjt1() throws Exception {
        response.setCharacterEncoding("utf-8");
        list8 = new ArrayList();
        String sql = "select k.org_name,t.expect_money from hsfs_org_extend_info t,hsfs_org_base_info k " +
                "where t.org_code = k.org_code and t.areaid like '" + areaid + "%' and t.buryear = '" + buryear + "'";

        sql += " and rownum<12 order by t.areaid";

        list = chartdao.account_use(sql);
        String s = "area,";
        String s2 = "资金申请金额,";
        list8.add("资金申请对比,,金额(元),体检人数");
        for (int i = 0; i < list.size(); i++) {
            List l = (ArrayList) list.get(i);
            s += l.get(0);
            s2 += l.get(1) == null ? "0" : l.get(1);
            if (i != list.size() - 1) {
                s += ",";
                s2 += ",";
            }
        }
        list8.add(s);
        list8.add(s2);
        return "accountpie";
    }

    /**
     * 服务价值评估统计图
     *
     * @return
     * @throws Exception
     */

    public String fundCompareTjt2() throws Exception {
        response.setCharacterEncoding("utf-8");
        list8 = new ArrayList();
        String sql = "select max(k.org_name), sum(t.allmoney),k.org_areaid from hsfs_fund_apply_form t, hsfs_org_base_info k "
                + " where t.org_code = k.org_code and k.org_areaid like '"
                + areaid
                + "%' "
                + "and t.buryear = '"
                + buryear
                + "' and t.gatterflag=0 ";
        if (areaid.length() == 6) {
            sql += " and k.org_level in (2,3)";
        }
        sql += " and rownum<12 group by t.org_code, k.org_areaid order by k.org_areaid";

        list = chartdao.account_use(sql);
        String s = "area,";
        String s2 = "服务价值,";
        list8.add("服务价值对比,,金额(元),体检人数");
        for (int i = 0; i < list.size(); i++) {
            List l = (ArrayList) list.get(i);
            s += l.get(0);
            s2 += l.get(1) == null ? "0" : l.get(1);
            if (i != list.size() - 1) {
                s += ",";
                s2 += ",";
            }
        }
        list8.add(s);
        list8.add(s2);
        return "accountpie";
    }


    /**
     * 服务机构资金使用对比导出
     *
     * @return
     * @throws Exception
     */
    public String exportOrgCompare() throws Exception {

        SimpleDateFormat dateformat = new SimpleDateFormat("yyyy-MM-dd");
        response.reset();
        String date = dateformat.format(new Date());
        StringBuffer s = new StringBuffer("attachment;filename=机构资金使用对比("
                + date + ").xls");
        try {
            response.setHeader("Content-Disposition", new String(s.toString()
                    .getBytes("GBK"), "ISO8859-1"));
        } catch (UnsupportedEncodingException e1) {
            e1.printStackTrace();
        }
        response.setContentType("application/vnd.ms-excel;charset=GBK");
        String[] tlist = {"机构名称", "资金使用总额(元)"};
        String sql = "select w.org_name,w2.allmoney from hsfs_org_base_info w  left join (select w2.org_code,sum(allmoney) allmoney from hsfs_fund_apply_form w2 "
                + "where w2.offer_state <> 2 and w2.gatterflag='0' and w2.buryear='"
                + buryear
                + "' group by w2.org_code ) w2  "
                + "on w.org_code = w2.org_code  where w.org_areaid like '"
                + areaid + "%'   " + "and w.org_level in (";
        // 县用户的时候只统计3,2级别机构
        if (areaid.length() == 6) {
            sql += "2,3)";
        }

        if (areaid.length() == 8) {
            sql += "1,2)";
        }
        if (areaid.length() == 10) {
            sql += "1)";
        }
        sql += " order by w.org_areaid";
        //System.out.println("--" + sql);
        //System.out.println(list2.size());
        list = chartdao.account_use(sql);
        List list20 = new ArrayList();
        ToExcel.exportExcel(tlist, list, s.toString(), response
                .getOutputStream(), list20);
        return null;
    }

    // 月份 各机构每月拨付数据对比  首页
    public String accountpie9() throws Exception {
        response.setCharacterEncoding("utf-8");
        list9 = new ArrayList();
        HttpSession session = request.getSession();
        HsfsOrgBaseInfo organ = (HsfsOrgBaseInfo) session.getAttribute("org");
        // String orgareaid = RetrunAreaId.callAreaid(organ);// 机构所在区域
        // int orglevel=Integer.parseInt(organ.getOrgLevel());
        list9.add("公卫资金每月实收资金情况分析,,金额(元),体检人数");
        // String
        // orgsql="select w.org_name,w.org_code from hsfs_org_base_info w where w.org_areaid like '"+orgareaid+"%'  and w.org_level in ("+(orglevel-1)+","+orglevel+") order by w.org_level desc,w.org_code asc ";
        // System.out.println(orgsql);
        // list=chartdao.account_use(orgsql);
        String s = "";
        String msql = "";
        // 13.5.21 修改为统计本机构
        list9.add("month,一月, 二月, 三月, 四月,五月,六月,七月,八月,九月,十月,十一月,十二月");
        // for(int i=0;i<list.size();i++){
        s = "";
        // List l=(ArrayList)list.get(i);
        s += organ.getOrgName();
        msql = " select m01,m02,m03,m04,m05,m06,m07,m08,m09,m10,m11,m12 from hsfs_fund_offer_temp where orgcode='"
                + organ.getOrgCode() + "' and buryear='" + buryear + "'";
//		 System.out.println(msql+"-----");
        List l2 = chartdao.account_use(msql);
        if (l2.size() > 0) {
            List l3 = (List) l2.get(0);
            //String t = s;
            StringBuffer ss = new StringBuffer();
            String w = "";
            for (int j = 0; j < l3.size(); j++) {
                w = l3.get(j) == null ? "0" : l3.get(j).toString();
                ss.append(w);
                if (j < l3.size() - 1) {
                    ss.append(",");
                }
            }
            s += "," + ss.toString();
            list9.add(s);
        } else {
            for (int j = 0; j < 12; j++) {
                s += ",0";
            }
            list9.add(s);
        }

        return "accountpie";
    }

    // 月份 各机构每月拨付数据对比
    public String accountpie10() throws Exception {
        response.setCharacterEncoding("utf-8");
        list9 = new ArrayList();
        HttpSession session = request.getSession();
        HsfsOrgBaseInfo organ = (HsfsOrgBaseInfo) session.getAttribute("org");
        // String orgareaid = RetrunAreaId.callAreaid(organ);// 机构所在区域
        // int orglevel=Integer.parseInt(organ.getOrgLevel());
        list9.add("公卫资金每月实收资金情况分析,,金额(元),体检人数");
        // String
        // orgsql="select w.org_name,w.org_code from hsfs_org_base_info w where w.org_areaid like '"+orgareaid+"%'  and w.org_level in ("+(orglevel-1)+","+orglevel+") order by w.org_level desc,w.org_code asc ";
        // System.out.println(orgsql);
        // list=chartdao.account_use(orgsql);
        String s = "";
        String msql = "";
        // 13.5.21 修改为统计本机构
        list9.add("month,一月, 二月, 三月, 四月,五月,六月,七月,八月,九月,十月,十一月,十二月");
        // for(int i=0;i<list.size();i++){
        s = "";
        // List l=(ArrayList)list.get(i);
        s += organ.getOrgName();
        msql = " select buryear,m01,m02,m03,m04,m05,m06,m07,m08,m09,m10,m11,m12 from hsfs_fund_offer_temp where orgcode='"
                + organ.getOrgCode() + "' order by buryear";//+ "' and buryear='" + buryear + "'";
//		 System.out.println(msql+"-----");
        List l2 = chartdao.account_use(msql);
        if (l2.size() > 0) {
            for (int i = 0; i < l2.size(); i++) {
                List l3 = (List) l2.get(i);
                //String t = s;
                StringBuffer ss = new StringBuffer();
                String w = "";
                for (int j = 0; j < l3.size(); j++) {
                    w = l3.get(j) == null ? "0" : l3.get(j).toString();
                    ss.append(w);
                    if (j < l3.size() - 1) {
                        ss.append(",");
                    }
                }
                list9.add(ss.toString());
            }

        } else {
            for (int j = 0; j < 12; j++) {
                s += ",0";
            }
            list9.add(s);
        }

        return "accountpie";
    }

    /**
     * 月份 各机构每月拨付数据对比表格展示
     */
    public String perMonthCompare() throws Exception {
        HttpSession session = request.getSession();
        HsfsOrgBaseInfo organ = (HsfsOrgBaseInfo) session.getAttribute("org");
        String sql = " select m01,m02,m03,m04,m05,m06,m07,m08,m09,m10,m11,m12,(m01+ m02+m03+ m04+ m05+ m06+ m07+ m08+m09+m10+m11+m12),buryear from hsfs_fund_offer_temp where orgcode='"
                + organ.getOrgCode() + "' order by buryear";//"' and buryear='" + buryear + "'";
        //System.out.println(sql);
        list = chartdao.account_use(sql);
        return "accountpie";
    }

    /**
     * 机构年资金接收对比分析导出
     *
     * @return
     * @throws Exception
     */
    public String exportPerMonthCompare() throws Exception {
        SimpleDateFormat dateformat = new SimpleDateFormat("yyyy-MM-dd");
        HttpSession session = request.getSession();
        HsfsOrgBaseInfo organ = (HsfsOrgBaseInfo) session.getAttribute("org");
        String orgName = organ.getOrgName();
        response.reset();
        String date = dateformat.format(new Date());
//		StringBuffer s = new StringBuffer("attachment;filename= 月接收资金对比分析("
//				+ date + ").xls");
        StringBuffer s = new StringBuffer("attachment;filename= " + orgName + "-月接收资金对比分析(" + date + ").xls");
        try {
            response.setHeader("Content-Disposition", new String(s.toString()
                    .getBytes("GBK"), "ISO8859-1"));
        } catch (UnsupportedEncodingException e1) {
            e1.printStackTrace();
        }
        response.setContentType("application/vnd.ms-excel;charset=GBK");
        String[] tlist = {"年度", "一月", "二月", "三月", "四月", "五月", "六月", "七月",
                "八月", "九月", "十月", "十一月", "十二月", "合计"};

        String sql = " select buryear,m01,m02,m03,m04,m05,m06,m07,m08,m09,m10,m11,m12,(m01+ m02+m03+ m04+ m05+ m06+ m07+ m08+m09+m10+m11+m12) from hsfs_fund_offer_temp where orgcode='"
                + organ.getOrgCode() + "' order by buryear";// + "' and buryear='" + buryear + "'";
        list = chartdao.account_use(sql);
        List list20 = new ArrayList();
        //System.out.println(s.toString());
        ToExcel.exportExcel(tlist, list, s.toString(), response
                .getOutputStream(), list20);
        return null;
    }

    public String offertj() throws Exception {// 公卫资金拨付统计
        String year;
        // 初始化年度
        year = Calendar.getInstance().get(Calendar.YEAR) + "";
        StringBuffer sql = new StringBuffer(100);
        sql
                .append("select (select a.org_name from HSFS_ORG_BASE_INFO a where t.orgcode=a.org_code) as orgname,t.m01,t.m02,t.m03,t.m04,t.m05,t.m06,t.m07,t.m08,t.m09,t.m10,t.m11,t.m12 from HSFS_FUND_OFFER_TEMP t  where 1=1 ");
        if (orgcode != null && !orgcode.equals("") && orgcode != "null") {
            sql.append(" and t.orgcode ='");
            sql.append(orgcode);
            sql.append("'");
        }
        sql
                .append("  group by t.orgcode,t.m01, t.m02, t.m03,t.m04,t.m05,t.m06,t.m07,t.m08, t.m09,t.m10,t.m11,t.m12");
        list = (ArrayList) chartdao.selfwjl(sql.toString());
        String name1 = "";
        String name2 = "";
        String name3 = "";
        String name4 = "";
        String name5 = "";
        String name6 = "";
        String name7 = "";
        String name8 = "";
        String name9 = "";
        String name10 = "";
        String name11 = "";
        String name12 = "";
        String name13 = "";
        for (int i = 0; i < list.size(); i++) {
            List list1 = (ArrayList) list.get(i);
            name1 = list1.get(0).toString();
            name2 = list1.get(1).toString();
            name3 = list1.get(2).toString();
            name4 = list1.get(3).toString();
            name5 = list1.get(4).toString();
            name6 = list1.get(5).toString();
            name7 = list1.get(6).toString();
            name8 = list1.get(7).toString();
            name9 = list1.get(8).toString();
            name10 = list1.get(9).toString();
            name11 = list1.get(10).toString();
            name12 = list1.get(11).toString();
            name13 = list1.get(12).toString();

        }
        StringBuffer sql1 = new StringBuffer(50);
        sql1
                .append("select a.org_name from HSFS_ORG_BASE_INFO a where a.org_code='");
        sql1.append(orgcode);
        sql1.append("'");
        list = chartdao.selfwjl(sql.toString());
        if (list.size() > 0) {
            List list1 = (ArrayList) list.get(0);
            result = list1.get(0).toString();
        }
        String name = name1 + "," + name2 + "," + name3 + "," + name4 + ","
                + name5 + "," + name6 + "," + name7 + "," + name8 + "," + name9
                + "," + name10 + "," + name11 + "," + name12 + "," + name13;
        response.setCharacterEncoding("utf-8");
        StringBuffer results = new StringBuffer();
        results.append(year);
        results.append(" 年（");
        results.append(result);
        results.append("）资金按月拨付统计明细,,金额（元）;");
        results.append("month,1,2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12月份;");
        results.append(name);
        PrintWriter out = response.getWriter();
        out.write(results.toString());
        out.flush();
        out.close();
        return null;

    }


    public String objspread() {
        String sql = "select min(t.name),case when min(s.num) is null then 0 else sum(s.num) end num from hsfs_servtype_setting t left join (select s.servcie_type ,count(1) num from hsfs_popu_base_info p,hsfs_servtype_info s where p.arch_code=s.arch_code and p.ib_useing=0 and s.buryear='" + buryear + "' and s.servcie_type in (select max(code) from hsfs_servtype_setting t where t.project_type=1 and buryear='" + buryear + "' group by mobile_code) and  p.org_code ='" + orgcode + "' group by s.servcie_type,s.buryear order by s.servcie_type  ) s  on t.code=s.servcie_type ";
        sql += " where t.buryear='" + buryear + "' and t.project_type = 1  group by t.mobile_code";
//		System.out.println(sql);
        list5 = chartdao.account_obj(sql);
        return "accountpie";
    }

    public String fundresource() {
        list5 = new ArrayList();
        list5.add("0,中央政府资助");
        list5.add("1,省政府资助");
        list5.add("2,市政府资助");
        list5.add("3,县政府资助");
        list5.add("4,其它来源");
        for (int i = 0; i < list5.size(); i++) {
            String[] s = list5.get(i).toString().split(",");
            list2 = chartdao.account_use("select case when sum(account_money) is null then 0 else sum(account_money) end from hsfs_capital_account t where finance=" + s[0] + " and check_state=1 and buryear='" + buryear + "'");
            s[0] = ((List) list2.get(0)).get(0).toString();
//			System.out.println();
            list5.set(i, s);
        }
//		list.add("5");
        return "accountpie";
    }

    public ChartDao getChartdao() {
        return chartdao;
    }

    public String getOrgcode() {
        return orgcode;
    }

    public void setOrgcode(String orgcode) {
        this.orgcode = orgcode;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public void setChartdao(ChartDao chartdao) {
        this.chartdao = chartdao;
    }

    public void setServletRequest(HttpServletRequest arg0) {
        this.request = arg0;
    }

    public String getDate1() {
        return date1;
    }

    // public String getData() {
    // return data;
    // }
    //
    //
    // public void setData(String data) {
    // this.data = data;
    // }

    public int getCurrPage() {
        return currPage;
    }

    public void setCurrPage(int currPage) {
        this.currPage = currPage;
    }

    public int getTotalPages() {
        return totalPages;
    }

    public List getList8() {
        return list8;
    }

    public void setList8(List list8) {
        this.list8 = list8;
    }

    public List getList9() {
        return list9;
    }

    public void setList9(List list9) {
        this.list9 = list9;
    }

    public void setTotalPages(int totalPages) {
        this.totalPages = totalPages;
    }

    public PageUtil getPage() {
        return page;
    }

    public void setPage(PageUtil page) {
        this.page = page;
    }

    public void setDate1(String date1) {
        this.date1 = date1;
    }

    public String getJigou() {
        return jigou;
    }

    public void setJigou(String jigou) {
        this.jigou = jigou;
    }

    public String getDate2() {
        return date2;
    }

    public void setDate2(String date2) {
        this.date2 = date2;
    }

    public String getYm() {
        return ym;
    }

    public void setYm(String ym) {
        this.ym = ym;
    }

    public void setServletResponse(HttpServletResponse arg0) {
        this.response = arg0;
    }

    public String getBuryear() {
        return buryear;
    }

    public void setBuryear(String buryear) {
        this.buryear = buryear;
    }

    public String getServtype() {
        return servtype;
    }

    public void setServtype(String servtype) {
        this.servtype = servtype;
    }

    public List getList() {
        return list;
    }

    public void setList(List list) {
        this.list = list;
    }

    public String getServname() {
        return servname;
    }

    public void setServname(String servname) {
        this.servname = servname;
    }

    public String getServcheck() {
        return servcheck;
    }

    public void setServcheck(String servcheck) {
        this.servcheck = servcheck;
    }

    public String getOrglevel() {
        return orglevel;
    }

    public void setOrglevel(String orglevel) {
        this.orglevel = orglevel;
    }

    public String getAreaid() {
        return areaid;
    }

    public String getSeltype() {
        return seltype;
    }

    public void setSeltype(String seltype) {
        this.seltype = seltype;
    }

    public void setAreaid(String areaid) {
        this.areaid = areaid;
    }

    public String getResult() {
        return result;
    }

    public void setResult(String result) {
        this.result = result;
    }

    public List getList2() {
        return list2;
    }

    public void setList2(List list2) {
        this.list2 = list2;
    }

    public List getList3() {
        return list3;
    }

    public void setList3(List list3) {
        this.list3 = list3;
    }

    public List getList4() {
        return list4;
    }

    public void setList4(List list4) {
        this.list4 = list4;
    }

    public List getList5() {
        return list5;
    }

    public void setList5(List list5) {
        this.list5 = list5;
    }

    public List getList6() {
        return list6;
    }

    public void setList6(List list6) {
        this.list6 = list6;
    }

    public List getList7() {
        return list7;
    }

    public void setList7(List list7) {
        this.list7 = list7;
    }

}
