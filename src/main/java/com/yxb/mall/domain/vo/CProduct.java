package com.yxb.mall.domain.vo;

import com.yxb.mall.domain.dto.PageDto;
import org.apache.commons.lang3.StringUtils;

import java.util.Date;
import java.io.Serializable;

/**
 * (CProduct)实体类
 *
 * @author makejava
 * @since 2020-03-13 00:28:43
 */
public class CProduct extends PageDto implements Serializable {
    private static final long serialVersionUID = -63201626535126031L;
    /**
    * 商品ID
    */
    private Integer productId;
    /**
    * 商品名称
    */
    private String productName;
    /**
    * 商品进价
    */
    private String productPrice;//单价
    
    private Date jingouTime;
    
    private String jingouOperator;
    
    private Date updateTime;

    private String updateOperator;

    private int productNum;//进购数量

    private String catagory;

    private String productTotalPrice;//商品进购数量乘以单价

    /**
     * 查询项
     */
    private String searchTerm;
    /**
     * 查询内容
     */
    private String searchContent;


    public String getProductTotalPrice() {
        return String.valueOf(Integer.parseInt(this.productPrice)*this.productNum);
    }

    public void setProductTotalPrice(String productTotalPrice) {
        this.productTotalPrice = String.valueOf(Integer.parseInt(this.productPrice)*this.productNum);
    }

    public int getProductNum() {
        return productNum;
    }

    public void setProductNum(int productNum) {
        this.productNum = productNum;
    }

    public String getUpdateOperator() {
        return updateOperator;
    }

    public void setUpdateOperator(String updateOperator) {
        this.updateOperator = updateOperator;
    }


    public String getCatagory() {
        return catagory;
    }

    public void setCatagory(String catagory) {
        this.catagory = catagory;
    }

    public Integer getProductId() {
        return productId;
    }

    public void setProductId(Integer productId) {
        this.productId = productId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getProductPrice() {
        return productPrice;
    }

    public void setProductPrice(String productPrice) {
        this.productPrice = productPrice;
    }

    public Date getJingouTime() {
        return jingouTime;
    }

    public void setJingouTime(Date jingouTime) {
        this.jingouTime = jingouTime;
    }

    public String getJingouOperator() {
        return jingouOperator;
    }

    public void setJingouOperator(String jingouOperator) {
        this.jingouOperator = jingouOperator;
    }

    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }


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
}