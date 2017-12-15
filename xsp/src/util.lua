util = {}
util.ERROR_CODE = 108
util.qianWangXpos1 = 750
util.qianWangXpos2 = 870
util.qianWangXposCenter = 815

my_hud_id = 0
resource_hud_id = 0
attack_hud_id = 0
attack_info_times = 0
hud_text_color = "0xff81afdc"
hud_background_color = "0xc8030303"
attack_hud_text_color = "0xfffaa000"
attack_info_hud_text_color = "0xff94b64d"
hud_text_font_size = 35

-- 点击手势
function util.click(x,y)
	touchDown(1, x, y); 
	mSleep(150);
	touchUp(1, x, y); 
end

function util.move(fromX,fromY,toX,toY)
	touchDown(1, fromX, fromY); 
	mSleep(50)
	touchMove(1, toX, toY)
	mSleep(50)
	touchUp(1, toX, toY); 
end

function util.clickBottomSpace()
	width,height = getScreenSize()
	util.click((width * 0.5),2108)
	mSleep(500)
end

function util.xylog(x,y)
dialog(x..","..y)
end

function util.pullMenuToBottom()
	util.move(130,1600,130,500)
	mSleep(500)
	util.move(130,1600,130,500)
	mSleep(500)
end

function util.closeMenuIfNecessary()
	x1, y1 = findColorInRegionFuzzy(0xad2f15, 90, 1086, 1605, 1100, 1729, 0, 0)--被打被侦查会影响左上角的判断
	x, y = findColorInRegionFuzzy(0x314c70, 99, 10, 100, 230, 230, 0, 0)
	if x > -1 and x1 <= -1 then
		util.click(x,y)
		util.hudToast("关闭子菜单")
		mSleep(500)
		util.closeMenuIfNecessary()
		return 0
	else
	end
end

function util.showAttackInfo(toastInfo)
	attack_info_times = attack_info_times + 1	
	yPos = screen_height  * (1 - 0.195 -  0.06 * attack_info_times)
	if yPos < 0 then
		return
	end
	current_time = os.date("%m-%d %H:%M:%S", os.time())
	screen_width,screen_height = getScreenSize()
	local accackInfoId = createHUD() 
	showHUD(accackInfoId,current_time.." 有敌人攻打主人的"..toastInfo,hud_text_font_size,attack_info_hud_text_color,hud_background_color,0,screen_width * (1 - 0.4),yPos,screen_width * 0.4,screen_height  * 0.055)  
end

function util.initMyHud()
	screen_width,screen_height = getScreenSize()
	my_hud_id = createHUD() 
	showHUD(my_hud_id,"主人,欢迎您回来,准备好了我们就开始吧~",hud_text_font_size,hud_text_color,hud_background_color,2,0,screen_height  * (1 - 0.195),screen_width * 0.7,screen_height  * 0.055)  
end

function util.initResourceHud()
	screen_width,screen_height = getScreenSize()
	resource_hud_id = createHUD() 
	showHUD(resource_hud_id,"暂时无敌军偷袭主人资源哦~",hud_text_font_size,hud_text_color,hud_background_color,0,0,screen_height  * (1 - 0.195) - screen_height  * 0.06 * 1,screen_width * 0.4,screen_height  * 0.055)  
end

function util.initAttackHud()
	screen_width,screen_height = getScreenSize()
	attack_hud_id = createHUD() 
	showHUD(attack_hud_id,"暂时无敌军攻打主人城堡哦~",hud_text_font_size,hud_text_color,hud_background_color,0,0,screen_height  * (1 - 0.195) - screen_height  * 0.06 * 2,screen_width * 0.4,screen_height  * 0.055)  
end

function util.attackHudToast(toastInfo)
	screen_width,screen_height = getScreenSize()
	showHUD(attack_hud_id,toastInfo,hud_text_font_size,attack_hud_text_color,hud_background_color,0,0,screen_height  * (1 - 0.195) - screen_height  * 0.06 * 2,screen_width * 0.4,screen_height  * 0.055)  
end

function util.resourceHudToast(toastInfo)
	screen_width,screen_height = getScreenSize()
	showHUD(resource_hud_id,toastInfo,hud_text_font_size,attack_hud_text_color,hud_background_color,0,0,screen_height  * (1 - 0.195) - screen_height  * 0.06 * 1,screen_width * 0.4,screen_height  * 0.055)  
end

function util.hudToast(toastInfo)
	screen_width,screen_height = getScreenSize()
	showHUD(my_hud_id,toastInfo,hud_text_font_size,hud_text_color,hud_background_color,2,0,screen_height  * (1 - 0.195),screen_width * 0.7,screen_height  * 0.055)  
end

return util