-----------------------------------------------------------------------------------------
--
-- level_1.lua
--
-- Authors: Daniel Burris and Jairo Arreola
--
-- This is level 1 of the rock-paper-scissors game. It is identical to the level 2,3 lua
-- files except for the fact that it pushes us into level 2 upon victory and uses the level
-- 1 sprites, background, and difficulty (5000ms decision time).
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

-- These local variables are used to keep track of which frame we're on in animation sequences

local alex = 0 -- This variable represents the alex sprite
local bubble = 0 -- This variable represents the bubble sprite
local bubbleCount = 0 -- This variables tracks which option the user selected from alex's thought-bubble (rock,paper, scissors)
local janken = 0 -- This variable represents the janken sprite
local jankenHand = 0 -- This variable represents the janken hand sprite, his hand and body are seperate sprites

-- Local variable used to start the countdown timer, its set to countdowntimerValue + 1
-- so that the countdown timer is between 3 < x < 3.99 instead of 2 < x < 2.99
local secondsLeft = 1
local countDownTimer = 0 -- timer used at the beginning of a round, lasts 3 seconds
local decisionTimer = 0 -- timer used when player is deciding what to play, lasts 5000ms on this level
local timerText -- represents the text for the countDownTimer
local messageText -- text displayed when the native.showalert appears at the end of each round
local startGame = false -- variable used to signal the start of the game after the 3 second countDownTimer
local startGameTimer -- timer used to 
local winner = " " -- variable used to see if a winner has been found yet


-- nextLevel()
--      input: none
--      output: none
--      
--      This function resets the scores for both the player and the enemy and pushes us
--      into the next level. Called when alex beats the enemy.
local function nextLevel(event)
    resetScoreboard(2)
    scoreText.text = " "
    composer.gotoScene("level_2") -- going to level 2
end

-- exitToMenu()
--      input: none
--      output: none
--      
--      This function resets the scores for both the player and the enemy and pushes us 
--      into the menu. Called when alex loses to the enemy.
local function exitToMenu(event)
    resetScoreboard(0)
    scoreText.text = " "
    composer.gotoScene("menu")
end


-- updateTime()
--      input: none
--      output: none
--
--      This function is called when we start the countdown for each round. It draws the 3-2-1
--      countdown timer in the middle of the screen prior to the user selecting his R-P-S for Alex.
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

