require("util")
require("public")
dianjiang = {}
dianjiang.STEP_dian_jiang = 0

function func_click_dian_jiang_button()
	util.pullMenuToBottom()
	--找固定位置按钮颜色
	x, y = findColorInRegionFuzzy(0x248ed3, 80, 750, 1600, 785, 1655, 0, 0)
	if x > -1 then
		util.click(815,1630)
		dianjiang.STEP_dian_jiang = 2
		util.hudToast("前往招募武将")
	else
		x, y = findColorInRegionFuzzy(0x248ed3, 80, 750, 1695, 785, 1745, 0, 0)
		if x > -1 then
			util.click(815,1720)
			dianjiang.STEP_dian_jiang = 3
			util.hudToast("前往购买技能")
		else
			util.hudToast("无可招募武将或可研究技能")
			dianjiang.STEP_dian_jiang = util.ERROR_CODE
		end
	end
end

function func_detect_mian_fei_alert()
	x, y = findColorInRegionFuzzy(0x288dd0, 99, 196, 1133, 469, 1200, 0, 0)
	x, y = findColorInRegionFuzzy(	0xa9904d, 99, 763, 1133, 1039, 1200, 0, 0)
	if x > -1 and x1 > -1 then
	x, y = findColorInRegionFuzzy(0x941813, 99, 889, 429, 1028, 569, 0, 0)--恭喜你旁边的红色,找不到则可能有弹窗
		if x > -1 then
		else
			util.hudToast("检测到免费次数不足弹窗")
			util.click(x,y)
			util.closeMenuIfNecessary()
			dianjiang.STEP_dian_jiang = util.ERROR_CODE
		end
	end
end

function func_click_wu_jiang()
	x, y = findColorInRegionFuzzy(0x3fff00, 99, 93, 937, 596, 1130, 0, 0)
	if x > -1 then
		util.closeMenuIfNecessary()
		dianjiang.STEP_dian_jiang = util.ERROR_CODE
	else
		util.click(335,1070)
		dianjiang.STEP_dian_jiang = 4
		util.hudToast("点击招募武将")
--		func_detect_mian_fei_alert()
		util.mySleep(1500)--弹窗需要一段时间
	end
end

function func_click_ji_neng()
	x, y = findColorInRegionFuzzy(0x36db04, 99, 110, 1643, 600, 1855, 0, 0)
	if x > -1 then
		util.closeMenuIfNecessary()
		dianjiang.STEP_dian_jiang = util.ERROR_CODE
	else
		util.click(355,1785)
		dianjiang.STEP_dian_jiang = 5
		util.hudToast("点击研究技能")
--		func_detect_mian_fei_alert()
		util.mySleep(1500)--弹窗需要一段时间
	end
end

function func_dian_jiang_detect_he_cheng_alert()
	x, y = findColorInRegionFuzzy(0x314c70, 99, 10, 100, 230, 230, 0, 0)
	if x > -1 then
	else
		util.hudToast("检测到合成弹窗")
		util.click(621,1803)
		util.mySleep(500)
		func_dian_jiang_detect_he_cheng_alert()
	end
end

--step 4
function func_confirm_wu_jiang()
	util.mySleep(500)
	util.click(920,1770)
	util.hudToast("确认武将招募")
	util.mySleep(1000)--等待确认弹窗消失后再检测合成弹窗
	func_dian_jiang_detect_he_cheng_alert()
	dianjiang.STEP_dian_jiang = 6
end

--step 5
function func_confirm_ji_neng()
	util.mySleep(500)
	util.click(920,1770)
	util.hudToast("确认购买技能")
	util.mySleep(1000)--等待确认弹窗消失再检测合成弹窗
	func_dian_jiang_detect_he_cheng_alert()
	dianjiang.STEP_dian_jiang = 7
end

function dianjiang.func_dian_jiang()
	util.mySleep(500)
	if dianjiang.STEP_dian_jiang == 0 then
		public.func_open_zong_lan()
		util.hudToast("开始点将")
		dianjiang.STEP_dian_jiang = 1
		dianjiang.func_dian_jiang()
		return 0
	elseif dianjiang.STEP_dian_jiang == 1 then
		func_click_dian_jiang_button()
		dianjiang.func_dian_jiang()
		return 0
	elseif dianjiang.STEP_dian_jiang == 2 then--武将
		func_click_wu_jiang()
		dianjiang.func_dian_jiang()
		return 0
	elseif dianjiang.STEP_dian_jiang == 3 then--技能
		func_click_ji_neng()
		dianjiang.func_dian_jiang()
		return 0
	elseif dianjiang.STEP_dian_jiang == 4 then--武将研究结束
		func_confirm_wu_jiang()
		dianjiang.func_dian_jiang()
		return 0
	elseif dianjiang.STEP_dian_jiang == 5 then--技能研究结束
		func_confirm_ji_neng()
		dianjiang.func_dian_jiang()
		return 0
	elseif dianjiang.STEP_dian_jiang == 6 then--退回武将界面
		util.closeMenuIfNecessary()
		util.hudToast("结束武将招募")
		dianjiang.STEP_dian_jiang = util.ERROR_CODE
		dianjiang.func_dian_jiang()
		return 0
	elseif dianjiang.STEP_dian_jiang == 7 then--退回技能界面
		util.closeMenuIfNecessary()
		util.hudToast("结束技能购买")
		dianjiang.STEP_dian_jiang = util.ERROR_CODE
		dianjiang.func_dian_jiang()
		return 0
	elseif dianjiang.STEP_dian_jiang == util.ERROR_CODE then
	end
	public.func_close_zong_lan()
	dianjiang.STEP_dian_jiang = 0
end
return jianjiang