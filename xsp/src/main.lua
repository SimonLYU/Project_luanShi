--config
chu_zheng = 0
-- init
STEP_chu_zheng = 0

-- 点击手势
function click(x,y)
	touchDown(1, x, y); 
	mSleep(150);
	touchUp(1, x, y); 
end

function move(x1,y1,x2,y2,width,height)
	touchDown(1, x, y); 
	mSleep(50)
	touchMove(1, width, height)
	mSleep(50)
	touchUp(1, x, y); 
end

function xylog(x,y)
dialog(x..","..y)
end

function func_open_zong_lan()
	x, y = findColorInRegionFuzzy(0x171a1d, 99, 20, 1000, 70, 1130, 0, 0)
	if x > -1 then
	else
	click(38,1028)
	end
	return 1
end

function func_click_chu_zheng()
	x, y = findColorInRegionFuzzy(0x248ed3, 80, 0, 0, 1241, 2207, 0, 0)
	if x > -1 then
	--队列一
	else
		x, y = findColorInRegionFuzzy(0x248ed3, 80, 0, 0, 1241, 2207, 0, 0)
		if x > -1 then
		--队列二
		else
		--移动两次后寻找队列三
			move(0,0,0,0,0,0)
			move(0,0,0,0,0,0)
			x, y = findColorInRegionFuzzy(0x248ed3, 80, 0, 0, 1241, 2207, 0, 0)
			if x > -1 then
			--队列三
			else
			end
		end
	end
end

function func_chu_zheng()
	mSleep(500)
	if(STEP_chu_zheng == 0) then
		STEP_chu_zheng = STEP_chu_zheng + func_open_zong_lan()
		func_chu_zheng()
	elseif(STEP_chu_zheng == 1) then
	-- 找出征蓝色按钮
		STEP_chu_zheng = STEP_chu_zheng + func_click_chu_zheng()
		func_chu_zheng()
	else
	end
	xylog(x,y)
end

function main()
	init("0", 0);
	repeat
		if(chu_zheng == 0) then
		func_chu_zheng()
		end
		mSleep(500)
	until(false)
end
main()