
require("vec")
require("particle")
require("repeller")

w = 800
h = 600

function love.load()
	love.window.setMode(w, h)

	particle = Particle:create(
		Vec2:create(w/2, h/2)
	)

	system = ParticleSystem:create(
		Vec2:create(w/2, h/2),
		100
	)

	repeller = Repeller:create(
		Vec2:create(w/2 - 100, h/2 + 100)
	)
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

	repeller:interact_with_system(system)
	system:update(dt)
end

function love.draw()
	particle:draw()
	system:draw()
	repeller:draw()
end