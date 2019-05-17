UserInterface = newclass("UserInterface")

function UserInterface:init()
 local WINDOW_WIDTH = 300
  local WINDOW_HEIGHT = 500
  local EDGE_OFFSET = 4
  local EDGE_OFFSET_L = EDGE_OFFSET + 10
  local ITEM_HEIGHT = 20
  local ITEM_WIDTH = WINDOW_WIDTH - 2 * EDGE_OFFSET
  local TOTAL_ITEM_HEIGHT = ITEM_HEIGHT + EDGE_OFFSET
  local UI_START = 20 + EDGE_OFFSET
  
  self.mainWindow = GuiWindow(100,100,WINDOW_WIDTH,WINDOW_HEIGHT,"ANoniem's - Radar create tool",false)
  
      GuiLabel(EDGE_OFFSET_L ,  EDGE_OFFSET           , ITEM_WIDTH, ITEM_HEIGHT,"Zoommnmmmmmmmmmmmmmmm:",false,self.mainWindow)
  self.zoomScroll = 
  guiCreateScrollBar( EDGE_OFFSET,  UI_START + TOTAL_ITEM_HEIGHT  , ITEM_WIDTH, ITEM_HEIGHT,true,false,self.mainWindow)
  guiScrollBarSetScrollPosition(self.zoomScroll, map(2.0, 0.5, 10.0, 0, 100))
  
      GuiLabel(EDGE_OFFSET_L ,  UI_START + 2 * TOTAL_ITEM_HEIGHT, ITEM_WIDTH, ITEM_HEIGHT,"Far clip:",false,self.mainWindow)
  self.farScroll = 
  guiCreateScrollBar( EDGE_OFFSET,  UI_START + 3 * TOTAL_ITEM_HEIGHT, ITEM_WIDTH, ITEM_HEIGHT,true,false,self.mainWindow)  
  guiScrollBarSetScrollPosition(self.farScroll, map(1000.0, 100, 2000, 0, 100 ))
      
      GuiLabel(EDGE_OFFSET_L ,  UI_START + 4 * TOTAL_ITEM_HEIGHT, ITEM_WIDTH, ITEM_HEIGHT,"Near clip:",false,self.mainWindow)
  self.nearScroll = 
  guiCreateScrollBar( EDGE_OFFSET,  UI_START + 5 * TOTAL_ITEM_HEIGHT, ITEM_WIDTH, ITEM_HEIGHT,true,false,self.mainWindow)
  guiScrollBarSetScrollPosition(self.nearScroll, map(2.0, -100, 100, 0, 100))
  
      GuiLabel(EDGE_OFFSET_L ,  UI_START + 6 * TOTAL_ITEM_HEIGHT, ITEM_WIDTH, ITEM_HEIGHT,"Saturation:",false,self.mainWindow)
  self.saturationScroll = 
  guiCreateScrollBar( EDGE_OFFSET,  UI_START + 7 * TOTAL_ITEM_HEIGHT, ITEM_WIDTH, ITEM_HEIGHT,true,false,self.mainWindow)
  guiScrollBarSetScrollPosition(self.saturationScroll, map(1.0, -6, 6, 0, 100))
  
  self.checkLighting = 
    GuiCheckBox(  EDGE_OFFSET,  UI_START + 8 * TOTAL_ITEM_HEIGHT, ITEM_WIDTH, ITEM_HEIGHT,"Lighting",true,false,self.mainWindow)
  self.checkAverageTexColor = 
    GuiCheckBox(  EDGE_OFFSET,  UI_START + 9 * TOTAL_ITEM_HEIGHT, ITEM_WIDTH, ITEM_HEIGHT,"Equal color (Might not work with textures with alpha)",false,false,self.mainWindow)
  self.checkEdgeFade = 
    GuiCheckBox(  EDGE_OFFSET,  UI_START + 10 * TOTAL_ITEM_HEIGHT,  ITEM_WIDTH, ITEM_HEIGHT,"Fade radar edge to alpha",false,false,self.mainWindow)
  self.checkOneTexture =
    GuiCheckBox(  EDGE_OFFSET,  UI_START + 11 * TOTAL_ITEM_HEIGHT,  ITEM_WIDTH, ITEM_HEIGHT,"Output as one texture",false,false,self.mainWindow)
  
  self.qualityComboBox = 
    GuiComboBox(  EDGE_OFFSET,  UI_START + 12 * TOTAL_ITEM_HEIGHT,  ITEM_WIDTH, ITEM_HEIGHT,"Output Quality",false,self.mainWindow)
  self.qualityComboBox:addItem("4 units : 1 pixel (default)")
  self.qualityComboBox:addItem("2 units : 1 pixel")
  self.qualityComboBox:addItem("1 units : 1 pixel")
  self.qualityComboBox:addItem("1 units : 2 pixel")
  self.qualityComboBox:setSelected(0) --Select the first item.
  
      GuiLabel(EDGE_OFFSET_L ,  UI_START + 13 * TOTAL_ITEM_HEIGHT,  ITEM_WIDTH, ITEM_HEIGHT,"Top-Left corner of map:",false,self.mainWindow)
  self.buttonTopLeft = 
      GuiButton(  EDGE_OFFSET,  UI_START + 14 * TOTAL_ITEM_HEIGHT,  ITEM_WIDTH, ITEM_HEIGHT,"Set to current position",false,self.mainWindow)
      GuiLabel(EDGE_OFFSET_L ,  UI_START + 15 * TOTAL_ITEM_HEIGHT,  ITEM_WIDTH, ITEM_HEIGHT,"Bottom-Right corner of map:",false,self.mainWindow)
  self.buttonBottomRight = 
      GuiButton(  EDGE_OFFSET,  UI_START + 16 * TOTAL_ITEM_HEIGHT,  ITEM_WIDTH, ITEM_HEIGHT,"Set to current position",false,self.mainWindow)
  self.buttonStart = 
      GuiButton(  EDGE_OFFSET,  UI_START + 17 * TOTAL_ITEM_HEIGHT,  ITEM_WIDTH, ITEM_HEIGHT,"Create map",false,self.mainWindow)
