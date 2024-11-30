
Particle = {}
Particle.__index = Particle

--
-- Частица
--
function Particle:create(position)
	local self = {}
	setmetatable(self, Particle)

	self.gravity = Vec2:create(0, .05)

	self.position = position
	self.acceleration = Vec2:create(0, 0)
	self.velocity = Vec2:create(
		math.random(-400, 400)/100,
		math.random(-400, 0)/100
	)

	self.lifespan = 2 -- В секундах
	self.life = math.random(100 * self.lifespan/2, self.lifespan * 100)/100
	self.texture = love.graphics.newImage("texture.png")

	return self
end

function Particle:apply_force(force)
	self.acceleration:add(force)
end

function Particle:update(dt)
	self:apply_force(self.gravity)

	self.velocity:add(self.acceleration)
	self.position:add(self.velocity)
	self.life = self.life - 1*dt

	self.acceleration:mul(0)
end

function Particle:is_dead()
	if self.life < 0 then
		return true
	end
	return false
end

function Particle:draw()
	r, g, b, a = love.graphics.getColor()
	love.graphics.setColor(.75, .75, 0, self.life/self.lifespan)
	love.graphics.draw(self.texture, self.position.x, self.position.y)
	love.graphics.setColor(r, g, b, a)
end

--
-- Система частиц
--

ParticleSystem = {}
ParticleSystem.__index = ParticleSystem

function ParticleSystem:create(origin, n, cls)
	local self = {}
	setmetatable(self, ParticleSystem)

	self.origin = origin
	self.n = n or 10
	self.particles = {}
	self.cls = cls or Particle

	return self
end

function ParticleSystem:draw()
	for k, v in pairs(self.particles) do
		v:draw()
	end
end

function ParticleSystem:create_particle()
	return self.cls:create(self.origin:copy())
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


