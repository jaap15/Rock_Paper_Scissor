-----------------------------------------------------------------------------------------
--
-- level_2.lua
--
-- Authors: Daniel Burris and Jairo Arreola
-----------------------------------------------------------------------------------------

local composer = require("composer")

-- Scene Creation / Manipulation
local scene = composer.newScene()

-- Widget Creation / Manipulation
-- Used for buttons, sliders, radio buttons
local widget = require("widget")

local sheetName = require("sprite_data")

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
local alex;
local bubble;
local bubbleCount = 0;
local janken;
local countDownTimer;
local decisionTimer;
local timerText;
local bubbleClickable = false
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
local function bubbleTapListener( event )
    print("BubbleCount before ++: " .. bubbleCount)
    bubbleCount = bubbleCount + 1
    if(bubbleCount == 1) then
        bubble:setSequence("bubble_scissor");
        bubble:play();
    elseif (bubbleCount == 2) then
        bubble:setSequence("bubble_paper");
        bubble:play();
    else
        bubbleCount = 0;
        bubble:setSequence("bubble_rock");
        bubble:play();
    end

end
-- create()
--      input: none
--      output: none
--
--      This function creates all the objects that will be used in the scene and adds
--      them to the scene group.
function scene:create( event )

    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen  

     -----------------------------background--------------------------------
    local bgOptions = sheetName:getBgOptions()
    local bgSheet = graphics.newImageSheet( "images/bg.png", bgOptions );
    local bg = display.newImage (bgSheet, 2);
    -- print(bgOptions.frames[1].height)

    -----------------------------Alex Kidd--------------------------------
    local alexOptions = sheetName:getAlexOptions()
    local alexSequenceData = sheetName:getAlexSequenceData()
    local alexSheet = graphics.newImageSheet( "images/alex.png", alexOptions );
    alex = display.newSprite (alexSheet, alexSequenceData); 

    -----------------------------Bubble--------------------------------
    local bubbleSequenceData = sheetName:getBubbleSequenceData()
    bubble = display.newSprite (alexSheet, bubbleSequenceData);
    bubble:addEventListener( "tap", bubbleTapListener )

    -----------------------------Janken--------------------------------
    local jankenOptions = sheetName:getJankenOptions()
    local jankenSequenceData = sheetName:getJankenSequenceData()
    local jankenSheet = graphics.newImageSheet( "images/enemy.png", jankenOptions );
    janken = display.newSprite (jankenSheet, jankenSequenceData);
    janken:setSequence("enemy2_set");

    -- This is the countdown timer text seen after pressing the ready button at the beginning
    timerText = display.newText(" ", 0, 0, native.systemFont, 30)
    timerText:setTextColor(0, 0, 0)

    -- -- Positioning all objects on the screen
    bg.x = display.contentWidth / 2;
    bg.y= display.contentHeight / 2;
    alex.x = display.contentCenterX-80; 
    alex.y = display.contentCenterY+66; 
    bubble.x = display.contentCenterX-90; 
    bubble.y = display.contentCenterY+26; 
    janken.x = display.contentCenterX+80;
    janken.y = display.contentCenterY+66;
    timerText.x = display.contentCenterX     
    timerText.y = display.contentCenterY
    scoreText.x = display.contentCenterX
    scoreText.y = display.contentHeight / 2 - bgOptions.frames[1].height/1.8

    -- Setting Anchor
    alex.anchorX = 0; 
    alex.anchorY = 1; 
    bubble.anchorX = 0; 
    bubble.anchorY = 1;
    janken.anchorX = 1;
    janken.anchorY = 1;

    -- Setting Scale
    bubble.xScale = 1.2
    bubble.yScale = 1.2

    -- Adding all objects to the scene group, this will bind these object to the scene
    -- and they will be removed / replaced when switching to and from scenes
    sceneGroup:insert( bg )
    sceneGroup:insert( alex )
    sceneGroup:insert( bubble )
    sceneGroup:insert( janken )
    sceneGroup:insert( timerText )
    
end


-- show()
--      input: none
--      output: none
--
--      This function destroys the game scenes when its swapped to the menu scene
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
        bubbleCount = 0;
        bubble:setSequence("bubble_rock");
        bubble.isVisible = true

    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
        -- startCountdown()

    end
end


-- hide()
--      input: none
--      output: none
--
--      This function does nothing for us, but is still part of Corona SDK scene creation requirements
function scene:hide( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)

    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
    end
end


-- destroy()
--      input: none
--      output: none
--
--      This function does nothing for us, but is still part of Corona SDK scene creation requirements
function scene:destroy( event )

    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view

end


-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene