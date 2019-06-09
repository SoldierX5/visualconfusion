-- include useful files
u_execScript("utils.lua")
u_execScript("common.lua")
u_execScript("commonpatterns.lua")
u_execScript("nextpatterns.lua")
u_execScript("evolutionpatterns.lua")

-- this function adds a pattern to the timeline based on a key
function addPattern(mKey) 
		if mKey == 1 then pMirrorSpiralDouble(math.random(1, 2), 2)
	elseif mKey == 2 then pMirrorWallStrip(2, math.random(22, 23), 0)
	elseif mKey == 3 then pMirrorWallStrip(3, math.random(22, 25), 3)
	elseif mKey == 4 then pWallExVortex(1, math.random(1, 5), 22)
	end
end

-- shuffle the keys, and then call them to add all the patterns
-- shuffling is better than randomizing - it guarantees all the patterns will be called
keys = { 1, 2, 2, 2, 2, 3, 3, 3, 4, 4, 4 }
keys = shuffle(keys)
index = 0

special = "none"

-- onInit is an hardcoded function that is called when the level is first loaded
function onInit()
	l_setSpeedMult(3)
	l_setSpeedInc(0.04)
	l_setRotationSpeed(0.01)
	l_setRotationSpeedMax(0.9)
	l_setRotationSpeedInc(0.5)
	l_setDelayMult(1.35)
	l_setDelayInc(0.0)
	l_setFastSpin(71.0)
	l_setSides(64)
	l_setSidesMin(64)
	l_setSidesMax(64)
	l_setIncTime(45)

	l_setPulseMin(1)
	l_setPulseMax(1)
	l_setPulseSpeed(1)
	l_setPulseSpeedR(1)
	l_setPulseDelayMax(1)

	l_setBeatPulseMax(1)
	l_setBeatPulseDelayMax(20)

	l_setSwapEnabled(false)
end

-- onLoad is an hardcoded function that is called when the level is started/restarted
function onLoad()
	setCurveMult(0.85)
	m_messageAddImportant("Running system diagnostic...", 140)
	e_eventWaitS(10)
	m_messageAddImportant("Identifying parameters...", 180)
	e_eventWaitS(10)
	m_messageAddImportant("Calculating orbital trajectory...", 180)
	e_eventWaitS(15)
	m_messageAddImportant("All systems nominal. Prepare for launch.", 300)	
	e_eventWaitS(258)
	
	m_messageAddImportant("Congratulations Captain, you did it! \nFiring up the warpdrive to \nthe nearest planetary body.", 450)
	m_messageAddImportant("You can now continue playing the \nlevel for a higher score, \nif you so desire...", 400)
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
	e_eventWaitS(45) 
	l_setIncTime(15)
	l_setPulseSpeed(10)
	l_setPulseMin(70)
	l_setPulseMax(100)
	l_setPulseSpeedR(0.6)
	l_setRotationSpeedInc(0.001)
	l_setBeatPulseMax(20)
	
	e_eventWaitS(15)
	l_setIncTime(1000)
	l_setPulseSpeed(20)
	l_setPulseMin(100)
	l_setPulseMax(170)
	l_setPulseSpeedR(0.7)
	l_setBeatPulseMax(34)
end

-- continuous direction change (even if not on level increment)
dirChangeTime = 1000

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