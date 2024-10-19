
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
	mover.angle = 0
	mover.active = false
	return mover
end

function Mover:apply_force(force)
	self.acceleration:add(force / self.mass)
end

function Mover:apply_friction(factor)
	local friction = (self.velocity * -1):norm()

	if friction then
		friction:mul(factor)
		self:apply_force(friction)
	end
end

function Mover:draw()
	--love.graphics.rectangle("fill", self.position.x - self.width/2, self.position.y - self.height/2, self.width, self.height)
	love.graphics.push()
	love.graphics.translate(self.position.x, self.position.y)
	love.graphics.rotate(self.angle)
	r, g, b, a = love.graphics.getColor()

	love.graphics.setLineWidth(4)
	love.graphics.line(-30, -30, 30, 0, -30, 30, -30, -30) -- Треугольник

	-- Двигатель
	local type = "line"

	if self.active then
		love.graphics.setColor(1, 0, 0, 1)
		type = "fill"
	end

	love.graphics.rectangle(type, -40, 5, 10, 20)
	love.graphics.rectangle(type, -40, -25, 10, 20)

	love.graphics.setColor(r, g, b, a)
	love.graphics.pop()
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
