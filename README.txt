Snake Game - LÖVE 11.5

How to run:
Open PowerShell in this folder and run:
& "C:\Program Files\LOVE\love.exe" .

Controls:
Enter - Start or restart
Arrow keys or WASD - Move
Escape - Return to menu

Assignment concepts:
1. Game state manager: menu and playing states.
2. Entity components: Position, Movement, Renderer.
3. Vector2 metamethods: __add, __eq, __tostring.
4. Input command pattern: bind and handleKey.
5. Observer pattern: subscribe and emit.
6. High-score saving and loading.

Note:
LÖVE 11.5 normally uses LuaJIT, which does not support
Lua 5.4 to-be-closed variables using &lt;close&gt;.
The highscore_lua54_demo.lua file is a separate Lua 5.4 example.