
Box = {}
Box.__index = Box

function Box:create(origin, size)
	local self = {}
	setmetatable(self, Box)

	self.origin = origin
	self.size = size
	self.csize = size
	self.state = "live"

	return self
end

function Box:draw()
	if self.state ~= "dead" then
		r, g, b, a = love.graphics.getColor()

		tl = self.origin - self.size/2
		br = self.origin + self.size/2
		tr = self.origin + Vec2:create(self.size.x/2, -self.size.y/2)
		bl = self.origin + Vec2:create(-self.size.x/2, self.size.y/2)

		love.graphics.setColor(0, 1, 0)

		love.graphics.line(
			tl.x, tl.y,
			tr.x, tr.y,
			br.x, br.y,
			bl.x, bl.y,
			tl.x, tl.y
		)

		love.graphics.setColor(r, g, b, a)
	end
end
