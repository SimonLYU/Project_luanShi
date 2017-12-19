--require
require("public")
require("xiehuo")
require("util")
require("chuzheng")
require("dianjiang")
require("zaobing")
require("yanjiu")
require("jisi")
require("juanxian")
require("bangzhu")
require("shouhuo")
require("attack")
local bb = require("3rd.badboy")
local json = bb.json
--moudle
self = {}
--config
CONFIG_chu_zheng = 1
CONFIG_xie_huo = 1
CONFIG_dian_jiang = 1
CONFIG_zao_bing = 1
CONFIG_yan_jiu = 1
CONFIG_ji_si = 1
CONFIG_juan_xian = 1
CONFIG_bang_zhu = 1
CONFIG_shou_huo = 1
CONFIG_attact = 1

--有选项页
function configUI()
	alert_width = 700
	alert_height = 900
	screen_width,screen_height = getScreenSize()
	if screen_width < alert_width then
	alert_width = screen_width - 40
	end
	if screen_height < alert_height then
	alert_height = screen_height - 40
	end
	
	local MyTable = {
	
		["style"] = "default",
		["width"] = alert_width,
		["height"] = alert_height,
		["config"] = "save_001.dat",
		["bg"] = "bg.png",
		["okname"] = "确定",
		["cancelname"] = "取消",
		["views"] = {
			{
				["type"] = "Page",
				["text"] = "总设置",
				["views"] = {
					{
						["type"] = "Label",
						["text"] = "tip:请将模拟器分辨率调至:1242*2208",
						["size"] = 25,
						["align"] = "left",
						["color"] = "255,108,88",
					},
					{
						["type"] = "Label",
						["text"] = "ps:脚本开启后请勿手动操作,可能会导致脚本卡住!!",
						["size"] = 25,
						["align"] = "left",
						["color"] = "255,108,88",
					},
					{
						["type"] = "Label",
						["text"] = "运行速度",
						["size"] = 40,
						["align"] = "left",
						["color"] = "255,108,88",
					},
					{
						["type"] = "Label",
						["text"] = "根据设备或模拟器卡顿成都选择",
						["size"] = 25,
						["align"] = "left",
						["color"] = "255,108,88",
					},
					{
						["type"] = "RadioGroup",
						["id"] = "RadioGroupSpeed",
						["list"] = "快速,中速,慢速",
						["select"] = "2"	,
						["color"] = "255,255,255",
					},
					{
						["type"] = "Label",
						["text"] = "基本功能",
						["size"] = 40,
						["align"] = "left",
						["color"] = "255,108,88",
					},
					{
						["id"] = "CheckBoxGroup1",
						["type"] = "CheckBoxGroup",
						["size"] = 40,
						["list"] = "队列出征,自动卸货,招募研究,自动造兵,研究科技,免费祭祀,联盟捐献,宝藏帮助,自动收资,被打开罩",
						["select"] = "0@1@2@3@4@5@6@7@8@9",
						["color"] = "255,255,255",
					},
					{
						["type"] = "Label",
						["text"] = "队列出征目标:",
						["size"] = 40,
						["align"] = "left",
						["color"] = "255,108,88",
					},
					{
						["type"] = "Label",
						["text"] = "勾选队列出征后,以下设置生效",
						["size"] = 25,
						["align"] = "left",
						["color"] = "255,108,88",
					},
					{
						["type"] = "Label", 
						["text"] = "ps:击杀野外敌兵时可能会重复进军,重复进军扣除的体力会返还给玩家,无需担心",
						["size"] = 25,
						["align"] = "left",
						["color"] = "255,108,88",
					},
					{
						["type"] = "RadioGroup",
						["id"] = "RadioGroupChuZheng",
						["list"] = "杀野外敌兵,据点或采集",
						["select"] = "1"	,
						["color"] = "255,255,255",
					},
					{
						["type"] = "Label",
						["text"] = "队列出征数量:",
						["size"] = 40,
						["align"] = "left",
						["color"] = "255,108,88",
					},
					{
						["type"] = "Label",
						["text"] = "勾选队列出征后,以下设置生效",
						["size"] = 25,
						["align"] = "left",
						["color"] = "255,108,88",
					},
					{
						["id"] = "ComboBoxDuiLieCount",
						["type"] = "ComboBox",
						["size"] = 40,
						["list"] = "1,2,3,4,5",
						["color"] = "255,108,88",
						["select"] = "2"
					},
				}
			},
			{
				["type"] = "Page",
				["text"] = "出征设置",
				["views"] = {
					{
						["type"] = "Label",
						["text"] = "tip:勾选队列出征后,本页面设置才会生效",
						["size"] = 25,
						["align"] = "left",
						["color"] = "255,108,88",
					},
					{
						["type"] = "Label",
						["text"] = "目标等级(全局生效):",
						["size"] = 40,
						["align"] = "left",
						["color"] = "255,108,88",
					},
					{
						["type"] = "Label",
						["text"] = "此项关系到搜索资源等级时,\"加号\"点击的次数",
						["size"] = 25,
						["align"] = "left",
						["color"] = "255,108,88",
					},
					{
						["id"] = "EditLevel",
						["type"] = "Edit",
						["prompt"] = "请输入数值",
						["text"] = "5",
						["size"] = 40,
						["align"] = "left",
						["color"] = "255,108,88",
						["kbtype"] = "number",
					},
					{
						["type"] = "Label",
						["text"] = "当前可搜索野怪的最高等级:",
						["size"] = 40,
						["align"] = "left",
						["color"] = "255,108,88",
					},
					{
						["type"] = "Label",
						["text"] = "此项关系到搜索资源等级时,\"减号\"点击的次数",
						["size"] = 25,
						["align"] = "left",
						["color"] = "255,108,88",
					},
					{
						["id"] = "EditMaxLevel",
						["type"] = "Edit",
						["prompt"] = "请输入数值",
						["text"] = "23",
						["size"] = 40,
						["align"] = "left",
						["color"] = "255,108,88",
						["kbtype"] = "number",
					},
					{
						["type"] = "Label",
						["text"] = "采集资源配置:",
						["size"] = 40,
						["align"] = "left",
						["color"] = "255,108,88",
					},
					{
						["type"] = "Label",
						["text"] = "以下配置对攻打野外敌兵不生效!!!",
						["size"] = 25,
						["align"] = "left",
						["color"] = "255,108,88",
					},
					{
						["type"] = "Label",
						["text"] = "队列一:",
						["size"] = 40,
						["align"] = "left",
						["color"] = "255,108,88",
					},
					{
						["id"] = "ComboBox1",
						["type"] = "ComboBox",
						["size"] = 40,
						["list"] = "木材,粮草,铁矿,宝石,据点",
						["select"] = "0"
					},
					{
						["type"] = "Label",
						["text"] = "队列二:",
						["size"] = 40,
						["align"] = "left",
						["color"] = "255,108,88",
					},
					{
						["id"] = "ComboBox2",
						["type"] = "ComboBox",
						["size"] = 40,
						["list"] = "木材,粮草,铁矿,宝石,据点",
						["select"] = "0"
					},
					{
						["type"] = "Label",
						["text"] = "队列三:",
						["size"] = 40,
						["align"] = "left",
						["color"] = "255,108,88",
					},
					{
						["id"] = "ComboBox3",
						["type"] = "ComboBox",
						["size"] = 40,
						["list"] = "木材,粮草,铁矿,宝石,据点",
						["select"] = "0"
					},
					{
						["type"] = "Label",
						["text"] = "队列四:",
						["size"] = 40,
						["align"] = "left",
						["color"] = "255,108,88",
					},
					{
						["id"] = "ComboBox4",
						["type"] = "ComboBox",
						["size"] = 40,
						["list"] = "木材,粮草,铁矿,宝石,据点",
						["select"] = "0"
					},
					{
						["type"] = "Label",
						["text"] = "队列五:",
						["size"] = 40,
						["align"] = "left",
						["color"] = "255,108,88",
					},
					{
						["id"] = "ComboBox5",
						["type"] = "ComboBox",
						["size"] = 40,
						["list"] = "木材,粮草,铁矿,宝石,据点",
						["select"] = "0"
					},
				}
			},
			{
				["type"] = "Page",
				["text"] = "科技研究设置",
				["views"] = {
					{
						["type"] = "Label",
						["text"] = "tip:勾选招募研究后,本页面设置才会生效",
						["size"] = 25,
						["align"] = "left",
						["color"] = "255,108,88",
					},
					{
						["type"] = "Label",
						["text"] = "科技研究倾向:",
						["size"] = 40,
						["align"] = "left",
						["color"] = "255,108,88",
					},
					{
						["id"] = "ComboBoxKeJi",
						["type"] = "ComboBox",
						["size"] = 40,
						["list"] = "发展,战斗",
						["select"] = "0"
					},
				}
			},
			{
				["type"] = "Page",
				["text"] = "被打检测设置",
				["views"] = {
					{
						["type"] = "Label",
						["text"] = "tip:勾选被打开罩后,本页面设置才会生效",
						["size"] = 25,
						["align"] = "left",
						["color"] = "255,108,88",
					},
					{
						["type"] = "Label",
						["text"] = "免战牌不足时自动购买:",
						["size"] = 40,
						["align"] = "left",
						["color"] = "255,108,88",
					},
					{
						["id"] = "ComboBoxMianZhanPai",
						["type"] = "ComboBox",
						["size"] = 40,
						["list"] = "购买,不购买",
						["select"] = "0"
					},
					{
						["type"] = "Label",
						["text"] = "金币不足时使用元宝补充:",
						["size"] = 40,
						["align"] = "left",
						["color"] = "255,108,88",
					},
					{
						["id"] = "ComboBoxMianZhanPaiYuanBao",
						["type"] = "ComboBox",
						["size"] = 40,
						["list"] = "补充,不补充",
						["select"] = "0"
					},
				}
			},
			{
				["type"] = "Page",
				["text"] = "祭祀倾向设置",
				["views"] = {
					{
						["type"] = "Label",
						["text"] = "tip:勾选免费祭祀后,本页面设置才会生效",
						["size"] = 25,
						["align"] = "left",
						["color"] = "255,108,88",
					},
					{
						["type"] = "Label",
						["text"] = "祭祀倾向:",
						["size"] = 40,
						["align"] = "left",
						["color"] = "255,108,88",
					},
					{
						["id"] = "ComboBoxJiSi",
						["type"] = "ComboBox",
						["size"] = 40,
						["list"] = "木材,粮草,铁矿,宝石",
						["select"] = "0"
					},
				}
			},
		}
	}
	return MyTable

