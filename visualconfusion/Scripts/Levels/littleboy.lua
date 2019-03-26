-- include useful files
u_execScript("utils.lua")
u_execScript("common.lua")
u_execScript("commonpatterns.lua")

-- this function adds a pattern to the timeline based on a key
function addPattern(mKey)
		if mKey == 0 then pAltBarrage(math.random(1, 10), 2) 
	elseif mKey == 1 then pInverseBarrage(0)
	elseif mKey == 2 then pTunnel(math.random(1, 5))
	elseif mKey == 3 then pMirrorWallStrip(1, math.random(0, 1), 0)
	elseif mKey == 4 then pWallExVortex (1, math.random(1, 1), 1)
	elseif mKey == 5 then pRandomBarrage(math.random(2, 5), 2.25)
	elseif mKey == 6 then pMirrorSpiralDouble(math.random(1, 5), 0)
	elseif mKey == 7 then pMirrorSpiral(math.random(2, 3), 0)
	elseif mKey == 8 then pWallExVortex (1, math.random(2, 3), 1)
	end
end

-- shuffle the keys, and then call them to add all the patterns
-- shuffling is better than randomizing - it guarantees all the patterns will be called
keys = { 0, 0, 1, 1, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 5, 6, 6, 7, 7, 7, 8, 8}
keys = shuffle(keys)
index = 0

-- onInit is an hardcoded function that is called when the level is first loaded
function onInit()
	l_setSpeedMult(3)
	l_setSpeedInc(0.05)
	l_setRotationSpeed(0.4)
	l_setRotationSpeedMax(0.8)
	l_setRotationSpeedInc(0.15)
	l_setDelayMult(1.07)
	l_setDelayInc(0.0)
	l_setFastSpin(71.0)
	l_setSides(6)
	l_setSidesMin(5)
	l_setSidesMax(6)
	l_setIncTime(15)

	l_setPulseMin(64)
	l_setPulseMax(84)
	l_setPulseSpeed(2.0)
	l_setPulseSpeedR(1.5)
	l_setPulseDelayMax(9)

	l_setBeatPulseMax(20)
	l_setBeatPulseDelayMax(10)

	l_setSwapEnabled(true)
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
dirChangeTime = 100

-- onUpdate is an hardcoded function that is called every frame
function onUpdate(mFrameTime)
	dirChangeTime = dirChangeTime - mFrameTime;
	if dirChangeTime < 0 then
		-- do not change direction while fast spinning
		if u_isFastSpinning() == false then
			l_setRotationSpeed(l_getRotationSpeed() * -1.0)
			dirChangeTime = 300
		end
	end 
end