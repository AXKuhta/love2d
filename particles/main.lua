
require("vec")
require("particle")

w = 800
h = 600

function love.load()
	love.window.setMode(w, h)

	particle = Particle:create(
		Vec2:create(w/2, h/2)
	)

	system = ParticleSystem:create(
		Vec2:create(w/2, h/2)
	)

	system:init()
end

function love.update(dt)
	x, y = love.mouse.getPosition()
	v = Vec2:create(x, y)

	particle:update(dt)

	if particle:is_dead() then
		particle = Particle:create(
			Vec2:create(w/2, h/2)
		)
	end

	system:update(dt)
end

function love.draw()
	particle:draw()
	system:draw()
end