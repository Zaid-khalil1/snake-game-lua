
local Entity = require("entity")
local Vector2 = require("vector2")
local Input = require("input")
local Highscore = require("highscore")
local Events = require("events")

local SnakeGame = {}
SnakeGame.__index = SnakeGame

local CELL_SIZE = 20
local GRID_WIDTH = 40
local GRID_HEIGHT = 30

function SnakeGame:new()
	local game = setmetatable({}, SnakeGame)

	game.input = Input:new()

	Events.subscribe("score_changed", function(score)
		game.score = score
	end)

	game:reset()
	return game
end

function SnakeGame:reset()
	self.snake = {
		Entity:new(20, 15),
		Entity:new(19, 15),
		Entity:new(18, 15)
	}

	self.direction = Vector2:new(1, 0)
	self.nextDirection = Vector2:new(1, 0)

	self.timer = 0
	self.moveDelay = 0.12
	self.score = 0
	self.highscore = Highscore.load()
	self.gameOver = false

	self:spawnFood()
end

function SnakeGame:spawnFood()
	repeat
		self.food = Vector2:new(
			love.math.random(1, GRID_WIDTH),
			love.math.random(1, GRID_HEIGHT)
		)

		local onSnake = false

		for _, segment in ipairs(self.snake) do
			if segment:isAt(self.food) then
				onSnake = true
				break
			end
		end
	until not onSnake
end

function SnakeGame:update(dt)
	if self.gameOver then
		return
	end

	self.timer = self.timer + dt

	if self.timer >= self.moveDelay then
		self.timer = self.timer - self.moveDelay
		self:moveSnake()
	end
end

function SnakeGame:moveSnake()
	self.direction = self.nextDirection:copy()

	local head = self.snake[1]
	local newPosition = head.position + self.direction

	-- Wall collision
	if newPosition.x < 1 or newPosition.x > GRID_WIDTH
	or newPosition.y < 1 or newPosition.y > GRID_HEIGHT then
		self:endGame()
		return
	end

	local eating = (newPosition == self.food)

	-- Body collision
	for i, segment in ipairs(self.snake) do
		if segment:isAt(newPosition) then
			if not (i == #self.snake and not eating) then
				self:endGame()
				return
			end
		end
	end

	table.insert(
		self.snake,
		1,
		Entity:new(newPosition.x, newPosition.y)
	)

	if eating then
		self.score = self.score + 1
		Events.emit("score_changed", self.score)

		if self.score > self.highscore then
			self.highscore = self.score
			Highscore.save(self.score)
		end

		self:spawnFood()
	else
		table.remove(self.snake)
	end
end

function SnakeGame:endGame()
	self.gameOver = true
	Highscore.save(self.score)
end

function SnakeGame:keypressed(key)
	if self.gameOver then
		if key == "return" or key == "kpenter" then
			self:reset()
		end
		return
	end

	self.input:handleKey(key, self)
end

function SnakeGame:draw()
	love.graphics.setColor(1, 1, 1)
	love.graphics.print("Score: " .. self.score, 10, 10)
	love.graphics.print("Best: " .. self.highscore, 10, 30)

	for _, segment in ipairs(self.snake) do
		local renderer = segment:getComponent("Renderer")

		love.graphics.setColor(renderer.color)

		love.graphics.rectangle(
			"fill",
			(segment.position.x - 1) * CELL_SIZE,
			(segment.position.y - 1) * CELL_SIZE,
			renderer.size - 1,
			renderer.size - 1
		)
	end

	love.graphics.setColor(1, 0.2, 0.2)

	love.graphics.rectangle(
		"fill",
		(self.food.x - 1) * CELL_SIZE,
		(self.food.y - 1) * CELL_SIZE,
		CELL_SIZE - 1,
		CELL_SIZE - 1
	)

	if self.gameOver then
		love.graphics.setColor(1, 1, 1)

		love.graphics.printf(
			"GAME OVER\n\nScore: " .. self.score ..
			"\n\nPress ENTER to Restart",
			0, 220, 800, "center"
		)
	end
end

return SnakeGame
