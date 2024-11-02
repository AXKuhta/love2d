
function line_circle_collision(p1, p2, circle)
	local p1x = p1.x
	local p1y = p1.y
	local p2x = p2.x
	local p2y = p2.y
	local xc3 = circle.position.x
	local yc3 = circle.position.y
	local r3 = circle.radius

	local locp1x = p1x - xc3
	local locp1y = p1y - yc3

	local locp2x = p2x - xc3
	local locp2y = p2y - yc3

	local p1p2x = locp2x - locp1x
	local p1p2y = locp2y - locp1y

	local a = p1p2x * p1p2x + p1p2y * p1p2y
	local b = 2 * (p1p2x * locp1x + p1p2y * locp1y)
	local c = locp1x * locp1x + locp1y * locp1y - r3 * r3
	local delta = b * b - (4 * a * c)
	if delta < 0 then
		return nil
	elseif delta == 0 then
		local u = -b / ( 2 * a)
		local x = p1x + (u * p1p2x)
		local y = p1y + (u * p1p2y)
		return {{x, y}}
	else
		sqr = math.sqrt(delta)
		local u1 = (-b + sqr) / (2 * a)
		local u2 = (-b - sqr) / (2 * a)
		--print(u1, u2)
		if not(u1 > 0 and u1 < 1) and not(u2 > 0 and u2 < 1) then
			return nil
		end
		local x1 = p1x + (u1 * p1p2x)
		local y1 = p1y + (u1 * p1p2y)
		local x2 = p1x + (u2 * p1p2x)
		local y2 = p1y + (u2 * p1p2y)
		return {{x1, y1}, {x2, y2}}
	end
end
