-- include useful files
u_execScript("utils.lua")
u_execScript("common.lua")
u_execScript("commonpatterns.lua")

-- this function adds a pattern to the timeline based on a key
function addPattern(mKey)

	if mKey == 1 then pMirrorSpiralDouble(math.random(1, 2), 4)
	end
end

-- shuffle the keys, and then call them to add all the patterns
-- shuffling is better than randomizing - it guarantees all the patterns will be called
keys = { 1, 1 }
keys = shuffle(keys)
index = 0

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

-- onInit is an hardcoded function that is called when the level is first loaded
function onInit()
	l_setSpeedMult(4)
	l_setSpeedInc(0.10)
	l_setRotationSpeed(0.65)
	l_setRotationSpeedMax(1.3)
	l_setRotationSpeedInc(0.2)
	l_setDelayMult(1.0)
	l_setDelayInc(-0.01)
	l_setFastSpin(80.0)
	l_setSides(24)
	l_setSidesMin(20)
	l_setSidesMax(28)
	l_setIncTime(15)

	l_setPulseMin(68)
	l_setPulseMax(80)
	l_setPulseSpeed(3.6)
	l_setPulseSpeedR(1.4)
	l_setPulseDelayMax(7)

	l_setBeatPulseMax(15)
	l_setBeatPulseDelayMax(21.8)
end

-- onIncrement is an hardcoded function that is called when the level difficulty is incremented
function onIncrement()
end

-- onUnload is an hardcoded function that is called when the level is closed/restarted
function onUnload()
end

-- continuous direction change (even if not on level increment)
dirChangeTime = 150

-- onUpdate is an hardcoded function that is called every frame
function onUpdate(mFrameTime)
	dirChangeTime = dirChangeTime - mFrameTime;
	if dirChangeTime < 0 then
		-- do not change direction while fast spinning
		if u_isFastSpinning() == false then
			l_setRotationSpeed(l_getRotationSpeed() * -1.0)
			dirChangeTime = 100
		end
	end 
end