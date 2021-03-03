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
	point = love.audio.newSource("mp3/score.mp3", "static")
	wing = love.audio.newSource("mp3/wing.mp3", "static")
	lose = love.audio.newSource("mp3/lose.mp3", "static")
	slap = love.audio.newSource("mp3/slap.mp3", "static")
	win = love.audio.newSource("mp3/dub.mp3", "static")
	--Colors
	terrain = {.87,.84,.58}
	green = {.30,.74,.18}

    ground = love.graphics.newImage("img/ground.png")
	groundScroll = 0
	gspeed = 60

	bg = love.graphics.newImage("img/background.png")
	bgScroll = 0
	bgspeed = 30
	bgLP = 413
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

	function randomPipes()
		topSpace = math.random(0,108)
		downSpace = 50
	end
		--
	player= Bird()
	gameState = 'start'
	dirt = Ground(0,218,168,25,terrain)
	score = 0
	gameSpeed = 100
	--Loop
	function firstpipes()
		randomPipes()
		pipe2 = Pipe(V_Width ,0, 25, topSpace, gameSpeed,true)
		pipe1 = Pipe(V_Width ,topSpace + downSpace, 25, V_Height-downSpace-topSpace-35, gameSpeed,false)
	end
	firstpipes()
	function secondspipes()
		randomPipes()
		pipe4 = Pipe(V_Width + 120 ,0, 25, topSpace, gameSpeed,true)
		pipe3 = Pipe(V_Width + 120 ,topSpace + downSpace, 25, V_Height-downSpace-topSpace-35, gameSpeed,false)
	end
	secondspipes()

end

function love.update(dt)

	bgScroll = (bgScroll + bgspeed*dt) % bgLP
	groundScroll = (groundScroll + gameSpeed*dt) % V_Width

	if gameState == 'start' then
		
	elseif gameState == 'play' then
		if pipe1.x + pipe1.w <0 then
			firstpipes()
			pipe1.x=pipe3.x+120
			pipe2.x=pipe4.x+120
		end

		if pipe3.x + pipe3.w <0 then
			secondspipes()
			pipe3.x=pipe1.x+120
			pipe4.x=pipe2.x+120
		end
		
		if pipe1.x < player.x then
			if pipe1.pass == 0 then
				score = score+1
				pipe1.pass = 1
				point:play()
			end
		elseif  pipe3.x < player.x then
			if pipe3.pass == 0 then
				score = score+1
				pipe3.pass = 1
				point:play()
			end
		end

		if score > 9 then 
			gameState = 'won'
			win:play()
			pipe1.x , pipe2.x, pipe3.x, pipe4.x = V_Width + 5 , V_Width + 5, V_Width + 5, V_Width + 5
		end
		if player:collides(pipe1) or player:collides(pipe2) or player:collides(pipe3) or player:collides(pipe4) then
			slap:play()
			gameState='end'
			player.y = 190
			pipe1.x , pipe2.x, pipe3.x, pipe4.x = V_Width + 5 , V_Width + 5, V_Width + 5, V_Width + 5
			lose:play()
		end	
		if player.y < 1 or player.y > 185 then
			slap:play()
			gameState='end'
			pipe1.x , pipe2.x, pipe3.x, pipe4.x = V_Width + 5 , V_Width + 5, V_Width + 5, V_Width + 5
			lose:play()
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
		elseif gameState == 'end' or gameState == 'won' then
			player= Bird()
			gameState = 'start'
			score = 0
			gameSpeed = 100
			firstpipes()
			secondspipes()
		end	
		
	elseif key == 'z' then
		if gameState == 'start' or gameState == 'pause' then
			gameState = 'play'
		elseif gameState == 'play' then
			player:jump()
			wing:play()
		end
	end
	
end

function love.draw()
	love.graphics.draw(bg, -bgScroll, 0, 0, 1.42) 
	love.graphics.draw(ground, -groundScroll, 618, 0, 1.9) 
    push:apply('start')
	love.graphics.setFont(font)
   
	if gameState == 'start' then
    	love.graphics.printf('Flappy bird', 0, 20, V_Width, 'center')
	elseif gameState == 'end' then
		love.graphics.printf('Game over! Your score was:', 0, 20, V_Width, 'center')
		love.graphics.print(tostring(score),V_Width/2, 80)
		love.graphics.printf('Press Enter to restart', 15, 105, 200, 'right',0,.6,.6)
	elseif gameState == 'won' then
		love.graphics.printf('You won! Congrats!:', 0, 20, V_Width, 'center')
		love.graphics.printf('Press Enter to restart', 15, 105, 200, 'right',0,.6,.6)
	else
		love.graphics.print(tostring(score),V_Width/2, V_Height/8)
	end
	
	player:render()	
		player:render()	
	player:render()	
	dirt:render()
	pipe1:render()
	pipe2:render()
    pipe3:render()
	pipe4:render()
    
    push:apply('end')
end
