package com.kh.hsfs.model;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 15-7-28
 * Time: 下午9:02
 * To change this template use File | Settings | File Templates.
 */
public class HospitalInfo implements java.io.Serializable {
    private int id;
    private String hospcode;
    private String name;
    private String sex;
    private String age;
    private String height;
    private String weight;
    private String surface_area;
    private String operation_time;


    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getHospcode() {
        return hospcode;
    }

    public void setHospcode(String hospcode) {
        this.hospcode = hospcode;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public String getAge() {
        return age;
    }

    public void setAge(String age) {
        this.age = age;
    }

    public String getHeight() {
        return height;
    }

    public void setHeight(String height) {
        this.height = height;
    }

    public String getWeight() {
        return weight;
    }

    public void setWeight(String weight) {
        this.weight = weight;
    }

    public String getSurface_area() {
        return surface_area;
    }

    public void setSurface_area(String surface_area) {
        this.surface_area = surface_area;
    }

    public String getOperation_time() {
        return operation_time;
    }

    public void setOperation_time(String operation_time) {
        this.operation_time = operation_time;
    }
}
