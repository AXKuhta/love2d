
require("vec")
require("circle")

w = 500
h = 500

function love.load()
	love.window.setMode(w, h)

	circ1 = Circle:create(Vec2:create(w/2 + 5, h/2), 20)
	circ2 = Circle:create(Vec2:create(w/2 - 5, h/2), 20)

	circ1.velocity.x = 5
	circ2.velocity.x = -5
end

function love.update(dt)
	x, y = love.mouse.getPosition()
	v = Vec2:create(x, y)

	circ1:update(dt)
	circ2:update(dt)

	if circ1:collide_with_circle(circ2) then
		print("collide")
	end

	if circ2:collide_with_circle(circ1) then
		print("collide 2")
	end
end

function love.draw()
	circ1:draw()
	circ2:draw()
end
