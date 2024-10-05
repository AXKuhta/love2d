
require("vec")
require("mover")
require("liquid")

w = 500
h = 500

function love.load()
	love.window.setMode(w, h)
	mover = Mover:create(
		Vec2:create(200, 200),
		Vec2:create(),
		1
	)

	gravity = Vec2:create(0, 0.1)
end

function love.update(dt)
	x, y = love.mouse.getPosition()
	v = Vec2:create(x, y)

	mover:apply_force(gravity)

	local friction = (mover.velocity * -1):norm()

	if friction then
		friction:mul(0.005)
		mover:apply_force(friction)
	end

	mover:update(dt)
end

function love.draw()
	mover:draw()
end