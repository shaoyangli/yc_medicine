package com.kh.hsfs.impl;

import com.kh.base.impl.BaseDaoImpl;
import com.kh.hsfs.dao.MedicineWfDao;
import com.kh.hsfs.model.MeddetailVpa;
import com.kh.hsfs.model.MeddetailWf;
import com.kh.hsfs.model.MedicineVpa;
import com.kh.hsfs.model.MedicineWf;
import com.kh.util.PageUtil;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: lsy
 * Date: 15-7-28
 * Time: 下午10:09
 * To change this template use File | Settings | File Templates.
 */
public class MedicineWfImpl implements MedicineWfDao {

    private BaseDaoImpl bdi;
    @Override
    public int saveWf(MedicineWf t) {
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
            //查询住记录
            MedicineWf wf = (MedicineWf)bdi.getObject(MedicineWf.class, id);

            //删除主记录
            bdi.remove(wf);
            return 1;
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    @Override
    public MedicineWf findWfById(int id) {
        MedicineWf Wf = null;

        try {
            Wf =(MedicineWf) bdi.getObject(MedicineWf.class, id);
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return Wf;
    }

    @Override
    public void updateWf(MedicineWf t) {
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
