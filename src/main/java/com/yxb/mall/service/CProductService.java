package com.yxb.mall.service;

import com.yxb.mall.architect.constant.BussinessCode;
import com.yxb.mall.architect.utils.BussinessMsgUtil;
import com.yxb.mall.dao.CProductConditionMapper;
import com.yxb.mall.dao.CProductMapper;
import com.yxb.mall.domain.bo.BussinessMsg;
import com.yxb.mall.domain.vo.CProduct;
import com.yxb.mall.domain.vo.CProductCondition;
import net.sf.json.JSON;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.nutz.json.Json;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;
import org.springframework.util.StringUtils;

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

    /*获取产品种类以便前端进行销售*/
    public String getGoodsPageList() {
        //获取产品种类
        Set<CProductCondition> cProductConditionsList = cProductConditionMapper.getGoodsPageList();
        JSONArray allGoodsArray = new JSONArray();
        allGoodsArray = getLastProduct(allGoodsArray,cProductConditionsList);

        Map<String, Object> map = new HashMap<String, Object>();
        map.put("code",0);
        map.put("msg","");
        map.put("data", allGoodsArray);

        return Json.toJson(map);
    }

    //组装产品select
    public JSONArray getLastProduct(JSONArray allGoodsArray,Set<CProductCondition> cProductConditionsList){
        JSONArray fruitArray = new JSONArray();//水果
        JSONArray clothArray = new JSONArray();//衣服
        JSONArray foodArray = new JSONArray();//食品
        JSONArray shucaiArray = new JSONArray();//蔬菜
        Map<String,Object> fruitType = new HashMap<>();
        Map<String,Object> clothType = new HashMap<>();
        Map<String,Object> foodType = new HashMap<>();
        Map<String,Object> shucaiType = new HashMap<>();
        fruitType.put("name","水果");fruitType.put("type","optgroup");
        clothType.put("name","衣服");clothType.put("type","optgroup");
        foodType.put("name","食品");foodType.put("type","optgroup");
        shucaiType.put("name","蔬菜");shucaiType.put("type","optgroup");
        fruitArray.add(fruitType);
        clothArray.add(clothType);
        foodArray.add(foodType);
        shucaiArray.add(shucaiType);
        for(CProductCondition cProductCondition: cProductConditionsList){ //循环产品获取商品名和分类、价格
            Map<String,Object> jsonObject = new HashMap<>();
            String productName = cProductCondition.getProductName();
            String catagoryFlag = cProductCondition.getCatagory();
            String xiaoPrice = cProductCondition.getXiaoPrice();
            switch (catagoryFlag){
                case "1"://水果
                    jsonObject.put("name",productName);jsonObject.put("value",productName+"-"+xiaoPrice);
                    fruitArray.add(jsonObject);
                    break;
                case "2"://衣服
                    jsonObject.put("name",productName);jsonObject.put("value",productName+"-"+xiaoPrice);
                    clothArray.add(jsonObject);
                    break;
                case "3"://食品
                    jsonObject.put("name",productName);jsonObject.put("value",productName+"-"+xiaoPrice);
                    foodArray.add(jsonObject);
                    break;
                case "4"://蔬菜
                    jsonObject.put("name",productName);jsonObject.put("value",productName+"-"+xiaoPrice);
                    shucaiArray.add(jsonObject);
                    break;
            }
        }

        Iterator fruitIterator = fruitArray.iterator();
        if(fruitIterator.hasNext()&&fruitArray.size()>1){
            while (fruitIterator.hasNext()){
                allGoodsArray.add(fruitIterator.next());
            }
        }else{
            allGoodsArray.remove(fruitIterator.next());
        }



        Iterator clothIterator = clothArray.iterator();
        if(clothIterator.hasNext()&&clothArray.size()>1){
            while (clothIterator.hasNext()){
                allGoodsArray.add(clothIterator.next());
            }
        }else{
            allGoodsArray.remove(clothIterator.next());
        }


        Iterator foodIterator = foodArray.iterator();
        if(foodIterator.hasNext()&&foodArray.size()>1){
            while (foodIterator.hasNext()){
                allGoodsArray.add(foodIterator.next());
            }
        }else{
            allGoodsArray.remove(foodIterator.next());
        }


        Iterator shucaiIterator = shucaiArray.iterator();
        if(shucaiIterator.hasNext()&&shucaiArray.size()>1){
            while (shucaiIterator.hasNext()){
                allGoodsArray.add(shucaiIterator.next());
            }
        }else{
            allGoodsArray.remove(shucaiIterator.next());
        }

        return allGoodsArray;
    }
}