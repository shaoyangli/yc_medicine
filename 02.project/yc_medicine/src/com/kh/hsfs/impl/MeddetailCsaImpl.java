package com.kh.hsfs.impl;

import com.kh.base.impl.BaseDaoImpl;
import com.kh.hsfs.dao.MeddetailCsaDao;
import com.kh.hsfs.model.MeddetailCsa;
import com.kh.hsfs.model.MedicineCsa;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 15-8-25
 * Time: 下午9:24
 * To change this template use File | Settings | File Templates.
 */
public class MeddetailCsaImpl implements MeddetailCsaDao {
    private BaseDaoImpl bdi;
    @Override
    public int saveCsa(MeddetailCsa t) {
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
    public int removeById(int id) {
        try {
            MeddetailCsa csa = (MeddetailCsa)bdi.getObject(MeddetailCsa.class, id);
            bdi.remove(csa);
            return 1;
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    @Override
    public MeddetailCsa findCsaById(int id) {
        MeddetailCsa csa = null;

        try {
            csa =(MeddetailCsa) bdi.getObject(MeddetailCsa.class, id);
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return csa;
    }

    public BaseDaoImpl getBdi() {
        return bdi;
    }

    public void setBdi(BaseDaoImpl bdi) {
        this.bdi = bdi;
    }
}
