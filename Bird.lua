--Bird
Bird = Class{}
local BIRD_IMAGE = love.graphics.newImage("img/bird.png")

function Bird:init()
	self.x = 40
	self.y = 110
	self.w = 19
	self.h = 19
	self.gravity = 0 --lo hace caer 
end

function Bird:update(dt)
	self.gravity = self.gravity + 516 * dt
	self.y = self.y + self.gravity *dt
end

function Bird:jump()
	if self.y >0 then
		self.gravity = -120
	end
end

function Bird:collides(pipe)
	if self.x > pipe.x + pipe.w or pipe.x > self.x + self.w then
		return false
	end
	  if self.y > pipe.y + pipe.h or pipe.y > self.y + self.h then 
		return false
	end
	return true 
end

function Bird:render()
	--love.graphics.setColor(1,1,.2)
	--love.graphics.rectangle('line',self.x, self.y, self.w, self.h)
	love.graphics.draw(BIRD_IMAGE,self.x-1, self.y-1)
end