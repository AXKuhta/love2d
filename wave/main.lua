
require("vec")
require("wave")

w = 800
h = 600

function love.load()
	love.window.setMode(w, h)

	ww1 = Wave:create(
		Vec2:create(0, 0),
		w,
		50,
		10
	)
end

function love.update(dt)
	ww1:update(dt)
end

function love.draw()
	ww1:draw()
end