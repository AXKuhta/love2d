
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

-- Магический метод
function Vec2:__add(other)
	return Vec2:create(
		self.x + other.x,
		self.y + other.y
	)
end

function Vec2:__sub(other)
	return Vec2:create(
		self.x - other.x,
		self.y - other.y
	)
end

function Vec2:__mul(value)
	return Vec2:create(
		self.x * value,
		self.y * value
	)
end

function Vec2:__div(value)
	return Vec2:create(
		self.x / value,
		self.y / value
	)
end

-- Inplace
-- Если хотим накапливать
function Vec2:add(other)
	self.x = self.x + other.x
	self.y = self.y + other.y
end

function Vec2:sub(other)
	self.x = self.x - other.x
	self.y = self.y - other.y
end

function Vec2:mul(value)
	self.x = self.x * value
	self.y = self.y * value
end

function Vec2:div(value)
	self.x = self.x / value
	self.y = self.y / value
end

-- Прочие операции
function Vec2:copy()
	return Vec2:create(self.x, self.y)
end

function Vec2:mag()
	return math.sqrt(self.x*self.x + self.y*self.y)
end

function Vec2:norm()
	local m = self:mag()

	if (m > 0) then
		return self / m
	end
end

function Vec2:limit(max_value)
	if self:mag() > max_value then
		return self:norm() * max_value
	end
	return self:copy()
end
