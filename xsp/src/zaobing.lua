require "util"
require "public"

zaobing = {}
STEP_zao_bing = 0

bing_ying_xPos1 = {516,0}
bing_ying_yPos1 = {667,0}
bing_ying_xPos2 = {718,0}
bing_ying_yPos2 = {866,0}
bing_ying_center_x = {635,0}
bing_ying_center_y = {1067,0}

titles = {"步兵营","骑兵营","弓兵营","战车工坊","陷阱工坊"}
y1_positions = {865,955,1045,1140,1230}
y2_positions = {925,1015,1105,1200,1290}
TIMES_search_qian_wang = 1
--寻找前往
function func_zhao_bing_search_qian_wang()
	if TIMES_search_qian_wang <= 5 then
		x, y = findColorInRegionFuzzy(0x298acf, 80, util.qianWangXpos1, y1_positions[TIMES_search_qian_wang], util.qianWangXpos2, y2_positions[TIMES_search_qian_wang], 0, 0)
		if x > -1 then
			util.click(util.qianWangXposCenter,y)
			STEP_zao_bing = 2
			util.hudToast("点击前往"..titles[TIMES_search_qian_wang])
			TIMES_search_qian_wang = 1
			mSleep(1500)
			return 0
		else
			TIMES_search_qian_wang = TIMES_search_qian_wang + 1
			func_zhao_bing_search_qian_wang()
			return 0
		end
	else
		util.hudToast("当前无需造兵")
		STEP_zao_bing = util.ERROR_CODE
		TIMES_search_qian_wang = 1
	end
end

function func_click_bing_ying()
		x, y = findColorInRegionFuzzy(0x30e619, 99, bing_ying_xPos1[_G["current_device"]], bing_ying_yPos1[_G["current_device"]], bing_ying_xPos2[_G["current_device"]], bing_ying_yPos2[_G["current_device"]], 0, 0)
		if x > -1 then
			util.click(bing_ying_center_x[_G["current_device"]],bing_ying_center_y[_G["current_device"]])
			mSleep(500)
		end
		util.click(bing_ying_center_x[_G["current_device"]],bing_ying_center_y[_G["current_device"]])
		STEP_zao_bing = 3
end

function func_click_xun_lian()
	util.click(694,1278)
	mSleep(500)
	STEP_zao_bing = 4
end

function func_click_blue_xun_lian()
	util.click(936,2073)
	mSleep(500)
	STEP_zao_bing = 5
end

function func_zhao_bing_detect_alert()
		x, y = findColorInRegionFuzzy(0x278bce, 99, 142, 1243, 520, 1338, 0, 0)
		x1, y1 = findColorInRegionFuzzy(0xa58846, 99, 723, 1243, 1102, 1338, 0, 0)
		if x > -1 and x1 > -1 then
			--有弹窗
			util.click(331,1293)
			mSleep(500)
			util.closeMenuIfNecessary()
			mSleep(500)
			STEP_zao_bing = util.ERROR_CODE
		else
			x, y = findColorInRegionFuzzy(0xad9251, 99, 432, 1243, 808, 1338, 0, 0)
			x1, y1 = findColorInRegionFuzzy(0x143046, 99, 757, 2027, 1103, 2113, 0, 0)
			if x > -1 and x1 > -1 then
				--有弹窗
				util.clickBottomSpace()
				mSleep(500)
				util.closeMenuIfNecessary()
				mSleep(500)
				STEP_zao_bing = util.ERROR_CODE
			else
				STEP_zao_bing = util.ERROR_CODE
			end
		end
end

function zaobing.func_zao_bing()
mSleep(500)
	if STEP_zao_bing == 0 then
		public.func_open_zong_lan()
		util.hudToast("开始造兵")
		STEP_zao_bing = 1
		zaobing.func_zao_bing()
		return 0
	elseif STEP_zao_bing == 1 then
		func_zhao_bing_search_qian_wang()
		zaobing.func_zao_bing()
		return 0
	elseif STEP_zao_bing == 2 then
		func_click_bing_ying()
		zaobing.func_zao_bing()
		return 0
	elseif STEP_zao_bing == 3 then
		func_click_xun_lian()
		zaobing.func_zao_bing()
		return 0
	elseif STEP_zao_bing == 4 then
		func_click_blue_xun_lian()
		zaobing.func_zao_bing()
		return 0
	elseif STEP_zao_bing == 5 then
		func_zhao_bing_detect_alert()
		zaobing.func_zao_bing()
		return 0
	elseif STEP_zao_bing == util.ERROR_CODE then
	end

	public.func_close_zong_lan()
	STEP_zao_bing = 0
end

return zaobing