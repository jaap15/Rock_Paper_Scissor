-----------------------------------------------------------------------------------------
--
-- level_select.lua
--
-- Authors: Daniel Burris and Jairo Arreola
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
alexScore = 0;
currentLevel = 0;
enemyScore = 0;

function resetScoreboard(level)
    alexScore = 0;
    currentLevel = level;
    enemyScore = 0;
end

local function levelOneButtonEvent(event)
    if ("ended" == event.phase) then
        resetScoreboard(1)
        updateScoreBoard()
        composer.gotoScene("level_1")
    end
end

local function levelTwoButtonEvent(event)
    if ("ended" == event.phase) then
        resetScoreboard(2)
        updateScoreBoard()
        composer.gotoScene("level_2")
    end
end

local function levelThreeButtonEvent(event)
    if ("ended" == event.phase) then
        resetScoreboard(3)
        composer.gotoScene("level_3")
    end
end

local function returnButtonEvent(event)
    if ("ended" == event.phase) then
        composer.gotoScene("menu")
    end
end

-- updateScoreBoard()
--      input: none
--      output: none
--
--      This global function updats the score board shown at the top of the game scene. It is 
--      updated with simple string.format functionality.
function updateScoreBoard()
    scoreText.text = string.format("ALEX: %01d  LEVEL: %01d  ENEMY: %01d", alexScore, currentLevel, enemyScore)
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

    -- This is the text that represents the scoreboard to the player
    scoreText = display.newText(" ", 0, 0, native.systemFont)
    scoreText:setTextColor(235, 235, 235)

    -- Game Background
    local menuBG = display.newImage("images/menuBG.jpg")
    menuBG.width = display.contentWidth
    menuBG.height = display.pixelWidth    

    local levelOneButton = widget.newButton({    
        id = "levelOneButton",
        label = "Level 1",    
        width = 100,
        height = 20,
        fontSize = 10,
        defaultFile = "images/button.png",
        onEvent = levelOneButtonEvent
    } )  

    local levelTwoButton = widget.newButton({    
        id = "levelTwoButton",
        label = "Level 2",    
        width = 100,
        height = 20,
        fontSize = 10,
        defaultFile = "images/button.png",
        onEvent = levelTwoButtonEvent
    } ) 

    local levelThreeButton = widget.newButton({    
        id = "levelThreeButton",
        label = "Level 3",    
        width = 100,
        height = 20,
        fontSize = 10,
        defaultFile = "images/button.png",
        onEvent = levelThreeButtonEvent
    } )

    local returnButton = widget.newButton({    
        id = "returnButton",
        label = "Return to Menu",    
        width = 100,
        height = 20,
        fontSize = 10,
        defaultFile = "images/button.png",
        onEvent = returnButtonEvent
    } )

    -- Positioning all objects on the screen
    menuBG.x = display.contentCenterX
    menuBG.y = display.contentCenterY 
    levelOneButton.x = display.contentCenterX
    levelOneButton.y = display.contentCenterY - 50
    levelTwoButton.x = display.contentCenterX
    levelTwoButton.y = display.contentCenterY
    levelThreeButton.x = display.contentCenterX
    levelThreeButton.y = display.contentCenterY + 50
    returnButton.x = display.contentCenterX
    returnButton.y = display.contentCenterY + 100


    -- Adding all objects to the scene group, this will bind these object to the scene
    -- and they will be removed / replaced when switching to and from scenes
    sceneGroup:insert( menuBG )
    sceneGroup:insert( levelOneButton )
    sceneGroup:insert( levelTwoButton )
    sceneGroup:insert( levelThreeButton )
    sceneGroup:insert( returnButton )
    
    
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