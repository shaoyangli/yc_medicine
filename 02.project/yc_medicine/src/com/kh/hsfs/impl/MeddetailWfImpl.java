package com.kh.hsfs.impl;

import com.kh.base.impl.BaseDaoImpl;
import com.kh.hsfs.dao.MeddetailWfDao;
import com.kh.hsfs.model.MeddetailWf;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 15-8-25
 * Time: 下午9:24
 * To change this template use File | Settings | File Templates.
 */
public class MeddetailWfImpl implements MeddetailWfDao {
    private BaseDaoImpl bdi;
    @Override
    public int saveWf(MeddetailWf t) {
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
            MeddetailWf Wf = (MeddetailWf)bdi.getObject(MeddetailWf.class, id);
            bdi.remove(Wf);
            return 1;
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    @Override
    public MeddetailWf findWfById(int id) {
        MeddetailWf Wf = null;

        try {
            Wf =(MeddetailWf) bdi.getObject(MeddetailWf.class, id);
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return Wf;
    }

    public BaseDaoImpl getBdi() {
        return bdi;
    }

    public void setBdi(BaseDaoImpl bdi) {
        this.bdi = bdi;
    }
}
