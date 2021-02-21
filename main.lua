push  = require 'push'
Class = require 'Class'
bird = require 'Bird'
bird = require 'Ground'
pipe = require 'Pipe'
-----

W_Width  = 500
W_Height = 720

V_Width  = 168
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
		--pipe
		function randomPipes()
			topSpace = math.random(0,108)
			downSpace = 50
		end
		--
	player= Bird()
	gameState = 'start' -- 'pause' 'collide'
	dirt = Ground(0,218,168,25,terrain)
	grass = Ground(0,208,168,10,green)
	score = 0
	gameSpeed = 50
	--Loop
	function firstpipes()
		randomPipes()
		pipe1 = Pipe(V_Width ,0, 25, topSpace, gameSpeed)
		pipe2 = Pipe(V_Width ,topSpace + downSpace, 25, V_Height-downSpace-topSpace-35, gameSpeed) --35 : 25 de dirt, 10 de grass
	end
	firstpipes()
	function secondspipes()
		randomPipes()
		pipe3 = Pipe(V_Width + 120 ,0, 25, topSpace, gameSpeed)
		pipe4 = Pipe(V_Width + 120 ,topSpace + downSpace, 25, V_Height-downSpace-topSpace-35, gameSpeed) --35 : 25 de dirt, 10 de grass
	end
	secondspipes()

end

function love.update(dt)
	if gameState == 'start' then
		
	elseif gameState == 'play' then
		if pipe1.x + pipe1.w <0 and pipe2.x + pipe2.w < 0 then
			firstpipes()
			pipe1.x=pipe3.x+120
			pipe2.x=pipe4.x+120
		end

		if pipe3.x + pipe3.w <0 and pipe4.x + pipe4.w < 0 then
			secondspipes()
			pipe3.x=pipe1.x+120
			pipe4.x=pipe2.x+120
		end
		
		if pipe1.x < player.x then
			if pipe1.pass == 0 then
				score = score+1
				pipe1.pass = 1
			end
		elseif  pipe3.x < player.x then
			if pipe3.pass == 0 then
				score = score+1
				pipe3.pass = 1
			end
		end
			
		player:update(dt)
		pipe1:update(dt)
		pipe2:update(dt)
		pipe3:update(dt)
		pipe4:update(dt)
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
	if gameState == 'start' then
    	love.graphics.setFont(font)
    	love.graphics.printf('Flappy bird', 0, 20, V_Width, 'center')
	else
	love.graphics.print(tostring(score),V_Width/2, V_Height/8)
	end
    --draw begin --------
	player:render()
	dirt:render()
	grass:render()

	pipe1:render()
	pipe2:render()
    pipe3:render()
	pipe4:render()
    
    
    push:apply('end')
end
