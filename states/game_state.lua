
local SnakeGame = require("snake_game")

local GameState = {}

function GameState:enter()
	self.game = SnakeGame:new()
end

function GameState:update(dt)
	if self.game then
		self.game:update(dt)
	end
end

function GameState:draw()
	if self.game then
		self.game:draw()
	end
end

function GameState:keypressed(key, gameState)
	if self.game then
		self.game:keypressed(key)
	end

	if key == "escape" then
		gameState:switch("menu")
	end
end

return GameState
