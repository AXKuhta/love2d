
Ball = {}
Ball.__index = Ball

function Ball:create(position, velocity, radius)
	local ball = {}
	setmetatable(ball, Ball)
	ball.position = position
	ball.velocity = velocity
	ball.radius = radius
	ball.acceleration = Vec2:create(0, 0)
	return ball
end

function Ball:draw()
	love.graphics.circle("fill", self.position.x, self.position.y, self.radius)

	--- Wrap images
	love.graphics.circle("fill", self.position.x - h, self.position.y, self.radius)
	love.graphics.circle("fill", self.position.x + h, self.position.y, self.radius)
	love.graphics.circle("fill", self.position.x, self.position.y - h, self.radius)
	love.graphics.circle("fill", self.position.x, self.position.y + h, self.radius)
end

function Ball:update(dt)
	self.velocity = self.velocity + self.acceleration
	self.velocity = self.velocity:limit(5)
	self.position = self.position + self.velocity
	self:boundcheck()
end

function Ball:hit_test_paddle()

end

function Ball:boundcheck()
	self.position.x = self.position.x % w
	self.position.y = self.position.y % h
end
