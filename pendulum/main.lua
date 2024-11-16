
require("vec")
require("pendulum")
require("entity")
require("spring")

w = 800
h = 600

function love.load()
	love.window.setMode(w, h)

	p1 = Pendulum:create(
		Vec2:create(w/2, h/2),
		100
	)

	p2 = Pendulum:create(
		p1.position,
		100
	)

	p3 = Pendulum:create(
		p2.position,
		100
	)

	s1 = Spring:create(
		Vec2:create(50, 100),
		200
	)

	e1 = Entity:create(
		Vec2:create(20, 20)
	)

	gravity = Vec2:create(
		0, 10
	)
end

function love.update(dt)
	x, y = love.mouse.getPosition()
	v = Vec2:create(x, y)

	p1:update(dt)
	p2:update(dt)
	p3:update(dt)

	s1:constrain_length(e1, 20, 400)
	s1:connect(e1)

	e1:apply_force(gravity)

	e1:update(dt)
end

function love.draw()
	p1:draw()
	p2:draw()
	p3:draw()

	s1:draw(e1)

	e1:draw()
end