package com.kh.base.impl;

import com.kh.base.dao.BaseDao;
import com.kh.util.DBConnection;
import com.kh.util.PageUtil;
import oracle.jdbc.OracleTypes;
import oracle.sql.ARRAY;
import oracle.sql.ArrayDescriptor;
import oracle.sql.STRUCT;
import oracle.sql.StructDescriptor;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.HibernateTemplate;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.io.Serializable;
import java.lang.reflect.ParameterizedType;
import java.sql.*;
import java.util.*;

@SuppressWarnings("unchecked")
public class BaseDaoImpl<T extends Serializable> implements BaseDao<T> {
    private static final Log logger = LogFactory.getLog(BaseDaoImpl.class);
    protected Class<T> entityClass;
    protected HibernateTemplate hibernateTemplate;

    protected Class getEntityClass() {
        if (entityClass == null) {
            entityClass = (Class<T>) ((ParameterizedType) getClass()
                    .getGenericSuperclass()).getActualTypeArguments()[0];
        }
        return entityClass;
    }
    //根据实体clasz以及sql查询返回实体对象list
    public List getEntityBySql(String sql,Class clasz) throws Exception{
        Session session= this.hibernateTemplate.getSessionFactory().getCurrentSession();
        List results = session.createSQLQuery(sql).addEntity(clasz).list();
        return results;
    }

    public Object get(Class clasz, Long id) throws Exception {
        try {
            return (Object) hibernateTemplate.get(clasz, id);
        } catch (Exception e) {
            e.printStackTrace();
            logger.info("得到对象失败");
            throw new Exception("得到对象失败");
        }
    }

    public Object getInt(Class clasz, int id) throws Exception {
        try {
            return (Object) hibernateTemplate.get(clasz, id);
        } catch (Exception e) {
            e.printStackTrace();
            logger.info("得到对象失败");
            throw new Exception("得到对象失败");
        }
    }

    public Object getObject(Class classz, String strID) throws Exception {
        try {
            return (Object) hibernateTemplate.get(classz, strID);
        } catch (Exception e) {
            e.printStackTrace();
            logger.info("得到对象失败");
            throw new Exception("得到对象失败");
        }
    }

    public Object getObject(String hql, String strID, String name)
            throws Exception {
        try {
            // return (Object) hibernateTemplate.get(classz, strID);
            List<Object> list = hibernateTemplate.find(hql, new Object[]{
                    strID, name});
            return (list == null || list.size() == 0) ? null : list.get(0);
        } catch (Exception e) {
            e.printStackTrace();
            logger.info("得到对象失败");
            throw new Exception("得到对象失败");
        }
    }

    public Object getObject2(String hql, int id, String str1, String str2)
            throws Exception {
        try {
            // return (Object) hibernateTemplate.get(classz, strID);
            List<Object> list = hibernateTemplate.find(hql, new Object[]{id,
                    str1, str2});
            return (list == null || list.size() == 0) ? null : list.get(0);
        } catch (Exception e) {
            e.printStackTrace();
            logger.info("得到对象失败");
            throw new Exception("得到对象失败");
        }
    }

    public void remove(T obj) throws Exception {
        try {
            hibernateTemplate.delete(obj);
        } catch (Exception e) {
            e.printStackTrace();
            logger.info("删除对象失败");
            throw new Exception("删除对象失败");
        }
    }

    public void removeById(Class clasz, Long id) throws Exception {
        try {
            hibernateTemplate.delete(this.get(clasz, id));
        } catch (Exception e) {
            e.printStackTrace();
            logger.info("根据编号删除对象失败");
            throw new Exception("根据编号删除对象失败");
        }
    }

    public int save(T obj) throws Exception {
        int id;
        try {
            hibernateTemplate.save(obj);
            id = 1;
        } catch (Exception e) {
            id = 0;
            e.printStackTrace();
            logger.info("保存对象失败");
            throw new Exception("保存对象失败");
        }
        return id;
    }