end

--main
function main()
	--init
	init("0", 0);
	setScreenScale(1242,2208)
	util.initMyHud()
	--UI
	local ret, results = showUI(json.encode(configUI()))    --table转json
	_G["CONFIG_attack"] = 0--检测被打默认为关闭
	_G["CONFIG_mian_zhan_pai"] = tonumber(results["ComboBoxMianZhanPai"])
	_G["CONFIG_mian_zhan_pai_yuan_bao"] = tonumber(results["ComboBoxMianZhanPaiYuanBao"])
	_G["CONFIG_chu_speed"]  = tonumber(results["RadioGroupSpeed"])--快速,中速,慢速
	--点击确认返回1, 取消返回0
	if ret == 1 then
		--results 返回以id为key的Map类型数据,返回值为字符串
		if bb.strutils.contains(results["CheckBoxGroup1"],"0") then
			CONFIG_chu_zheng = 1
			if tonumber(results["EditLevel"]) <= 0 then
				dialog("主人,您填写的出征等级不正确哦,下次记得填好哦,~", 0)
				main()
				return 0
			end
			if tonumber(results["EditMaxLevel"]) <= 0 then
				dialog("主人,您填写的当前可搜索野怪的最高等级不正确哦,下次记得填好哦~", 0)
				main()
				return 0
			end
			
			_G["CONFIG_chu_zheng_type"]  = tonumber(results["RadioGroupChuZheng"])--0:打怪,1:据点采集
			_G["CONFIG_search_level"] =	tonumber(results["EditLevel"]) - 1
			_G["CONFIG_max_level"] =	tonumber(results["EditMaxLevel"]) - 1
			_G["CONFIG_dui_lie_count"] =	tonumber(results["ComboBoxDuiLieCount"]) + 1
			_G["chuzheng_first"]  = tonumber(results["ComboBox1"])
			_G["chuzheng_second"]  = tonumber(results["ComboBox2"])
			_G["chuzheng_third"]  = tonumber(results["ComboBox3"])
			_G["chuzheng_forth"]  = tonumber(results["ComboBox4"])
			_G["chuzheng_fifth"]  = tonumber(results["ComboBox5"])
		else
			CONFIG_chu_zheng = 0
		end
		if bb.strutils.contains(results["CheckBoxGroup1"],"1") then--卸货
			CONFIG_xie_huo = 1
		else 
			CONFIG_xie_huo = 0
		end
		if bb.strutils.contains(results["CheckBoxGroup1"],"2") then--点将
			CONFIG_dian_jiang = 1
		else
			CONFIG_dian_jiang = 0
		end
		if bb.strutils.contains(results["CheckBoxGroup1"],"3") then--造兵
			CONFIG_zao_bing = 1
		else
			CONFIG_zao_bing = 0
		end
		if bb.strutils.contains(results["CheckBoxGroup1"],"4") then--科技
			CONFIG_yan_jiu = 1
			_G["CONFIG_ke_ji_qing_xiang"] =	tonumber(results["ComboBoxKeJi"])
		else
			CONFIG_yan_jiu = 0
		end
		if bb.strutils.contains(results["CheckBoxGroup1"],"5") then--祭祀
			CONFIG_ji_si = 1
			_G["CONFIG_ji_si_qing_xiang"] =	tonumber(results["ComboBoxJiSi"]) + 1
		else
			CONFIG_ji_si = 0
		end
		if bb.strutils.contains(results["CheckBoxGroup1"],"6") then--捐献
			CONFIG_juan_xian = 1
		else
			CONFIG_juan_xian = 0
		end
		if bb.strutils.contains(results["CheckBoxGroup1"],"7") then--捐献
			CONFIG_bang_zhu = 1
		else
			CONFIG_bang_zhu = 0
		end
		if bb.strutils.contains(results["CheckBoxGroup1"],"8") then--捐献
			CONFIG_shou_huo = 1
		else
			CONFIG_shou_huo = 0
		end
		if bb.strutils.contains(results["CheckBoxGroup1"],"9") then--开罩
			CONFIG_attact = 1
			_G["CONFIG_attack"] = 1
		else
			CONFIG_attact = 0
			_G["CONFIG_attack"] = 0
		end
		_G["current_device"] = 1--todo...屏幕适配,暂时写死1,表示为7plus
	else
		dialog("主人拜拜,我们下次见哦~", 0)
		lua_exit()
	end
	
	if CONFIG_attact == 0 and CONFIG_shou_huo == 0 and CONFIG_dian_jiang == 0 and CONFIG_chu_zheng == 0 and CONFIG_xie_huo == 0 and CONFIG_zao_bing == 0 and CONFIG_yan_jiu == 0 and CONFIG_ji_si == 0 and CONFIG_juan_xian == 0 and CONFIG_bang_zhu == 0 then
		dialog("主人,要记得选择功能哦~",0)
		main()
		return 0
	end
	
	util.initResourceHud()
	util.initAttackHud()

	repeat
		if CONFIG_chu_zheng == 1 then
			chuzheng.func_chu_zheng()
		end
		if CONFIG_xie_huo == 1 then
			xiehuo.func_xie_huo()
		end
		if CONFIG_dian_jiang == 1 then
			dianjiang.func_dian_jiang()
		end
		if CONFIG_zao_bing == 1 then
			zaobing.func_zao_bing()
		end
		if CONFIG_yan_jiu == 1 then
			yanjiu.func_yan_jiu()
		end
		if CONFIG_ji_si == 1 then
			jisi.func_ji_si()
		end
		if CONFIG_juan_xian == 1 then
			juanxian.func_juan_xian()
		end
		if CONFIG_bang_zhu == 1 then
			bangzhu.func_bang_zhu()
		end
		if CONFIG_shou_huo == 1 then
			shouhuo.func_shou_huo()
		end
		if CONFIG_attack == 1 then
			util.closeMenuIfNecessary()
			attack.func_detectAttack()
		end
		util.mySleep(500)
	until(false)
end
main()
return self