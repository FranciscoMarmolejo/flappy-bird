Pipe = Class{}

function Pipe:init(x,y,w,h)
	self.x = x
	self.y = y
	self.w = w
	self.h = h
end

function Pipe:update(dt)
	self.x = self.x - 10 *dt 
end

function Pipe:render()
	love.graphics.setColor(.5, 1, 0)
	love.graphics.rectangle('fill',self.x, self.y, self.w, self.h)
end