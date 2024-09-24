
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

--
-- LUUR
-- LBBR
-- LBBR
-- LBBR
-- LDDR
--
function Ball:hit_test_rect(rect)
	-- Four lines that make a rectangle
	local left_x 	= rect.position.x - rect.size.x/2
	local right_x 	= rect.position.x + rect.size.x/2
	local top_y 	= rect.position.y - rect.size.y/2
	local bottom_y 	= rect.position.y + rect.size.y/2

	if self:hit_test_line(left_x, top_y, left_x, bottom_y) then
		self.velocity.x = -self.velocity.x
		self.position.x = left_x - self.radius - 0.1
	elseif self:hit_test_line(right_x, top_y, right_x, bottom_y) then
		self.velocity.x = -self.velocity.x
		self.position.x = right_x + self.radius + 0.1
	elseif self:hit_test_line(left_x, top_y, right_x, top_y) then
		self.velocity.y = -self.velocity.y
		self.position.y = top_y - self.radius - 0.1
	elseif self:hit_test_line(left_x, bottom_y, right_x, bottom_y) then
		self.velocity.y = -self.velocity.y
		self.position.y = bottom_y + self.radius + 0.1
	end
end

function Ball:hit_test_line(x1, y1, x2, y2)
	local dx = x2 - x1
	local dy = y2 - y1
	local a = dx*dx + dy*dy
	local b = 2*(dx*(x1 - self.position.x) + dy*(y1 - self.position.y))
	local c = (x1 - self.position.x)^2 + (y1 - self.position.y)^2 - self.radius^2
	local D = b^2 - 4*a*c

	if D < 0 then
		return false
	end

	local t1 = (-b - D^0.5) / (2*a)
	local t2 = (-b + D^0.5) / (2*a)

	return (t1 >= 0 and t1 <= 1) or (t2 >= 0 and y2 <= 1)
end

function Ball:boundcheck()
	self.position.x = self.position.x % w
	self.position.y = self.position.y % h
end
