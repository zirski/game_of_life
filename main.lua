function love.load()
    GridSize = 5
    TileSize = 10
    
    Tiles = {}
    for i = 1, GridSize do
        Tiles[i] = {}
        for j = 1, GridSize do
            Tiles[i][j] = false
        end
    end
    generateTiles(15)
end

function neighbor(x, y)
    
end

function love.draw()
    for i = 1, GridSize do
        local x = 15 * i
        local y = 15 * i
        
        love.graphics.rectangle("fill", x, y, TileSize, TileSize)
    end
end

function generateTiles(numTiles)
    local coords = {}

    for i = 1, numTiles do

        local x = love.math.random(1, GridSize)
        local y = love.math.random(1, GridSize)

        Tiles[x][y] = true
    end
end

-- function love.keypressed(key)
--     if key == "return" then
--         for j = 1, 5 do
--             print(Tiles[1][j])
--         end
--     end
-- end