-----------------------------------------------------------------------------------------
--
-- level_3.lua
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
local alex = 0;
local bubble = 0;
local bubbleCount = 0;
local janken = 0;
local jankenHand = 0;
local secondsLeft = 4
local countDownTimer = 0;
local decisionTimer = 0;
local timerText;
local messageText;
local startGame = false
local startGameTimer;
local winner = " ";

local function nextLevel(event)
    resetScoreboard(0)
    scoreText.text = " "
    composer.gotoScene("level_complete")
end

local function exitToMenu(event)
    resetScoreboard(0)
    scoreText.text = " "
    composer.gotoScene("menu")
end


-- updateTime()
--      input: none
--      output: none
--
--      This function is our 3 second countdown timer. It is called every second and updates
--      the text in the middle of the scene when secondsLeft is above 0. When there is no time left
--      we start the game by calling play().
local function updateTime()

    -- If countdown timer is still running decrement countdown timer and display it
    -- else remove the timer and play()
    messageText.isVisible = false
    timerText.isVisible = true
    startGame = false

    if (secondsLeft > 0) then
        secondsLeft = secondsLeft - 1 
        timeDisplay = string.format("%01d", secondsLeft)
        timerText.text = timeDisplay
    else
        secondsLeft = 4
        timerText.isVisible = false
        startGame = true
    end
end

local function startCountdown()
    jankenHand.isVisible = false
    janken:setSequence("enemy3_shake");
    countDownTimer = timer.performWithDelay( 1000, updateTime, 5 )
end

local function contGame(event)
    startGame = false
    timer.resume( startGameTimer )
    startCountdown()
end

local function findWinner(player, enemy)
    messageText.isVisible = false
    if (player == 0 and enemy == 1) then
        alexScore = alexScore + 1
        updateScoreBoard()
        messageText.text = "Alex wins!"
    elseif (player == 0 and enemy == 2) then
        enemyScore = enemyScore + 1
        updateScoreBoard()
        messageText.text = "Enemy wins!"
    elseif (player == 1 and enemy == 0) then
        enemyScore = enemyScore + 1
        updateScoreBoard()
        messageText.text = "Enemy wins!"
    elseif (player == 1 and enemy == 2) then
        alexScore = alexScore + 1
        updateScoreBoard()
        messageText.text = "Alex wins!"
    elseif (player == 2 and enemy == 0) then
        alexScore = alexScore + 1
        updateScoreBoard()
        messageText.text = "Alex wins!"
    elseif (player == 2 and enemy == 1) then
        enemyScore = enemyScore + 1
        updateScoreBoard()
        messageText.text = "Enemy wins!"
    else
        messageText.text = "Tie!"
    end

    if(alexScore > 1 and enemyScore < 2 ) then
        print("winner of level is Alex")
        winner = "Alex";
        timer.cancel( startGameTimer )
        native.showAlert("Winner!", "Go to end Scene", {"End Scene"}, nextLevel)
    elseif (alexScore < 2 and enemyScore > 1) then
        print("Winner of level is Enemy")
        winner = "Enemy";
        timer.cancel( startGameTimer )
        native.showAlert("Game Over!", "You lost", {"Exit to Menu"}, exitToMenu)
    else
        print("Game is still going on")
        winner = " ";
        native.showAlert("Game!", messageText.text, {"Resume"}, contGame)
    end
end

local function checkHands()
    print("time up ")
    bubble.isVisible = false
    alex = setSpriteHandSequence(alex, "alex", bubbleCount)

    enemyChoice = math.random(0, 2)
    print("enemy's choice: " .. enemyChoice)
    jankenHand = setSpriteHandSequence(jankenHand, "enemy".. currentLevel, enemyChoice)
    janken:setSequence( "enemy3_set" )
    jankenHand.isVisible = true
    findWinner(bubbleCount, enemyChoice)
end

local function play()
    decisionTimer = timer.performWithDelay( 5000, checkHands, 1 )
    alex:setSequence ("alex_shake");
    alex:play();

    janken:setSequence("enemy3_shake");
    janken:play();

    
end

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

local function checkStartGame()

    if(startGame == true and winner == " ") then
        timer.pause( startGameTimer )
        bubble.isVisible = true
        play()
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
 
    -----------------------------background--------------------------------
    local bgOptions = sheetName:getBgOptions()
    local bgSheet = graphics.newImageSheet( "images/bg.png", bgOptions );
    local bg = display.newImage (bgSheet, 3);
    print(bgOptions.frames[1].height)

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
    janken:setSequence("enemy3_shake");

    jankenHand = display.newSprite (jankenSheet, jankenSequenceData);
    jankenHand:setSequence("enemy3_scissor");


    -- This is the countdown timer text seen after pressing the ready button at the beginning
    timerText = display.newText(" ", 0, 0, native.systemFont, 30)
    timerText:setTextColor(0, 0, 0)

    messageText = display.newText(" ", 0, 0, native.systemFont, 30)
    messageText:setTextColor(0, 0, 0)

    -- Positioning all objects on the screen
    bg.x = display.contentWidth / 2;
    bg.y= display.contentHeight / 2;
    alex.x = display.contentCenterX-80; 
    alex.y = display.contentCenterY+66; 
    bubble.x = display.contentCenterX-90; 
    bubble.y = display.contentCenterY+26; 
    janken.x = display.contentCenterX+80;
    janken.y = display.contentCenterY+66;
    jankenHand.x = display.contentCenterX+41;
    jankenHand.y = display.contentCenterY+42;
    timerText.x = display.contentCenterX     
    timerText.y = display.contentCenterY
    scoreText.x = display.contentCenterX
    scoreText.y = display.contentHeight / 2 - bgOptions.frames[1].height/1.8
    messageText.x = display.contentCenterX     
    messageText.y = display.contentCenterY

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
    sceneGroup:insert( jankenHand )
    sceneGroup:insert( timerText )
    sceneGroup:insert( messageText )
    
    
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
        bubble.isVisible = false
        jankenHand.isVisible = false
        messageText.isVisible = false

    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
        startCountdown()
        -- countDownTimer = timer.performWithDelay( 1000, updateTime, 5 )
        startGameTimer = timer.performWithDelay(100, checkStartGame, -1)

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