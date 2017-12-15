require("public")
require("util")
xiehuo = {}
xiehuo.STEP_xie_huo = 0

function func_click_xie_huo_button()
	util.pullMenuToBottom()
	--找固定位置按钮颜色
	x, y = findColorInRegionFuzzy(0x248ed3, 80, 750, 826, 786, 785, 0, 0)
	if x > -1 then
		util.hudToast("点击前往卸货")
		util.click(815,855)
		xiehuo.STEP_xie_huo = 2
	else
		util.hudToast("当前无需卸货")
		xiehuo.STEP_xie_huo = util.ERROR_CODE
	end
end

function func_click_ship()
	mSleep(1000)--系统自动移动视角的时候需要一定的时间
	util.click(648,1100)
	xiehuo.STEP_xie_huo = 3
end

function func_xie_huo_click_confirm()
	util.click(620,1300)
	xiehuo.STEP_xie_huo = util.ERROR_CODE
end

function xiehuo.func_xie_huo()
	mSleep(500)
	if(xiehuo.STEP_xie_huo == 0) then
		--打开总览
		public.func_open_zong_lan()
		util.hudToast("开始卸货")
		xiehuo.STEP_xie_huo = 1
		xiehuo.func_xie_huo()
		return 0
	elseif(xiehuo.STEP_xie_huo == 1) then
		func_click_xie_huo_button()
		xiehuo.func_xie_huo()
		return 0
	elseif(xiehuo.STEP_xie_huo == 2) then
		func_click_ship()
		util.hudToast("点击船")
		xiehuo.func_xie_huo()
		return 0
	elseif(xiehuo.STEP_xie_huo == 3) then
		func_xie_huo_click_confirm()
		util.hudToast("点击卸货")
		xiehuo.func_xie_huo()
		return 0
	elseif(xiehuo.STEP_xie_huo == util.ERROR_CODE) then
	end
	util.hudToast("卸货结束关闭总览")	
	public.func_close_zong_lan()
	xiehuo.STEP_xie_huo = 0
end
return xiehuo