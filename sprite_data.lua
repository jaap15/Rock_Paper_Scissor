-----------------------------------------------------------------------------------------
--
-- sprite_data.lua
--
-- Code provided by: Haeyong Chung
--
-- This lua file contains all the animation seqeunces, resolutions, and sprite configurations
-- for the project. We chose to make this file seperate from the main.lua because it 
-- not only keeps the main.lua simple and clean, but it helps overall organization of the 
-- program (seperates our code from provided code).
--
-- All credit for spritesheets and background images goes to SEGA's Alex Kidd, found below
-- http://www.spriters-resource.com/master_system/alexkiddmw/sheet/51712/
-- http://www.spriters-resource.com/master_system/alexkiddmw/sheet/10911/
-- http://www.spriters-resource.com/master_system/alexkiddmw/sheet/51709/
-----------------------------------------------------------------------------------------
local SheetInfo = {} -- Creating a table to hold all of our animation options

-- Sprite definitions for background
-- All background images are contained in one big .png file. So we select which background we want
-- by defining the origin of the background and grabbing the width of height of it. 
SheetInfo.bgOptions =
{
    frames = {
         { 
            --bg1
             x = 0, 
             y = 0, 
             width = 256, 
             height = 192
         }, 
         {
            -- bg2
              x = 0, 
              y = 192, 
              width = 256, 
              height = 192
          }, 
         { 
            -- bg3
             x = 256, 
             y = 192, 
             width = 256, 
             height = 192
         }, 
         { 
            -- bg4, added this for the ending scene, giving credit to original artist
             x = 256, 
             y = 0, 
             width = 256, 
             height = 192
         },          

     }
}

-- Sprite definitions for Alex Kidd
-- The Alex Kidd sprite sheet contains alot of information in it not all of which we need, this options sheet breaks 
-- down all the frames we need into an easy to read table. 
SheetInfo.alexOptions =
{
    frames = {
        { 
            --frame 1
            x = 1, 
            y = 2, 
            width = 16, 
            height = 25
        }, 
        { 
            --frame 2
            x = 18, 
            y = 2, 
            width = 16, 
            height = 25
        }, 
        { 
            --frame 3
            x = 35, 
            y = 2, 
            width = 16, 
            height = 25
        }, 
        { 
            --frame 4
            x = 52, 
            y = 2, 
            width = 16, 
            height = 25
        }, 
        { 
            --ready1
            x = 1, 
            y = 54, 
            width = 16, 
            height = 24
        }, 
        { 
            --ready2
            x = 19, 
            y = 54, 
            width = 16, 
            height = 24
        }, 
        { 
            -- rock
            x = 37, 
            y = 54, 
            width = 29, 
            height = 24
        }, 
        { 
            -- scissor
            x = 67, 
            y = 54, 
            width = 33, 
            height = 24
        }, 
        { 
            -- paper
            x = 101, 
            y = 54, 
            width = 33, 
            height = 24
        }, 
        { 
            -- bubblerock
            x = 1, 
            y = 79, 
            width= 32, 
            height= 32
        }, 
        { 
            -- bubblescissor
            x = 35, 
            y = 79, 
            width= 32, 
            height= 32
        }, 
        { 
            -- bubblepaper
            x = 69, 
            y = 79, 
            width= 32, 
            height= 32
        }, 

     }
}

-- Animation definitions for Alex Kidd
-- Here we are defining which frames are to be played in success to form a successful animation sequence
-- and defining how much time is displayed between frame changes
SheetInfo.alexSequenceData = {

    {name = "alex_normal", start=1 , count = 4, time = 800}, 
    {name = "alex_faster", frames={1,2,3,4}, time = 400}, 
    {name = "alex_shake", frames={5,6}, time = 500}, 
    {name = "alex_rock", frames={7}}, 
    {name = "alex_paper", frames={9}}, 
    {name = "alex_scissor", frames={8}},

}

