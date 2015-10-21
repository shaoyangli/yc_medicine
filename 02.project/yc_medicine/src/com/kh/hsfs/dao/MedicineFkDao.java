package com.kh.hsfs.dao;

import com.kh.hsfs.model.MedicineFk;
import com.kh.util.PageUtil;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: lsy
 * Date: 15-7-28
 * Time:
 */
public interface MedicineFkDao {
    public int saveFk(MedicineFk t);
    public List getByJdbcSQL(String sql);
    public PageUtil findBySqlPage(int currPage, int rows, String sql);
    public int removeById(int id);
    public MedicineFk findFkById(int id);
    public void updateFk(MedicineFk t);
}
