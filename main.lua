G = love.graphics

function love.load()
    NumTiles = 250
    GridSize = 100
    -- TileSize = 10
    
    Tiles = {}
    for i = 1, GridSize do
        Tiles[i] = {}
        for j = 1, GridSize do
            Tiles[i][j] = false
        end
    end
    generateTiles(NumTiles)

    print(#Tiles)
end


function updateCell(a, b)
    local check = {
        {x = a + 1, y = b},
        {x = a - 1, y = b},
        {x = a, y = b + 1},
        {x = a, y = b - 1},
        {x = a - 1, y = b + 1},
        {x = a + 1, y = b - 1},
        {x = a + 1, y = b + 1},
        {x = a - 1, y = b - 1}
    }
    local NumNeighbors = 0 -- Cell Neighbours
    
    for i, v in ipairs(check) do
        if v.x >= 1 and v.x <= GridSize and v.y >= 1 and v.y <= GridSize then
            if Tiles[v.x][v.y] then -- switched [v.x] and [v.y] values lol - previous author must have reversed x and y axis
                NumNeighbors = NumNeighbors + 1
            end
        end
    end

    if Tiles[a][b] and NumNeighbors < 2 then
        Tiles[a][b] = false
    end
    
    if Tiles[a][b] and (NumNeighbors == 2 or NumNeighbors == 3) then
        Tiles[a][b] = true
    end
    
    if Tiles[a][b] and NumNeighbors > 3 then
        Tiles[a][b] = false
    end
    
    if not Tiles[a][b] and NumNeighbors == 3 then
        Tiles[a][b] = true
    end
end

function love.update(dt)
    for i = 1, GridSize do
        for j = 1, GridSize do
            updateCell(i, j)
        end
    end
    -- updateCell(love.math.random(1, GridSize), love.math.random(1, GridSize))
end

function love.draw()
    for i = 1, #Tiles do
        for j = 1, #Tiles do
            local x = (G.getWidth() / #Tiles) * (i - 1)
            local y = (G.getHeight() / #Tiles) * (j - 1)

            if Tiles[i][j] then
                G.setColor(1, 1, 1, 1)
            end
            G.rectangle("fill", x, y, G.getWidth() / #Tiles, G.getHeight() / #Tiles)
            G.setColor(0, 0, 0, 1)
        end
    end
end

function generateTiles(numTiles)
    for i = 1, numTiles do

        local x = love.math.random(1, GridSize)
        local y = love.math.random(1, GridSize)

        Tiles[x][y] = true
    end
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
    
    if key == "return" then
        for i = 1, GridSize do
            for j = 1, GridSize do
                updateCell(i, j)
            end
        end
        -- for i = 1, 1000 do
        --     updateCell(love.math.random(1, GridSize), love.math.random(1, GridSize))
        -- end
    end
end