-- Sprite definitions for Janken
-- The enemy (Janken) sprite sheet contains alot of information in it not all of which we need, this options sheet breaks 
-- down all the frames we need into an easy to read table. 
SheetInfo.jankenOptions =
{
    frames = {
        {
            -- 1. boss_shake1
            x= 154, 
            y= 13, 
            width= 39, 
            height= 48 
        }, 
        {
            -- 2. boss_shake2
            x= 195, 
            y= 13, 
            width= 39, 
            height= 48 
        }, 
        {
            -- 3. boss_set
            x= 236, 
            y= 13, 
            width= 32, 
            height= 48 
        }, 
        {
            -- 4. boss_rock
            x= 305, 
            y= 13, 
            width= 15, 
            height= 48 
        }, 
        {
            -- 5. boss_paper
            x= 270, 
            y= 13, 
            width= 16, 
            height= 48 
        }, 
        {
            -- 6. boss_scissor
            x= 287, 
            y= 13, 
            width= 16, 
            height= 48 
        }, 
        
        {
            -- 7. enemy1_shake1
            x= 153, 
            y= 62, 
            width= 23, 
            height= 31 
        }, 
        {
            -- 8. enemy1_shake2
            x= 178, 
            y= 62, 
            width= 23, 
            height= 31 
        }, 
        {
            -- 9. enemy1_set
            x= 236, 
            y= 62, 
            width= 15, 
            height= 31 
        }, 
        {
            -- 10. enemy1_rock
            x= 270, 
            y= 62, 
            width= 16, 
            height= 31 
        }, 
        {
            -- 11. enemy1_paper
            x= 287, 
            y= 62, 
            width= 16, 
            height= 31 
        }, 
        {
            -- 12. enemy1_scissor
            x= 304, 
            y= 62, 
            width= 16, 
            height= 31 
        }, 

        {
            -- 13. enemy2_shake1
            x= 153, 
            y= 96, 
            width= 23, 
            height= 31 
        }, 
        {
            -- 14. enemy2_shake2
            x= 178, 
            y= 96, 
            width= 23, 
            height= 31 
        }, 
        {
            -- 15. enemy2_set
            x= 236, 
            y= 96, 
            width= 15, 
            height= 31 
        }, 
        {
            -- 16. enemy2_rock
            x= 270, 
            y= 96, 
            width= 16, 
            height= 31 
        }, 
        {
            -- 17. enemy2_paper
            x= 287, 
            y= 96, 
            width= 16, 
            height= 31 
        }, 
        {
            -- 18. enemy2_scissor
            x= 304, 
            y= 96, 
            width= 16, 
            height= 31 
        }, 

     }
}

-- Animation definitions for Janken
-- Here we are defining which frames are to be played in success to form a successful animation sequence
-- and defining how much time is displayed between frame changes
SheetInfo.jankenSequenceData = {

    --{name = "boss_flap", frames={7,8}, time = 500},
    {name = "enemy3_shake", frames={1,2}, time = 500},
    {name = "enemy3_set", frames={3}, time = 10, loopCount=1},
    {name = "enemy3_rock", frames={4}, time = 10, loopCount=1},
    {name = "enemy3_paper", frames={5}, time = 10, loopCount=1},
    {name = "enemy3_scissor", frames={6}, time = 10, loopCount=1},

    --{name = "enemy1_flap", frames={7,8}, time = 500},
    {name = "enemy1_shake", frames={7,8}, time = 500},
    {name = "enemy1_set", frames={9}, time = 10, loopCount=1},
    {name = "enemy1_rock", frames={10}, time = 10, loopCount=1},
    {name = "enemy1_scissor", frames={11}, time = 10, loopCount=1},
    {name = "enemy1_paper", frames={12}, time = 10, loopCount=1},

    --{name = "enemy2_flap", frames={7,8}, time = 500},
    {name = "enemy2_shake", frames={13,14}, time = 500},
    {name = "enemy2_set", frames={15}, time = 10, loopCount=1},
    {name = "enemy2_rock", frames={16}, time = 10, loopCount=1},
    {name = "enemy2_scissor", frames={17}, time = 10, loopCount=1},
    {name = "enemy2_paper", frames={18}, time = 10, loopCount=1},

}

-- Animation definitions for bubble
-- Here we are defining which frames are to be played in success to form a successful animation sequence
-- and defining how much time is displayed between frame changes
SheetInfo.bubbleSequenceData = {

    {name = "bubble_rock", frames={10}}, 
    {name = "bubble_scissor", frames={11}},
    {name = "bubble_paper", frames={12}},

}

--  SheetInfo:getBgOption()
--      input: none
--      output: bgOptions
--
--      This function returns the background options to the caller
function SheetInfo:getBgOptions()
    return self.bgOptions;
end

--  SheetInfo:getAlexOptions()
--      input: none
--      output: alexOptions
--
--      This function returns the Alex Kidd options to the caller
function SheetInfo:getAlexOptions()
    return self.alexOptions;
end

--  SheetInfo:getAlexSequenceData()
--      input: none
--      output: alexSequenceData
--
--      This function returns the Alex Kidd sequence data to the caller
function SheetInfo:getAlexSequenceData()
    return self.alexSequenceData;
end

--  SheetInfo:getJankenOptions()
--      input: none
--      output: jankenOptions
--
--      This function returns the Janken options to the caller
function SheetInfo:getJankenOptions()
    return self.jankenOptions;
end

--  SheetInfo:getJankenSequenceData()
--      input: none
--      output: jankenSequenceData
--
--      This function returns the Janekn sequence data to the caller
function SheetInfo:getJankenSequenceData()
    return self.jankenSequenceData;
end

--  SheetInfo:getBubbleSequenceData()
--      input: none
--      output: bubbleSequenceData
--
--      This function returns the bubble sequence data to the caller
function SheetInfo:getBubbleSequenceData()
    return self.bubbleSequenceData;
end

return SheetInfo