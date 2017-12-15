require("util")
require("public")
chuzheng = {}

chuzheng.STEP_chu_zheng = 0
STEP_search_resource = 0
NEED_research = 1

resource_x_position = {722,532,913,1100,332,138}--木,粮,铁,宝石,据点,野外敌兵

resource_y_position = 1690

currentDuiLie = 1
function func_click_chu_zheng()
	x, y = findColorInRegionFuzzy(0x248ad4, 80, 750, 1630, 870, 1675, 0, 0)
	if x > -1 then
	--队列一
	util.click(x,y)
	chuzheng.STEP_chu_zheng = 2
	util.hudToast("点击队列"..currentDuiLie)
	mSleep(500)
	return 0
	else
		x, y = findColorInRegionFuzzy(0x1d72b5, 80, 750, 1715, 870, 1755, 0, 0)
		if x > -1 then
			--队列二
			util.click(x,y)
			chuzheng.STEP_chu_zheng = 2
			util.hudToast("点击队列"..currentDuiLie)
			mSleep(500)
			return 0
		else
			--移动两次后寻找队列三和四
			util.pullMenuToBottom()
			x, y = findColorInRegionFuzzy(0x248ed3, 80, 750, 630, 870, 670, 0, 0)
			if x > -1 then
				--队列三
				util.click(x,y)
				chuzheng.STEP_chu_zheng = 2
				util.hudToast("点击队列"..currentDuiLie)
				mSleep(500)
				return 0
			else
				x, y = findColorInRegionFuzzy(0x248ed3, 80, 750, 537, 870, 590, 0, 0)
				if x > -1 then
					--队列四
					util.click(x,y)
					chuzheng.STEP_chu_zheng = 2
					util.hudToast("点击队列"..currentDuiLie)
					mSleep(500)
					return 0
				else
					x, y = findColorInRegionFuzzy(0x248ed3, 80, 750, 470, 870, 500, 0, 0)
					if x > -1 then
						--队列五
						util.click(x,y)
						chuzheng.STEP_chu_zheng = 2
						util.hudToast("点击队列"..currentDuiLie)
						mSleep(500)
						return 0
					else
						--nothing
						util.hudToast("当前没有可出征队列")
						chuzheng.STEP_chu_zheng = util.ERROR_CODE
						return 0
					end
				end
			end
		end
	end
end

function search_bar_is_shown()--返回值0表示正常,1表示异常在城外,2表示异常在城内
	x1, y1 = findColorInRegionFuzzy(0x434e80, 99, 140, 1920, 210, 1980, 0, 0)
	x, y = findColorInRegionFuzzy(0xfff2b5, 99, 140, 1920, 210, 1980, 0, 0)
	x2, y2 = findColorInRegionFuzzy(0xfff0a9, 99, 753, 1920, 825, 1980, 0, 0)
	x3, y3 = findColorInRegionFuzzy(0x434e80, 99, 140, 1920, 210, 1980, 0, 0)
	x4, y4 = findColorInRegionFuzzy(0x248ad3, 99, 444, 2096, 794, 2175, 0, 0)
	if x > -1 and x1 > -1 and x2 > -1 and x3 > -1 and x4 > -1 then--如果发现这些特征,那么不该继续去搜索了
		return 0
	else
		if public.func_detect_out_of_city() then
			return 1
		else
			return 2
		end
	end
end

