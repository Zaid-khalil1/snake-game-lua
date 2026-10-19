
local Vector2 = {}
Vector2.__index = Vector2

function Vector2:new(x, y)
	return setmetatable({
		x = x or 0,
		y = y or 0
	}, Vector2)
end

-- Metamethods allow using operators with vectors.
function Vector2.__add(a, b)
	return Vector2:new(a.x + b.x, a.y + b.y)
end

function Vector2.__eq(a, b)
	return a.x == b.x and a.y == b.y
end

function Vector2:__tostring()
	return "(" .. self.x .. ", " .. self.y .. ")"
end

-- Compatibility with the existing Snake game.
function Vector2:add(other)
	self.x = self.x + other.x
	self.y = self.y + other.y
	return self
end

function Vector2:copy()
	return Vector2:new(self.x, self.y)
end

function Vector2:equals(other)
	return self == other
end

return Vector2
