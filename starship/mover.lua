
Mover = {}
Mover.__index = Mover

function Mover:create(position, width, height, mass)
	local mover = {}
	setmetatable(mover, Mover)
	mover.position = position
	mover.velocity = Vec2:create(0, 0)
	mover.width = width
	mover.height = height
	mover.mass = mass or 1
	mover.acceleration = Vec2:create(0, 0)
	mover.angle = 0
	mover.active = false

	-- Форма корабля
	mover.p1 = Vec2:create(-30, -30)
	mover.p2 = Vec2:create(30, 0)
	mover.p3 = Vec2:create(-30, 30)

	-- Флажок врезания
	mover.being_hit = false

	return mover
end

function Mover:apply_force(force)
	self.acceleration:add(force / self.mass)
end

function Mover:apply_friction(factor)
	local friction = (self.velocity * -1):norm()

	if friction then
		friction:mul(factor)
		self:apply_force(friction)
	end
end

function Mover:draw()
	--love.graphics.rectangle("fill", self.position.x - self.width/2, self.position.y - self.height/2, self.width, self.height)
	love.graphics.push()
	love.graphics.translate(self.position.x, self.position.y)
	love.graphics.rotate(self.angle)
	r, g, b, a = love.graphics.getColor()

	love.graphics.setLineWidth(4)

	if self.being_hit then
		love.graphics.setColor(1, 0, 0, 1)
		love.graphics.polygon("fill",
			self.p1.x, self.p1.y,
			self.p2.x, self.p2.y,
			self.p3.x, self.p3.y,
			self.p1.x, self.p1.y
		)
	end

	love.graphics.line(
		self.p1.x, self.p1.y,
		self.p2.x, self.p2.y,
		self.p3.x, self.p3.y,
		self.p1.x, self.p1.y
	) -- Треугольник

	-- Двигатель
	local type = "line"

	if self.active then
		love.graphics.setColor(1, 0, 0, 1)
		type = "fill"
	end

	love.graphics.rectangle(type, -40, 5, 10, 20)
	love.graphics.rectangle(type, -40, -25, 10, 20)

	love.graphics.setColor(r, g, b, a)
	love.graphics.pop()
end

function rotate_point_around_origin(point, angle)
	return Vec2:create(
		point.x * math.cos(angle) - point.y * math.sin(angle),
		point.y * math.cos(angle) + point.x * math.sin(angle)
	)
end

function Mover:collide_with_obstacle(obstacle)
	-- Точки корабля в пространстве экрана
	local scr_p1 = rotate_point_around_origin(self.p1, self.angle) + self.position
	local scr_p2 = rotate_point_around_origin(self.p2, self.angle) + self.position
	local scr_p3 = rotate_point_around_origin(self.p3, self.angle) + self.position

	self.being_hit = false

	local port_hit = line_circle_collision(scr_p1, scr_p2, obstacle)
	if port_hit ~= nil then
		self.being_hit = true
	end

	local starboard_hit = line_circle_collision(scr_p2, scr_p3, obstacle)
	if starboard_hit ~= nil then
		self.being_hit = true
	end

	local stern_hit = line_circle_collision(scr_p3, scr_p1, obstacle)
	if stern_hit ~= nil then
		self.being_hit = true
	end
end

function Mover:update(dt)
	self.velocity = self.velocity + self.acceleration
	self.position = self.position + self.velocity
	self.acceleration:mul(0)
	self:boundcheck()
end

function Mover:boundcheck()
	self.position.x = self.position.x % w
	self.position.y = self.position.y % h
end

function Mover:phys_boundcheck()
	if self.position.y + self.height/2 > h then -- Bottom
		self.position.y = h - self.height/2
		self.velocity.y = -self.velocity.y
	elseif self.position.y - self.height/2 < 0 then -- Top
		self.position.y = self.height/2
		self.velocity.y = -self.velocity.y
	elseif self.position.x + self.width/2 > w then
		self.position.x = w - self.width/2
		self.velocity.x = -self.velocity.x
	elseif self.position.x - self.width/2 < 0 then
		self.position.x = self.width/2
		self.velocity.x = -self.velocity.x
	end
end
