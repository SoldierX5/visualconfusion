-- include useful files
u_execScript("utils.lua")
u_execScript("common.lua")
u_execScript("commonpatterns.lua")
u_execScript("nextpatterns.lua")

-- this function adds a pattern to the timeline based on a key
function addPattern(mKey)
		if mKey == 0 then pACBarrage()
	elseif mKey == 1 then pACBarrageMulti()
	elseif mKey == 2 then pACBarrageMultiAltDir()
	end
end

-- shuffle the keys, and then call them to add all the patterns
-- shuffling is better than randomizing - it guarantees all the patterns will be called
keys = { 0, 0 }
keys = shuffle(keys)
index = 0

-- onInit is an hardcoded function that is called when the level is first loaded
function onInit()
	l_setSpeedMult(2.25)
	l_setSpeedInc(0.025)
	l_setRotationSpeed(0.75)
	l_setRotationSpeedMax(0.7)
	l_setRotationSpeedInc(0)
	l_setDelayMult(1.1)
	l_setDelayInc(-0.01)
	l_setFastSpin(100.0)
	l_setSides(6)
	l_setSidesMin(5)
	l_setSidesMax(7)
	l_setIncTime(30)

	l_setPulseMin(66)
	l_setPulseMax(99)
	l_setPulseSpeed(5.05)
	l_setPulseSpeedR(1.34)
	l_setPulseDelayMax(7)

	l_setBeatPulseMax(50)
	l_setBeatPulseDelayMax(30)

	enableSwapIfDMGreaterThan(1.25)
end

-- onLoad is an hardcoded function that is called when the level is started/restarted
function onLoad()
end

-- onStep is an hardcoded function that is called when the level timeline is empty
-- onStep should contain your pattern spawning logic
function onStep()	
	addPattern(keys[index])
	index = index + 1
	
	if index - 1 == #keys then
		index = 1
	end
end

-- onIncrement is an hardcoded function that is called when the level difficulty is incremented
function onIncrement()
end

-- onUnload is an hardcoded function that is called when the level is closed/restarted
function onUnload()
end

-- continuous direction change (even if not on level increment)
dirChangeTime = 400
hueIMin = 0.0
hueIMax = 22.0
hueIStep = 0.0065

-- onUpdate is an hardcoded function that is called every frame
function onUpdate(mFrameTime)
	dirChangeTime = dirChangeTime - mFrameTime;
	if dirChangeTime < 0 then
		-- do not change direction while fast spinning
		if u_isFastSpinning() == false then
			l_setRotationSpeed(l_getRotationSpeed() * -1.0)
			dirChangeTime = 40
		end
	end 

	s_setHueInc(s_getHueInc() + hueIStep)
	if(s_getHueInc() > hueIMax) then hueIStep = hueIStep * -1 end
	if(s_getHueInc() < hueIMin) then hueIStep = hueIStep * -1 end
end