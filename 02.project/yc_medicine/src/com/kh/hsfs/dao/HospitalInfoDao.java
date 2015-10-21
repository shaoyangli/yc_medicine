package com.kh.hsfs.dao;

import com.kh.hsfs.model.HospitalInfo;
import com.kh.util.PageUtil;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: lsy
 * Date: 15-7-28
 * Time: 下午10:05
 */
public interface HospitalInfoDao {
    public int saveHosp(HospitalInfo t);
    public List getByJdbcSQL(String sql);
    public PageUtil findBySqlPage(int currPage, int rows, String sql);
    public int removeById(int id);
    public HospitalInfo findHospById(int id);
    public void updateHosp(HospitalInfo t);
}
