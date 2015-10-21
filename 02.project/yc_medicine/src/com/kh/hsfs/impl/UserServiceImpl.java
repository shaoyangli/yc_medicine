package com.kh.hsfs.impl;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.kh.base.dao.BaseDao;
import com.kh.hsfs.dao.UserService;
import com.kh.hsfs.model.HsfsOrgBaseInfo;
import com.kh.hsfs.model.HsfsUserInfo;
import com.kh.hsfs.model.HsfsUserPower;
import com.kh.hsfs.model.HsfsUserRole;
import com.kh.hsfs.model.HsfsUserRolePower;
import com.kh.util.PageUtil;

public class UserServiceImpl implements UserService {
    private BaseDao bdi;

    public List findList(String sql) {
        List list = bdi.getByJdbcSQL(sql);
        return list;
    }

    public int saveUser(HsfsUserInfo user) {
        int result;
        try {
            bdi.save(user);
            result = 0;
        } catch (Exception e) {
            result = 1;
        }
        return result;
    }

    /**
     * ����1��ʾ�õ�¼Id�Ѿ�ʹ����
     */
    public int checkLoginID(String loginID) {
        String sql = "select count(1) from hsfs_user_info where user_loginid = '"
                + loginID + "'";
        int r = bdi.getCounts(sql);
        if (r > 0) {
            return 1;
        } else {
            return 0;
        }
    }

    public int saveUserRole(HsfsUserRole userRole) {
        String roleName = userRole.getRoleName();
        String sql = "";
        //�޸�
        if (userRole.getRoleCode() > 0) {
            sql = "select count(1) from hsfs_user_role where role_name = '"
                    + roleName + "' and role_code<>" + userRole.getRoleCode();

        } else {
            //����
            sql = "select count(1) from hsfs_user_role where role_name = '"
                    + roleName + "'";
        }
        int count = bdi.getCounts(sql);
        if (count == 0) {
            try {
                bdi.saveorUpdate(userRole);
                return 0;
            } catch (Exception e) {

                e.printStackTrace();
                return 1;
            }
        } else {
            return 2;
        }


    }

    public int saveUserPower(HsfsUserPower power) {
        try {
            bdi.save(power);
            return 0;
        } catch (Exception e) {

            e.printStackTrace();
            return 1;
        }
    }

    public int saveOrUpdateRolePower(HsfsUserRolePower rolePower) {
        int roleId = rolePower.getRoleId();
        if (rolePower.getPowerId().equals("")) {
            rolePower.setPowerId("0");
        }
        String sql = "select count(1) from hsfs_user_role_power where role_id = "
                + roleId;
        int count = bdi.getCounts(sql);// ��ѯ�Ƿ��Ѿ����ڽ�ɫ��Ȩ����Ϣ
        if (count > 0) {
            int id = bdi
                    .getCounts("select id from hsfs_user_role_power where role_id = "
                            + roleId);
            rolePower.setId(id);
        }
        try {
            bdi.saveorUpdate(rolePower);
            return 0;
        } catch (Exception e) {
            e.printStackTrace();
            return 1;
        }
    }

    public String findId(String sql) {
        String powerIds = "";
        List list = bdi.getByJdbcSQL2(sql);
        if (list.size() > 0) {
            powerIds = (String) bdi.getByJdbcSQL2(sql).get(0);
        }
        return powerIds;
    }

    // ����һ��sql��������
    private int findmainId(String sql) {
        int id = -1;
        List list = bdi.getByJdbcSQL2(sql);
        if (list.size() > 0) {
            id = Integer.parseInt((String) bdi.getByJdbcSQL2(sql).get(0));
        }
        return id;
    }

