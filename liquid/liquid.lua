
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

-- TODO: переделать под кружок, где position определяет *центр*
function Liquid:bbox_test_circle(circle)
	local xc = circle.position.x + circle.radius/2
	local yc = circle.position.y + circle.radius/2

	local in_horizontal = xc + circle.radius/2 > self.x and xc - circle.radius/2 < self.x + self.width
	local in_vertical = 	yc + circle.radius/2 > self.y and yc - circle.radius/2 < self.y + self.height

	return in_horizontal and in_vertical
end

function Liquid:bbox_test_point(x, y)
	local in_horizontal = x >= self.x and x <= self.x + self.width
	local in_vertical = y >= self.y and y <= self.y + self.height

	return in_horizontal and in_vertical
end

-- Четыре точки
function Liquid:bbox_test_box(box)
	local right_x = box.position.x - box.width/2
	local left_x = box.position.x + box.width/2
	local top_y = box.position.y - box.height/2
	local bottom_y = box.position.y + box.height/2

	return self:bbox_test_point(right_x, top_y) or self:bbox_test_point(left_x, top_y) or self:bbox_test_point(right_x, bottom_y) or self:bbox_test_point(left_x, bottom_y)
end

function Liquid:interact_with_box(box)
	if self:bbox_test_box(box) then
		local mag = box.velocity:mag() -- Harder impact, harder ricochet
		local drag = self.c * mag * mag * box.width

		local drag_vec = (box.velocity * -1):norm()

		drag_vec:mul(drag)

		box:apply_force(drag_vec)
	end
end

function Liquid:draw()
	local r, g, b, a = love.graphics.getColor()

	love.graphics.setColor(0, 120/255, 190/255, 0.5)
	love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
	love.graphics.setColor(r, g, b, a)
end
