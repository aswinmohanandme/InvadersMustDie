--[[
    - Author :: Aswin Mohan
    - Dated : 07 July 2016

    - @Descriptiton
        A simple Shoot'em Up Game
]]

-- Initialise Game Code Here
function love.load(arg)
    hero = {}
    hero.posX = 300
    hero.posY = 450
    hero.speed = 200

    enemies = {}
    for i = 0 , 7 do
        enemy = {}
        enemy.width = 40
        enemy.height = 20
        enemy.posX = i * (enemy.width + 60 ) + 100
        enemy.posY = enemy.height + 100
        enemy.speed = 200
        table.insert(enemies , enemy)
    end
end

-- Physics Takes Place Here
function love.update(dt)
    -- Move the Player
    if love.keyboard.isDown('a') then
        hero.posX = hero.posX - hero.speed * dt
    end
    if love.keyboard.isDown('d') then
        hero.posX = hero.posX + hero.speed * dt
    end

    -- Move the Enemies down
    for i , v in ipairs(enemies) do
        v.posY = v.posY + v.speed * dt

        -- If they Hit the Ground YOu are Dead
        if v.posY > 445 then
            -- Game End
            v.posY = -v.posY
        end
    end
end

-- Draw per Frame
function love.draw()

    -- Render the Ground
    love.graphics.setColor(0, 255, 0, 255)
    love.graphics.rectangle('fill', 0, 465, 800, 150)

    -- Render the enemies
    love.graphics.setColor(0, 255, 255, 255)
    for i , v in ipairs(enemies) do
        love.graphics.rectangle('fill', v.posX, v.posY, v.width, v.height)
    end

    -- Render the Player
    love.graphics.setColor(0, 255, 255, 255)
    love.graphics.rectangle('fill', hero.posX, hero.posY, 32, 16)
end
