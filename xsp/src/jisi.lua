require "util"
require "public"

jisi = {}
STEP_ji_si = 0
--资源位置：木，粮，铁，宝石
ji_si_resource_xPos = {626,213,335,906}
ji_si_resource_yPos = {1045,1305,1746,1750}

function func_ji_si_qian_wang()
	util.pullMenuToBottom()
	x, y = findColorInRegionFuzzy(0x298acf, 80, util.qianWangXpos1, 1401, util.qianWangXpos2, 1454, 0, 0)
	if x > -1 then
	util.hudToast("点击前往祭祀")
		util.click(util.qianWangXposCenter,y)
		util.mySleep(1500)--移动视角需要一段时间
		STEP_ji_si = 2
	else
	util.hudToast("当前不可免费祭祀")
		STEP_ji_si = util.ERROR_CODE
	end
end

function func_click_ji_tan()
	util.click(622,1060)
	util.hudToast("点击祭坛")
	STEP_ji_si = 3
end

function func_click_ji_si()
	util.click(767,1243)
	util.hudToast("点击祭祀")
	STEP_ji_si = 4
end

function func_ji_si_detect_alert()
	x, y = findColorInRegionFuzzy(0x314c70, 99, 10, 100, 230, 230, 0, 0)
	if x > -1 then
		return false
	else--有弹窗
		return true
	end
end

function func_choose_resource()
	local currentResource = _G["CONFIG_ji_si_qing_xiang"]
	util.click(ji_si_resource_xPos[currentResource],ji_si_resource_yPos[currentResource])
	util.mySleep(500)
	if func_ji_si_detect_alert() then
		STEP_ji_si = util.ERROR_CODE
		util.click(334,1290)
	else
		func_choose_resource()
	end
end

function jisi.func_ji_si()
util.mySleep(500)
	if STEP_ji_si == 0 then
		public.func_open_zong_lan()
		STEP_ji_si = 1
		util.hudToast("开始祭祀")
		jisi.func_ji_si()
		return 0
	elseif STEP_ji_si == 1 then
		func_ji_si_qian_wang()
		jisi.func_ji_si()
		return 0
	elseif STEP_ji_si == 2 then
		func_click_ji_tan()
		jisi.func_ji_si()
		return 0
	elseif STEP_ji_si == 3 then
		func_click_ji_si()
		jisi.func_ji_si()
		return 0
	elseif STEP_ji_si == 4 then
		func_choose_resource()
		jisi.func_ji_si()
		return 0
	elseif STEP_ji_si == util.ERROR_CODE then
	end
	util.closeMenuIfNecessary()
	public.func_close_zong_lan()
	STEP_ji_si = 0
end

return jisi