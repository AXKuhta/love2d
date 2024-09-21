
require("vec")

w = 500
h = 500

function love.load()
	love.window.setMode(w, h)

	center = Vec2:create(w / 2, h / 2)
end

function love.draw()
	local x, y = love.mouse.getPosition()
	local v = Vec2:create(x, y)
	local delta = v - center
	local mag = delta:mag()

	local line_v = center + delta:norm()*50

	love.graphics.setColor(1, 0, 0)
	love.graphics.rectangle("fill", 0, 0, mag, 10)
	love.graphics.line(center.x, center.y, line_v.x, line_v.y)
end