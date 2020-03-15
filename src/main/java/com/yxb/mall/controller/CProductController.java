package com.yxb.mall.controller;

import com.yxb.mall.architect.annotation.SystemControllerLog;
import com.yxb.mall.architect.constant.BussinessCode;
import com.yxb.mall.architect.utils.BussinessMsgUtil;
import com.yxb.mall.domain.bo.BussinessMsg;
import com.yxb.mall.domain.vo.CProduct;
import com.yxb.mall.domain.vo.CProductCondition;
import com.yxb.mall.domain.vo.Role;
import com.yxb.mall.service.CProductService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;

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
    public String ajaxGoodsList(CProduct cProduct){
        return cProductService.selectGoodsResultPageList(cProduct);
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
     * 保存商品信息
     * @return
     */
    @PostMapping("/ajax_save_goods.do")
    @ResponseBody
    @SystemControllerLog(description="保存商品信息")
    public BussinessMsg ajaxSaveRole(CProduct cProduct){
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
    @RequestMapping("/goodsKuCun.do")
    @ResponseBody
    public String ajaxGoodsKuCunList(CProductCondition cProductCondition){
        return cProductService.selectGoodsKuCunResultPageList(cProductCondition);
    }
}