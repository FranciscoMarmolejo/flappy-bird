Pipe = Class{}
local PIPE_IMAGE = love.graphics.newImage("img/pipe.png")
local ancho = PIPE_IMAGE:getWidth()*.15
local alto = PIPE_IMAGE:getHeight()*.15
function Pipe:init(x,y,w,h,speed,r)
	self.x = x
	self.y = y
	self.w = w
	self.h = h
	self.speed = speed
	self.pass = 0--0 por default, parte del score
	self.rotation = r -- 0 necesito rotar, 1 no necesito rotar
end

function Pipe:update(dt)
	self.x = self.x - self.speed *dt 
end

function Pipe:render()
	PIPE_SPRITE= love.graphics.newQuad(0,0,self.w, self.h,ancho,alto)

	love.graphics.setColor(.5, 1, 0)
	love.graphics.rectangle('line',self.x, self.y, self.w, self.h)
	if self.rotation == false then
		--love.graphics.draw(PIPE_IMAGE,self.x,self.y,0,.145,.15) <--Metodo anterior
		love.graphics.draw(PIPE_IMAGE,PIPE_SPRITE,self.x,self.y)
	elseif self.rotation == true then
		love.graphics.draw(PIPE_IMAGE,PIPE_SPRITE,self.x+self.w,self.y+self.h,math.pi)
	end	

end