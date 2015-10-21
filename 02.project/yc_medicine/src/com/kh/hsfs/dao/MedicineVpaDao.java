package com.kh.hsfs.dao;

import com.kh.hsfs.model.MedicineVpa;
import com.kh.util.PageUtil;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: lsy
 * Date: 15-7-28
 * Time:
 */
public interface MedicineVpaDao {
    public int saveVpa(MedicineVpa t);
    public List getByJdbcSQL(String sql);
    public PageUtil findBySqlPage(int currPage, int rows, String sql);
    public int removeById(int id);
    public MedicineVpa findVpaById(int id);
    public void updateVpa(MedicineVpa t);
}
