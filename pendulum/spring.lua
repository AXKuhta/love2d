Spring = {}
Spring.__index = Spring

function Spring:create(origin, length)
	local self = {}
	setmetatable(self, Spring)
	self.origin = origin
	self.length = length
	self.k = 0.1

	self.position = Vec2:create(0, 0)
	self.angle = 0
	self.angular_velocity = 0
	self.angular_acceleration = 0
	self.damping = 0.995
	self.radius = 20
	self.dragging = false

	return self
end

function Spring:connect(entity)
	local delta = entity.position - self.origin
	local direction = delta:norm()
	local distance = delta:mag()
	local stretch = distance - self.length

	local force = direction * (-1 * self.k * stretch)

	entity:apply_force(force)
end

function Spring:draw(entity)
	love.graphics.rectangle("fill", self.origin.x - 5, self.origin.y - 5, 10, 10)
	love.graphics.line(entity.position.x, entity.position.y, self.origin.x, self.origin.y)
end

function Spring:constrain_length(entity, min_len, max_len)
	local delta = entity.position - self.origin
	local direction = delta:norm()
	local distance = delta:mag()

	if distance < min_len then
		entity.position = self.origin + direction*min_len
		entity.velocity:mul(0)
	elseif distance > max_len then
		entity.position = self.origin + direction*max_len
		entity.velocity:mul(0)
	end
end
