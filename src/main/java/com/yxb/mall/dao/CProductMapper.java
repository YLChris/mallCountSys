package com.yxb.mall.dao;

import com.yxb.mall.domain.vo.CProduct;
import com.yxb.mall.domain.vo.CProductCondition;
import com.yxb.mall.domain.vo.CSelltimeProduct;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * (CProduct)表数据库访问层
 */
@Service
@Mapper
public interface CProductMapper {

    /**
     * 通过ID查询单条数据
     *
     * @param productId 主键
     * @return 实例对象
     */
    CProduct queryById(Integer productId);

    /**
     * 查询指定行数据
     *
     * @param offset 查询起始位置
     * @param limit 查询条数
     * @return 对象列表
     */
    List<CProduct> queryAllByLimit(@Param("offset") int offset, @Param("limit") int limit);


    /**
     * 通过实体作为筛选条件查询
     *
     * @param cProduct 实例对象
     * @return 对象列表
     */
    List<CProduct> queryAll(CProduct cProduct);

    /**
     * 新增数据
     *
     * @param cProduct 实例对象
     * @return 影响行数
     */
    int insert(CProduct cProduct);

    /**
     * 修改数据
     *
     * @param cProduct 实例对象
     * @return 影响行数
     */
    int update(CProduct cProduct);

    /**
     * 通过主键删除数据
     *
     * @param productId 主键
     * @return 影响行数
     */
    int deleteById(Integer productId);

    /**
     * 进购商品信息分页列表显示
     * @return
     */
    List<CProduct> selectGoodsListByPage(@Param("cProduct") CProduct cProduct,@Param("start") int start,@Param("end") int end);

    /**
     * 查询商品总记录数
     * @return
     */
    Long selectCountCProduct(CProduct cProduct);

    /*检查商品唯一性*/
    Long selectProductNameCheck(String productName, Integer productId, String catagory,String productPrice);


    /*新增商品*/
    void insertSelective(CProduct cProduct);

    /*修改商品信息*/
    void updateByPrimaryKeySelective(CProduct cProduct);

    /*获取库存、利润等信息*/
    CProduct getKuCunLiang(@Param("productName") String productName,@Param("catagory") String catagory,@Param("productPrice") String productPrice);

    /*获取商品出售记录*/
    List<CSelltimeProduct> goodsRecordInfo(@Param("cSelltimeProduct") CSelltimeProduct cSelltimeProduct,@Param("start") int start,@Param("end") int end);

    /*获取商品出售记录数量*/
    Map<String,String> goodsRecordInfoCount(@Param("cSelltimeProduct") CSelltimeProduct cSelltimeProduct);

    List<CSelltimeProduct> goodsRecordInfo1(@Param("cSelltimeProduct")CSelltimeProduct cSelltimeProduct);
}