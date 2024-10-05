
require("vec")
require("mover")

w = 500
h = 500

function love.load()
	love.window.setMode(w, h)
	mover = Mover:create(
		Vec2:create(300, 200),
		Vec2:create()
	)

	mover.acceleration.x = 0.01
	mover.acceleration.y = -0.01

	gravity = Vec2:create(0, 0.01)
end

function love.update(dt)
	x, y = love.mouse.getPosition()
	v = Vec2:create(x, y)

	dir = (v - mover.position):norm()

	--mover.acceleration = dir * 0.05

	mover:apply_force(gravity)

	mover:update(dt)
end

function love.draw()
	mover:draw()
end