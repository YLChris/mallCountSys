package com.yxb.mall.domain.vo;

import com.yxb.mall.domain.dto.PageDto;
import org.springframework.stereotype.Service;

import java.io.Serializable;

/**
 * (CProductCondition)实体类
 *
 * @author makejava
 * @since 2020-03-15 14:31:07
 */
@Service
public class CProductCondition extends PageDto implements Serializable {
    private static final long serialVersionUID = -57267664864795597L;

    //产品标识
    private String productSeq;
    private String productName;
    /**
    * 产品进购价
    */
    private String productPrice;
    
    private String catagory;
    /**
    * 库存量
    */
    private Integer kuCunLiang;
    /**
    * 销量
    */
    private Integer xiaoLiang;
    /**
    * 销售价格
    */
    private String xiaoPrice;
    /**
    * 该产品的销售总额
    */
    private String xiaoTotalPrice;
    /**
    * 净利润
    */
    private String liRun;
    /**
    * 进购产品总数量
    */
    private Integer jingouNum;


    /**
     * 查询项
     */
    private String searchTerm;
    /**
     * 查询内容
     */
    private String searchContent;

    /**
     * 商品描述
     */
    private String productDesc;

    /**
     * 商品状态
     */
    private String productStatus;


    public String getProductSeq() {
        return productSeq;
    }

    public void setProductSeq(String productSeq) {
        this.productSeq = productSeq;
    }

    public String getProductStatus() {
        return productStatus;
    }

    public void setProductStatus(String productStatus) {
        this.productStatus = productStatus;
    }

    public String getProductDesc() {
        return productDesc;
    }

    public void setProductDesc(String productDesc) {
        this.productDesc = productDesc;
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

    public String getCatagory() {
        return catagory;
    }

    public void setCatagory(String catagory) {
        this.catagory = catagory;
    }

    public Integer getKuCunLiang() {
        return kuCunLiang;
    }

    public void setKuCunLiang(Integer kuCunLiang) {
        this.kuCunLiang = kuCunLiang;
    }

    public Integer getXiaoLiang() {
        return xiaoLiang;
    }

    public void setXiaoLiang(Integer xiaoLiang) {
        this.xiaoLiang = xiaoLiang;
    }

    public String getXiaoPrice() {
        return xiaoPrice;
    }

    public void setXiaoPrice(String xiaoPrice) {
        this.xiaoPrice = xiaoPrice;
    }

    public String getXiaoTotalPrice() {
        return xiaoTotalPrice;
    }

    public void setXiaoTotalPrice(String xiaoTotalPrice) {
        this.xiaoTotalPrice = xiaoTotalPrice;
    }

    public String getLiRun() {
        return liRun;
    }

    public void setLiRun(String liRun) {
        this.liRun = liRun;
    }

    public Integer getJingouNum() {
        return jingouNum;
    }

    public void setJingouNum(Integer jingouNum) {
        this.jingouNum = jingouNum;
    }

}