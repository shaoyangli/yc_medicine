package com.kh.hsfs.dao;

import com.kh.hsfs.model.MeddetailVpa;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 15-8-25
 * To change this template use File | Settings | File Templates.
 */
public interface MeddetailVpaDao {
    public int saveVpa(MeddetailVpa t);
    public List getByJdbcSQL(String sql);
//    public PageUtil findBySqlPage(int currPage, int rows, String sql);
    public int removeById(int id);
    public MeddetailVpa findVpaById(int id);
//    public void updateVpa(MeddetailVpa t);
}
