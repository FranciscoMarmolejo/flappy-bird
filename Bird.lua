--Bird
Bird = Class{}

function Bird:init()
	self.x = 75
	self.y = 180
	self.w = 30
	self.h = 25
	self.gravity = 0 --lo hace caer 
end

function Bird:update(dt)
	self.gravity = self.gravity + 516 * dt
	self.y = self.y + self.gravity *dt
end

function Bird:jump()
	if self.y >0 then
		self.gravity = -165
	end
end

function Bird:render()
	love.graphics.setColor(1,1,.2)
	love.graphics.rectangle('fill',self.x, self.y, self.w, self.h)
end