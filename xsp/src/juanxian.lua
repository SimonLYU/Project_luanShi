require "util"
require "public"

juanxian = {}
STEP_juan_xian = 0

function func_juan_xian_qian_wang()
	util.pullMenuToBottom()
	x, y = findColorInRegionFuzzy(0x298acf, 80, util.qianWangXpos1, 1023, util.qianWangXpos2, 1075, 0, 0)
	if x > -1 then
	util.hudToast("点击前往联盟捐献")
		util.click(util.qianWangXposCenter,y)
--		mSleep(1500)--移动视角需要一段时间
		STEP_juan_xian = 2
	else
		util.hudToast("当前无需联盟捐献")
		STEP_juan_xian = util.ERROR_CODE
	end
end

function func_click_first_ke_ji()
--	width,height = getScreenSize()
	util.click(1030,595)
	STEP_juan_xian = 3
	util.hudToast("点击第一个可捐献的科技")
end

function func_juan_xian_detect_no_resource()
	x, y = findColorInRegionFuzzy(0x314c70, 99, 10, 100, 230, 230, 0, 0)
	if x > -1 then
		return true
	else
		return false
	end
end

function func_juan_xian_detect_alert()
	x, y = findColorInRegionFuzzy(0x268dd3, 99, 144, 1242, 507, 1330, 0, 0)
	x1, y1 = findColorInRegionFuzzy(0xa9904c, 99, 733, 1249, 1091, 1328, 0, 0)
	if x > -1 and x1 > -1 then
		util.clickBottomSpace()
		return true
	else
		return false
	end
end

function func_click_juan_xian()
	x, y = findColorInRegionFuzzy(0x297bbd, 99, 722, 1455, 1113, 1585, 0, 0)
	if x > -1 then
		util.hudToast("点击捐献")
		util.click(923,1520)
		mSleep(500)
	else
		util.hudToast("科技升级中")
		util.clickBottomSpace()
		util.closeMenuIfNecessary()
		STEP_juan_xian = util.ERROR_CODE
		return 0
	end

	if func_juan_xian_detect_no_resource() then--资源不足
		util.hudToast("资源不足")
		util.closeMenuIfNecessary()
		util.clickBottomSpace()
		util.closeMenuIfNecessary()
		STEP_juan_xian = util.ERROR_CODE
		return 0
	else
		if func_juan_xian_detect_alert() then
			util.clickBottomSpace()
			util.closeMenuIfNecessary()
			STEP_juan_xian = util.ERROR_CODE
			return 0
		else
			func_click_juan_xian()
			return 0
		end
	end
end

function juanxian.func_juan_xian()
	mSleep(500)
	if STEP_juan_xian == 0 then
		public.func_open_zong_lan()
		STEP_juan_xian = 1
		util.hudToast("开始联盟捐献")
		juanxian.func_juan_xian()
	elseif STEP_juan_xian == 1 then
		func_juan_xian_qian_wang()
		juanxian.func_juan_xian()
		return 0
	elseif STEP_juan_xian == 2 then
		func_click_first_ke_ji()
		juanxian.func_juan_xian()
		return 0
	elseif STEP_juan_xian == 3 then
		func_click_juan_xian()
		juanxian.func_juan_xian()
		return 0
	elseif STEP_juan_xian == util.ERROR_CODE then
	end
	util.hudToast("联盟捐献结束")
	public.func_close_zong_lan()
	STEP_juan_xian = 0
end

return juanxian