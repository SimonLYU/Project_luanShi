require "util"
require "public"

bangzhu = {}
STEP_bang_zhu = 0

function func_bang_zhu_search_qian_wang()
	util.pullMenuToBottom()
	--找固定位置按钮颜色
	x, y = findColorInRegionFuzzy(0x248ed3, 80, util.qianWangXpos1, 1204, util.qianWangXpos2, 1253, 0, 0)
	if x > -1 then
		util.hudToast("点击前往宝藏帮助")
		util.click(util.qianWangXposCenter,y)
		STEP_bang_zhu = 2
	else
	util.hudToast("当前无需宝藏帮助")
		STEP_bang_zhu = util.ERROR_CODE
	end
end

function func_lie_biao_search()
	util.click(292,275)
	util.mySleep(500)
	x, y = findColorInRegionFuzzy(0x2899d6, 80, 884, 862, 1118, 925, 0, 0)
	if x > -1 then
		util.hudToast("挖掘免费宝藏")
		util.click(x,y)
	else
		util.hudToast("无可挖掘宝藏")
	end
	STEP_bang_zhu = 3
end

function func_my_bao_zang_search()
	util.click(638,275)
	util.mySleep(500)
	x, y = findColorInRegionFuzzy(0xa98f4e, 80, 885, 860, 1118, 925, 0, 0)
	if x > -1 then
		util.hudToast("收获宝藏")
		util.click(x,y)
		util.mySleep(500)
	else
		util.hudToast("无可收获宝藏")
	end
	util.click(1005,891)
	STEP_bang_zhu = 4
end

function func_detect_help_alert()
	x, y = findColorInRegionFuzzy(0x314c70, 99, 10, 100, 230, 230, 0, 0)
	if x > -1 then
		return false
	else
		return true
	end
end

function func_help_lie_biao_search()
	util.click(929,275)
	util.mySleep(500)
	util.click(1000,894)
	util.mySleep(500)
	if func_detect_help_alert() then
		util.hudToast("没有可以免费帮助的盟友")
		util.clickBottomSpace()
		STEP_bang_zhu = 5
		return 0
	else
		util.hudToast("帮助盟友")
		func_help_lie_biao_search()
		return 0
	end
end

function bangzhu.func_bang_zhu()
util.mySleep(500)
	if STEP_bang_zhu == 0 then
		--打开总览
		public.func_open_zong_lan()
		util.hudToast("开始进行联盟宝藏帮助")
		STEP_bang_zhu = 1
		bangzhu.func_bang_zhu()
		return 0
	elseif STEP_bang_zhu == 1 then
		func_bang_zhu_search_qian_wang()
		bangzhu.func_bang_zhu()
		return 0
	elseif STEP_bang_zhu == 2 then
		func_lie_biao_search()
		bangzhu.func_bang_zhu()
		return 0
	elseif STEP_bang_zhu == 3 then
		func_my_bao_zang_search()
		bangzhu.func_bang_zhu()
		return 0
	elseif STEP_bang_zhu == 4 then
		func_help_lie_biao_search()
		bangzhu.func_bang_zhu()
		return 0
	elseif STEP_bang_zhu == 5 then
		util.closeMenuIfNecessary()
		STEP_bang_zhu = util.ERROR_CODE
		return 0
	elseif STEP_bang_zhu == util.ERROR_CODE then
	end
	public.func_close_zong_lan()
	STEP_bang_zhu = 0
end

return bangzhu