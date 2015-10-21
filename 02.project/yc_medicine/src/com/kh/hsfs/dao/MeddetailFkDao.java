package com.kh.hsfs.dao;

import com.kh.hsfs.model.MeddetailFk;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 15-8-25
 * Time:
 * To change this template use File | Settings | File Templates.
 */
public interface MeddetailFkDao {
    public int saveFk(MeddetailFk t);
    public List getByJdbcSQL(String sql);
//    public PageUtil findBySqlPage(int currPage, int rows, String sql);
    public int removeById(int id);
    public MeddetailFk findFkById(int id);
//    public void updateFk(MeddetailFk t);
}
