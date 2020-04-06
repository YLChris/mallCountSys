package com.yxb.mall.domain.vo;

import java.io.Serializable;

/**
 * (CSelltimeProduct)实体类
 */
public class CSelltimeProduct implements Serializable {
    private static final long serialVersionUID = -38033253109894630L;
    
    private String productSeq;
    
    private String productName;
    
    private String xiaoshouYear;
    
    private String xiaoshouMonth;
    
    private String xiaoshouDay;

    private String xiaoshouLiang;

    private String xiaoshouPrice;

    private String xiaoshouTotalPrice;

    private String operator;

    /**
     * 查询项
     */
    private String searchTerm;
    /**
     * 查询内容
     */
    private String searchContent;

    public String getSearchTerm() {
        return searchTerm;
    }

    public void setSearchTerm(String searchTerm) {
        this.searchTerm = searchTerm;
    }

    public String getSearchContent() {
        return searchContent;
    }

    public void setSearchContent(String searchContent) {
        this.searchContent = searchContent;
    }

    public String getXiaoshouTotalPrice() {
        return xiaoshouTotalPrice;
    }

    public void setXiaoshouTotalPrice(String xiaoshouTotalPrice) {
        this.xiaoshouTotalPrice = xiaoshouTotalPrice;
    }

    public String getOperator() {
        return operator;
    }

    public void setOperator(String operator) {
        this.operator = operator;
    }

    public String getXiaoshouPrice() {
        return xiaoshouPrice;
    }

    public void setXiaoshouPrice(String xiaoshouPrice) {
        this.xiaoshouPrice = xiaoshouPrice;
    }

    public String getXiaoshouLiang() {
        return xiaoshouLiang;
    }

    public void setXiaoshouLiang(String xiaoshouLiang) {
        this.xiaoshouLiang = xiaoshouLiang;
    }

    public String getProductSeq() {
        return productSeq;
    }

    public void setProductSeq(String productSeq) {
        this.productSeq = productSeq;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getXiaoshouYear() {
        return xiaoshouYear;
    }

    public void setXiaoshouYear(String xiaoshouYear) {
        this.xiaoshouYear = xiaoshouYear;
    }

    public String getXiaoshouMonth() {
        return xiaoshouMonth;
    }

    public void setXiaoshouMonth(String xiaoshouMonth) {
        this.xiaoshouMonth = xiaoshouMonth;
    }

    public String getXiaoshouDay() {
        return xiaoshouDay;
    }

    public void setXiaoshouDay(String xiaoshouDay) {
        this.xiaoshouDay = xiaoshouDay;
    }

}