
Mover = {}
Mover.__index = Mover

function Mover:create(position, width, height, mass)
	local mover = {}
	setmetatable(mover, Mover)
	mover.position = position
	mover.velocity = Vec2:create(0, 0)
	mover.width = width
	mover.height = height
	mover.mass = mass or 1
	mover.acceleration = Vec2:create(0, 0)
	return mover
end

function Mover:apply_force(force)
	self.acceleration:add(force / self.mass)
end

function Mover:draw()
	love.graphics.rectangle("fill", self.position.x - self.width/2, self.position.y - self.height/2, self.width, self.height)
end

function Mover:update(dt)
	self.velocity = self.velocity + self.acceleration
	self.position = self.position + self.velocity
	self.acceleration:mul(0)
	self:phys_boundcheck()
end

function Mover:phys_boundcheck()
	if self.position.y + self.height/2 > h then -- Bottom
		self.position.y = h - self.height/2
		self.velocity.y = -self.velocity.y
	elseif self.position.y - self.height/2 < 0 then -- Top
		self.position.y = self.height/2
		self.velocity.y = -self.velocity.y
	elseif self.position.x + self.width/2 > w then
		self.position.x = w - self.width/2
		self.velocity.x = -self.velocity.x
	elseif self.position.x - self.width/2 < 0 then
		self.position.x = self.width/2
		self.velocity.x = -self.velocity.x
	end
end

function Mover:boundcheck()
	self.position.x = self.position.x % w
	self.position.y = self.position.y % h
end
