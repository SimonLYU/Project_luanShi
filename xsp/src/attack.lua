require "util"

attack = {}
STEP_attack = 0
STEP_sub_attack = 0

search_x1 = 992
search_y1 = 353
search_x2 = 1189
search_y2 = 435
search_space = 303
search_count = 0

attack_times = 0
attack_resource_times = 0

is_on_fire = 0

--step 1
function detectAttackIcon()
	x, y = findColorInRegionFuzzy(0xad2f15, 90, 1086 , 1605 - (163 *  is_on_fire), 1233, 1729 - (163 *  is_on_fire), 0, 0)
	if x > -1 then
		util.click(1160,1671 - 163 *  is_on_fire)
		util.hudToast("查看行军记录")
		STEP_attack = 2      
		return 0
	end
	STEP_attack = util.ERROR_CODE
	return 0
end

--step 2
function ishelp()
	x, y = findColorInRegionFuzzy(0x3e7a38, 99, 61, 486, 274, 536, 0, 0)
	if x > -1 then
		return true
	else
		return false
	end
end
--sub step 0
function subfunc_click_zuo_biao()
	if ishelp() == true then
		util.hudToast("此行军为援军")
		util.click(1130,425)
		STEP_sub_attack = util.ERROR_CODE
	else
		--侦查
		util.click(1128,776)
		util.mySleep(200)
		x, y = findColorInRegionFuzzy(0x314c70, 99, 10, 100, 230, 230, 0, 0)
		if x > -1 then
			util.hudToast("此行军为侦查")
			STEP_sub_attack = util.ERROR_CODE
		else
			--点击目标坐标
			util.click(335,1033)
			util.hudToast("查看被攻击的目标")
			STEP_sub_attack = 1 
		end
	end
end
--sub step 1
function subfunc_click_mu_biao()
	util.click(617,1087)
	util.hudToast("点击被攻打的目标")
	STEP_sub_attack = 2
end
--sub step 2
function subfunc_click_zeng_yi()
	util.click(904,1020)--撤军和增益
	util.mySleep(500)
	x, y = findColorInRegionFuzzy(0x314c70, 99, 10, 100, 230, 230, 0, 0)
	if x > -1 then
		util.hudToast("准备选择可用免战牌")
		STEP_sub_attack = 3
	else
		attack_resource_times = attack_resource_times + 1
		util.resourceHudToast("人家帮主人撤兵了"..attack_resource_times.."次资源田~")
		util.showAttackInfo("资源田")
		util.hudToast("资源田已经撤军")
		STEP_sub_attack = util.ERROR_CODE
	end
end
--sub step 3
function subfunc_click_zhao()

	x, y = findColorInRegionFuzzy(0x2284ed, 99, 345, 417, 395, 437, 0, 0)
	if x > -1 then--免战牌已经生效
		STEP_sub_attack = util.ERROR_CODE
		util.hudToast("免战牌已经生效")
	else
		util.hudToast("寻找可用免战牌")
		util.click(1143,337)
		STEP_sub_attack = 4
	end
end
--sub step 4
function subfunc_choose_zhao()
	util.click(1011,618)--使用免战牌
	util.mySleep(200)
	x, y = findColorInRegionFuzzy(0x2d8fcc, 90, 139, 1240, 516, 1335, 0, 0)
	x1, y1 = findColorInRegionFuzzy(0x9c823b, 90, 731, 1240, 1100, 1335, 0, 0)
	if x > -1 and x1 > -1 then--如果没有免战牌
		if _G["CONFIG_mian_zhan_pai"] == 0 then
			util.click(923,1293)--购买
			util.mySleep(200)
			x, y = findColorInRegionFuzzy(0x2d8fcc, 90, 139, 1240, 516, 1335, 0, 0)
			x1, y1 = findColorInRegionFuzzy(0x9c823b, 90, 731, 1240, 1100, 1335, 0, 0)
			if x > -1 and x1 > -1 then--金币不足
				if _G["CONFIG_mian_zhan_pai_yuan_bao"] == 0 then
					util.hudToast("金币不足元宝补充")
					util.click(923,1293)--补充
					util.mySleep(200)
					x, y = findColorInRegionFuzzy(0x2d8fcc, 90, 139, 1240, 516, 1335, 0, 0)
					x1, y1 = findColorInRegionFuzzy(0x9c823b, 90, 731, 1240, 1100, 1335, 0, 0)
					if x > -1 and x1 > -1 then--元宝不足
						util.click(330,1293)--算了,挨打吧
						util.hudToast("元宝不足,取消购买")
					else
						attack_times = attack_times + 1
						util.attackHudToast("人家帮主人开启了"..attack_times.."次免战牌~")
						util.showAttackInfo("城堡")
						util.hudToast("元宝购买免战牌")
					end
				else
					util.hudToast("金币不足,取消购买")
					util.click(330,1293)--不补充金币
				end
			else
				attack_times = attack_times + 1
				util.attackHudToast("人家帮主人开启了"..attack_times.."次免战牌~")
				util.showAttackInfo("城堡")
				util.hudToast("购买免战牌")
			end
		else
			util.click(330,1293)--不购买
			util.hudToast("取消购买免战牌")
		end
		STEP_sub_attack = util.ERROR_CODE
	else
		attack_times = attack_times + 1
		util.attackHudToast("人家帮主人开启了"..attack_times.."次免战牌~")
		util.showAttackInfo("城堡")
		STEP_sub_attack = util.ERROR_CODE
	end
