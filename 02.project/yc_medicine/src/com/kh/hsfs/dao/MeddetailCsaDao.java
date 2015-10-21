package com.kh.hsfs.dao;

import com.kh.hsfs.model.MeddetailCsa;
import com.kh.hsfs.model.MedicineCsa;
import com.kh.util.PageUtil;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 15-8-25
 * Time:
 * To change this template use File | Settings | File Templates.
 */
public interface MeddetailCsaDao {
    public int saveCsa(MeddetailCsa t);
    public List getByJdbcSQL(String sql);
//    public PageUtil findBySqlPage(int currPage, int rows, String sql);
    public int removeById(int id);
    public MeddetailCsa findCsaById(int id);
//    public void updateCsa(MeddetailCsa t);
}
