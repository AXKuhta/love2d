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

function Pendulum:update(dt)
	self.position.x = self.length * math.sin(self.angle) + self.origin.x
	self.position.y = self.length * math.cos(self.angle) + self.origin.y
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
