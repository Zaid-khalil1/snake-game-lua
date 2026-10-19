local GameState = require("gamestate")
local gameState

function love.load()
	love.window.setTitle("Snake Game")
	love.window.setMode(800, 600)

	gameState = GameState:new()
end

function love.update(dt)
	gameState:update(dt)
end

function love.draw()
	love.graphics.clear(0.1, 0.1, 0.12)
	gameState:draw()
end

function love.keypressed(key)
	gameState:keypressed(key)
end