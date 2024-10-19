
require("vec")
require("mover")

w = 500
h = 500

function love.load()
	love.window.setMode(w, h)
	mover_a = Mover:create(
		Vec2:create(200, 200),
		10, 80, 1
	)

	mover_b = Mover:create(
		Vec2:create(300, 200),
		20, 80, 1
	)

	gravity = Vec2:create(0, 0.2)
end

function love.update(dt)
	x, y = love.mouse.getPosition()
	v = Vec2:create(x, y)

	mover_a:apply_force(gravity)
	mover_b:apply_force(gravity)
	mover_a:apply_friction(0.005)
	mover_b:apply_friction(0.005)

	mover_a:update(dt)
	mover_b:update(dt)
end

function love.draw()
	mover_a:draw()
	mover_b:draw()
end