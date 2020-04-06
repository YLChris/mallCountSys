package com.yxb.mall.controller.system;

import com.yxb.mall.controller.BasicController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @Date2020/3/12 19:59
 * @Version V1.0
 **/
@Controller
@RequestMapping("goods")
public class GoodsController extends BasicController {

    /**
     *跳转到商品进购列表页面
     * @return
     */
    @RequestMapping("/goodsJinGou.do")
    public String goodsJinGou() {
        return "system/goodsJinGou";
    }

    /**
     *跳转到商品出售列表页面
     * @return
     */
    @RequestMapping("/goodsChushou.do")
    public String goodsChushou() {
        return "system/goodsChushou";
    }


    /**
     *跳转到商品库存列表页面
     * @return
     */
    @RequestMapping("/goodsKuCun.do")
    public String goodsKuCun() {
        return "system/goodsKuCun";
    }


    /**
     *跳转到商品出售信息更改列表页面
     * @return
     */
    @RequestMapping("/goodsInfo.do")
    public String goodsInfo() {
        return "system/goodsInfo";
    }


    /**
     *跳转到商品销量信息更改列表页面
     * @return
     */
    @RequestMapping("/goodsXiaoLiang.do")
    public String goodsXiaoLiang() {
        return "system/goodsXiaoLiang";
    }

    /**
     *跳转到商品利润信息图形化页面
     * @return
     */
    @RequestMapping("/liRunXinxi.do")
    public String liRunXinxi() {
        return "system/liRunXinxi";
    }

    /**
     *跳转到商场收入支出页面
     * @return
     */
    @RequestMapping("/shouruZhichu.do")
    public String shouruZhichu() {
        return "system/shouruZhichu";
    }

    /**
     * 商品出售记录
     * @return
     */
    @RequestMapping("/chushouRecord.do")
    public String chushouRecord(){
        return "system/goodsInfoRecord";
    }
}
