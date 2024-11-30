
--
-- Система частиц
--

ParticleSystem = {}
ParticleSystem.__index = ParticleSystem

function ParticleSystem:create()
	local self = {}
	setmetatable(self, ParticleSystem)

	self.particles = {}

	return self
end

function ParticleSystem:draw()
	for k, v in pairs(self.particles) do
		v:draw()
	end
end

function ParticleSystem:add_particle(particle)
	self.particles[#self.particles + 1] = particle
end

function ParticleSystem:update(dt)
	--if #self.particles < self.n then
	--	self.particles[#self.particles + 1] = self:create_particle()
	--end

	for k, v in pairs(self.particles) do
		v:update(dt)

		if v:is_dead() then
			self.particles[k] = nil -- Безопасно
		end
	end
end
