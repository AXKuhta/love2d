
require("vec")
require("box")
require("particle")

system = ParticleSystem:create()
w = 1920
h = 1080

function love.load()
	love.window.setMode(w, h)

	pos = Vec2:create(w/2, h/2)

	box = Box:create(
		pos,
		Vec2:create(200, 200)
	)
end

function love.update(dt)
	x, y = love.mouse.getPosition()
	v = Vec2:create(x, y)

	if box:is_dead() then
		local pos = Vec2:create(
			math.random(200, w-200),
			math.random(200, h-200)
		)
		box = Box:create(
			pos,
			Vec2:create(200, 200)
		)
	end

	system:update(dt)
	box:update(dt)
end

function love.draw()
	-- particle:draw()
	system:draw()
	box:draw()
end