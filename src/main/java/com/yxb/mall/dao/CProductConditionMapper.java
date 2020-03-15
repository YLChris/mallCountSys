package com.yxb.mall.dao;

import com.yxb.mall.domain.vo.CProductCondition;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;

import java.util.List;

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
    List<CProductCondition> queryCproductConditionByCProduct(CProductCondition cProductCondition);

    //插入库存信息以及产品利润信息
    void insertCproductCondition(CProductCondition cProductCondition);

    //更新库存信息以及产品利润信息
    void updateCproductCondition(CProductCondition cProductCondition);

    //查询某商品库存 利润等信息数量
    Long selectCountCProductCondition(CProductCondition cProductCondition);
}