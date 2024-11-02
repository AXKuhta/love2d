Wave = {}
Wave.__index = Wave

function Wave:create(position, width, amplitude, frequency)
	local self = {}
	setmetatable(self, Wave)
	self.position = position
	self.width = width
	self.amplitude = amplitude
	self.frequency = frequency

	self.accumulator = 0.0

	return self
end

function Wave:update(dt)
	self.accumulator = self.accumulator + dt
end

function Wave:draw()
	love.graphics.push()
	love.graphics.translate(self.position.x, self.position.y)
	for x=0, self.width, 8 do
		local normalized_x = x/self.width

		y = self.amplitude*math.sin(2*math.pi*x/self.width*self.frequency + self.accumulator)

		local r = 20 + normalized_x*100
		local g = 54 + normalized_x*12
		local b = 90 - normalized_x*90

		love.graphics.setColor(r/255, r/255, r/255)
		love.graphics.circle("line", x, y+h/2, 10)
		love.graphics.setColor(r/255, g/255, b/255, 0.5)
		love.graphics.circle("fill", x, y+h/2, 10)
	end
	love.graphics.pop()
end