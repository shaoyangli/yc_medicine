package com.kh.hsfs.impl;

import com.kh.base.impl.BaseDaoImpl;
import com.kh.hsfs.dao.MeddetailVpaDao;
import com.kh.hsfs.model.MeddetailVpa;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 15-8-25
 * Time: 下午9:24
 * To change this template use File | Settings | File Templates.
 */
public class MeddetailVpaImpl implements MeddetailVpaDao {
    private BaseDaoImpl bdi;
    @Override
    public int saveVpa(MeddetailVpa t) {
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
            MeddetailVpa Vpa = (MeddetailVpa)bdi.getObject(MeddetailVpa.class, id);
            bdi.remove(Vpa);
            return 1;
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    @Override
    public MeddetailVpa findVpaById(int id) {
        MeddetailVpa Vpa = null;

        try {
            Vpa =(MeddetailVpa) bdi.getObject(MeddetailVpa.class, id);
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return Vpa;
    }

    public BaseDaoImpl getBdi() {
        return bdi;
    }

    public void setBdi(BaseDaoImpl bdi) {
        this.bdi = bdi;
    }
}
