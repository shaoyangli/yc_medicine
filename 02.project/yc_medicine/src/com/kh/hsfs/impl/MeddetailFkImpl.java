package com.kh.hsfs.impl;

import com.kh.base.impl.BaseDaoImpl;
import com.kh.hsfs.dao.MeddetailFkDao;
import com.kh.hsfs.model.MeddetailFk;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 15-8-25
 * Time: 下午9:24
 * To change this template use File | Settings | File Templates.
 */
public class MeddetailFkImpl implements MeddetailFkDao {
    private BaseDaoImpl bdi;
    @Override
    public int saveFk(MeddetailFk t) {
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
            MeddetailFk Fk = (MeddetailFk)bdi.getObject(MeddetailFk.class, id);
            bdi.remove(Fk);
            return 1;
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    @Override
    public MeddetailFk findFkById(int id) {
        MeddetailFk Fk = null;

        try {
            Fk =(MeddetailFk) bdi.getObject(MeddetailFk.class, id);
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return Fk;
    }

    public BaseDaoImpl getBdi() {
        return bdi;
    }

    public void setBdi(BaseDaoImpl bdi) {
        this.bdi = bdi;
    }
}
