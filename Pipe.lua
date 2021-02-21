Pipe = Class{}

function Pipe:init(x,y,w,h,speed)
	self.x = x
	self.y = y
	self.w = w
	self.h = h
	self.speed = speed
	self.pass = 0--0 por default, parte del score
end

function Pipe:update(dt)
	self.x = self.x - self.speed *dt 
end

function Pipe:render()
	love.graphics.setColor(.5, 1, 0)
	love.graphics.rectangle('fill',self.x, self.y, self.w, self.h)
end