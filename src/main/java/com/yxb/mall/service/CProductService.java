package com.yxb.mall.service;

import com.yxb.mall.architect.constant.BussinessCode;
import com.yxb.mall.architect.utils.BussinessMsgUtil;
import com.yxb.mall.dao.CProductConditionMapper;
import com.yxb.mall.dao.CProductMapper;
import com.yxb.mall.domain.bo.BussinessMsg;
import com.yxb.mall.domain.vo.CProduct;
import com.yxb.mall.domain.vo.CProductCondition;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.nutz.json.Json;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;

import java.util.*;

/**
 * (CProduct)表服务接口
 *
 * @author makejava
 * @since 2020-03-13 00:29:40
 */
@Service
public class CProductService {

    private Logger log = LogManager.getLogger(RoleService.class);
    
    @Autowired
    private CProductMapper cProductMapper;

    @Autowired
    private CProductConditionMapper cProductConditionMapper;
    /**
     * 商品信息分页显示
     *
     * @return
     */
    public String selectGoodsResultPageList(CProduct cProduct) {

        if("catagory".equals(cProduct.getSearchTerm())) {
            String searchContent = cProduct.getSearchContent();
            switch (searchContent) {
                case "水果":
                    cProduct.setSearchContent("1");
                    break;
                case "衣服":
                    cProduct.setSearchContent("2");
                    break;
                case "食品":
                    cProduct.setSearchContent("3");
                    break;
                case "蔬菜":
                    cProduct.setSearchContent("4");
                    break;
            }
        }
        List<CProduct> cProductList = cProductMapper.selectGoodsListByPage(cProduct);
        Long count = cProductMapper.selectCountCProduct(cProduct);
        Map<String, Object> map = new HashMap<String, Object>();

        map.put("code",0);
        map.put("msg","");
        map.put("count",count);
        map.put("data", cProductList);

        return Json.toJson(map);
    }

    /**
     * 根据产品id查询产品
     * @param productId
     * @return
     */
    public CProduct selectCProductById(Integer productId) {
        return cProductMapper.queryById(productId);
    }

    /**
     * 保存商品信息
     *
     * @param loginName 当前登录用户
     * @return
     * @throws Exception
     */
    @Transactional
    public BussinessMsg saveOrUpdateCProduct(CProduct cProduct, String loginName) throws Exception {
        log.info("保存商品开始");
        long start = System.currentTimeMillis();
        try {
            int jingouTotalNum= 0;//进购总数
            List<CProduct> cProductsList = cProductMapper.queryAll(cProduct);//查询该产品在数据库是否存在并获取该产品的进购数量
            CProductCondition cProductCondition = new CProductCondition();//每添加上商品，就对该商品进行统计
            if(!CollectionUtils.isEmpty(cProductsList)){
                for(CProduct item: cProductsList){//遍历取出对应的进购数量
                    jingouTotalNum=jingouTotalNum+item.getProductNum();
                }
                cProductCondition.setJingouNum(jingouTotalNum+cProduct.getProductNum());
            }else{
                cProductCondition.setJingouNum(cProduct.getProductNum());
            }
            cProductCondition.setProductName(cProduct.getProductName());
            cProductCondition.setCatagory(cProduct.getCatagory());
            cProductCondition.setProductPrice(cProduct.getProductPrice());

            //保存商品信息
            cProduct.setProductNum(cProduct.getProductNum());
            cProduct.setJingouOperator(loginName);
            cProduct.setJingouTime(new Date());
            cProductMapper.insertSelective(cProduct);

            //查询是否有商品库存表以及利润信息等，进行插入或者更新
            List<CProductCondition> cProductConditionList = cProductConditionMapper.queryCproductConditionByCProduct(cProductCondition);
            if(!CollectionUtils.isEmpty(cProductConditionList)){
                cProductCondition.setKuCunLiang(cProductConditionList.get(0).getKuCunLiang()+cProduct.getProductNum());
                cProductConditionMapper.updateCproductCondition(cProductCondition);
            }else{
                cProductCondition.setKuCunLiang(cProduct.getProductNum());
                cProductConditionMapper.insertCproductCondition(cProductCondition);
            }
        } catch (Exception e) {
            log.error("保存商品方法内部错误", e);
            throw e;
        } finally {
            log.info("保存商品信息结束,用时" + (System.currentTimeMillis() - start) + "毫秒");
        }
        return BussinessMsgUtil.returnCodeMessage(BussinessCode.GLOBAL_SUCCESS);
    }

    /*加载库存信息*/
    public String selectGoodsKuCunResultPageList(CProductCondition cProductCondition) {
        List<CProductCondition> cProductConditionsList = cProductConditionMapper.queryCproductConditionByCProduct(cProductCondition);
        Long count = cProductConditionMapper.selectCountCProductCondition(cProductCondition);
        Map<String, Object> map = new HashMap<String, Object>();

        map.put("code",0);
        map.put("msg","");
        map.put("count",count);
        map.put("data", cProductConditionsList);

        return Json.toJson(map);
    }
}