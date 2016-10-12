-----------------------------------------------------------------------------------------
--
-- main.lua
--
-- Authors: Daniel Burris and Jairo Arreola
-- 
-- This game was constructed around composer scenes and sprite sheet animations. Each level
-- and menu is a seperate scene with its own seperate functions and sprites / animations.
-- All sprite data and sprite animation code was provided to us, we placed what we needed
-- into our own files named sprite_data.lua. This file is referenced in every scene that uses
-- the provided sprites. All credit goes to original creators and third-party packagers for
-- sprite sheets. Information about them can be found in sprite_data.lua. The main.lua
-- simply takes us into the menu scene, and all game functionality is handled in the 
-- subsequent scenes. 
-----------------------------------------------------------------------------------------

-- Composer object is used for the creation and manipulation of scenes
local composer = require("composer")

-- Default code, hiding the status bar
display.setStatusBar(display.HiddenStatusBar)

-- Only thing main.lua does is push us into the menu scene, all other functions are 
-- carried out in their respective scenes
composer.gotoScene("menu")


-- Note to the grader:
-- If you want to test all functionlity of the project and do not want to sit through the 3 second countdown
-- timer and 5 or 3 second hand shaking timers for every round in every level, Ctrl+F the following lines in level_1.lua, 
-- level_2.lua, and level_3.lua and edit the values to something smaller for faster debug / evaluation (i.e 1 or 100ms).
--
-- local secondsLeft = 4 	<--- This statement sets the countdown timer for each level, for faster debug and evaluation, change to lower value (i.e. 1)
-- decisionTimer = timer.performWithDelay( 5000, checkHands, 1 )	<--- This statement defines how much time the user has to make his decision in the game, for faster debug and evaluation, change to lower value (i.e. 100)
-- decisionTimer = timer.performWithDelay( 3000, checkHands, 1 ) 	<--- This statement is found in level_3.lua
