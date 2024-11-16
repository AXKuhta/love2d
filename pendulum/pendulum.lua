Pendulum = {}
Pendulum.__index = Pendulum

function Pendulum:create(origin, length)
	local self = {}
	setmetatable(self, Pendulum)
	self.origin = origin
	self.length = length
	self.position = Vec2:create(0, 0)
	self.angle = 0
	self.angular_velocity = 0
	self.angular_acceleration = 0
	self.damping = 0.995
	self.radius = 20
	self.dragging = false
	return self
end

function Pendulum:drag()
	if self.dragging then
		local x, y = love.mouse.getPosition()
		local v = Vec2:create(x, y)
		local diff = v - self.origin
		self.angle = math.atan2(diff.x, diff.y)
	end
end

function Pendulum:handle_input()
	local x, y = love.mouse.getPosition()
	v = Vec2:create(x, y)

	if love.mouse.isDown(1) then
		if (self.position - v):mag() <= self.radius then
			self.dragging = true
		end
	else
		self.dragging = false
	end
end

function Pendulum:update(dt)
	self:handle_input()
	self:drag()

	self.position.x = self.length * math.sin(self.angle) + self.origin.x
	self.position.y = self.length * math.cos(self.angle) + self.origin.y

	local gravity = 0.4

	self.angular_acceleration = (-1*gravity / self.length) * math.sin(self.angle)
	self.angular_velocity = self.angular_velocity + self.angular_acceleration
	self.angular_velocity = self.angular_velocity * self.damping
	self.angle = self.angle + self.angular_velocity
end

function Pendulum:draw()
	love.graphics.push()
	love.graphics.translate(self.origin.x, self.origin.y)
	love.graphics.circle("line", 0, 0, 5)
	love.graphics.pop()

	love.graphics.line(
		self.origin.x, self.origin.y,
		self.position.x, self.position.y
	)

	love.graphics.circle("fill", self.position.x, self.position.y, self.radius)
end