    public int saveObj(T obj) throws Exception {
        int id;
        try {
            hibernateTemplate.getSessionFactory().getCurrentSession().save(obj);
            id = 1;
        } catch (Exception e) {
            id = 0;
            e.printStackTrace();
            logger.info("保存对象失败");
            throw new Exception("保存对象失败");
        }
        return id;
    }

    public Object load(Class clasz, Long id) throws Exception {
        try {
            T load = (T) hibernateTemplate.load(clasz, id);
            return load;
        } catch (Exception e) {
            e.printStackTrace();
            logger.info("load对象数量失败");
            throw new Exception("load对象数量失败");
        }
    }

    public T merge(T obj) throws Exception {
        try {
            T merge = (T) hibernateTemplate.merge(obj);
            return merge;
        } catch (Exception e) {
            e.printStackTrace();
            logger.info("merge对象数量失败");
            throw new Exception("merge对象数量失败");
        }
    }

    public void saveorUpdate(T obj) throws Exception {
        try {
            hibernateTemplate.saveOrUpdate(obj);
        } catch (Exception e) {
            e.printStackTrace();
            logger.info("saveorupdate对象失败");
            throw new Exception("saveorupdate对象失败");
        }
    }

    public void update(T obj) throws Exception {
        try {
            hibernateTemplate.update(obj);
        } catch (Exception e) {
            e.printStackTrace();
            logger.info("修改对象失败");
            throw new Exception("修改对象失败");
        }
    }

    public List<T> queryList(String hql) throws Exception {
        try {
            return (List<T>) hibernateTemplate.find(hql);
        } catch (Exception e) {
            e.printStackTrace();
            logger.info("查询对象列表失败");
            throw new Exception("查询对象列表失败");
        }
    }

    public List<T> queryByNativeSQL(final String sql) throws Exception {
        try {
            return (List<T>) hibernateTemplate.execute(new HibernateCallback() {
                public Object doInHibernate(Session session)
                        throws HibernateException, SQLException {
                    return session.createSQLQuery(sql).list();
                }

            });
        } catch (Exception e) {
            e.printStackTrace();
            logger.info("本地sql删除失败");
            throw new Exception("本地sql删除失败");
        }
    }

    /**
     * 执行一条SQL 语句 retrun Integer
     */
    public int executeBySQL(final String sql) {
        return (Integer) hibernateTemplate.execute(new HibernateCallback() {
            public Object doInHibernate(Session session) throws SQLException {
                final int state = session.createSQLQuery(sql).executeUpdate();
                return (Object) state;
            }
        });
    }

    public List getForPages(final String hql, final int offset,
                            final int recoders) {
        List list = hibernateTemplate.executeFind(new HibernateCallback() {
            public Object doInHibernate(Session session)
                    throws HibernateException, SQLException {
                Query query = session.createQuery(hql);
                query.setFirstResult(offset);
                query.setMaxResults(recoders);
                List list = query.list();
                return list;
            }
        });
        logger.info("查询分页功能");
        return list;
    }

