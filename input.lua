
local Vector2 = require("vector2")

local Input = {}
Input.__index = Input

function Input:new()
	local input = setmetatable({
		commands = {}
	}, Input)

	local directions = {
		up = Vector2:new(0, -1),
		down = Vector2:new(0, 1),
		left = Vector2:new(-1, 0),
		right = Vector2:new(1, 0)
	}

	local function changeDirection(game, direction)
		if not game then return end

		local reverse =
			direction.x == -game.direction.x
			and direction.y == -game.direction.y

		if not reverse then
			game.nextDirection = direction:copy()
		end
	end

	input:bind("up", function(game)
		changeDirection(game, directions.up)
	end)

	input:bind("w", function(game)
		changeDirection(game, directions.up)
	end)

	input:bind("down", function(game)
		changeDirection(game, directions.down)
	end)

	input:bind("s", function(game)
		changeDirection(game, directions.down)
	end)

	input:bind("left", function(game)
		changeDirection(game, directions.left)
	end)

	input:bind("a", function(game)
		changeDirection(game, directions.left)
	end)

	input:bind("right", function(game)
		changeDirection(game, directions.right)
	end)

	input:bind("d", function(game)
		changeDirection(game, directions.right)
	end)

	return input
end

function Input:bind(key, command)
	self.commands[key] = command
end

function Input:handleKey(key, game)
	local command = self.commands[key]

	if command then
		command(game)
	end
end

return Input
