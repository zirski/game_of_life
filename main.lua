G = love.graphics

function love.load()
    NumTiles = 50
    GridSize = 75
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

function updateCell(x, y)
    local NumNeighbors = 0

    xmin = x - 1
    xadd = x + 1
    ymin = y - 1
    yadd = y + 1

    if xmin == 0 then
        xmin = GridSize
    end

    if xadd == GridSize + 1 then
        xadd = 1
    end

    if ymin == 0 then
        ymin = GridSize
    end

    if yadd == GridSize + 1 then
        yadd = 1
    end
    
    if Tiles[xmin][ymin] then
        NumNeighbors = NumNeighbors + 1
    end

    if Tiles[x][ymin] then
        NumNeighbors = NumNeighbors + 1
    end

    if Tiles[xadd][ymin] then
        NumNeighbors = NumNeighbors + 1
    end

    if Tiles[xmin][y] then
        NumNeighbors = NumNeighbors + 1
    end

    if Tiles[xadd][y] then
        NumNeighbors = NumNeighbors + 1
    end

    if Tiles[xmin][yadd] then
        NumNeighbors = NumNeighbors + 1
    end

    if Tiles[x][yadd] then
        NumNeighbors = NumNeighbors + 1
    end

    if Tiles[xadd][yadd] then
        NumNeighbors = NumNeighbors + 1
    end

    if NumNeighbors < 2 and Tiles[x][y] then
        Tiles[x][y] = false
    end
    
    if NumNeighbors == 2 or NumNeighbors == 3 and not Tiles[x][y] then
        Tiles[x][y] = true
    end
    
    if NumNeighbors > 3 and Tiles[x][y] then
        Tiles[x][y] = false
    end
    
    if NumNeighbors == 3 and not Tiles[x][y] then
        Tiles[x][y] = true
    end
end

function love.update(dt)
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
    end
end