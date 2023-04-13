-- Wing Behaviour:
-- when its >114km/h wing goes up, airbrake function is active
-- when its <114km/h, wing goes down, airbrake function is inactive
-- BUT when you brake at over 114km/h the airbrake+wing are active until you stop braking, then they go down if its under 114km/h

-- Test cases to validate script:
-- Go over 114km/h and stop braking under 114km/h: Wing should be up and airbrake should work, then the wing should go down
-- Go over 114km/h and stop braking over 114km/h: Wing should be up and airbrake should work, then the wing should remain up
-- Go under 114km/h and brake: Wing should be down and airbrake should be off

local airBrake = false
local wingActive = false
local airBrakeKeyFrame = 0 --used to control animations
local wingKeyFrame = 0
local airBrakeDone = true
local timeDelayDefaultValue = 0.5 --delay for wing to go down (seconds)
local timeDelay = 0.5 --delay for wing to go down (seconds)
local wingSpeedMult = 2 -- multiplier for animation speed
local brakeSpeedMult = 4 -- multiplier for brake animation speed
local wingOnAero = { -- get from aero.ini
  id = 3,
  gainCD = 0,
  gainCL = 1,
}
local wingOffAero = { -- get from aero.ini
  id = 3,
  gainCD = 0,
  gainCL = 1,
}

function isWingUp()
  return car.speedKmh > 114 or car.extraC -- always override with extraC, if on
end

function WingBehaviour(dt)
  if isWingUp() and car.brake > 0 then
    -- ac.log("case_1 - brake with airbrake & wing up")
    airBrake = true
    wingActive = true
    timeDelay = timeDelayDefaultValue
  elseif isWingUp() then
    -- ac.log("case_2 - brake without airbrake & wing up")
    airBrake = false
    wingActive = true
  elseif car.speedKmh < 114 and car.brake == 0 then
    -- ac.log("case_3 - turning airbrake off after braking from speed threshold")
    airBrake = false
    if airBrakeDone then
      wingActive = WaitHalfSecond(dt) or car.extraC -- always override with extraC, if on
    end
  end
end

function WaitHalfSecond(dt)
  if timeDelay ~= 0 then
    --ac.log("delay_on")
    timeDelay = math.max(0,timeDelay - dt)
    return true
  else
    return false
  end
end


local carNode = ac.findNodes('carRoot:0') -- getting car node
local wingAnim = ac.getFolder(ac.FolderID.ContentCars) .. '/' .. ac.getCarID(0) .. '/animations/wing.ksanim'  -- loading animations
local airBrakeAnim = ac.getFolder(ac.FolderID.ContentCars) .. '/' .. ac.getCarID(0) .. '/animations/wing_brake.ksanim' 

function WingAnimationBehaviour(dt)
  if wingActive then
    wingKeyFrame = math.min(1,wingKeyFrame + (wingSpeedMult*dt))
  else
    wingKeyFrame = math.max(0, wingKeyFrame - (wingSpeedMult*dt))
  end
  if airBrake then
    airBrakeKeyFrame = math.min(1,airBrakeKeyFrame + (brakeSpeedMult*dt))
    if airBrakeKeyFrame <= 1 then
      airBrakeDone = true
    else
      airBrakeDone = false
    end
  else
    airBrakeKeyFrame = math.max(0, airBrakeKeyFrame - (brakeSpeedMult*dt))
  end
  carNode:setAnimation(wingAnim, wingKeyFrame)
  carNode:setAnimation(airBrakeAnim, airBrakeKeyFrame)
end

function WingPhysicsBehaviour()
  if wingActive then
    ac.setWingGain(wingOnAero.id, wingOnAero.gainCD, wingOnAero.gainCL)
  else
    ac.setWingGain(wingOffAero.id, wingOffAero.gainCD, wingOffAero.gainCL)
  end
end

function script.update(dt)
  WingBehaviour(dt)
  WingAnimationBehaviour(dt)
end