-- include useful files
u_execScript("utils.lua")
u_execScript("common.lua")
u_execScript("commonpatterns.lua")

-- this function adds a pattern to the timeline based on a key
function addPattern(mKey)
		if mKey == 0 then pAltBarrage(math.random(1, 10), 2) 
	elseif mKey == 1 then pBarrageSpiral(3, 0.6, 1)
	elseif mKey == 2 then pInverseBarrage(0)
	elseif mKey == 3 then pTunnel(math.random(1, 4))
	elseif mKey == 4 then pMirrorWallStrip(1, math.random(0, 1), 0)
	elseif mKey == 5 then pWallExVortex(0, math.random(0, 0), 1)
	elseif mKey == 6 then pDMBarrageSpiral(math.random(4, 7), 0.4, 1)
	elseif mKey == 7 then pRandomBarrage(math.random(2, 3), 2.25)
	elseif mKey == 8 then pMirrorSpiralDouble(math.random(1, 2), 0)
	elseif mKey == 9 then pMirrorSpiral(math.random(2, 4), 0)
	elseif mKey == 10 then pWallExVortex(0, math.random(3, 3), 1)
	end
end

-- shuffle the keys, and then call them to add all the patterns
-- shuffling is better than randomizing - it guarantees all the patterns will be called
keys = { }
keys = shuffle(keys)
index = 0

-- onInit is an hardcoded function that is called when the level is first loaded
function onInit()
	l_setSpeedMult(0.0001)
	l_setSpeedInc(0.25)
	l_setRotationSpeed(0.1)
	l_setRotationSpeedMax(0.6)
	l_setRotationSpeedInc(0.07)
	l_setDelayMult(1.07)
	l_setDelayInc(0.0)
	l_setFastSpin(71.0)
	l_setSides(3)
	l_setSidesMin(3)
	l_setSidesMax(3)
	l_setIncTime(10)

	l_setPulseMin(1)
	l_setPulseMax(100)
	l_setPulseSpeed(10)
	l_setPulseSpeedR(1.5)
	l_setPulseDelayMax(1)

	l_setBeatPulseMax(0)
	l_setBeatPulseDelayMax(0)

	enableSwapIfDMGreaterThan(1)
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
         addPattern(mKey)
		if mKey == 0 then pAltBarrage(math.random(1, 10), 2) 
	elseif mKey == 1 then pBarrageSpiral(3, 0.6, 1)
	elseif mKey == 2 then pInverseBarrage(0)
	elseif mKey == 3 then pTunnel(math.random(1, 3))
	elseif mKey == 4 then pMirrorWallStrip(1, math.random(0, 1), 0)
	elseif mKey == 5 then pWallExVortex(0, math.random(0, 0), 1)
	elseif mKey == 6 then pDMBarrageSpiral(math.random(4, 7), 0.4, 1)
	elseif mKey == 7 then pRandomBarrage(math.random(2, 3), 2.25)
	elseif mKey == 8 then pMirrorSpiralDouble(math.random(1, 2), 0)
	elseif mKey == 9 then pMirrorSpiral(math.random(2, 4), 0)
	elseif mKey == 10 then pWallExVortex(0, math.random(3, 3), 1)
	
end

-- shuffle the keys, and then call them to add all the patterns
-- shuffling is better than randomizing - it guarantees all the patterns will be called
keys = { 1, 1, 3, 7, 7, 7, 7 }
keys = shuffle(keys)
index = 0

	l_setIncTime(25)
	
	l_setPulseMin(1)
	l_setPulseMax(1)
	l_setPulseSpeed(1)
	l_setPulseSpeedR(1.5)
	l_setPulseDelayMax(1)
	l_setRotationSpeed(0.35)
	l_setSpeedMult(3.35)


end

-- onUnload is an hardcoded function that is called when the level is closed/restarted
function onUnload()
end

-- continuous direction change (even if not on level increment)
dirChangeTime = 100000000000000

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