-----------------------------------------------------------------------------------------
--
-- main.lua
--
-- Authors: Daniel Burris and Jairo Arreola
-- The project is created using scene switching with the composer object. The composer
-- object allows for the creation and switching between of scenes. Each part of the 
-- project is created using a scene (Main Menu, Level Select, Level 1, Level 2, Level 3, 
-- Level Complete). Each scene is defined with 4 functions: create(), show(), hide(), 
-- destory(). When these functions are called is defined in each scene. The create function 
-- is used to draw the interface in most scenes. The show scene is used when we need code 
-- that will loop while the scene is open. The hide and destroy functions are mostly unused. 
-----------------------------------------------------------------------------------------

-- Composer object is used for the creation and manipulation of scenes
local composer = require("composer")

-- Default code, hiding the status bar
display.setStatusBar(display.HiddenStatusBar)

-- Only thing main.lua does is push us into the menu scene, all other functions are 
-- carried out in their respective scenes
composer.gotoScene("menu")