package com.yxb.mall.service;

import com.yxb.mall.architect.constant.BussinessCode;
import com.yxb.mall.architect.utils.BussinessMsgUtil;
import com.yxb.mall.dao.CProductConditionMapper;
import com.yxb.mall.dao.CProductMapper;
import com.yxb.mall.domain.bo.BussinessMsg;
import com.yxb.mall.domain.bo.ExcelExport;
import com.yxb.mall.domain.vo.CProduct;
import com.yxb.mall.domain.vo.CProductCondition;
import com.yxb.mall.domain.vo.CSelltimeProduct;
import com.yxb.mall.domain.vo.User;
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

    private Logger log = LogManager.getLogger(CProductService.class);
    
    @Autowired
    private CProductMapper cProductMapper;

    @Autowired
    private CProductConditionMapper cProductConditionMapper;
    /**
     * 商品信息分页显示
     *
     * @return
     */
    public String selectGoodsResultPageList(CProduct cProduct,int page,int limit) {
        int start = limit*(page-1);//起始数据索引
        int end = limit*page;//末尾数据索引
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
        List<CProduct> cProductList = cProductMapper.selectGoodsListByPage(cProduct,start,end);
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
            List<CProductCondition> cProductConditionList = cProductConditionMapper.querySame(cProductCondition);
            if(!CollectionUtils.isEmpty(cProductConditionList)){
                cProductCondition.setKuCunLiang(cProductConditionList.get(0).getKuCunLiang()+cProduct.getProductNum());
                cProductConditionMapper.updateCproductCondition(cProductCondition);
            }else{
                cProductCondition.setProductDesc(cProduct.getProductDesc());
                cProductCondition.setKuCunLiang(cProduct.getProductNum());
                String productSeq = String.valueOf((int)((Math.random()*9+1)*100000));
                cProductCondition.setProductSeq(productSeq);//随机6位数
                cProductCondition.setLiRun(String.valueOf(-(Integer.parseInt(cProductCondition.getProductPrice())*cProductCondition.getKuCunLiang())));
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
    public String selectGoodsKuCunResultPageList(CProductCondition cProductCondition,int limit,int page) {
        int start = limit*(page-1);//起始数据索引
        int end = limit*page;//末尾数据索引
        List<CProductCondition> cProductConditionsList = cProductConditionMapper.queryCproductConditionByCProduct(cProductCondition,start,end);
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
            String productSeq = cProductCondition.getProductSeq();
            switch (catagoryFlag){
                case "1"://水果
                    jsonObject.put("name",productName);jsonObject.put("value",productName+"-"+xiaoPrice+"-"+productSeq);
                    fruitArray.add(jsonObject);
                    break;
                case "2"://衣服
                    jsonObject.put("name",productName);jsonObject.put("value",productName+"-"+xiaoPrice+"-"+productSeq);
                    clothArray.add(jsonObject);
                    break;
                case "3"://食品
                    jsonObject.put("name",productName);jsonObject.put("value",productName+"-"+xiaoPrice+"-"+productSeq);
                    foodArray.add(jsonObject);
                    break;
                case "4"://蔬菜
                    jsonObject.put("name",productName);jsonObject.put("value",productName+"-"+xiaoPrice+"-"+productSeq);
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

    /**
     * 保存商品出售信息
     * @param cProductCondition
     * @param currentLoginName
     * @return
     */
    @Transactional
    public BussinessMsg saveOrUpdateCProductCondition(CProductCondition cProductCondition, String currentLoginName) {
        String catagory = cProductCondition.getCatagory();
        switch (catagory) {
            case "水果":
                cProductCondition.setCatagory("1");
                break;
            case "衣服":
                cProductCondition.setCatagory("2");
                break;
            case "食品":
                cProductCondition.setCatagory("3");
                break;
            case "蔬菜":
                cProductCondition.setCatagory("4");
                break;
        }
        //查询是否有商品库存表以及利润信息等，进行插入或者更新
        List<CProductCondition> cProductConditionList = cProductConditionMapper.queryCproductConditionByCProductCondition(cProductCondition);
        if(!CollectionUtils.isEmpty(cProductConditionList)){
            String productPrice = cProductConditionList.get(0).getProductPrice();//获取进购价格与出售价格对比
            String xiaoPrice = cProductCondition.getXiaoPrice();//出售价格
            if((Integer.parseInt(productPrice)-Integer.parseInt(xiaoPrice))>0){//若进购价格比出售价格高  则报错
                return BussinessMsgUtil.returnCodeMessage(BussinessCode.PRODUCTPRICE_ERROR);
            }
            cProductConditionMapper.updateCproductConditionByProductId(cProductCondition);
        }
        return BussinessMsgUtil.returnCodeMessage(BussinessCode.GLOBAL_SUCCESS);

    }

    //商品出售
    @Transactional
    public BussinessMsg ChushouProductInfo(String productInfoArr,String loginName) {
        try {
            productInfoArr = productInfoArr.substring(0,productInfoArr.length()-1);
            String[] productInfoItemArr = productInfoArr.split("&");
            Calendar now = Calendar.getInstance();
            for(String item:productInfoItemArr){
                CSelltimeProduct cSelltimeProduct = new CSelltimeProduct();
                String[] productChushouInfo = item.split(",");
                cSelltimeProduct.setProductSeq(productChushouInfo[0]);//序号
                String productName = cProductConditionMapper.queryProductNameBySeq(productChushouInfo[0]);//通过序号查询商品名
                cSelltimeProduct.setXiaoshouLiang(productChushouInfo[1]);//出售数量
                if(!StringUtils.isEmpty(productName)){
                    cSelltimeProduct.setProductName(productName);//商品名
                }
                cSelltimeProduct.setXiaoshouPrice(String.valueOf(Integer.parseInt(productChushouInfo[2])/Integer.parseInt(productChushouInfo[1])));//出售价格
                cSelltimeProduct.setXiaoshouYear(now.get(Calendar.YEAR)+"");//出售年份
                cSelltimeProduct.setXiaoshouMonth((now.get(Calendar.MONTH) + 1) + "");//出售月份
                cSelltimeProduct.setXiaoshouDay(now.get(Calendar.DAY_OF_MONTH)+"");//出售日
                cSelltimeProduct.setXiaoshouTotalPrice(productChushouInfo[2]);//总计
                cSelltimeProduct.setOperator(loginName);//出售人
                //根据商品id查询商品
                CProductCondition cProductCondition =new CProductCondition();
                cProductCondition.setProductSeq(cSelltimeProduct.getProductSeq());
                List<CProductCondition> cProductConditionList = cProductConditionMapper.querySameBySeq(cProductCondition);
                if(!CollectionUtils.isEmpty(cProductConditionList)){//若库存销量表有值
                    //库存不足
                    Integer kucun = cProductConditionList.get(0).getKuCunLiang();
                    Integer xiaoshouliang = Integer.parseInt(cSelltimeProduct.getXiaoshouLiang());

                    if(kucun-xiaoshouliang<0){
                        String productName1 = cProductConditionList.get(0).getProductName();
                        BussinessCode.PRODUCTKUCUNBUZU_ERROR.setMsg(productName1+"产品库存不足，请及时进货");
                        return BussinessMsgUtil.returnCodeMessage(BussinessCode.PRODUCTKUCUNBUZU_ERROR);
                    }
                    //销量
                    cProductCondition.setXiaoLiang((cProductConditionList.get(0).getXiaoLiang()+Integer.parseInt(cSelltimeProduct.getXiaoshouLiang())));
                    //总出售价格
                    Integer productTotalPrice = Integer.parseInt(cProductConditionList.get(0).getXiaoPrice())*cProductCondition.getXiaoLiang();
                    cProductCondition.setXiaoTotalPrice(String.valueOf(productTotalPrice));
                    //库存量
                    cProductCondition.setKuCunLiang(kucun-xiaoshouliang);
                    //进购价格*进购数量-出售数量*出售价格
                    Integer jingouPrice=Integer.parseInt(cProductConditionList.get(0).getProductPrice())*cProductConditionList.get(0).getJingouNum();
                    cProductCondition.setLiRun(String.valueOf(Integer.parseInt(cProductCondition.getXiaoTotalPrice())-jingouPrice));
                    cProductConditionMapper.insertSellTimeCproduct(cSelltimeProduct);//插入分时表
                    cProductConditionMapper.updateCproductCondition(cProductCondition);
                }
            }
            return BussinessMsgUtil.returnCodeMessage(BussinessCode.GLOBAL_SUCCESS);
        } catch (Exception e) {
            log.error("出售商品方法内部错误", e);
            throw e;
        } finally {
            log.info("出售商品信息结束");
        }
    }

    //商品记录查询
    public String goodsRecordInfo(CSelltimeProduct cSelltimeProduct,int limit,int page) {
        int start = limit*(page-1);//起始数据索引
        int end = limit*page;//末尾数据索引
        List<CSelltimeProduct> cSelltimeProducts1 = cProductMapper.goodsRecordInfo(cSelltimeProduct,start,end);
        Map<String,String> cSelltimeProductsCount = cProductMapper.goodsRecordInfoCount(cSelltimeProduct);
        if(CollectionUtils.isEmpty(cSelltimeProducts1)){
            return null;
        }

        Map<String, Object> map = new HashMap<String, Object>();
        map.put("code",0);
        map.put("msg","");
        map.put("count",cSelltimeProductsCount.get("counts"));
        map.put("data", cSelltimeProducts1);

        return Json.toJson(map);
    }

    /*组装利润信息*/
    public String zuzhuangLiRun() {
        List<CProductCondition> cProductConditionsList = cProductConditionMapper.queryProductLuRun();
        List<String> productNameList = new ArrayList<>();
        List<String> liRunList = new ArrayList<>();
        List<Map<String, Object>> allKeyValue = new ArrayList<>();
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("code",0);
        map.put("msg","");
        if(CollectionUtils.isEmpty(cProductConditionsList)){
            map.put("liRunData", null);
            map.put("productNameData", null);
        }else{
            for (int i=0;i<cProductConditionsList.size();i++){
                Map<String, Object> mapBing = new HashMap<String, Object>();//饼状图
                productNameList.add(cProductConditionsList.get(i).getProductName());
                liRunList.add(cProductConditionsList.get(i).getLiRun());
                mapBing.put("value",cProductConditionsList.get(i).getLiRun());
                mapBing.put("name",cProductConditionsList.get(i).getProductName());
                allKeyValue.add(mapBing);
            }
            map.put("liRunData", liRunList.toArray());
            map.put("productNameData", productNameList.toArray());
            map.put("nameValue", allKeyValue.toArray());
        }

        return Json.toJson(map);
    }


    /**
     * 出售商品信息列表EXCEL导出
     * @return
     */
    public ExcelExport excelExportProductRecordList(){
        ExcelExport excelExport = new ExcelExport();
        CSelltimeProduct cSelltimeProduct = new CSelltimeProduct();
        List<CSelltimeProduct> cSelltimeProducts1 = cProductMapper.goodsRecordInfo1(cSelltimeProduct);
        excelExport.addColumnInfo("商品名称","productName");
        excelExport.addColumnInfo("单品批次销量","xiaoshouLiang");
        excelExport.addColumnInfo("商品售价","xiaoshouPrice");
        excelExport.addColumnInfo("单批次总收益","xiaoshouTotalPrice");
        excelExport.addColumnInfo("年份","xiaoshouYear");
        excelExport.addColumnInfo("月份","xiaoshouMonth");
        excelExport.addColumnInfo("日期","xiaoshouDay");
        excelExport.addColumnInfo("收费员","operator");

        excelExport.setDataList(cSelltimeProducts1);
        return excelExport;
    }

    /**
     * 出售商品库存列表EXCEL导出
     * @return
     */
    public ExcelExport excelExportProductKucunList() {
        ExcelExport excelExport = new ExcelExport();
        List<CProductCondition> cProductConditionListnditionList = cProductConditionMapper.queryCproductConditionByCProduct1();
        excelExport.addColumnInfo("商品名称","productName");
        excelExport.addColumnInfo("商品分类","catagory");
        excelExport.addColumnInfo("商品进购价格","productPrice");
        excelExport.addColumnInfo("该类商品进购数量","jingouNum");
        excelExport.addColumnInfo("商品库存量","kuCunLiang");
        excelExport.addColumnInfo("商品销量","xiaoLiang");
        excelExport.addColumnInfo("商品出售价格","xiaoPrice");
        excelExport.addColumnInfo("商品销售总额","xiaoTotalPrice");
        excelExport.addColumnInfo("该类商品净利润","liRun");

        excelExport.setDataList(cProductConditionListnditionList);
        return excelExport;
    }

    //组装利润线性图
    public String zuzhuangLiRunLine() {
        List<CProductCondition> cProductConditionsList = cProductConditionMapper.queryProductLuRun();
        if(CollectionUtils.isEmpty(cProductConditionsList)){
            return null;
        }
        for(int i=0;i<cProductConditionsList.size();i++){
            CProductCondition cProductCondition = cProductConditionsList.get(i);
            String productName =  cProductCondition.getProductName();
            String lirun = cProductCondition.getLiRun();
        }
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("code",0);
        map.put("msg","");

        return Json.toJson(map);
    }
}