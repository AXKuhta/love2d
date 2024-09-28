
require("vec")
require("ball")
require("wall")
require("scene")

------------------------------------------------------------------------------------
-- Declare all globals here
------------------------------------------------------------------------------------
w = 640
h = 640

------------------------------------------------------------------------------------
-- Pong scene
------------------------------------------------------------------------------------

function init_pong_scene()
	local scene = Scene:create()

	local ball = Ball:create(
		Vec2:create(300, 240),
		Vec2:create(),
		20
	)

	ball.velocity.x = 30
	ball.velocity.y = -3

	local wall_size = Vec2:create(w, 20)

	local wall_u = Wall:create(Vec2:create(w/2, 10), wall_size)
	local wall_d = Wall:create(Vec2:create(w/2, h - 10), wall_size)

	local paddle_size = Vec2:create(20, 100)

	local paddle_l = Wall:create(
		Vec2:create(40, h/2),
		paddle_size
	)

	local paddle_r = Wall:create(
		Vec2:create(w - 40, h/2),
		paddle_size
	)

	scene.update = function(self, dt)
		ball:update(dt)
		ball:hit_test_rect(wall_u)
		ball:hit_test_rect(wall_d)
		ball:hit_test_rect(paddle_r)
		ball:hit_test_rect(paddle_l)

		if love.keyboard.isDown("w") then
			paddle_l.position.y = paddle_l.position.y - 200*dt
		elseif love.keyboard.isDown("s") then
			paddle_l.position.y = paddle_l.position.y + 200*dt
		end

		if love.keyboard.isDown("i") then
			paddle_r.position.y = paddle_r.position.y - 200*dt
		elseif love.keyboard.isDown("k") then
			paddle_r.position.y = paddle_r.position.y + 200*dt
		end
	end

	scene:add(ball)
	scene:add(wall_u)
	scene:add(wall_d)
	scene:add(paddle_l)
	scene:add(paddle_r)

	return scene
end

function love.load()
	love.window.setMode(w, h)

	pong_scene = init_pong_scene()
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

	pong_scene:update(dt)
end

function love.draw()
	pong_scene:draw()

	love.graphics.print("FPS: " .. tostring(love.timer.getFPS()), 10, 30)
end
