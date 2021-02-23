Pipe = Class{}
local PIPE_IMAGE = love.graphics.newImage("img/pipe.png")
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
	love.graphics.setColor(.5, 1, 0)
	--love.graphics.rectangle('line',self.x, self.y, self.w, self.h)
	if self.rotation == false then
		love.graphics.draw(PIPE_IMAGE,self.x,self.y,0,.145,.15)
	elseif self.rotation == true then
		love.graphics.draw(PIPE_IMAGE,self.x+self.w,self.y+self.h,math.pi,.145,.15)
	end	

end