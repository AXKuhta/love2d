
Paddle = {}
Paddle.__index = Paddle

function Paddle:create(position, size)
	local paddle = {}
	setmetatable(paddle, Paddle)
	paddle.position = position
	paddle.size = size
	return paddle
end

function Paddle:draw()
	love.graphics.rectangle("fill", self.position.x - self.size.x/2, self.position.y - self.size.y/2, self.size.x, self.size.y)
end

function Paddle:update(dt)

end
