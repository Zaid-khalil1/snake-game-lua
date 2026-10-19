
local Vector2 = require("vector2")

local Entity = {}
Entity.__index = Entity

function Entity:new(x, y)
	x = x or 0
	y = y or 0

	local entity = setmetatable({
		components = {},
		position = Vector2:new(x, y)
	}, Entity)

	entity:addComponent("Position", {
		x = x,
		y = y
	})

	entity:addComponent("Movement", {
		dx = 0,
		dy = 0
	})

	entity:addComponent("Renderer", {
		color = {0.2, 0.85, 0.35},
		size = 20
	})

	return entity
end

function Entity:addComponent(name, component)
	self.components[name] = component
	return component
end

function Entity:getComponent(name)
	return self.components[name]
end

function Entity:hasComponent(name)
	return self.components[name] ~= nil
end

function Entity:move(direction)
	self.position = self.position + direction

	local position = self:getComponent("Position")
	position.x = self.position.x
	position.y = self.position.y
end

function Entity:isAt(position)
	return self.position == position
end

return Entity
