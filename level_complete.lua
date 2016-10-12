-----------------------------------------------------------------------------------------
--
-- level_complete.lua
--
-- Authors: Daniel Burris and Jairo Arreola
--
-- This is level complete scene, it is only reachable by successfully beating the boss level
-- (level 3). It is more of a congratulations screen than a level as it appears after the 
-- player has beaten the game.
-----------------------------------------------------------------------------------------

local composer = require("composer")
local scene = composer.newScene()
local widget = require("widget")

-- Loading our sprite_data.lua file 
local sheetName = require("sprite_data")

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

-- exitToMenu()
--      input: none
--      output: none
--      
--      This function just switches from the level_complete scene to the menu scene
local function exitToMenu(event)
    if ("ended" == event.phase) then
        composer.gotoScene("menu")
    end
end

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
--      input: none
--      output: none
--
--      This function creates all the objects that will be used in the scene and adds
--      them to the scene group.
function scene:create( event )

    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen   

    -- Game Background for level complete
    local bgOptions = sheetName:getBgOptions()
    local bgSheet = graphics.newImageSheet( "images/bg.png", bgOptions );
    local bg = display.newImage (bgSheet, 4);

    -- Text congratulating the player for winning! Thanking them for playing! and giving credit to sprite sheet makers
    local msg1 = display.newText("Congratulations! You defeated Janken!", display.contentCenterX, display.contentCenterY-(display.contentCenterY/1.1))
    local msg2 = display.newText("Thanks for playing!", display.contentCenterX, display.contentCenterY-(display.contentCenterY/1.2))
    local msg3 = display.newText("Credit for all sprites used:", display.contentCenterX, display.contentCenterY-(display.contentCenterY/2.2))

    -- Creating the backToMenuButton button, sends us from the level_complete scene to the menu scene
    local backToMenuButton = widget.newButton({    
            id = "backToMenuButton",
            label = "Menu",    
            width = 100,
            height = 20,
            fontSize = 10,
            defaultFile = "images/button.png",
            onEvent = exitToMenu
        } )   

    -- Positioning all objects on the screen
    bg.x = display.contentWidth / 2;
    bg.y= display.contentHeight / 2;
    backToMenuButton.x = display.contentCenterX
    backToMenuButton.y = display.contentCenterY+(display.contentCenterY/1.9)

    -- Adding all objects to the scene group, this will bind these object to the scene
    -- and they will be removed / replaced when switching to and from scenes
    sceneGroup:insert( bg )
    sceneGroup:insert( msg1 )
    sceneGroup:insert( msg2 )
    sceneGroup:insert( msg3 )
    sceneGroup:insert( backToMenuButton )
    
end


-- show()
--      input: none
--      output: none
--
--      This function does nothing for us, but is still part of Corona SDK scene creation requirements
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)

    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen

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
        composer.removeScene("menu")

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