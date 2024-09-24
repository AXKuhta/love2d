require("vec")
require("ball")

------------------------------------------------------------------------------------
-- Declare all globals here
------------------------------------------------------------------------------------
w = 500
h = 500

function love.load()
	love.window.setMode(w, h)
	ball = Ball:create(
		Vec2:create(300, 200),
		Vec2:create()
	)

	ball.acceleration.x = 0.01
	ball.acceleration.y = -0.01
end

function love.update(dt)
	x, y = love.mouse.getPosition()
	v = Vec2:create(x, y)

	dir = (v - ball.position):norm()

	ball.acceleration = dir * 0.05

	ball:update(dt)
end

function love.draw()
	ball:draw()
end
