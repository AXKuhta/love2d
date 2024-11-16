
Entity = {}
Entity.__index = Entity

function Entity:create(position, length)
	local self = {}
	setmetatable(self, Entity)

	self.position = position
	self.velocity = Vec2:create(0, 0)
	self.acceleration = Vec2:create(0, 0)
	self.drag_offset = Vec2:create(0, 0)
	self.damping = 0.9
	self.mass = 10
	self.dragging = false
	self.radius = 20

	return self
end

function Entity:handle_input()
	local x, y = love.mouse.getPosition()
	v = Vec2:create(x, y)

	if love.mouse.isDown(1) then
		if (self.position - v):mag() <= self.radius then
			self.dragging = true
			self.drag_offset = self.position - v
		end
	else
		self.dragging = false
	end
end

function Entity:drag()
	if self.dragging then
		local x, y = love.mouse.getPosition()
		v = Vec2:create(x, y)

		self.position = v + self.drag_offset
	end
end

function Entity:apply_force(force)
	self.acceleration = self.acceleration + force
end

function Entity:update(dt)
	self:handle_input()

	self.velocity = self.velocity + self.acceleration
	self.velocity = self.velocity * self.damping
	self.acceleration:mul(0)

	self.position = self.position + self.velocity

	self:drag()
end

function Entity:draw()
	local mode = "fill"

	if self.dragging then
		mode = "line"
	end

	love.graphics.circle(mode, self.position.x, self.position.y, self.radius)
end
