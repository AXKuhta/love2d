
Obstacle = {}
Obstacle.__index = Obstacle

function Obstacle:create(base)
	local self = {}
	setmetatable(self, Obstacle)
	self.radius = 20
	self.base = base

	self.position = Vec2:create(0, 0)

	-- Накопители фазы для x, y
	self.angle = Vec2:create(0, 0)

	-- Частота гармонической функции
	self.velocity = Vec2:create(
		love.math.random(-.05, .05),
		love.math.random(-.05, .05)
	)

	self.amplitude = Vec2:create(
		love.math.random(w/8),
		love.math.random(h/8)
	)

	return self
end

function Obstacle:update(dt)
	self.angle:add(self.velocity)
	self.position.x = math.sin(self.angle.x) * self.amplitude.x + self.base.x
	self.position.y = math.sin(self.angle.x) * self.amplitude.y + self.base.y

	self.base.x = self.base.x + 2

	self.base.x = self.base.x % w
	self.base.y = self.base.y % h
end

function Obstacle:draw()
	love.graphics.push()
	love.graphics.translate(self.position.x, self.position.y)
	love.graphics.circle("fill", 0, 0, self.radius)
	love.graphics.circle("fill", 0+w, 0, self.radius)
	love.graphics.circle("fill", 0-w, 0, self.radius)
	love.graphics.circle("fill", 0, 0+h, self.radius)
	love.graphics.circle("fill", 0, 0-h, self.radius)
	love.graphics.pop()
end
