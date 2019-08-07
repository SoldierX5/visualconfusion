-- include useful files
u_execScript("utils.lua")
u_execScript("common.lua")
u_execScript("commonpatterns.lua")

-- this function adds a pattern to the timeline based on a key
function addPattern(mKey)
		if mKey == 0 then pAltBarrage(math.random(1, 10), 2) 
	elseif mKey == 1 then pBarrageSpiral(3, 0.6, 1)
	elseif mKey == 2 then pInverseBarrage(0)
	elseif mKey == 3 then pTunnel(math.random(1, 5))
	elseif mKey == 4 then pMirrorWallStrip(1, math.random(0, 1), 0)
	elseif mKey == 5 then pWallExVortex(0, math.random(0, 0), 1)
	elseif mKey == 6 then pDMBarrageSpiral(math.random(4, 7), 0.4, 1)
	elseif mKey == 7 then pRandomBarrage(math.random(2, 5), 2.25)
	elseif mKey == 8 then pMirrorSpiralDouble(math.random(1, 2), 0)
	elseif mKey == 9 then pMirrorSpiral(math.random(2, 4), 0)
	elseif mKey == 10 then pWallExVortex(0, math.random(3, 3), 1)
	end
end

-- shuffle the keys, and then call them to add all the patterns
-- shuffling is better than randomizing - it guarantees all the patterns will be called
keys = { 0, 0, 1, 1, 2, 2, 3, 4, 4, 5, 6, 7, 7, 7, 8, 9, 9 }
keys = shuffle(keys)
index = 0

-- onInit is an hardcoded function that is called when the level is first loaded
function onInit()
	l_setSpeedMult(2.6)
	l_setSpeedInc(0.3)
	l_setRotationSpeed(0.1)
	l_setRotationSpeedMax(4)
	l_setRotationSpeedInc(0)
	l_setDelayMult(1.07)
	l_setDelayInc(0.0)
	l_setFastSpin(71.0)
	l_setSides(6)
	l_setSidesMin(6)
	l_setSidesMax(6)
	l_setIncTime(10)

	l_setPulseMin(70)
	l_setPulseMax(100)
	l_setPulseSpeed(50.0)
	l_setPulseSpeedR(1.5)
	l_setPulseDelayMax(0.5)

	l_setBeatPulseMax(-10)
	l_setBeatPulseDelayMax(0.000000000001)

	enableSwapIfDMGreaterThan(1)
end

-- onLoad is an hardcoded function that is called when the level is started/restarted
function onLoad()
	e_eventWaitS(12.5)
	m_messageAddImportant("flip!", 80)
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
	l_setRotationSpeed(4)
	l_setBeatPulseMax(60)
	l_setBeatPulseDelayMax(10)
	l_setIncTime(300)
end

-- onUnload is an hardcoded function that is called when the level is closed/restarted
function onUnload()
end

-- continuous direction change (even if not on level increment)
dirChangeTime = 50

-- onUpdate is an hardcoded function that is called every frame
function onUpdate(mFrameTime)
	dirChangeTime = dirChangeTime - mFrameTime;
	if dirChangeTime < 0 then
		-- do not change direction while fast spinning
		if u_isFastSpinning() == false then
			l_setRotationSpeed(l_getRotationSpeed() * -1.0)
			dirChangeTime = 1
		end
	end 
end