function map(x, in_min, in_max, out_min, out_max) 
  return (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min
end

SCREEN_WIDTH, SCREEN_HEIGHT = guiGetScreenSize()

GlobalViewShader = ViewShader()
GlobalRadarCreate = RadarCreate()
GlobalUI = UserInterface()

function main()
  --setCameraTarget(getLocalPlayer())
  setCloudsEnabled(false)
  setFogDistance(1000)
  setFarClipDistance(1000)
  setHeatHaze(0)
  GlobalRadarCreate:syncCamera()
end
addCommandHandler("shader", function() GlobalViewShader:toggleShader() end)
addEventHandler ( "onClientResourceStart", getResourceRootElement(getThisResource()), main)