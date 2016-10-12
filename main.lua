-----------------------------------------------------------------------------------------
--
-- main.lua
--
-- Authors: Daniel Burris and Jairo Arreola
-- 
-- This game was constructed around composer scenes and sprite sheet animations. Each level
-- and menu is a seperate scene with its own seperate functions and sprites / animations.
-- All sprite data and sprite animation options were provided to us from the beginning.
-----------------------------------------------------------------------------------------

-- Composer object is used for the creation and manipulation of scenes
local composer = require("composer")

-- Default code, hiding the status bar
display.setStatusBar(display.HiddenStatusBar)

-- Only thing main.lua does is push us into the menu scene, all other functions are 
-- carried out in their respective scenes
composer.gotoScene("menu")