push  = require 'push'
Class = require 'Class'
-----

W_Width  = 1280
W_Height = 720

V_Width  = 432
V_Height = 243

function love.load()
    love.window.setTitle("Paco n Garret Productions")
    --sponsors
    ground = love.graphics.newImage("img/ground.png")

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
    push:apply('start')
    --draw begin --------

    --main txt
    love.graphics.setFont(font)
    love.graphics.printf('Flappy bird', 0, 20, V_Width, 'center') 
    
    love.graphics.draw(ground, 50,10, 0, .2, .2)
    
    push:apply('end')
end