function func_search_resource_iron()
	mSleep(500)
	if STEP_search_resource == 0 then
		--touch search
		util.hudToast("点击搜索")
		util.click(1003,1837)
		mSleep(500)
		STEP_search_resource = 1
		func_search_resource_iron()
		return 0
	elseif STEP_search_resource == 1 then
		--touch
		local xPos = resource_x_position[_G["chuzheng_first"] + 1]
		if currentDuiLie == 1 then
			if public.func_get_current_chu_zheng_config() == 0 then
				xPos =	resource_x_position[6]
			else
				xPos =	resource_x_position[_G["chuzheng_first"]  + 1]
			end
		elseif currentDuiLie == 2 then
			if public.func_get_current_chu_zheng_config() == 0 then
				xPos =	resource_x_position[6]
			else
				xPos =	resource_x_position[_G["chuzheng_second"] + 1]
			end
		elseif currentDuiLie == 3 then
			if public.func_get_current_chu_zheng_config() == 0 then
				xPos =	resource_x_position[6]
			else
				xPos =	resource_x_position[_G["chuzheng_third"] + 1]
			end
				elseif currentDuiLie == 4 then
			if public.func_get_current_chu_zheng_config() == 0 then
				xPos =	resource_x_position[6]
			else
				xPos =	resource_x_position[_G["chuzheng_forth"] + 1]
			end
				elseif currentDuiLie == 5 then
			if public.func_get_current_chu_zheng_config() == 0 then
				xPos =	resource_x_position[6]
			else
				xPos =	resource_x_position[_G["chuzheng_fifth"] + 1]
			end
		end
		util.click(xPos,resource_y_position)
		mSleep(500)
		STEP_search_resource = 2
		util.hudToast("选择资源")
		func_search_resource_iron()
		return 0
	elseif STEP_search_resource == 2 then
		if search_bar_is_shown() == 1 then--异常 城外
			util.hudToast("城外位置出现异常状况,跳过")
			STEP_search_resource = 9
			func_search_resource_iron()
			return 0
		elseif search_bar_is_shown() == 2 then--异常 城内
			util.hudToast("城内位置出现异常状况,跳过")
			STEP_search_resource = util.ERROR_CODE
			func_search_resource_iron()
			return 0
		end
		util.hudToast("重置等级")
		if NEED_research == 1 then
			--touch -
			for i=1,max_level,1 do
				util.click(176,1946)
				mSleep(50)
			end
			--touch +
			for i=1,search_level,1 do
				util.click(791,1946)
				mSleep(50)
			end
		end
		STEP_search_resource = 3
		func_search_resource_iron()
		return 0
	elseif STEP_search_resource == 3 then
		--touch blue search
		util.hudToast("开始寻找")
		util.click(618,2131)
		mSleep(1000)
		STEP_search_resource = 4
		func_search_resource_iron()
		return 0
	elseif STEP_search_resource == 4 then
		--检测弹窗
		if public.func_detect_out_of_city() then--弹窗会遮盖城外标志,如果此时检测在城外,那么没有必要检测弹窗
			STEP_search_resource = 5
			func_search_resource_iron()
			return 0
		end
		x, y = findColorInRegionFuzzy(0x9d8240, 99, 444, 1246, 802, 1326, 0, 0)
		x1, y1 = findColorInRegionFuzzy(0x1b1a1d, 99, 444, 1100, 802, 1200, 0, 0)
		x2, y2 = findColorInRegionFuzzy(0x123952, 99, 493, 2103, 737, 2147, 0, 0)--底部模糊的蓝色搜索按钮
		if (x > -1 and x1 > -1 and x2 > -1) then--发现弹窗
			util.click(625,1288)
			STEP_search_resource = 2
			search_level = search_level - 1
			util.hudToast("高级资源不足，开始寻找低级资源："..search_level.."级")
			func_search_resource_iron()
			return 0
		else
			STEP_search_resource = 5
			func_search_resource_iron()
			return 0
		end
	elseif STEP_search_resource == 5 then
		--touch center resource
		util.hudToast("点击找到的资源")
		util.click(626,1086)
		mSleep(1000)
		if public.func_get_current_chu_zheng_config() == 0 then
			STEP_search_resource = 10 --打怪
		else
			STEP_search_resource = 6
		end
		func_search_resource_iron()
		return 0
	elseif STEP_search_resource == 10 then --打怪

		util.hudToast("点击攻击")
		util.click(641,1500)
		STEP_search_resource = 7
		return 0
	elseif STEP_search_resource == 6 then
		--touch zhan ling

		util.click(900,1080)
		util.hudToast("点击占领")
		mSleep(200)
		STEP_search_resource = 7
		func_search_resource_iron()
		return 0
	elseif STEP_search_resource == 7 then
		--touch chu zheng

		util.click(968,2110)
		util.hudToast("点击出征")
		mSleep(200)
		STEP_search_resource = 8
		func_search_resource_iron()
		return 0
	elseif STEP_search_resource == 8 then
		--检测弹窗
		if public.func_detect_out_of_city() then--如果此时在城外,那么没有必要检测弹窗
			STEP_search_resource = 9
			func_search_resource_iron()
			return 0
		end
		x, y = findColorInRegionFuzzy(0xa98e4a, 99, 739, 1253, 1074, 1321, 0, 0)
		x1, y1 = findColorInRegionFuzzy(0x2888c8, 99, 152, 1253, 507, 1321, 0, 0)
		if x > -1 and x1 > -1 then--发现弹窗
			util.click(330,1292)
			NEED_research = 0
			STEP_search_resource = 0
			util.hudToast("检测到进军冲突，重新搜索")
			func_search_resource_iron()
			return 0
		else
			x, y = findColorInRegionFuzzy(0x9b803b, 99, 448, 1244, 787, 1329, 0, 0)
			x1, y1 = findColorInRegionFuzzy(0x1b1a1d, 99, 152, 1134, 507, 1216, 0, 0)
			if (x > -1 and x1 > -1) then--重复行军弹窗
				util.click(616,1286)
				mSleep(200)
				util.click(104,157)
				mSleep(500)
				NEED_research = 0
				STEP_search_resource = 0
				util.hudToast("重复行军，重新查找")
				func_search_resource_iron()
				return 0
			else
				x, y = findColorInRegionFuzzy(0x397198, 99, 1081, 434, 1194, 524, 0, 0)
				x1, y1 = findColorInRegionFuzzy(0x234259, 99, 328, 2063, 693, 2151, 0, 0)
				x2, y2 = findColorInRegionFuzzy(0x494229, 99, 796, 2056, 1159, 2154, 0, 0)
				if x > -1 and x1 > -1 and x2 > -1 then--体力不足
					util.hudToast("体力不足,停止进攻")
					util.clickBottomSpace()
					mSleep(500)
					util.closeMenuIfNecessary()
					STEP_search_resource = 9
					func_search_resource_iron()
					return 0
				else
					STEP_search_resource = 9
					func_search_resource_iron()
					return 0
				end
			end
		end
	elseif STEP_search_resource == 9 then
		currentDuiLie = currentDuiLie + 1
		if currentDuiLie > _G["CONFIG_dui_lie_count"] then
			currentDuiLie = 1
		end
		util.click(125,2125)--回城
		util.hudToast("点击回城")
		STEP_search_resource = util.ERROR_CODE
		mSleep(2500)
	elseif STEP_search_resource == util.ERROR_CODE then
	end
	STEP_search_resource = 0
	NEED_research = 1
	search_level = _G["CONFIG_search_level"] 
	chuzheng.STEP_chu_zheng = util.ERROR_CODE
end

function chuzheng.func_chu_zheng()
	max_level = _G["CONFIG_max_level"]
	search_level = _G["CONFIG_search_level"] 
	mSleep(500)
	if(chuzheng.STEP_chu_zheng == 0) then
		--打开总览
		public.func_open_zong_lan()
		util.hudToast("开始队列出征")
		chuzheng.STEP_chu_zheng = 1
		chuzheng.func_chu_zheng()
		return 0
	elseif(chuzheng.STEP_chu_zheng == 1) then
		--找出征蓝色按钮
		func_click_chu_zheng()
		chuzheng.func_chu_zheng()
		return 0
	elseif(chuzheng.STEP_chu_zheng == 2) then
		--采矿
		func_search_resource_iron()
		chuzheng.func_chu_zheng()
		return 0
	elseif(chuzheng.STEP_chu_zheng == util.ERROR_CODE) then
	end
	public.func_close_zong_lan()
	chuzheng.STEP_chu_zheng = 0
end
return chuzheng