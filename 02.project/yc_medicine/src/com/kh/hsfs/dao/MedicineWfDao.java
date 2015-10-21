package com.kh.hsfs.dao;

import com.kh.hsfs.model.MedicineWf;
import com.kh.util.PageUtil;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: lsy
 * Date: 15-7-28
 * Time:
 */
public interface MedicineWfDao {
    public int saveWf(MedicineWf t);
    public List getByJdbcSQL(String sql);
    public PageUtil findBySqlPage(int currPage, int rows, String sql);
    public int removeById(int id);
    public MedicineWf findWfById(int id);
    public void updateWf(MedicineWf t);
}
