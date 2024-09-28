
Wall = {}
Wall.__index = Wall

function Wall:create(position, size)
	local wall = {}
	setmetatable(wall, Wall)
	wall.position = position
	wall.size = size
	return wall
end

function Wall:draw()
	love.graphics.rectangle("fill", self.position.x - self.size.x/2, self.position.y - self.size.y/2, self.size.x, self.size.y)
end

function Wall:update(dt)

end