-- startCountdown()
--      input: none
--      output: none
--
--      This function starts our countdown timer for the beginning of the round. It initates the enemy
--      animation sequence and hides jankenHand (since he hasn't made a decision yet)
local function startCountdown()
    jankenHand.isVisible = false
    janken:setSequence("enemy1_shake");
    countDownTimer = timer.performWithDelay( 1000, updateTime, 5 )
end

-- contGame()
--      input: none
--      output: none
--
--      This function is called after the first round of a level completes, it resumes the start game timer
--      and does not reset the scoreboard and begins the countdown for the next round.
local function contGame(event)
    startGame = false
    timer.resume( startGameTimer )
    startCountdown()
end

-- findWinner()
--      input: player, enemy
--      output: none
--
--      This function simply checks for all possible outcomes of the R-P-S game. Assuming the following
--      rules: R > S, P > R, S > P. Player and Enemy are variables that track was option they played 
--      (rock, paper, or scissors)
local function findWinner(player, enemy)
    
    -- No Winner declared yet
    messageText.isVisible = false

    -- This big if statement is simply checking for all possibilities of Alex winning, enemy winning, or a tie game
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

    -- This is not checking for the winner of the round, but for the winner of the level, it decides whether
    -- alex beat the level, lost the level, or needs to keep playing
    if(alexScore == 2) then -- wins the round
        print("winner of level is Alex")
        winner = "Alex";
        timer.cancel( startGameTimer )
        native.showAlert("Winner!", "Go to next level", {"level 2"}, nextLevel)
    elseif (enemyScore == 2) then -- loses the round
        print("Winner of level is Enemy")
        winner = "Enemy";
        timer.cancel( startGameTimer )
        native.showAlert("Game Over!", "You lost", {"Exit to Menu"}, exitToMenu)
    else -- needs to keep playing
        print("Game is still going on")
        winner = " ";
        native.showAlert("Game!", messageText.text, {"Resume"}, contGame)
    end
end

-- checkHands()
--      input: none
--      output: none
--
--      This function checks to see what hand alex and janken played. Alex's hand is based on what 
--      the user chose, janken's hand is random.
local function checkHands()
    bubble.isVisible = false
    alex = setSpriteHandSequence(alex, "alex", bubbleCount)

    enemyChoice = math.random(0, 2)
    jankenHand = setSpriteHandSequence(jankenHand, "enemy".. currentLevel, enemyChoice)
    janken:setSequence( "enemy1_set" )
    jankenHand.isVisible = true
    findWinner(bubbleCount, enemyChoice) -- Passing both hands to the findWinner function
end

-- play()
--      input: none
--      output: none
--
--      This function starts the 5000ms timer for level 1 and begins the animations for both alex and
--      janken. 
local function play()
    decisionTimer = timer.performWithDelay( 100, checkHands, 1 )
    alex:setSequence ("alex_shake");
    alex:play();

    janken:setSequence("enemy1_shake");
    janken:play();    
end

-- bubbleTapListener()
--      input: none
--      output: none
--
--      This function is the tap listener for our bubble above alex, it is affiliated with a number 0-2
--      which corresponds to rock = 0, scissors = 1, paper = 2
local function bubbleTapListener( event )
    bubbleCount = bubbleCount + 1
    if(bubbleCount == 1) then
        bubble:setSequence("bubble_scissor");
        bubble:play()
    elseif (bubbleCount == 2) then
        bubble:setSequence("bubble_paper");
        bubble:play();
    else
        bubbleCount = 0;
        bubble:setSequence("bubble_rock");
        bubble:play()
    end

end

-- checkStartGame()
--      input: none
--      output: none
--
--      This function is called at the end of our 3s countDownTimer and allows the bubble to be clickable
--      and calls the play function which begins our animations. 
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
 
    -- Game Background for level 1
    local bgOptions = sheetName:getBgOptions()
    local bgSheet = graphics.newImageSheet( "images/bg.png", bgOptions );
    local bg = display.newImage (bgSheet, 1);

    -- Creating Alex sprite and sequence data
    local alexOptions = sheetName:getAlexOptions()
    local alexSequenceData = sheetName:getAlexSequenceData()
    local alexSheet = graphics.newImageSheet( "images/alex.png", alexOptions );
    alex = display.newSprite (alexSheet, alexSequenceData); 

    -- Creating bubble sprite and sequence data
    local bubbleSequenceData = sheetName:getBubbleSequenceData()
    bubble = display.newSprite (alexSheet, bubbleSequenceData);
    bubble:addEventListener( "tap", bubbleTapListener )

    -- Creating Janken sprite and sequence data
    local jankenOptions = sheetName:getJankenOptions()
    local jankenSequenceData = sheetName:getJankenSequenceData()
    local jankenSheet = graphics.newImageSheet( "images/enemy.png", jankenOptions );
    janken = display.newSprite (jankenSheet, jankenSequenceData);
    janken:setSequence("enemy1_shake");

    -- Creating Janken Hand sprite and sequence data
    jankenHand = display.newSprite (jankenSheet, jankenSequenceData);
    jankenHand:setSequence("enemy1_scissor");

    -- Creating the countdown timer text seen before a round starts
    timerText = display.newText(" ", 0, 0, native.systemFont, 30)
    timerText:setTextColor(0, 0, 0)

    -- Creating the text that is seen at the end of a round (outcome of round)
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
    jankenHand.x = display.contentCenterX+57;
    jankenHand.y = display.contentCenterY+50;
    timerText.x = display.contentCenterX     
    timerText.y = display.contentCenterY
    scoreText.x = display.contentCenterX
    scoreText.y = display.contentHeight / 2 - bgOptions.frames[1].height/1.8
    messageText.x = display.contentCenterX     
    messageText.y = display.contentCenterY

    -- Setting Anchor point for all sprites
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
--      This function defaults our bubble back to rock and hides all sprites since the round hasn't started yet,
--      It begins the startCountdown timer and begins the game
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