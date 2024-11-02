
Circle = {}
Circle.__index = Circle

function Circle:create(position, radius)
	local self = {}
	setmetatable(self, Circle)
	self.position = position
	self.velocity = Vec2:create(0, 0)
	self.radius = radius
	return self
end

function Circle:update(dt)
	self.position:add(self.velocity)

	self.position.x = self.position.x % w
	self.position.y = self.position.y % h
end

function Circle:collide_with_circle(other)
	local dist = (self.position - other.position):mag()
	return dist <= (self.radius + other.radius)
end

function Circle:draw()
	love.graphics.push()
	love.graphics.setColor(1,1,1)
	love.graphics.translate(self.position.x - self.radius, self.position.y - self.radius)
	love.graphics.circle("fill", 0, 0, self.radius)
	love.graphics.circle("fill", 0+w, 0, self.radius)
	love.graphics.circle("fill", 0-w, 0, self.radius)
	love.graphics.circle("fill", 0, 0+h, self.radius)
	love.graphics.circle("fill", 0, 0-h, self.radius)
	love.graphics.pop()
end