    // �û���¼
    public int checkLogin(String logInname, String loginPass, String year) {
        String sql = "select count(1) from hsfs_user_info where user_loginid = '"
                + logInname + "' and user_pwd = '" + loginPass + "' and is_stop = 0";
        System.out.println("=========" + sql);
        int result = 0;
        try {
            result = bdi.getCounts(sql);
        } catch (Exception e) {
            System.out.println("===========�쳣:result"+result);
            e.printStackTrace();
        }
        if (result > 0) {// ��¼�ɹ�
            System.out.println("����");
            int id = findmainId("select user_code from hsfs_user_info where user_loginid = '"
                    + logInname + "' and user_pwd = '" + loginPass + "'");// ��ǰ��¼�û�������
            try {
//				List<HsfsUserPower> userPowers = new ArrayList<HsfsUserPower>();
                HsfsUserInfo user = (HsfsUserInfo) bdi.getInt(
                        HsfsUserInfo.class, id);// �õ��û�����
//				String orgCode = user.getOrgCode();// ��Ͻ��������
//				int roleId = user.getPowerRole();// ������ɫid
//				HsfsOrgBaseInfo org = (HsfsOrgBaseInfo) bdi.getObject(
//						HsfsOrgBaseInfo.class, orgCode);// �õ��û���Ͻ�Ļ���
                // HsfsUserRole userRole =
                // (HsfsUserRole)bdi.getInt(HsfsUserRole.class, roleId);//�õ��û���ɫ
                // ��һ���ӽ�ɫ��ϵ���еõ���ɫ��Ȩ��
//				String sql1 = "select power_id from hsfs_user_role_power where role_id = "
//						+ roleId;
//				String power_ids = findId(sql1);// �õ�Ȩ��id
//				if (!power_ids.equals("0") && !power_ids.equals("")) {
//
//					String hql = "from HsfsUserPower p where p.powerId in ("
//							+ power_ids + ") order by p.orderId";
//					userPowers = (ArrayList<HsfsUserPower>) bdi.queryList(hql);
//				}
                HttpSession session = ServletActionContext.getRequest()
                        .getSession();
//				session.setAttribute("org", org);
                session.setAttribute("user", user);
                ///session.setAttribute("userPowers", userPowers);
                session.setAttribute("year", year);
//				String sqlp = "select PERCAPITAL from hsfs_param_info where buryear = '" + year + "' and rownum = 1 ";
//				List list = bdi.getByJdbcSQL2(sqlp);//��ѯ������Ĳ�����׼
//				if(list.size() > 0) {
//					String perMoney = (String)list.get(0);
//					session.setAttribute("perMoney", Float.parseFloat(perMoney));//������׼ ����ͷ����
//					//System.out.println(Float.parseFloat(perMoney));
//				}
            } catch (Exception e) {
                System.out.println("�쳣");
                e.printStackTrace();
            }
            return 0;
        } else {
            return 1;// ��¼ʧ��
        }

    }

