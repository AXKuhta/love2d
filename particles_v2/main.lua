
require("vec")
require("box")
require("particle")

w = 800
h = 600

function love.load()
	love.window.setMode(w, h)

	-- particle = Particle:create(
	-- 	Vec2:create(w/2, h/2)
	-- )

	-- system = ParticleSystem:create(
	-- 	Vec2:create(w/2, h/2),
	-- 	100
	-- )

	pos = Vec2:create(w/2, h/2)

	box = Box:create(
		pos,
		Vec2:create(200, 200)
	)
end

function love.update(dt)
	x, y = love.mouse.getPosition()
	v = Vec2:create(x, y)

	pos.x = x
	pos.y = y

	-- particle:update(dt)

	-- if particle:is_dead() then
	-- 	particle = Particle:create(
	-- 		Vec2:create(w/2, h/2)
	-- 	)
	-- end

	-- system:update(dt)
end

function love.draw()
	-- particle:draw()
	-- system:draw()
	box:draw()
end