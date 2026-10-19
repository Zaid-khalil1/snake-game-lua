-- Lua 5.4 feature: to-be-closed variables.

local function loadHighscore(filename)
    local file <close> = assert(io.open(filename, "r"))
    local content = file:read("*a")
    return tonumber(content) or 0
end

local function saveHighscore(filename, score)
    local file <close> = assert(io.open(filename, "w"))
    file:write(tostring(score))
end

return {
    load = loadHighscore,
    save = saveHighscore
}
