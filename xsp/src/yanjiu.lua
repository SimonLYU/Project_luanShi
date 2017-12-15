require "util"
require "public"

yanjiu = {}

STEP_yan_jiu = 0

function func_yan_jiu_search_qian_wang()
	x, y = findColorInRegionFuzzy(0x298acf, 80, 750, 1430, 870, 1490, 0, 0)
	if x > -1 then
		util.click(816,1459)
		util.hudToast("点击前往")
		util.mySleep(1500)
		STEP_yan_jiu = 2
	else
		util.hudToast("当前不可研究科技")
		STEP_yan_jiu = util.ERROR_CODE
	end
end

function func_click_tai_shi_yuan()
	util.click(625,1080)
	util.hudToast("点击太史院")
	util.mySleep(500)
	STEP_yan_jiu = 3
end

function func_click_yan_jiu()
	util.click(700,1277)
	util.hudToast("点击研究")
	util.mySleep(500)
	STEP_yan_jiu = 4
end

function func_choose_yan_jiu()
	local qing_xiang = _G["CONFIG_ke_ji_qing_xiang"]
	if qing_xiang == 0 then
		util.click(385,2117)
		util.hudToast("研究发展倾向")
	else
		util.click(993,2117)
		util.hudToast("研究战斗倾向")
	end
	STEP_yan_jiu = 5	
	util.mySleep(500)
end

function func_yan_jiu_click_confirm()
	util.click(915,1795)
	STEP_yan_jiu = 6
	util.mySleep(500)
end

function func_yan_jiu_detect_alert()
--	x, y = findColorInRegionFuzzy(0xa1420a, 99, 400, 1275, 840, 1400, 0, 0)
--	x1, y1 = findColorInRegionFuzzy(0x3d76a4, 99, 1070, 713, 1188, 807, 0, 0)
	x, y = findColorInRegionFuzzy(0xa1420a, 99, 400, 1275, 840, 1470, 0, 0)
	x1, y1 = findColorInRegionFuzzy(0x3d76a4, 99, 1070, 654, 1188, 807, 0, 0)
	if x > -1 and x1 > -1 then
		--检测到弹窗
		util.hudToast("资源不足,跳过研究")
		width,height = getScreenSize()
		util.click((width * 0.5),100)
		util.mySleep(500)
		util.click((width * 0.5),100)
		util.mySleep(500)
	else
		util.hudToast("研究结束,关闭界面")
	end
	util.closeMenuIfNecessary()
	STEP_yan_jiu = util.ERROR_CODE
end

function yanjiu.func_yan_jiu()
util.mySleep(500)
	if STEP_yan_jiu == 0 then 
		public.func_open_zong_lan()
		util.hudToast("开始技能研究")
		STEP_yan_jiu = 1
		yanjiu.func_yan_jiu()
		return 0
	elseif STEP_yan_jiu == 1 then
		func_yan_jiu_search_qian_wang()
		yanjiu.func_yan_jiu()
		return 0
	elseif STEP_yan_jiu == 2 then
		func_click_tai_shi_yuan()
		yanjiu.func_yan_jiu()
		return 0
	elseif STEP_yan_jiu ==3 then
		func_click_yan_jiu()
		yanjiu.func_yan_jiu()
		return 0
	elseif STEP_yan_jiu == 4 then
		func_choose_yan_jiu()
		yanjiu.func_yan_jiu()
		return 0
	elseif STEP_yan_jiu == 5 then
		func_yan_jiu_click_confirm()
		yanjiu.func_yan_jiu()
		return 0
	elseif STEP_yan_jiu == 6 then
		func_yan_jiu_detect_alert()
		yanjiu.func_yan_jiu()
		return 0
	elseif STEP_yan_jiu == util.ERROR_CODE then
	end
	STEP_yan_jiu = 0
	public.func_close_zong_lan()
end

return yanjiu