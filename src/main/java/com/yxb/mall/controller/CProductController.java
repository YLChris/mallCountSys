package com.yxb.mall.controller;

import com.fasterxml.jackson.databind.util.JSONPObject;
import com.fasterxml.jackson.databind.util.JSONWrappedObject;
import com.yxb.mall.architect.annotation.SystemControllerLog;
import com.yxb.mall.architect.constant.BussinessCode;
import com.yxb.mall.architect.utils.BussinessMsgUtil;
import com.yxb.mall.architect.utils.CommonHelper;
import com.yxb.mall.domain.bo.BussinessMsg;
import com.yxb.mall.domain.bo.ExcelExport;
import com.yxb.mall.domain.vo.*;
import com.yxb.mall.service.CProductService;
import net.sf.json.JSON;
import org.apache.ibatis.annotations.Param;
import org.json.JSONObject;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * (CProduct)表控制层
 *
 * @author makejava
 * @since 2020-03-13 00:29:40
 */
@Controller
@RequestMapping("cProduct")
public class CProductController extends BasicController{
    /**
     * 服务对象
     */
    @Resource
    private CProductService cProductService;


    /**
     * 加载商品列表List
     * @return
     */
    @RequestMapping("/ajax_goods_list.do")
    @ResponseBody
    public String ajaxGoodsList(CProduct cProduct,@RequestParam("page") int page,@RequestParam("limit") int limit){
        return cProductService.selectGoodsResultPageList(cProduct,page,limit);
    }

    /**
     * 商品列表添加
     * @return
     */
    @RequestMapping("/goods_add.do")
    public String goodsAdd(Model model){
        //新增页面标识
        model.addAttribute("pageFlag", "addPage");
        return "system/goods_edit";
    }

    /**
     * 跳转到商品修改页面
     * @param productId 商品id
     * @return
     */
    @RequestMapping("/goods_update.do")
    public String goodsUpdatePage(Model model,Integer productId){
        CProduct cProduct = cProductService.selectCProductById(productId);
        //修改页面标识
        model.addAttribute("pageFlag", "updatePage");
        model.addAttribute("cProduct", cProduct);
        return "system/goods_edit";
    }


    /**
     * 商品出售信息更改
     * @return
     */
    @RequestMapping("/goodsChuShou_edit.do")
    public String goodsChuShou_edit(Model model){
        //新增页面标识
        model.addAttribute("pageFlag", "addPage");
        return "system/goodsChuShou_edit";
    }


    /**
     * 保存商品信息
     * @return
     */
    @PostMapping("/ajax_save_goods.do")
    @ResponseBody
    @SystemControllerLog(description="保存商品信息")
    public BussinessMsg ajaxSaveGoods(CProduct cProduct){
        try {
            return cProductService.saveOrUpdateCProduct(cProduct, this.getCurrentLoginName());
        } catch (Exception e) {
            log.error("保存商品信息方法内部错误",e);
            return BussinessMsgUtil.returnCodeMessage(BussinessCode.PRODUCT_SAVE_ERROR);
        }
    }

    /**
     * 加载商品库存列表List
     * @return
     */
    @PostMapping("/goodsKuCun.do")
    @ResponseBody
    public String ajaxGoodsKuCunList(CProductCondition cProductCondition,@RequestParam("page") int page,@RequestParam("limit") int limit){
        return cProductService.selectGoodsKuCunResultPageList(cProductCondition,limit,page);
    }


    /**
     * 获取商品
     * @return
     */
    @GetMapping("/getGoods.do")
    @ResponseBody
    public String ajaxgetGoods(){
        return cProductService.getGoodsPageList();
    }



    /**
     * 保存商品出售信息
     * @return
     */
    @PostMapping("/ajax_saveChushou_goods.do")
    @ResponseBody
    @SystemControllerLog(description="保存商品信息")
    public BussinessMsg ajaxSaveChushouGoods(CProductCondition cProductCondition){
        try {
            return cProductService.saveOrUpdateCProductCondition(cProductCondition, this.getCurrentLoginName());
        } catch (Exception e) {
            log.error("保存商品信息方法内部错误",e);
            return BussinessMsgUtil.returnCodeMessage(BussinessCode.PRODUCT_SAVE_ERROR);
        }
    }


    /**
     * 出售商品
     * @return
     */
    @RequestMapping("/Chushou.do")
    @ResponseBody
    public BussinessMsg chushouGoods(@RequestParam(value = "productInfoArr") String productInfoArr){
        return cProductService.ChushouProductInfo(productInfoArr,this.getCurrentLoginName());
    }


    /**
     * 商品出售记录
     * @return
     */
    @PostMapping("/goodsRecordInfo.do")
    @ResponseBody
    public String goodsRecordInfo(CSelltimeProduct cSelltimeProduct,@RequestParam("page") int page,@RequestParam("limit") int limit){
        return cProductService.goodsRecordInfo(cSelltimeProduct,limit,page);
    }


    /**
     * 获取利润格式化数据
     * @return
     */
    @GetMapping("/liRundata.do")
    @ResponseBody
    public String getLiRunData(CProductCondition cProductCondition){
        return cProductService.zuzhuangLiRun();
    }


    /**
     * 导出商品出售信息列表信息
     * @return
     */
    @RequestMapping("/excel_sellProudctReport_export.do")
    public ModelAndView excelUsersExport(){
        ExcelExport excelExport = cProductService.excelExportProductRecordList();
        return CommonHelper.getExcelModelAndView(excelExport);
    }


    /**
     * 导出商品出售信息列表信息
     * @return
     */
    @RequestMapping("/excel_sellProudctKuCun_export.do")
    public ModelAndView excelProductKuCunExport(){
        ExcelExport excelExport = cProductService.excelExportProductKucunList();
        return CommonHelper.getExcelModelAndView(excelExport);
    }

    /**
     * 获取利润线性图
     * @return
     */
    @GetMapping("/liRundataLine.do")
    @ResponseBody
    public String getliRundataLine(){
        return cProductService.zuzhuangLiRunLine();
    }

}