package com.kh.hsfs.dao;

import com.kh.hsfs.model.MeddetailWf;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 15-8-25
 * Time:
 * To change this template use File | Settings | File Templates.
 */
public interface MeddetailWfDao {
    public int saveWf(MeddetailWf t);
    public List getByJdbcSQL(String sql);
//    public PageUtil findBySqlPage(int currPage, int rows, String sql);
    public int removeById(int id);
    public MeddetailWf findWfById(int id);
//    public void updateWf(MeddetailWf t);
}
