-- include useful files
u_execScript("utils.lua")
u_execScript("common.lua")
u_execScript("commonpatterns.lua")
u_execScript("nextpatterns.lua")
u_execScript("evolutionpatterns.lua")

-- this function adds a pattern to the timeline based on a key
function addPattern(mKey)
		if mKey == 0 then pAltBarrage(math.random(1, 10), 2) 
	elseif mKey == 1 then pBarrageSpiral(3, 0.6, 1)
	elseif mKey == 2 then pInverseBarrage(0)
	elseif mKey == 3 then pTunnel(math.random(1, 5))
	elseif mKey == 4 then pMirrorWallStrip(1, math.random(1, 1), 0)
	elseif mKey == 5 then pWallExVortex(0, math.random(0, 0), 1)
	elseif mKey == 6 then pDMBarrageSpiral(math.random(4, 7), 0.4, 1)
	elseif mKey == 8 then pMirrorSpiralDouble(math.random(1, 2), 0)
	elseif mKey == 9 then pMirrorSpiral(math.random(2, 4), 0)
	elseif mKey == 10 then pWallExVortex(0, math.random(3, 3), 1)
	elseif mKey == 11 then hmcDefSpinner()
	elseif mKey == 12 then hmcDefBarrageSpiral()
	elseif mKey == 13 then hmcDef2CageD()
	elseif mKey == 15 then hmcDefSpinnerSpiralAcc()
	elseif mKey == 16 then hmcDefBarrageSpiralRnd()
	elseif mKey == 17 then hmcDefBarrageInv()
	end
end

-- shuffle the keys, and then call them to add all the patterns
-- shuffling is better than randomizing - it guarantees all the patterns will be called
keys = { 0, 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 8, 10, 10, 11, 11, 12, 13, 13, 13, 15, 15, 15, 15 }
keys = shuffle(keys)
index = 0

-- onInit is an hardcoded function that is called when the level is first loaded
function onInit()
	l_setSpeedMult(3.65)
	l_setSpeedInc(0.00425)
	l_setRotationSpeed(0.3)
	l_setRotationSpeedMax(0.8)
	l_setRotationSpeedInc(-0.9)
	l_setDelayMult(1.07)
	l_setDelayInc(0.0)
	l_setFastSpin(71.0)
	l_setSides(6)
	l_setSidesMin(6)
	l_setSidesMax(6)
	l_setIncTime(3)

	l_setPulseMin(64)
	l_setPulseMax(100)
	l_setPulseSpeed(18.0)
	l_setPulseSpeedR(1.5)
	l_setPulseDelayMax(9)

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