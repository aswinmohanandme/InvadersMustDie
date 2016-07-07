--[[
    - Author :: Aswin Mohan
    - Dated : 07 July 2016

    - @Descriptiton
        A simple Shoot'em Up Game
]]

-- Initialise
function love.load(arg)
    hero = {}
    hero.posX = 300
    hero.posY = 450
    hero.speed = 200
end

-- Physics Takes Place Here
function love.update(dt)
    if love.keyboard.isDown('a') then
        hero.posX = hero.posX - hero.speed * dt
    end
    if love.keyboard.isDown('d') then
        hero.posX = hero.posX + hero.speed * dt
    end
end

-- Draw per Frame
function love.draw()

    -- Render the Ground
    love.graphics.setColor(0, 255, 0, 255)
    love.graphics.rectangle('fill', 0, 465, 800, 150)

    -- Render the Player
    love.graphics.setColor(0, 255, 255, 255)
    love.graphics.rectangle('fill', hero.posX, hero.posY, 32, 16)
end
