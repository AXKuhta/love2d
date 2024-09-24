
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
-- Alt, vert line at x=self.x-other.x
-- xx + yy = r
-- yy = r - xx
-- y = sqrt(r - xx)
--
function Ball:hit_test_rect(rect)
	-- Four lines that make a rectangle
	local left_x 	= rect.position.x - rect.size.x/2
	local right_x 	= rect.position.x + rect.size.x/2
	local top_y 	= rect.position.y - rect.size.y/2
	local bottom_y 	= rect.position.y + rect.size.y/2

	--if self:hit_test_line()
end

function Ball:hit_test_line(x1, y1, x2, y2)
	local local_x1 = x1 - self.position.x
	local local_y1 = self.position.y - y1
	local local_x2 = x2 - self.position.x
	local local_y2 = self.position.y - y2

	-- y = ax + b
	local a = (local_y2 - local_y1) / (local_x2 - local_x1 + 0.0001)
	local b = local_y2 - a*local_x2

	-- xx + yy = radiusradius
	-- yy = aa * xx + 2abx + bb
	-- xx + aa * xx + 2abx + bb = radiusradius
	-- (1 + aa) * xx + 2abx + bb = radiusradius
	-- (1 + aa) * xx + 2abx + bb - radiusradius = 0
	-- a_ = 1 + aa
	-- b_ = 2ab
	-- c_ = bb - radiusradius
	-- D = b_b_ - 4a_c_
	-- D > 0			Intersect exists
	local a_ = 1 + a*a
	local b_ = 2*a*b
	local c_ = b*b - self.radius*self.radius
	local D = b_*b_ - 4*a_*c_

	local btm = math.min(local_y1, local_y2)
	local top = math.max(local_y1, local_y2)

	-- ( -b_ ± sqrt(D) ) /2/a
	if D >= 0 and top > 0 and btm < 0 then
		return true
	else
		return false
	end
end

function Ball:boundcheck()
	self.position.x = self.position.x % w
	self.position.y = self.position.y % h
end
