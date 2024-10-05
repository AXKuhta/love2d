
Liquid = {}
Liquid.__index = Liquid

-- c is viscosity
function Liquid:create(x, y, width, height, c)
	local liquid = {}
	setmetatable(liquid, Liquid)
	liquid.x = x
	liquid.y = y
	liquid.width = width
	liquid.height = height
	liquid.c = c
	return liquid
end

function Liquid:bbox_test(circle)
	local xc = circle.position.x + circle.radius/2
	local yc = circle.position.y + circle.radius/2

	local in_horizontal = xc + circle.radius/2 > self.x and xc - circle.radius/2 < self.x + self.width
	local in_vertical = 	yc + circle.radius/2 > self.y and yc - circle.radius/2 < self.y + self.height

	return in_horizontal and in_vertical
end

function Liquid:draw()
	local r, g, b, a = love.graphics.getColor()

	love.graphics.setColor(0, 120/255, 190/255, 0.5)
	love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
	love.graphics.setColor(r, g, b, a)
end
