
require("vec")
require("box")
require("particle")

system = ParticleSystem:create()
w = 800
h = 600

function love.load()
	love.window.setMode(w, h)

	pos = Vec2:create(w/2, h/2)

	box = Box:create(
		pos,
		Vec2:create(20, 20)
	)
end

function love.update(dt)
	x, y = love.mouse.getPosition()
	v = Vec2:create(x, y)

	system:update(dt)
	box:update(dt)

	if love.mouse.isDown(1) then
		box:clicked(v)
	end
end

function love.draw()
	-- particle:draw()
	system:draw()
	box:draw()
end