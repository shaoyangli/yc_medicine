package com.kh.hsfs.dao;

import com.kh.hsfs.model.MedicineCsa;
import com.kh.util.PageUtil;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: lsy
 * Date: 15-7-28
 * Time:
 */
public interface MedicineCsaDao {
    public int saveCsa(MedicineCsa t);
    public List getByJdbcSQL(String sql);
    public PageUtil findBySqlPage(int currPage, int rows, String sql);
    public int removeById(int id);
    public MedicineCsa findCsaById(int id);
    public void updateCsa(MedicineCsa t);
}
