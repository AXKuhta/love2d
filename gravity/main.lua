
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

function love.load()
	love.window.setMode(w, h)

	j1 = JAM:create(
		Vec2:create(200, 200),
		1
	)

	j2 = JAM:create(
		Vec2:create(300, 200),
		2
	)

	gravity = Vec2:create(0, 0.01)
end

function love.update(dt)
	x, y = love.mouse.getPosition()
	v = Vec2:create(x, y)

	j1:update(dt)
	j2:update(dt)

	j1:interact(j2)
	j2:interact(j1)

	--mover_a:apply_force( attr:attract(mover_a) )
	--mover_b:apply_force( attr:attract(mover_b) )
end

function love.draw()
	j1:draw()
	j2:draw()
end