    /**
     * 如果数据库中的ID为String ,得到最大编号 *******error******* return Integer;
     */
    public int GetMaxID(String Hql) {
        int maxid = 0;
        try {
            String strmaxid = (String) ((Session) hibernateTemplate)
                    .createQuery(Hql).uniqueResult();
            maxid = Integer.parseInt(strmaxid.trim());
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                hibernateTemplate.clear();
            } catch (Exception e) {
                // TODO: handle exception
            }
        }
        logger.info("最大值");
        return maxid;
    }

    /**
     * 如果数据库中的ID为Integer ,得到最大编号 return Integer;
     */
    public int GetIntMaxID(final String Hql) {
        return (Integer) hibernateTemplate.execute(new HibernateCallback() {
            public Object doInHibernate(Session session)
                    throws HibernateException, SQLException {
                int maxid = 0;
                Integer longid = (Integer) session.createQuery(Hql)
                        .uniqueResult();
                maxid = (int) longid;
                logger.info("最大值");
                return maxid;
            }
        });
    }

    public int getPageRecorders(final String hql) {
        return (Integer) hibernateTemplate.execute(new HibernateCallback() {
            public Object doInHibernate(Session session)
                    throws HibernateException, SQLException {
                int maxid = 0;
                long longid = (Long) session.createQuery(
                        "select count(*) " + hql).uniqueResult();
                maxid = (int) longid;
                logger.info("最大值");
                return maxid;
            }
        });
    }

    /**
     * 数据对象计算；
     *
     * @param hql
     * @return
     */
    public String getStringToCount(String hql) {
        String str = "0";
        List l = hibernateTemplate.find(hql);
        if (l != null && l.size() > 0) {
            Long counts = (Long) l.get(0);
            str = String.valueOf(counts);
        }
        if (str == null || "".equals(str) || "null".equals(str)) {
            str = "0";
        }
        return str;
    }

    public List getStringArgs(String str, String mysplit) {
        List l = new ArrayList();
        if (str != null && str.length() > 0) {
            String[] args = str.split(mysplit);
            for (int i = 0; i < args.length; i++) {
                if (!mysplit.equals(args[i])) {
                    l.add(args[i]);
                }
            }
            return l;
        } else {
            return null;
        }
    }

    public List getByJdbcSQL3(String sql) {
        List pojolist = new ArrayList();
        Connection con = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        ResultSetMetaData rsmd = null;
        Session session = null;
        session = hibernateTemplate.getSessionFactory().openSession();
        con = session.connection();
        try {
            pst = con.prepareStatement(sql);
            rs = pst.executeQuery();
            rsmd = rs.getMetaData();
            int count = rsmd.getColumnCount();
            String s = "";
            while (rs.next()) {
                s = "";
                for (int i = 1; i <= count; i++) {
                    s += rs.getString(i) == null ? "" : rs.getString(i);
                    if (i != count) {
                        s += ",";
                    }
                    // temp_entity.add(rs.getString(i));
                }
                pojolist.add(s);
            }
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (pst != null) {
                    pst.close();
                }
                if (session != null) {
                    session.close();
                }
            } catch (SQLException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
        return pojolist;
    }

    public List getByJdbcSQL(String sql) {
        List pojolist = new ArrayList();
        Connection con = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        ResultSetMetaData rsmd = null;
        Session session = null;
        session = hibernateTemplate.getSessionFactory().openSession();
        con = session.connection();
        try {
            pst = con.prepareStatement(sql);
            rs = pst.executeQuery();
            rsmd = rs.getMetaData();
            int count = rsmd.getColumnCount();
            while (rs.next()) {
                List temp_entity = new ArrayList();
                for (int i = 1; i <= count; i++) {
                    temp_entity.add(rs.getString(i));
                }
                pojolist.add(temp_entity);
            }
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } finally {

            try {
                if (rs != null) {
                    rs.close();
                }
            } catch (SQLException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
            try {
                if (pst != null) {
                    pst.close();
                }
            } catch (SQLException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
            try {
                if (session != null) {
                    session.close();
                }
            } catch (Exception e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
        return pojolist;
    }

    public List getByJdbcSQL2(String sql) {
        List pojolist = new ArrayList();
        Connection con = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        ResultSetMetaData rsmd = null;
        Session session = null;
        session = hibernateTemplate.getSessionFactory().openSession();
        con = session.connection();
        try {
            pst = con.prepareStatement(sql);
            rs = pst.executeQuery();
            rsmd = rs.getMetaData();
            int count = rsmd.getColumnCount();
            while (rs.next()) {
                for (int i = 1; i <= count; i++) {
                    pojolist.add(rs.getString(i));
                }
            }
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } finally {

            try {
                if (rs != null) {
                    rs.close();
                }
            } catch (SQLException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
            try {
                if (pst != null) {
                    pst.close();
                }
            } catch (SQLException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
            try {
                if (session != null) {
                    session.close();
                }
            } catch (Exception e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
        return pojolist;
    }

    public int getPageCounts(String sql) {
        int pagecount = 0;
        Connection con = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        Session session = null;
        session = hibernateTemplate.getSessionFactory().openSession();
        con = session.connection();
        try {
            pst = con.prepareStatement(sql);
            rs = pst.executeQuery();
            while (rs.next()) {
                pagecount = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("getPageCounts 中捕获异常...");
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
                System.out.println("getPageCounts 中捕获rs!=null异常...");
            } finally {
                rs = null;
            }
            try {
                if (pst != null) {
                    pst.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
                System.out.println("getPageCounts 中捕获pst!=null异常...");
            } finally {
                pst = null;
            }
            try {
                if (session != null) {
                    session.close();
                }
            } catch (Exception e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
        return pagecount;
    }

    // 获取Request对象集合；
    public Map getRequestList(HttpServletRequest request) {
        Map map = new HashMap();
        Enumeration names = request.getParameterNames();
        while (names.hasMoreElements()) {
            Object currentvalue = names.nextElement();
            if (currentvalue != null) {
                String currentvalues = currentvalue.toString();
                map.put(currentvalues, request.getParameter(currentvalues));
            }
        }
        return map;

    }

    /**
     * 查询对象--复合主键情况
     *
     * @param clazz 对象
     * @param id    序列化对象id
     * @return 对象
     */
    public Object getObject(Class clazz, Serializable id) {
        T load = null;
        try {
            load = (T) hibernateTemplate.get(clazz, id);
        } catch (Exception e) {
            e.printStackTrace();
            logger.info("load对象数量失败");
            try {
                throw new Exception("load对象数量失败");
            } catch (Exception e1) {
                e1.printStackTrace();
            }
        }
        return load;
    }

    /**
     * 根据相关的参数，调用存储过程
     */

    public String getMedicals_Maxid(final String organcode, final String cerdate) {
        return (String) hibernateTemplate.execute(new HibernateCallback() {
            @SuppressWarnings("deprecation")
            public Object doInHibernate(Session session) throws SQLException {
                CallableStatement cs = session.connection().prepareCall(
                        "{?=call medicals_getlssue(?,?)}");
                cs.registerOutParameter(1, OracleTypes.VARCHAR);
                cs.setString(2, organcode);
                cs.setString(3, cerdate);
                cs.execute();
                return cs.getObject(1);
            }
        });
    }

    /**
     * highcharts 报表统计，调用存储过程
     *
     * @param proname 存储过程名
     * @param insql   输入参数
     * @return
     */
    public List chartCount(final String proname, final String insql) {
        return (List) hibernateTemplate.execute(new HibernateCallback() {
            @SuppressWarnings("deprecation")
            public Object doInHibernate(Session session) throws SQLException {
                CallableStatement cs = session.connection().prepareCall(
                        "{call " + proname + "(?,?,?)}");
                cs.setString(1, insql);
                cs.registerOutParameter(2, OracleTypes.INTEGER);
                cs.registerOutParameter(3, OracleTypes.CURSOR);
                cs.execute();
                List<String[]> list = new ArrayList<String[]>();
                int flag = (Integer) cs.getObject(2);
                // System.out.println(flag);
                if (flag == 1) {
                    ResultSet rs = (ResultSet) cs.getObject(3);
                    int count = rs.getMetaData().getColumnCount();
                    String[] str = new String[count];
                    while (rs.next()) {
                        for (int i = 1; i <= count; i++) {
                            str[i - 1] = rs.getString(i) == null ? "" : rs
                                    .getString(i);
                        }
                        list.add(str);
                        str = new String[count];
                    }
                } else {
                    System.out.println("-------调用存储过程执行错误");
                }
                return list;
            }
        });
    }

    public List<String[]> findResult(final String proname, final int type,
                                     final String address) {

        return (List) hibernateTemplate.execute(new HibernateCallback() {
            @SuppressWarnings("deprecation")
            public Object doInHibernate(Session session) throws SQLException {
                CallableStatement cs = session.connection().prepareCall(
                        "{call " + proname + "(?,?,?)}");
                cs.setInt(1, type);
                cs.setString(2, address);
                cs.registerOutParameter(3, OracleTypes.CURSOR);
                cs.execute();
                List<String[]> list = new ArrayList<String[]>();
                ResultSet rs = (ResultSet) cs.getObject(3);
                int count = rs.getMetaData().getColumnCount();// 结果集的列数
                while (rs.next()) {
                    String[] str = new String[count];
                    for (int i = 1; i <= count; i++) {
                        str[i - 1] = rs.getString(i) == null ? "" : rs
                                .getString(i);
                    }
                    list.add(str);
                }
                return list;
            }
        });
    }

    // 存储过程实现文件上传
    public int uploadFiles(final String fileName, final String fileType,
                           final String filePath) {
        return (Integer) hibernateTemplate.execute(new HibernateCallback() {
            @SuppressWarnings("deprecation")
            public Object doInHibernate(Session session) throws SQLException {
                CallableStatement cs = session.connection().prepareCall(
                        "{call hsfs_uploadFiles (?,?,?,?)}");
                cs.setString(1, fileName);
                cs.setString(2, fileType);
                cs.setString(3, filePath);
                cs.registerOutParameter(4, OracleTypes.INTEGER);
                cs.execute();
                int id = cs.getInt(4);
                return id;
            }
        });
    }

    // 存储过程实现文件上传
    public int uploadFiles1(final String fileName, final String fileType,
                            final String filePath) {
        return (Integer) hibernateTemplate.execute(new HibernateCallback() {
            @SuppressWarnings("deprecation")
            public Object doInHibernate(Session session) throws SQLException {
                CallableStatement cs = session.connection().prepareCall(
                        "{call hsfs_uploadFiles1 (?,?,?,?)}");
                cs.setString(1, fileName);
                cs.setString(2, fileType);
                cs.setString(3, filePath);
                cs.registerOutParameter(4, OracleTypes.INTEGER);
                cs.execute();
                int id = cs.getInt(4);
                return id;
            }
        });
    }

    /**
     * 资金申请
     *
     * @param proname
     * @param insql
     * @return
     */
    public String fundapply(final String proname, final String insql) {
        return (String) hibernateTemplate.execute(new HibernateCallback() {
            @SuppressWarnings("deprecation")
            public Object doInHibernate(Session session) throws SQLException {
                CallableStatement cs = session.connection().prepareCall(
                        "{call " + proname + "(?,?)}");
                cs.setString(1, insql);
                cs.registerOutParameter(2, OracleTypes.VARCHAR);
                cs.execute();
                String flag = (String) cs.getObject(2);
                return flag;
            }
        });
    }

    /**
     * 获取总记录数
     *
     * @param sql
     * @return
     */
    public int getCounts(final String sql) {
        return (Integer) hibernateTemplate.execute(new HibernateCallback() {
            @SuppressWarnings("deprecation")
            public Object doInHibernate(Session session) throws SQLException {
                Query query = session.createSQLQuery(sql);
                List list = query.list();
                return Integer.valueOf(list.get(0).toString());
            }
        });
    }

    /**
     * 统计
     *
     * @param sql
     * @return
     */
    public List getCount(final String sql) {
        List list = hibernateTemplate.executeFind(new HibernateCallback() {
            @SuppressWarnings("deprecation")
            public Object doInHibernate(Session session) throws SQLException {
                Query query = session.createSQLQuery(sql);
                List list = query.list();
                return list;
            }
        });
        return list;
    }

    public void bulkexecute(final String hql) {
        // TODO Auto-generated method stub
        hibernateTemplate.execute(new HibernateCallback() {
            @SuppressWarnings("deprecation")
            public Object doInHibernate(Session session) throws SQLException {
                Query query = session.createQuery(hql);
                return query.executeUpdate();
            }
        });
    }

    /**
     * 获取序列的序号
     *
     * @param sql
     * @return
     */
    public List getSq_index(final String sql) {
        return (List) hibernateTemplate.execute(new HibernateCallback() {
            @SuppressWarnings("deprecation")
            public Object doInHibernate(Session session) throws SQLException {
                Query query = session.createSQLQuery(sql);
                List list = query.list();
                return list;
            }
        });
    }

    /**
     * 组装数组
     */
    public Array getmyArray1(String oraclelist, Vector v) {
        ARRAY list = null;
        DBConnection db2 = new DBConnection();
        db2.openConnect();
        Connection con = db2.getConnection();
        if (v != null && v.size() > 0) {
            try {
                StructDescriptor structdesc = new StructDescriptor(
                        "MSALSEND_COUNT1", con);
                STRUCT[] structs = new STRUCT[v.size()];
                Object[] result = new Object[0];
                for (int i = 0; i < v.size(); i++) {
                    result = new Object[1];
                    List l = (List) v.get(i);
                    result[0] = new Long(Long.valueOf(l.get(0).toString()));
                    structs[i] = new STRUCT(structdesc, con, result);
                }
                ArrayDescriptor desc = ArrayDescriptor.createDescriptor(
                        oraclelist, con);
                list = new ARRAY(desc, con, structs);
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                Cclose(con);
            }
        } else {
            try {
                ArrayDescriptor desc = ArrayDescriptor.createDescriptor(
                        oraclelist, con);
                STRUCT[] structs = new STRUCT[0];
                list = new ARRAY(desc, con, structs);
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                Cclose(con);
            }
        }
        return list;
    }

    public void Cclose(Connection con) {
        if (con != null) {
            try {
                con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        con = null;
    }

    /**
     * 返回单值 以String类型返回
     *
     * @param sql
     * @return
     */
    public String getSingleResult(final String sql) {
        return (String) hibernateTemplate.execute(new HibernateCallback() {

            public Object doInHibernate(Session session)
                    throws HibernateException, SQLException {
                String str = "";
                try {
                    List list = session.createSQLQuery(sql).list();
                    if (list != null && list.size() != 0) {
                        str = list.get(0).toString();
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
                return str;
            }
        });
    }

    public int sendsalary(Long ids, String id, String name, String nowtime,
                          Long baseSalId) throws SQLException {
        return 0;
    }

    public List QueryListNew(String hql, Object[] obj) {
        return hibernateTemplate.find(hql, obj);
    }

    /**
     * update
     *
     * @param sql 修改sql语句
     * @return
     */
    public int updateSQL(final String sql) {
        return (Integer) hibernateTemplate.execute(

                new HibernateCallback() {

                    public Object doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        int flag = 0;
                        session.createSQLQuery(sql).executeUpdate();
                        flag = 1;
                        return flag;
                    }

                }

        );
    }

    public List re_Excel(final String sql) {
        return (List) hibernateTemplate.execute(new HibernateCallback() {
            public Object doInHibernate(Session session)
                    throws HibernateException, SQLException {
                Connection con = session.connection();
                Statement st = con.createStatement();
                ResultSet rs = st.executeQuery(sql);
                ResultSetMetaData rsmd = rs.getMetaData();// 获取查询的列
                int colunm_count = rsmd.getColumnCount();
                List list = new ArrayList();
                while (rs.next()) {
                    Object[] o = new Object[colunm_count];
                    for (int i = 1; i < colunm_count + 1; i++) {
                        o[i - 1] = rs.getObject(i);
                    }
                    list.add(o);
                }

                return list;
            }

        });
    }

    /**
     * 得到名称的单拼码
     *
     * @return
     */
    public String getPyFirstCode(final String name) {
        return (String) hibernateTemplate.execute(new HibernateCallback() {
            @SuppressWarnings("deprecation")
            public Object doInHibernate(Session session) throws SQLException {
                CallableStatement cs = session.connection().prepareCall(
                        "{?=call fGetPy(?)}");
                cs.setString(2, name);
                cs.registerOutParameter(1, OracleTypes.VARCHAR);
                cs.execute();
                return cs.getString(1);
            }
        });
    }

    public List getForPagesBySql(final String sql, final int offset,
                                 final int recoders) {
        List list = hibernateTemplate.executeFind(new HibernateCallback() {
            public Object doInHibernate(Session session)
                    throws HibernateException, SQLException {
                Query query = session.createSQLQuery(sql);
                query.setFirstResult(offset);
                query.setMaxResults(recoders);
                List list = query.list();
                session.close();
                return list;
            }

        });
        logger.info("查询分页功能");
        return list;

    }

    public PageUtil<T> findByHqlPage(final int currPage, final int rows,
                                     final String hql) {
        List<T> list = new ArrayList();
        list = hibernateTemplate.executeFind(new HibernateCallback() {
            public List<T> doInHibernate(Session session)
                    throws HibernateException, SQLException {
                return session.createQuery(hql).setFirstResult(
                        (currPage - 1) * rows).setMaxResults(rows).list();
            }
        });
        int totalRows = getPageRecorders(hql);
        PageUtil<T> page = new PageUtil<T>(totalRows, rows, currPage);
        page.setList(list);
        // 将保存结果的list放到page中
        return page;
    }

    public PageUtil<T> findBySqlPage(final int currPage, final int rows,
                                     final String sql) {
        List<T> list = new ArrayList();
        list = hibernateTemplate.executeFind(new HibernateCallback() {
            public List<T> doInHibernate(Session session)
                    throws HibernateException, SQLException {
                return session.createSQLQuery(sql).setFirstResult(
                        (currPage - 1) * rows).setMaxResults(rows).list();
            }
        });
        int totalRows = getCounts("select count(*) from (" + sql + ") ww");
        PageUtil<T> page = new PageUtil<T>(totalRows, rows, currPage);
        page.setList(list);
        // 将保存结果的list放到page中
        return page;
    }

    public PageUtil<T> findByProPage(final int currPage, final int rows,
                                     final String proname, final String insql) {
        List<T> list = new ArrayList();
        list = (List) hibernateTemplate.execute(new HibernateCallback() {
            @SuppressWarnings("deprecation")
            public Object doInHibernate(Session session) throws SQLException {
                CallableStatement cs = session.connection().prepareCall(
                        "{call " + proname + "(?,?,?,?)}");
                cs.setString(1, insql);
                cs.registerOutParameter(2, OracleTypes.VARCHAR);
                cs.registerOutParameter(3, OracleTypes.INTEGER);
                cs.registerOutParameter(4, OracleTypes.CURSOR);
                cs.execute();
                List<String[]> list = new ArrayList<String[]>();
                int flag = (Integer) cs.getObject(3);
                System.out.println(flag + "=");
                if (flag == 1) {
                    ResultSet rs = (ResultSet) cs.getObject(4);
                    int count = rs.getMetaData().getColumnCount();
                    String[] str = new String[count];
                    while (rs.next()) {
                        for (int i = 1; i <= count; i++) {
                            str[i - 1] = rs.getString(i) == null ? "" : rs
                                    .getString(i);
                        }
                        list.add(str);
                        str = new String[count];
                    }
                    str[0] = (String) cs.getObject(2);
                    for (int i = 2; i <= count; i++) {
                        str[i - 1] = "";
                    }
                    list.add(str);
                } else {
                    String[] str = new String[1];
                    str[0] = (String) cs.getObject(2);// 封装错误信息
                    System.out.println(str[0]);
                    list.add(str);
                }
                return list;
            }
        });
        int totalRows = 0;
        if (list != null && list.size() > 0) {
            if (list.size() > 1) {
                String s = ((String[]) list.get(list.size() - 1))[0].split(",")[2];
                totalRows = Integer.parseInt(s);
            }
        }
        PageUtil<T> page = new PageUtil<T>(totalRows, rows, currPage);
        page.setList(list);
        // 将保存结果的list放到page中
        return page;
    }

    public List<T> findAll(Class<T> clazz) {
        List<T> list = new ArrayList<T>();
        list = hibernateTemplate.find("from " + clazz.getName());
        return list;
    }

    @Resource
    public void setHibernateTemplate(HibernateTemplate hibernateTemplate) {
        this.hibernateTemplate = hibernateTemplate;
    }

}
