
require("vec")
require("ball")
require("paddle")

------------------------------------------------------------------------------------
-- Declare all globals here
------------------------------------------------------------------------------------
w = 500
h = 500

function love.load()
	love.window.setMode(w, h)
	ball = Ball:create(
		Vec2:create(300, 240),
		Vec2:create(),
		20
	)

	ball.velocity.x = 3
	ball.velocity.y = -0.3

	local paddle_size = Vec2:create(20, 100)

	paddle_l = Paddle:create(
		Vec2:create(40, h/2),
		paddle_size
	)

	paddle_r = Paddle:create(
		Vec2:create(w - 40, h/2),
		paddle_size
	)
end

function love.update(dt)
	x, y = love.mouse.getPosition()
	v = Vec2:create(x, y)

	-- Preventing object clipping by ensuring that dt is never too large
	-- The world will slow down below 25 fps, that's OK
	-- Ensure elsewhere that no object ever moves faster than 25px per second
	if dt > (1/25) then
		dt = 1/25
	end

	ball:update(dt)
	ball:hit_test_rect(paddle_r)
	ball:hit_test_rect(paddle_l)

	if love.keyboard.isDown("w") then
		paddle_l.position.y = paddle_l.position.y - 100*dt
	elseif love.keyboard.isDown("s") then
		paddle_l.position.y = paddle_l.position.y + 100*dt
	end
end

function love.draw()
	paddle_l:draw()
	paddle_r:draw()
	ball:draw()

	love.graphics.print("FPS: " .. tostring(love.timer.getFPS()), 10, 10)
end
