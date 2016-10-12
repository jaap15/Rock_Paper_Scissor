-----------------------------------------------------------------------------------------
--
-- menu.lua
--
-- Authors: Daniel Burris and Jairo Arreola
--
-- This scene is what the user first sees upon starting the game, it simply contains a 
-- button which takes them to the level select menu and shows the authors of the game.
-----------------------------------------------------------------------------------------

-- Composer object is used for the creation and manipulation of scenes
local composer = require("composer")

-- Scene Creation / Manipulation
local scene = composer.newScene()

-- Widget Creation / Manipulation
-- Used for buttons, sliders, radio buttons
local widget = require("widget")

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

-- startButtonEvent()
--      input: none
--      output: none
--      
--      This function just switches from the menu scene to the level select scene
local function startButtonEvent(event)
    if ("ended" == event.phase) then
        composer.gotoScene("level_select")
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

    -- Game Background
    local menuBG = display.newImage("images/menuBG.jpg")
    menuBG.width = display.contentWidth
    menuBG.height = display.pixelWidth

    -- Text to display developers of the game
    authors = display.newText("by Daniel Burris and Jairo Arreola", display.contentCenterX, display.contentCenterY+(display.contentCenterY/1.2))

    -- Creating the start button, sends us from the menu scene to the level select scene
    local startButton = widget.newButton({    
            id = "startButton",
            label = "Start",    
            width = 100,
            height = 20,
            fontSize = 10,
            defaultFile = "images/button.png",
            onEvent = startButtonEvent 
        } )   

    -- Positioning all objects on the screen
    menuBG.x = display.contentCenterX
    menuBG.y = display.contentCenterY  
    authors.x = display.contentCenterX
    authors.y = display.contentCenterY+(display.contentCenterY/1.2)
    startButton.x = display.contentCenterX
    startButton.y = display.contentCenterY+(display.contentCenterY/1.9)

    -- Adding all objects to the scene group, this will bind these object to the scene
    -- and they will be removed / replaced when switching to and from scenes
    sceneGroup:insert( menuBG )
    sceneGroup:insert( authors )
    sceneGroup:insert( startButton )
    
end


-- show()
--      input: none
--      output: none
--
--      This function destroys the level select, level select, and level 1-3 scenes when its
--      in the menu scene
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)

    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
        composer.removeScene("level_select")
        composer.removeScene("level_complete")
        composer.removeScene("level_1")
        composer.removeScene("level_2")
        composer.removeScene("level_3")


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