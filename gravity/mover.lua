
Mover = {}
Mover.__index = Mover

function Mover:create(position, velocity, mass)
	local mover = {}
	setmetatable(mover, Mover)
	mover.position = position
	mover.velocity = velocity
	mover.radius = 20
	mover.mass = mass or 1
	mover.acceleration = Vec2:create(0, 0)
	return mover
end

function Mover:apply_force(force)
	self.acceleration:add(force / self.mass)
end

function Mover:draw()
	love.graphics.circle("fill", self.position.x, self.position.y, self.radius)
end

function Mover:update(dt)
	self.velocity = self.velocity + self.acceleration

	if self.velocity:norm() then
		self.velocity:add( self.velocity:norm() * -0.001 )
	end

	self.position = self.position + self.velocity
	self.acceleration:mul(0)
	self:phys_boundcheck()
end

function Mover:phys_boundcheck()
	if self.position.y > h - self.radius then -- Bottom
		self.position.y = h - self.radius
		self.velocity.y = -self.velocity.y
	elseif self.position.y < 0 + self.radius then -- Top
		self.position.y = self.radius
		self.velocity.y = -self.velocity.y
	elseif self.position.x > w - self.radius then
		self.position.x = w - self.radius
		self.velocity.x = -self.velocity.x
	elseif self.position.x < 0 + self.radius then
		self.position.x = self.radius
		self.velocity.x = -self.velocity.x
	end
end

function Mover:boundcheck()
	self.position.x = self.position.x % w
	self.position.y = self.position.y % h
end
