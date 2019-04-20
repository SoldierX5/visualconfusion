-- include useful files
u_execScript("utils.lua")
u_execScript("common.lua")
u_execScript("commonpatterns.lua")
u_execScript("nextpatterns.lua")
u_execScript("evolutionpatterns.lua")

-- this function adds a pattern to the timeline based on a key
function addPattern(mKey) 
	    if mKey == 0 then pMirrorWallStrip(1, 0)
	elseif mKey == 1 then hmcDefSpinner()
	elseif mKey == 3 then pMirrorSpiralDouble(math.random(1, 2), 4)
	elseif mKey == 4 then rWallEx(math.random(0, l_getSides()), math.random(1, 2)) t_wait(getPerfectDelay(THICKNESS) * 2.8)
	elseif mKey == 5 then pMirrorWallStrip(1, 2)
	elseif mKey == 6 then rWallEx(math.random(0, l_getSides()), 1) t_wait(getPerfectDelay(THICKNESS) * 2.3)
	elseif mKey == 7 then cWallEx(math.random(0, l_getSides()), 7) t_wait(getPerfectDelay(THICKNESS) * 2.7)
	end
end

-- shuffle the keys, and then call them to add all the patterns
-- shuffling is better than randomizing - it guarantees all the patterns will be called
keys = { 0, 0, 0, 1, 4, 4, 5, 6, 7 }
keys = shuffle(keys)
index = 0

special = "none"

-- onInit is an hardcoded function that is called when the level is first loaded
function onInit()
	l_setSpeedMult(3.6)
	l_setSpeedInc(0.07)
	l_setSpeedInc(0.07)
	l_setRotationSpeed(0.4)
	l_setRotationSpeedMax(0.8)
	l_setRotationSpeedInc(0.045)
	l_setDelayMult(1.35)
	l_setDelayInc(0.0)
	l_setFastSpin(71.0)
	l_setSides(10)
	l_setSidesMin(10)
	l_setSidesMax(10)
	l_setIncTime(10)

	l_setPulseMin(60)
	l_setPulseMax(80)
	l_setPulseSpeed(2.4)
	l_setPulseSpeedR(1.45)
	l_setPulseDelayMax(6.8)

	l_setBeatPulseMax(18)
	l_setBeatPulseDelayMax(18.8)

	l_setSwapEnabled(true)
end

-- onLoad is an hardcoded function that is called when the level is started/restarted
function onLoad()
	setCurveMult(0.85)
end

-- onStep is an hardcoded function that is called when the level timeline is empty
-- onStep should contain your pattern spawning logic
function onStep()	
	if special == "none" then
		addPattern(keys[index])
		index = index + 1
 	
		if index - 1 == #keys then
			index = 1
		end
	
	end
end


-- onIncrement is an hardcoded function that is called when the level difficulty is incremented
function onIncrement()
	specials = shuffle(specials)

	if special == "none" then
		special = specials[1]
		m_messageAddImportant("Special: "..special, 120)
	else
		special = "none"
	end
end

-- continuous direction change (even if not on level increment)
dirChangeTime = 120

-- onUnload is an hardcoded function that is called when the level is closed/restarted
function onUnload()
end

-- onUpdate is an hardcoded function that is called every frame
function onUpdate(mFrameTime)
	dirChangeTime = dirChangeTime - mFrameTime;
	if dirChangeTime < 0 then
		-- do not change direction while fast spinning
		if u_isFastSpinning() == false then
			l_setRotationSpeed(l_getRotationSpeed() * -1.0)
			dirChangeTime = 200
		end
	end 
end