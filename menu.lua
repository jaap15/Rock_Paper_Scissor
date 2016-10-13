-----------------------------------------------------------------------------------------
--
-- menu.lua
--
-- Authors: Daniel Burris and Jairo Arreola
--
-- This scene is what the user first sees upon starting the game, it simply contains a 
-- background, button which takes them to the level select menu, and shows the authors 
-- of the game.
-----------------------------------------------------------------------------------------

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

    local cloud1 = display.newImage("images/menuClouds.png")
    cloud1.width = display.contentWidth
    cloud1.height = display.contentHeight

    local cloud2 = display.newImage("images/menuClouds.png")
    cloud2.width = display.contentWidth
    cloud2.height = display.contentHeight

    local cloud3 = display.newImage("images/menuClouds.png")
    cloud3.width = display.contentWidth
    cloud3.height = display.contentHeight

    local cloud4 = display.newImage("images/menuClouds.png")
    cloud4.width = display.contentWidth
    cloud4.height = display.contentHeight

    local cloud5 = display.newImage("images/menuClouds.png")
    cloud5.width = display.contentWidth
    cloud5.height = display.contentHeight

    local cloud6 = display.newImage("images/menuClouds.png")
    cloud6.width = display.contentWidth
    cloud6.height = display.contentHeight

    -- Game Title
    local menuTitle = display.newImage("images/menuTitle.png")
    menuTitle.width = display.contentWidth
    menuTitle.height = display.contentHeight

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
    menuTitle.x = display.contentCenterX
    menuTitle.y = display.contentCenterY
    cloud1.x = display.contentCenterX 
    cloud1.y = display.contentHeight
    cloud2.x = display.contentWidth
    cloud2.y = display.contentCenterY
    cloud3.x = display.contentCenterX
    cloud3.y = display.contentCenterY - 150
    cloud4.x = display.contentCenterX + 150
    cloud4.y = display.contentCenterY + 150
    cloud5.x = display.contentCenterX - 50
    cloud5.y = display.contentCenterY
    cloud6.x = display.contentCenterX + 175
    cloud6.y = display.contentCenterY - 175
    authors.x = display.contentCenterX
    authors.y = display.contentCenterY+(display.contentCenterY/1.2)
    startButton.x = display.contentCenterX
    startButton.y = display.contentCenterY+(display.contentCenterY/1.9)

    -- Adding all objects to the scene group, this will bind these object to the scene
    -- and they will be removed / replaced when switching to and from scenes
    sceneGroup:insert( cloud1 )
    sceneGroup:insert( cloud2 )
    sceneGroup:insert( cloud3 )
    sceneGroup:insert( cloud4 )
    sceneGroup:insert( cloud5 )
    sceneGroup:insert( cloud6 )
    sceneGroup:insert( menuTitle )
    sceneGroup:insert( authors )
    sceneGroup:insert( startButton )
    
end


-- show()
--      input: none
--      output: none
--
--      This function destroys the level select, level complete, and level 1-3 scenes when its
--      in the menu scene, this is to prevent any unseen errors with timers or delays from executing
--      while in the menu scene.
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
        -- Game Background
        display.setDefault("background", 0, 0, 1)

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