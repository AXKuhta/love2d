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

	self.position.x = self.length * math.sin(self.angle) + self.origin.x
	self.position.y = self.length * math.cos(self.angle) + self.origin.y

	if self.dragging then
		local x, y = love.mouse.getPosition()
		self.position.x = x
		self.position.y = y
	end
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
