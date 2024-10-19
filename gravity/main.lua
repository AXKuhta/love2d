
require("vec")
require("mover")
require("attractor")

w = 1280
h = 720

---------------------------------------------------------------------------------------------
-- Joint Attractor-Mover
---------------------------------------------------------------------------------------------
JAM = {}
JAM.__index = JAM

function JAM:create(position, size)
	local self = {}
	setmetatable(self, JAM)

	self.attractor = Attractor:create(
		position,
		size
	)

	self.mover = Mover:create(
		position,
		Vec2:create(),
		size
	)

	return self
end

function JAM:update(dt)
	self.mover:update(dt)
	
	-- Sync attractor to mover
	self.attractor.position = self.mover.position
end

function JAM:draw()
	self.mover:draw()
	self.attractor:draw()
end

function JAM:interact(other)
	self.mover:apply_force( other.attractor:attract(self.mover) )
end
---------------------------------------------------------------------------------------------

jams = {}
n = 10

function love.load()
	love.window.setMode(w, h)

	for i=1, n do
		local x = love.math.random(0, w)
		local y = love.math.random(0, h)
		local m = love.math.random(1, 2)

		j = JAM:create(
			Vec2:create(x, y),
			m
		)

		jams[i] = j
	end

	gravity = Vec2:create(0, 0.01)
end

function love.update(dt)
	x, y = love.mouse.getPosition()
	v = Vec2:create(x, y)

	for i=1, n do
		jams[i]:update(dt)
	end

	for i=1, n do
		for j=1, n do
			if i ~= j then
			 	jams[i]:interact(jams[j])
			end
		end
	end
end

function love.draw()
	for i=1, n do
		jams[i]:draw()
	end
end