require("util")
require("attack")
public = {}

function public.func_close_zong_lan()
	x, y = findColorInRegionFuzzy(0x171a1d, 95, 20, 1000, 70, 1130, 0, 0)
	if x > -1 then
		util.click(1142,1092)
		return 0
	end
end

function public.func_open_zong_lan()
	--初始化,关掉菜单,进入城内
	public.func_start_init()
	--打开总览
	x, y = findColorInRegionFuzzy(0x171a1d, 95, 20, 1000, 70, 1130, 0, 0)
	if x > -1 then
		util.clickBottomSpace()
		public.func_open_zong_lan()
		return 1
	else
		util.click(38,1028)
	end
end

function public.func_detect_out_of_city()
	x, y = findColorInRegionFuzzy(0xf7f7c1, 90, 4, 322, 98, 422, 0, 0)
	x1, y1 = findColorInRegionFuzzy(0x433c33, 90, 4, 322, 98, 422, 0, 0)
	x2, y2 = findColorInRegionFuzzy(0xd4c29f, 90, 955, 97, 1071, 198, 0, 0)
	x3, y3 = findColorInRegionFuzzy(0x484131, 90, 955, 97, 1071, 198, 0, 0)
	x4, y4 = findColorInRegionFuzzy(0x464135, 90, 1089, 97, 1227, 224, 0, 0)
	x5, y5 = findColorInRegionFuzzy(0xe6d9c5, 90, 1089, 97, 1227, 224, 0, 0)
	if x > -1 and x1 > -1 and x2 > -1 and x3 > -1 and x4 > -1 and x5 > -1 then
		return true
	else
		return false
	end
end

function public.close_invate_alert_if_needed()
	x, y = findColorInRegionFuzzy(0x2d526b, 90, 1042, 283, 1165, 386, 0, 0)--关闭
	x1, y1 = findColorInRegionFuzzy(0xd9ae56, 90, 1042, 283, 1165, 386, 0, 0)--关闭
	x2, y2 = findColorInRegionFuzzy(0xa88d4b, 90, 197, 1155, 380, 1221, 0, 0)--邀请
	x3, y3 = findColorInRegionFuzzy(0x2694d7, 90, 511, 1265, 736, 1325, 0, 0)--换一批
	x4, y4 = findColorInRegionFuzzy(0x642c17, 90, 507, 1357, 760, 1420, 0, 0)--换一批下面的红色
	x5, y5 = findColorInRegionFuzzy(0x431d20, 90, 136, 293, 248, 393, 0, 0)--关闭左边对称的红色
	if x > -1 and x1 > -1 and x2 > -1 and x3 > -1 and x4 > -1 and x5 > -1 then
		util.hudToast("检测到好友邀请弹窗!已关闭!")
		util.click(1111,341)
		util.mySleep(300)
		return true
	else
		return false
	end
end

function public.close_fu_dai_rain_alert_if_needed()
	x, y = findColorInRegionFuzzy(0xb53429, 90, 1010, 590, 1111, 697, 0, 0)--关闭
	x1, y1 = findColorInRegionFuzzy(0xffd36a, 90, 1010, 590, 1111, 697, 0, 0)--关闭
	x2, y2 = findColorInRegionFuzzy(0xc96b21, 90, 583, 707, 666, 789, 0, 0)--中间铃铛
	x3, y3 = findColorInRegionFuzzy(0x822f0a, 90, 392, 1159, 845, 1210, 0, 0)--分享倒计时
	x4, y4 = findColorInRegionFuzzy(0xffe826, 90, 555, 483, 658, 562, 0, 0)--顶部的金币
	x5, y5 = findColorInRegionFuzzy(0xcdaa65, 90, 557, 1668, 680, 1755, 0, 0)--底部两个分享按钮的中间部分
	x6, y6 = findColorInRegionFuzzy(0xa53438, 90, 557, 1668, 680, 1755, 0, 0)--底部两个分享按钮的中间部分
	if x > -1 and x1 > -1 and x2 > -1 and x3 > -1 and x4 > -1 and x5 > -1 and x6 > -1 then
		util.hudToast("检测到天降福袋雨弹窗!已关闭!")
		util.click(1066,641)
		util.mySleep(300)
		return true
	else
		return false
	end
end

function public.retry_internet_connect_if_needed()
	x, y = findColorInRegionFuzzy(0x171a1f, 90, 143, 828, 225, 885, 0, 0)
	x1, y1 = findColorInRegionFuzzy(0x191b1c, 90, 1000, 828, 1050, 885, 0, 0)
	x2, y2 = findColorInRegionFuzzy(0x268dd3, 90, 227, 1256, 427, 1322, 0, 0)
	x3, y3 = findColorInRegionFuzzy(0xac9150, 90, 811, 1256, 1024, 1322, 0, 0)
	x4, y4 = findColorInRegionFuzzy(0x181c1f, 90, 573, 1256, 667, 1322, 0, 0)
	if x > -1 and x1 > -1 and x2 > -1 and x3 > -1 and x4 > -1 then
		util.hudToast("网络连接不稳定,正在帮主人重试")
		util.click(912,1294)
		util.mySleep(300)
		return true
	else
		return false
	end
end

function public.func_start_init()
	--查看是否在城外
	if public.func_detect_out_of_city() then--在城郊
		util.hudToast("点击回城")
		util.click(125,2125)--回城
		util.mySleep(2500)
	end
	--先关掉菜单
	util.closeMenuIfNecessary()
	--好友邀请弹窗
	public.close_invate_alert_if_needed()
	--检测天降福袋雨
	public.close_fu_dai_rain_alert_if_needed()
	--检测网络连接
	public.retry_internet_connect_if_needed()
	--检测是否被打
	if public.should_detect_attack() then
		attack.func_detectAttack()
		util.mySleep(500)
	end
	--再检查一次是否在城外(在城外被攻击的时候,闪烁的红色会影响城外的判断,所以等被打检测结束之后再做一次城外检测)
	if public.func_detect_out_of_city() then--在城郊
		util.hudToast("点击回城")
		util.click(125,2125)--回城
		util.mySleep(2000)
	end
end

function public.func_get_current_chu_zheng_config()
	return _G["CONFIG_chu_zheng_type"]
end

function public.should_detect_attack()
	if _G["CONFIG_attack"] == 1 then
		return true
	else
		return false
	end
end

return public