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
    hero.shots = {}
    hero.width = 32
    hero.height = 16

    -- Seed Random Numbers
    math.randomseed(os.time())

    enemies = {}
    for i = 0 , 7 do
        enemy = {}
        enemy.width = 40
        enemy.height = 20
        enemy.posX = i * (enemy.width + 60 ) + 100
        enemy.posY = math.random(1, 100)
        enemy.speed = 15 
        table.insert(enemies , enemy)
    end

    bgImage = love.graphics.newImage("Assets/bg.png")
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

    -- Fire Some Shots
    local remEnemy = {}
    local remShots = {}

    for i , v in ipairs(hero.shots) do

        -- Move Shots Up
        v.posY = v.posY + v.speed * dt

        -- Delete Shots that are off Screen
        if v.posY < 0 then
            table.insert(remShots , i)
        end

        -- Check if the Shot Hit the Enemies
        for ii , vv in ipairs(enemies) do
            if CheckCollision(v.posX , v.posY , v.width , v.height,vv.posX , vv.posY , vv.width , vv.height) then
                table.insert(remShots , i)
                table.insert(remEnemy , ii)
            end
        end

        -- Remove Enemies and Shots
        for i , v in ipairs(remEnemy) do
            table.remove(enemies , v)
        end

        for i , v in ipairs(remShots) do
            table.remove(hero.shots , v)
        end
    end

    -- Move the Enemies down
    for i , v in ipairs(enemies) do
        v.posY = v.posY + v.speed * dt * math.random(1 , 10)

        -- If they Hit the Ground YOu are Dead
        if v.posY > 445 then
            -- Game End
            v.posY = -v.posY
        end
    end
end

-- Draw per Frame
function love.draw()
    -- Render the Background
    love.graphics.draw(bgImage)

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

    -- Render the Shots
    love.graphics.setColor(255, 255, 255, 255)
    for i , v in ipairs(hero.shots) do
        love.graphics.rectangle('fill', v.posX, v.posY, v.width, v.height)
    end
end

-- Fire Shots on Space Bar Press
function love.keyreleased(key)
    if key == "w" then
        shoot()
    end
end

-- Adds a shot to the shots library
function shoot()
    local shot = {}
    shot.posX = hero.posX + hero.width / 2
    shot.posY = hero.posY
    shot.speed = -100
    shot.width = 10
    shot.height = 10
    table.insert(hero.shots , shot)
end

-- Collision detection function.
-- Returns true if two boxes overlap, false if they don't
-- x1,y1 are the left-top coords of the first box, while w1,h1 are its width and height
-- x2,y2,w2 & h2 are the same, but for the second box
function CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)
  return x1 < x2+w2 and
         x2 < x1+w1 and
         y1 < y2+h2 and
         y2 < y1+h1
end
