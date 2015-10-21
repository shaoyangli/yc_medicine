package com.kh.hsfs.impl;

import com.kh.base.impl.BaseDaoImpl;
import com.kh.hsfs.dao.HospitalInfoDao;
import com.kh.hsfs.model.HospitalInfo;
import com.kh.hsfs.model.HsfsOrgBaseInfo;
import com.kh.util.PageUtil;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: lsy
 * Date: 15-7-28
 * Time: 下午10:09
 * To change this template use File | Settings | File Templates.
 */
public class HospitalInfoImpl implements HospitalInfoDao {

    private BaseDaoImpl bdi;
    @Override
    public int saveHosp(HospitalInfo t) {
        int id;
        try
        {
            bdi.saveorUpdate(t);
            id =1;
        }
        catch (Exception e)
        {
            id = 0;
            e.printStackTrace();
        }
        return id;
    }

    @Override
    public List getByJdbcSQL(String sql) {
        return bdi.getByJdbcSQL(sql);
    }

    @Override
    public PageUtil findBySqlPage(int currPage, int rows, String sql) {
        //默认显示第一页
        if(currPage == 0)
        {
            currPage = 1;
        }
        return bdi.findBySqlPage(currPage, rows, sql);
    }

    @Override
    public int removeById(int id) {
        try {
            HospitalInfo hsbi = (HospitalInfo)bdi.getObject(HospitalInfo.class, id);
            bdi.remove(hsbi);
            return 1;
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    @Override
    public HospitalInfo findHospById(int id) {
        HospitalInfo hobi = null;

        try {
            hobi =(HospitalInfo) bdi.getObject(HospitalInfo.class, id);
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return hobi;
    }

    @Override
    public void updateHosp(HospitalInfo t) {
        try {
            bdi.update(t);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public BaseDaoImpl getBdi() {
        return bdi;
    }

    public void setBdi(BaseDaoImpl bdi) {
        this.bdi = bdi;
    }
}
