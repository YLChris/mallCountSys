package com.yxb.mall.dao;

import com.yxb.mall.domain.vo.CProductCondition;
import com.yxb.mall.domain.vo.CSelltimeProduct;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Set;

/**
 * (CProductCondition)表数据库访问层
 *
 * @author makejava
 * @since 2020-03-15 14:31:48
 */
@Mapper
@Service
public interface CProductConditionMapper {

    //查询某商品库存 利润 销量等信息
    List<CProductCondition> queryCproductConditionByCProduct(@Param("cSelltimeProduct") CProductCondition cProductCondition,@Param("start") int start,@Param("end") int end);

    //插入库存信息以及产品利润信息
    void insertCproductCondition(CProductCondition cProductCondition);

    //更新库存信息以及产品利润信息
    void updateCproductCondition(CProductCondition cProductCondition);

    //查询某商品库存 利润等信息数量
    Long selectCountCProductCondition(CProductCondition cProductCondition);

    //获取产品种类
    Set<CProductCondition> getGoodsPageList();

    List<CProductCondition> queryCproductConditionByCProductCondition(CProductCondition cProductCondition);

    //根据产品id更新产品
    void updateCproductConditionByProductId(CProductCondition cProductCondition);

    //根据序号查询商品名
    String queryProductNameBySeq(String productSeq);

    //插入出售商品入分时表
    void insertSellTimeCproduct(CSelltimeProduct cSelltimeProduct);

    //查询是否有重复商品
    List<CProductCondition> querySame(CProductCondition cProductCondition);

    //查询是否有重复商品通过seq
    List<CProductCondition> querySameBySeq(CProductCondition cProductCondition);

    //组装利润信息
    List<CProductCondition> queryProductLuRun();

    List<CProductCondition> queryCproductConditionByCProduct1();
}