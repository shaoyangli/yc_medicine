package com.kh.hsfs.impl;

import com.kh.base.impl.BaseDaoImpl;
import com.kh.hsfs.dao.MedicineFkDao;
import com.kh.hsfs.model.MeddetailFk;
import com.kh.hsfs.model.MedicineFk;
import com.kh.util.PageUtil;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: lsy
 * Date: 15-7-28
 * Time: 下午10:09
 * To change this template use File | Settings | File Templates.
 */
public class MedicineFkImpl implements MedicineFkDao {

    private BaseDaoImpl bdi;
    @Override
    public int saveFk(MedicineFk t) {
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
            MedicineFk fk = (MedicineFk)bdi.getObject(MedicineFk.class, id);

            //删除主记录
            bdi.remove(fk);
            return 1;
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    @Override
    public MedicineFk findFkById(int id) {
        MedicineFk Fk = null;

        try {
            Fk =(MedicineFk) bdi.getObject(MedicineFk.class, id);
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return Fk;
    }

    @Override
    public void updateFk(MedicineFk t) {
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