end

addEventHandler("onClientGUIClick", self.checkLighting, 
function(button) 
  if(button == "left") then
    --dxSetShaderValue( viewShader, "uLighting", self.checkLighting:getSelected())
  end
end, 
false)

addEventHandler("onClientGUIClick", checkAverageTexColor, 
function(button) 
  if(button == "left") then
    --dxSetShaderValue( viewShader, "uEqualColor", self.checkAverageTexColor:getSelected())
  end
end, 
false)

addEventHandler("onClientGUIClick", self.buttonTopLeft, 
function(button) 
  if(button == "left") then
    local x,y,z = getElementPosition(getLocalPlayer())    
    self.buttonTopLeft:setText(string.format("x: %.2f y: %.2f z: %.2f", x,y,z))
  end
end, 
false)

addEventHandler("onClientGUIClick", self.buttonStart, 
function(button) 
  if(button == "left") then
    syncCamera()
  end
end, 
false)

addEventHandler("onClientGUIClick", self.buttonBottomRight, 
function(button) 
  if(button == "left") then
    local x,y,z = getElementPosition(getLocalPlayer())
    self.buttonBottomRight:setText(string.format("x: %.2f y: %.2f z: %.2f", x,y,z))
  end
end, 
false)

addEventHandler ( "onClientGUIComboBoxAccepted", guiRoot,
  function ( comboBox )
  if(comboBox == self.qualityComboBox) then
    local selectedIndex = self.qualityComboBox:getSelected()
  end
end
)

--Scroll callback.
addEventHandler( "onClientGUIScroll", root, function()
  if(source == self.zoomScroll) then
    GlobalViewShader:setZoom(map(guiScrollBarGetScrollPosition(source), 0, 100, 0.5, 10.0))
  elseif(source == self.nearScroll) then
    GlobalViewShader:setNearClip(map(guiScrollBarGetScrollPosition(source), 0, 100, -20, 1))
  elseif(source == self.farScroll) then
    GlobalViewShader:setFarClip(map(guiScrollBarGetScrollPosition(source), 0, 100, 100, 2000))
  elseif(source == self.saturationScroll) then
    GlobalViewShader:setSaturation(map(guiScrollBarGetScrollPosition(source), 0, 100, -6, 6))
  end
end
)