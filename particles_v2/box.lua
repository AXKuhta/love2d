
--
-- Коробка
--
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

		local tl = self.origin - self.size/2
		local br = self.origin + self.size/2
		local tr = self.origin + Vec2:create(self.size.x/2, -self.size.y/2)
		local bl = self.origin + Vec2:create(-self.size.x/2, self.size.y/2)

		love.graphics.setColor(0, 1, 0)

		love.graphics.line(
			tl.x, tl.y,
			tr.x, tr.y,
			br.x, br.y,
			bl.x, bl.y,
			tl.x, tl.y
		)

		love.graphics.circle("fill", tl.x, tl.y, 5)
		love.graphics.circle("fill", tr.x, tr.y, 5)
		love.graphics.circle("fill", bl.x, bl.y, 5)
		love.graphics.circle("fill", br.x, br.y, 5)

		love.graphics.setColor(r, g, b, a)
	end
end

function Box:clicked(v)
	if 	v.x > self.origin.x - self.size.x/2 and
		v.x < self.origin.x + self.size.x/2 and
		v.y > self.origin.y - self.size.y/2 and
		v.y < self.origin.y + self.size.y/2 then

		self.state = "dying"
	end
end

function Box:is_dead()
	return self.state == "dead"
end

function Box:update(dt)
	if self.state == "dying" then
		self.size = self.size - Vec2:create(.5, .5)
	end

	if self.state ~= "dead" and self.size.x < 0 then
		local tl = self.origin - self.csize/2
		local br = self.origin + self.csize/2
		local tr = self.origin + Vec2:create(self.csize.x/2, -self.csize.y/2)
		local bl = self.origin + Vec2:create(-self.csize.x/2, self.csize.y/2)

		system:add_particle(BoxSegmentParticle:create(tl, tr))
		system:add_particle(BoxSegmentParticle:create(tr, br))
		system:add_particle(BoxSegmentParticle:create(br, bl))
		system:add_particle(BoxSegmentParticle:create(bl, tl))

		system:add_particle(BoxEdgeParticle:create(tl))
		system:add_particle(BoxEdgeParticle:create(tr))
		system:add_particle(BoxEdgeParticle:create(bl))
		system:add_particle(BoxEdgeParticle:create(br))

		self.state = "dead"
	end
end

--
-- Один из сегментов коробки
--
BoxSegmentParticle = {}
BoxSegmentParticle.__index = BoxSegmentParticle

function BoxSegmentParticle:create(loc1, loc2)
	local self = {}
	setmetatable(self, BoxSegmentParticle)

	self.loc1 = loc1:copy()
	self.loc2 = loc2:copy()
	self.acceleration = Vec2:create(0, 0.05)
	self.velocity = Vec2:create(
		math.random(-200, 200) / 100,
		math.random(-100, 0) / 100
	)

	self.lifespan = 1
	self.life = 1

	return self
end

function BoxSegmentParticle:update(dt)
	self.velocity:add(self.acceleration)
	self.loc1:add(self.velocity)
	self.loc2:add(self.velocity)
	self.life = self.life - 1*dt
end

function BoxSegmentParticle:is_dead()
	if self.life < 0 then
		return true
	end
	return false
end

function BoxSegmentParticle:draw()
	r, g, b, a = love.graphics.getColor()
	love.graphics.setColor(1, 1, 1, self.life/self.lifespan)
	love.graphics.line(
		self.loc1.x, self.loc1.y,
		self.loc2.x, self.loc2.y
	)
	love.graphics.setColor(r, g, b, a)
end

--
-- Один из углов коробки
--
BoxEdgeParticle = {}
BoxEdgeParticle.__index = BoxEdgeParticle

function BoxEdgeParticle:create(loc)
	local self = {}
	setmetatable(self, BoxEdgeParticle)

	self.loc = loc:copy()
	self.acceleration = Vec2:create(0, 0.05)
	self.velocity = Vec2:create(
		math.random(-200, 200) / 100,
		math.random(-100, 0) / 100
	)

	self.lifespan = 1
	self.life = 1

	return self
end

function BoxEdgeParticle:update(dt)
	self.velocity:add(self.acceleration)
	self.loc:add(self.velocity)
	self.life = self.life - 1*dt
end

function BoxEdgeParticle:is_dead()
	if self.life < 0 then
		return true
	end
	return false
end

function BoxEdgeParticle:draw()
	r, g, b, a = love.graphics.getColor()
	love.graphics.setColor(1, 1, 1, self.life/self.lifespan)
	love.graphics.circle("fill", self.loc.x, self.loc.y, 5)
	love.graphics.setColor(r, g, b, a)
end