push  = require 'push'
Class = require 'Class'
-----

W_Width  = 1280
W_Height = 720

V_Width  = 432
V_Height = 243

function love.load()
    love.window.setTitle("Paco n Garret Productions")
    --imagenes
    ground = love.graphics.newImage("img/ground.png")
	bg = love.graphics.newImage("img/background.png")

    love.graphics.setDefaultFilter('nearest', 'nearest')
    math.randomseed(os.time())

    push:setupScreen(V_Width, V_Height, W_Width, W_Height, {
        fullscreen = false,
        resizable  = false,
        vsync      = false,
    })

    font = love.graphics.newFont('font.ttf', 18)
    love.graphics.setFont(font)
end

function love.update(dt)

end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end

function love.draw()
	love.graphics.draw(bg, 0, 0, 0, 1.42) --( drawable, x, y, r, sx, sy, ox, oy, kx, ky ) s=scale,o =Origin offse, k= Shearing facto
	love.graphics.draw(ground, 0,600, 0, .2, .1)
    push:apply('start')
    --draw begin --------

    --main txt
    love.graphics.setFont(font)
    love.graphics.printf('Flappy bird', 0, 20, V_Width, 'center') 
    
    
    
    push:apply('end')
end
