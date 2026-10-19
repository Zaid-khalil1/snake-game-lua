local MenuState = {}

function MenuState:update(dt)
end

function MenuState:draw()
	love.graphics.setColor(1, 1, 1)

	love.graphics.printf(
		"SNAKE GAME",
		0, 200, 800, "center"
	)

	love.graphics.printf(
		"Press ENTER to Play",
		0, 280, 800, "center"
	)
end

function MenuState:keypressed(key, gameState)
	if key == "return" then
		gameState:switch("playing")
	end
end
return MenuState

