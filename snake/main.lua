win_w = 400
win_h = 400
martix = {}
-- 方向  up down left right
direction = 'down'
isEat = true
snake_body = {}
food = {}

function love.load()
    initMartix()
    initSnakeBody()
end

function love.update(dt)
    love.timer.sleep(0.1)
    createFood()
    moveSnake()
    eatFood()
end

function love.draw()
    drawBg()
    drawSnake()
    drawFood()
end

function love.keypressed( key )
    if key == 's' then
        direction = 'down'
    end
    if key == 'w' then
        direction = 'up'
    end
    if key == 'd' then
        direction = 'right'
    end
    if key == 'a' then
        direction = 'left'
    end
end

function createFood()
    while isEat do
        local f_x = math.random(20)
        local f_y = math.random(20)
        if not (martix[f_x][f_y] == 1 or martix[f_x][f_y] == 2) then
            martix[f_x][f_y] = 2
            food = {f_x, f_y}
            isEat = false
            break
        end
    end
end

function initSnakeBody()
    for i = 1, 5 do
        martix[1][i] = 1
        snake_body[i] = {1, i}
    end
end

function moveSnake()
    local temp = snake_body[#snake_body]
    local head = {temp[1], temp[2]}
    if direction == 'down' then
        head[2] = head[2] + 1
    elseif direction == 'up' then
        head[2] = head[2] - 1
    elseif direction == 'left' then
        head[1] = head[1] - 1
    elseif direction == 'right' then
        head[1] = head[1] + 1
    end
    if ckeckLimit(head) then
        table.remove(snake_body, 1)
        table.insert(snake_body, head)
        updateMartix()
    end
end

function drawSnake()
    for k, v in pairs(snake_body) do
        love.graphics.setColor(0, 166, 0)
        love.graphics.rectangle("fill", (v[1] * 20 - 20), (v[2] * 20 - 20), 20, 20)
        love.graphics.setColor(0, 0, 0)
	end
end

function initMartix()
    for i = 1, 20 do
        martix[i] = {}
        for j = 1, 20 do
            martix[i][j] = 0
        end
    end
end

function drawBg()
    love.graphics.setColor(255, 255, 255)
    love.graphics.rectangle("fill", 0, 0, win_w, win_h)
    love.graphics.setColor(0, 0, 0)
end

function updateMartix()
    for i = 1, 20 do
        for j = 1, 20 do
            if martix[i][j] ~= 2 then
                martix[i][j] = 0
            end
        end
    end
    for k, v in pairs(snake_body) do
        martix[v[1]][v[2]] = 1
    end
end

function ckeckLimit( head )
    if head[1] < 1 then
        return false
    end
    if head[1] > 20 then
        return false
    end
    if head[2] < 1 then
        return false
    end
    if head[2] > 20 then
        return false
    end
    if martix[head[1]][head[2]] == 1 then
        return false
    end
    return true
end

function drawFood()
    for i = 1, 20 do
        for j = 1, 20 do
            if martix[i][j] == 2 then
                love.graphics.setColor(255, 0, 0)
                love.graphics.rectangle("fill", (i * 20 - 20), (j * 20 - 20), 20, 20)
                love.graphics.setColor(0, 0, 0)
            end
        end
    end
end

function eatFood()
    local head = snake_body[#snake_body]
    if head[1] == food[1] and head[2] == food[2] then
        table.insert(snake_body, {food[1], food[2]})
        isEat = true
    end
end