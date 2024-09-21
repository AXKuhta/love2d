
Vec2 = {}
Vec2.__index = Vec2

function Vec2:create(x, y)
	local vec = {}
	setmetatable(vec, Vec2)

	vec.x = x or 0
	vec.y = y or 0

	return vec
end

function Vec2:__tostring()
	return "Vec2(x=" .. string.format("%.2f", self.x) .. ", y=" .. string.format("%.2f", self.y) .. ")"
end