end

--sub step 
function subfunc_main()
	util.mySleep(500)
	if STEP_sub_attack == 0 then
		subfunc_click_zuo_biao()
		subfunc_main()
		return 0
	elseif STEP_sub_attack == 1 then
		subfunc_click_mu_biao()
		subfunc_main()
		return 0
	elseif STEP_sub_attack == 2 then
		subfunc_click_zeng_yi()
		subfunc_main()
		return 0
	elseif STEP_sub_attack == 3 then
		subfunc_click_zhao()
		subfunc_main()
		return 0
	elseif STEP_sub_attack == 4 then
		subfunc_choose_zhao()
		subfunc_main()
		return 0
	elseif STEP_sub_attack == util.ERROR_CODE then
		util.closeMenuIfNecessary()
	end
	STEP_sub_attack = 0
end

function lookDetail()	
	x, y = findColorInRegionFuzzy(0xa0410b, 99, 588, 2078, 655, 2133, 0, 0)
	if x > -1 then--城池被攻
		util.mySleep(300)
		is_on_fire = 1
		STEP_attack = 3
		util.click(100,151)--关闭燃烧窗口
		util.hudToast("城池在燃烧!")
		util.mySleep(300)
		return 0
	end

	util.click(932,2103)--先全部忽略,免得渐变红色影响判断
	util.mySleep(200)
	util.click(916,1288)
	util.mySleep(500)
	x1, y1 = findColorInRegionFuzzy(0xa57940, 80, search_x1 , search_y1 + search_count *search_space, search_x2 , search_y2 + search_count *search_space, 0, 0)
	x, y = findColorInRegionFuzzy(0xfdfbf9, 80, search_x1 , search_y1 + search_count *search_space, search_x2 , search_y2 + search_count *search_space, 0, 0)
	if x > -1 and x1 > -1 then
		util.click(x,y)
		util.hudToast("点击查看第"..(search_count + 1).."条行军信息")
		subfunc_main()
		STEP_attack = 0
	else
		STEP_attack = util.ERROR_CODE
	end
end

function moveToZuoShang()
	util.hudToast("开始检测敌军")
	--右
	util.move(930,1290,260,1290)
	util.mySleep(200)
	util.move(930,1290,260,1290)
	util.mySleep(200)
	--下
	util.move(300,500,300,1600)
	util.mySleep(200)
	util.move(300,500,300,1600)
	util.mySleep(200)
		
	STEP_attack = 1
end

function attack.func_detectAttack()
	util.mySleep(500)
	if STEP_attack == 0 then
	--这里先什么也不做
		moveToZuoShang()
		attack.func_detectAttack()
		return 0
	elseif STEP_attack == 1 then
		detectAttackIcon()
		attack.func_detectAttack()
		return 0
	elseif STEP_attack == 2 then
		lookDetail()
		search_count = search_count + 1
		attack.func_detectAttack()
		return 0
	elseif STEP_attack == 3 then --城池被攻破的情况
		STEP_attack = 0 
		attack.func_detectAttack()
		return 0
	elseif STEP_attack == util.ERROR_CODE then
	end
	util.hudToast("检测被攻击结束")
	util.closeMenuIfNecessary()
	STEP_attack = 0
	search_count = 0
	is_on_fire = 0
end

return attack