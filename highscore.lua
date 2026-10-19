
local Highscore = {}
local filename = "highscore.txt"

function Highscore.load()
	local contents = love.filesystem.read(filename)

	if not contents then
		return 0
	end

	return tonumber(contents) or 0
end

function Highscore.save(score)
	local currentHighscore = Highscore.load()

	if score > currentHighscore then
		love.filesystem.write(filename, tostring(score))
	end
end

return Highscore
