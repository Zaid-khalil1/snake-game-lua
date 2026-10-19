
local Events = {}
Events.listeners = {}

function Events.subscribe(eventName, callback)
	if not Events.listeners[eventName] then
		Events.listeners[eventName] = {}
	end

	table.insert(Events.listeners[eventName], callback)
end

function Events.emit(eventName, ...)
	local listeners = Events.listeners[eventName]

	if not listeners then
		return
	end

	for _, callback in ipairs(listeners) do
		callback(...)
	end
end

function Events.clear()
	Events.listeners = {}
end

return Events
