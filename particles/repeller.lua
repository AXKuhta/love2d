
Repeller = {}
Repeller.__index = Repeller

function Repeller:create(position, strength)
	local self = {}
	setmetatable(self, Repeller)

	self.position = position
	self.strength = strength or 100
	self.radius = 40

	return self
end

function Repeller:repel(particle)
	local delta = self.position - particle.position
	local dist = delta:mag()
	local dir = delta:norm()

	-- if dist <= self.radius * 2.01 then
	-- 	dist = 1
	-- end

	local force = dir * -1 * self.strength / (dist*dist) -- Inverse square

	particle:apply_force(force)
end

function Repeller:interact_with_system(system)
	for k, v in pairs(system.particles) do
		self:repel(v)
	end
end

function Repeller:update(dt)

end

function Repeller:draw()
	love.graphics.circle("line", self.position.x, self.position.y, self.radius)
end
