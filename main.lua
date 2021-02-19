push  = require 'push'
Class = require 'Class'
bird = require 'Bird'
bird = require 'Ground'
pipe= require 'Pipe'
-----

W_Width  = 1280
W_Height = 720

V_Width  = 432
V_Height = 243

function love.load()
    love.window.setTitle("Paco n Garret Productions")
    
	--Colors
	terrain = {.87,.84,.58}
	green = {.30,.74,.18}
	
	
	--imagenes
    ground = love.graphics.newImage("img/ground.png")
	bg = love.graphics.newImage("img/background.png")
---
    love.graphics.setDefaultFilter('nearest', 'nearest')
    math.randomseed(os.time())

    push:setupScreen(V_Width, V_Height, W_Width, W_Height, {
        fullscreen = false,
        resizable  = false,
        vsync      = false,
    })

    font = love.graphics.newFont('font.ttf', 18)
    love.graphics.setFont(font)
---
	--Game atributes 
	player= Bird()
	gameState = 'start' -- 'pause' 'collide'
	dirt = Ground(0,218,432,25,terrain)
	grass = Ground(0,208,432,10,green)
end

function love.update(dt)
	if gameState == 'start' then
		
	elseif gameState == 'play' then
		player:update(dt)
	end
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
		
    elseif key == 'enter' or key == 'return' then
		if gameState == 'play' then
			gameState = 'pause'
		else
		end	
		
	elseif key == 'z' then
		if gameState == 'start' or gameState == 'pause' then
			gameState = 'play'
		else
		player:jump()
		end
	end
	
end

function love.draw()
	love.graphics.draw(bg, 0, 0, 0, 1.42) --( drawable, x, y, r, sx, sy, ox, oy, kx, ky ) s=scale,o =Origin offse, k= Shearing facto
	--love.graphics.draw(ground, 0,600, 0, .2, .1)
    push:apply('start')
	
    --main txt
    love.graphics.setFont(font)
    love.graphics.printf('Flappy bird', 0, 20, V_Width, 'center')
	
    --draw begin --------
	player:render()
	dirt:render()
	grass:render()
 
    
    
    
    push:apply('end')
end