    // �û���¼
    public int checkLoginx(String pda_sn, String year) {
        String sql = "select count(1) from hsfs_user_info where pda_sn = '"
                + pda_sn + "' and is_stop = 0";
        int result = bdi.getCounts(sql);
        if (result > 0) {// ��¼�ɹ�
            int id = findmainId("select user_code from hsfs_user_info where pda_sn = '"
                    + pda_sn + "'  and rownum = 1");// ��ǰ��¼�û�������
            try {
                List<HsfsUserPower> userPowers = new ArrayList<HsfsUserPower>();
                HsfsUserInfo user = (HsfsUserInfo) bdi.getInt(
                        HsfsUserInfo.class, id);// �õ��û�����
                String orgCode = user.getOrgCode();// ��Ͻ��������
                int roleId = user.getPowerRole();// ������ɫid
                HsfsOrgBaseInfo org = (HsfsOrgBaseInfo) bdi.getObject(
                        HsfsOrgBaseInfo.class, orgCode);// �õ��û���Ͻ�Ļ���
                HttpSession session = ServletActionContext.getRequest()
                        .getSession();
                session.setAttribute("org", org);
                session.setAttribute("user", user);
                ///session.setAttribute("userPowers", userPowers);
                session.setAttribute("year", year);
                String sqlp = "select PERCAPITAL from hsfs_param_info where buryear = '" + year + "' and rownum = 1 ";
                List list = bdi.getByJdbcSQL2(sqlp);//��ѯ������Ĳ�����׼
                if (list.size() > 0) {
                    String perMoney = (String) list.get(0);
                    session.setAttribute("perMoney", Float.parseFloat(perMoney));//������׼ ����ͷ����
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            return 0;
        } else {
            return 1;// ��¼ʧ��
        }

    }

    /*
     * ������˵�
     */
    public void checkUserPowers() {
        HttpSession session = ServletActionContext.getRequest().getSession();
        HsfsUserInfo user = (HsfsUserInfo) session.getAttribute("user");
        List<HsfsUserPower> userPowers = new ArrayList<HsfsUserPower>();
        int roleId = user.getPowerRole();// ������ɫid
        String sql1 = "select power_id from hsfs_user_role_power where role_id = "
                + roleId;
        String power_ids = findId(sql1);// �õ�Ȩ��id
        System.out.println("power_ids======="+power_ids);
        if (!power_ids.equals("0") && !power_ids.equals("")) {
            System.out.println("chaxunchenggong power");
            String hql = "from HsfsUserPower p where p.powerId in ("
                    + power_ids + ") order by p.orderId";
            try {
                userPowers = (ArrayList<HsfsUserPower>) bdi.queryList(hql);
                System.out.println(userPowers.get(0).getPowerName());
            } catch (Exception e) {
                // TODO Auto-generated catch block
                System.out.println("Exception");
                e.printStackTrace();
            } catch (Throwable e){
                System.out.println("Throwable");
                e.printStackTrace();
                for(StackTraceElement elem : e.getStackTrace()) {
                    System.out.println(elem);
                }
            }finally {
                System.out.println("finally");

            }
        }
        System.out.println(userPowers.size() + "===============");
        session.setAttribute("userPowers", userPowers);

    }

    /**
     * ɾ���û�
     */
    public int removeUser(int id) {

        try {
            HsfsUserInfo user = (HsfsUserInfo) bdi.getInt(HsfsUserInfo.class,
                    id);
            bdi.remove(user);
            return 0;
        } catch (Exception e) {
            e.printStackTrace();
            return 1;
        }
    }

    /**
     * ɾ��Ȩ��
     */

    public int removePower(int pId) {
        HsfsUserPower power = (HsfsUserPower) findModel(HsfsUserPower.class,
                pId);
        int fahterId = power.getFatherId();
        // ɾ�������˵�
        if (fahterId > 0) {
            try {
                bdi.remove(power);
                return 0;
            } catch (Exception e) {
                e.printStackTrace();
                return 1;
            }
        }
        // ɾ��һ���˵�
        else {
            try {
                String hql = "from HsfsUserPower p where p.fatherId = " + pId;
                List<HsfsUserPower> powers = bdi.queryList(hql);
                // ��ɾ���Ӳ˵�
                for (HsfsUserPower p : powers) {
                    bdi.remove(p);
                }
                // ���ɾ��һ���˵�
                bdi.remove(power);
                return 0;
            } catch (Exception e) {
                e.printStackTrace();
                return 1;
            }
        }

    }

    public Object findModel(Class obj, int id) {
        try {
            return bdi.getInt(obj, id);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public int updatePower(HsfsUserPower power) {
        try {
            bdi.update(power);
            return 0;
        } catch (Exception e) {
            e.printStackTrace();
            return 1;
        }
    }

    public int updateUser(HsfsUserInfo user) {
        try {
            bdi.update(user);
            return 0;
        } catch (Exception e) {
            e.printStackTrace();
            return 1;
        }
    }

    /**
     * ɾ����ɫ֮ǰҪ�жϽ�ɫ�Ƿ�ʹ��,ɾ����ɫ��ʱ��Ҫ����ϵ���еļ�¼ҲҪɾ��
     */
    public int removeRole(int id) {
        String sql = "select count(1) from hsfs_user_info where power_role = "
                + id;
        int count = bdi.getCounts(sql);

        if (count == 0) {
            try {
                String sql1 = "delete from hsfs_user_role where role_code="
                        + id;
                String sql2 = "delete from hsfs_user_role_power where role_id="
                        + id;
                // HsfsUserRole role =
                // (HsfsUserRole)bdi.getInt(HsfsUserRole.class, id);
                // bdi.remove(role);
                bdi.executeBySQL(sql1);
                bdi.executeBySQL(sql2);
                return 0;
            } catch (Exception e) {

                e.printStackTrace();
                return 1;
            }
        } else {
            return 2;
        }
    }

    public PageUtil findBySqlPage(int currPage, int rows, String sql) {
        // Ĭ����ʾ��һҳ
        if (currPage == 0) {
            currPage = 1;
        }
        return bdi.findBySqlPage(currPage, rows, sql);
    }

    public int updateUserState(String state, int id) {
        String sql = "update hsfs_user_info set is_stop = '" + state + "' where user_code = " + id;
        int k = bdi.executeBySQL(sql);
        return k;
    }

    public BaseDao getBdi() {
        return bdi;
    }

    public void setBdi(BaseDao bdi) {
        this.bdi = bdi;
    }

}
