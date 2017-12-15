require "util"
require "public"

shouhuo = {}
STEP_shou_huo = 0

every_resource_xPos = {532,303,883,453,774,642,503,754,933,1133}
every_resource_yPos = {427,774,383,930,521,801,638,957,652,1257}

function fucn_pull_to_zuo_xia()
	util.hudToast("出城")
	util.click(125,2125)--回城
	util.mySleep(3000)
	util.hudToast("回城")
	util.click(125,2125)--回城
	util.mySleep(3000)
	--左
	util.hudToast("屏幕定位到城内左下角")
	for i = 1,3,1 do
		util.move(260,1290,930,1290)
		util.mySleep(200)
		util.move(260,1530,930,1530)
		util.mySleep(200)
		util.move(260,800,930,800)
		util.mySleep(200)
	end
	util.mySleep(500)
	--下
	for i = 1,3,1 do
		util.move(300,1600,300,500)
		util.mySleep(200)
		util.move(600,1600,600,500)
		util.mySleep(200)
		util.move(900,1600,900,500)
		util.mySleep(200)
	end
	STEP_shou_huo = 2
end

function func_click_every_resource()
	util.hudToast("依次收取城内左下角所有资源")
	for i=1,10,1 do
		util.click(every_resource_xPos[i],every_resource_yPos[i])
		util.mySleep(200)
	end	STEP_shou_huo = util.ERROR_CODE
end

function shouhuo.func_shou_huo()
	util.mySleep(500)
	if STEP_shou_huo == 0 then
		--初始化,关掉菜单,进入城内
		public.func_start_init()
		util.hudToast("开始收取城内资源")
		STEP_shou_huo = 1
		shouhuo.func_shou_huo()
		return 0
	elseif STEP_shou_huo == 1 then
		fucn_pull_to_zuo_xia()
		shouhuo.func_shou_huo()
		return 0
	elseif STEP_shou_huo == 2 then
		func_click_every_resource()
		shouhuo.func_shou_huo()
		return 0
	elseif STEP_shou_huo == util.ERROR_CODE then
	end
	util.hudToast("收取结束")
	STEP_shou_huo = 0
end

return shouhuo