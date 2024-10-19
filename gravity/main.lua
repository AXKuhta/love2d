
require("vec")
require("mover")
require("attractor")

w = 500
h = 500

function love.load()
	love.window.setMode(w, h)
	mover_a = Mover:create(
		Vec2:create(200, 200),
		Vec2:create(),
		1
	)

	mover_b = Mover:create(
		Vec2:create(300, 200),
		Vec2:create(),
		2
	)

	attr = Attractor:create(
		Vec2:create(250, 400),
		30
	)

	gravity = Vec2:create(0, 0.01)
end

function love.update(dt)
	x, y = love.mouse.getPosition()
	v = Vec2:create(x, y)

	mover_a:update(dt)
	mover_b:update(dt)

	mover_a:apply_force( attr:attract(mover_a) )
	mover_b:apply_force( attr:attract(mover_b) )
end

function love.draw()
	mover_a:draw()
	mover_b:draw()
	attr:draw()
end