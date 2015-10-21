package com.kh.base.dao;

import java.io.Serializable;
import java.util.List;


import com.kh.util.PageUtil;

/**
 * BaseDao基类DAO；
 */

public interface BaseDao<T extends Serializable> {

    /**
     * 保存实体
     *
     * @param obj
     */
    public int save(T obj) throws Exception;

    /**
     * hibernate 的save方法;
     */
    public int saveObj(T obj) throws Exception;
    //根据实体clasz以及sql查询返回实体对象list
    public List getEntityBySql(String sql,Class clasz) throws Exception;
    /**
     * 修改操作
     */
    public void update(T obj) throws Exception;

    /**
     * 删除；
     */
    public void remove(T obj) throws Exception;

    /**
     * 删除by ID；
     */
    public void removeById(Class clasz, Long id) throws Exception;

    /**
     * 查询by ID；
     */
    public Object get(Class clasz, Long id) throws Exception;

    /**
     * 查询by ID；
     */
    public Object getInt(Class clasz, int id) throws Exception;

    /**
     * load一个对象,会在二级缓存跟内存中寻找对象
     */
    public Object load(Class clasz, Long id) throws Exception;

    /**
     * 保存或更新对象 select,update/insert[2条sql]
     */
    public void saveorUpdate(T obj) throws Exception;

    /**
     * 将传入的detached状态的对象的属性复制到持久化对象中，并返回该持久化对象 。<br>
     * 如果该session中没有关联的持久化对象，加载一个，<br>
     * 如果传入对象未保存，保存一个副本并作为持久对象返回，传入对象依然保持detached状态。<br>
     * merge=select,update/insert,select[3条sql]
     *
     * @return detached状态的, 更新之后的对象
     */
    public T merge(T obj) throws Exception;


    /**
     * 通过hql查询列表
     *
     * @param hql
     * @return
     * @throws Exception
     */
    public List<T> queryList(String hql) throws Exception;

    public List<T> queryByNativeSQL(final String sql) throws Exception;

    /**
     * 查询 return Object
     *
     * @throws Exception
     */
    public Object getObject(Class classz, String strID) throws Exception;

    /**
     * 查询 return Object
     *
     * @throws Exception
     */
    public Object getObject(String hql, String strID, String name) throws Exception;

    public Object getObject2(String hql, int id, String str1, String str2) throws Exception;

    /**
     * 一般JDBC SQL 适用于数据量大的查询
     *
     * @param SQL
     * @return LIST
     * @throws Exception
     */
    public List getByJdbcSQL(String sql);

    public List getByJdbcSQL2(String sql);

    /**
     * 获取最大编号；
     *
     * @param SQL
     * @return int
     * @throws Exception
     */
    public int GetMaxID(String Hql);

    /**
     * 数据对象计算
     *
     * @param SQL
     * @return int
     * @throws Exception
     */
    public String getStringToCount(String hql);

    /**
     * 执行一条SQL 语句 retrun Integer
     */
    public int executeBySQL(final String sql);

    /**
     * 如果数据库中的ID为Integer ,得到最大编号 return Integer;
     */
    public int GetIntMaxID(String Hql);

    /**
     * 获取总记录数
     *
     * @param sql
     * @return
     */
    public int getCounts(final String sql);

    /**
     * 可以用来统计 返回 记录数集合
     *
     * @param sql
     * @return
     */
    public List getCount(final String sql);

    /**
     * 批量执行操作方法；
     */
    public void bulkexecute(String hql);

    /**
     * 获取序列的序号
     *
     * @param sql
     * @return
     */
    public List getSq_index(final String sql);

    public String getSingleResult(final String sql);

    /**
     * 重载查询方法；
     */
    public List QueryListNew(String hql, Object[] obj);

    /**
     * update
     *
     * @param sql 修改sql语句
     * @return
     */
    public int updateSQL(final String sql);

    public List getForPagesBySql(final String sql, final int offset,
                                 final int recoders);

    public List<T> findAll(Class<T> clazz);

    /**
     * 使用hql 分页调用方法
     *
     * @param currPage 当前页
     * @param rows     每页显示数量 如果系统整体每页显示一样 此项可以去掉
     * @param hql      hql语句
     * @return
     */
    public PageUtil<T> findByHqlPage(int currPage, int rows, String hql);

    /**
     * 使用sql 分页调用方法
     *
     * @param currPage 当前页
     * @param rows     每页显示数量 如果系统整体每页显示一样 此项可以去掉
     * @param sql      sql语句
     * @return
     */
    public PageUtil<T> findBySqlPage(int currPage, int rows, String sql);

    /**
     * highcharts 报表统计，调用存储过程
     *
     * @param proname 存储过程名
     * @param insql   输入参数
     * @return
     */
    public List chartCount(String proname, String insql);

    /**
     * 资金申请
     * @param proname
     * @param insql
     * @return
     */
    /**
     * 执行存储过,返回集合
     */
    public List<String[]> findResult(String proname, int type, String address);

    //调用存储过程返回主键  服务记录文件上传
    public int uploadFiles(String fileName, String fileType, String filePath);

    //邮件附件上传
    public int uploadFiles1(String fileName, String fileType, String filePath);

    public String fundapply(String proname, String insql);
    //public PageUtil<T> findByPage(int currPage, int rows,Class<T> clazz);

    public PageUtil<T> findByProPage(final int currPage, final int rows,
                                     final String proname, final String insql);
}
