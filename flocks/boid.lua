Boid = {}
Boid.__index = Boid

function Boid:create(x, y)
    local boid = {}
    setmetatable(boid, Boid)
    boid.position = Vector:create(x, y)
    boid.velocity = Vector:create(math.random(-10, 10) / 10, math.random(-10, 10) / 10)
    boid.acceleration = Vector:create(0, 0)
    boid.r = 5
    boid.vertices = {0, - boid.r * 2, -boid.r, boid.r * 2, boid.r, 2 * boid.r}
    boid.maxSpeed = 4
    boid.maxForce = 0.1
	boid.prox = 0.0
    return boid
end

-- Берёт boids
-- Возвращает от 0 до 1
function Boid:proximity_value(boids)
	local total = 20
	local thresh = 50
	local near = 0

	for k, v in pairs(boids) do
		local dist = self.position:distTo(v.position)

		if dist > 0 and dist < thresh then
			near = near + 1
		end
	end

	return near / total
end

function Boid:update(boids)
    self:flock(boids)
	self.prox = self:proximity_value(boids)
    self.velocity:add(self.acceleration)
    self.velocity:limit(self.maxSpeed)
    self.position:add(self.velocity)
    self.acceleration:mul(0)
    self:borders()
end

function Boid:flock(boids)
    local sep = self:separate(boids)
    local align = self:align(boids)
    local coh = self:cohesion(boids)

    sep:mul(1.5)
    align:mul(1)
    coh:mul(1)

    if isSep then
        self:applyForce(sep)
    end

    if isAlign then
        self:applyForce(align)
    end

    if isCoh then
        self:applyForce(coh)
    end
end

function Boid:applyForce(force)
    self.acceleration:add(force)
end

function Boid:seek(target)
	local desired = target - self.position
	
	desired:norm()
	desired:mul(self.maxSpeed)

	local steer = desired - self.velocity

	steer:limit(self.maxForce)
    
	return steer
end

-- Отпугивание
function Boid:separate(others)
	local separation = 25.0
	local steer = Vector:create(0, 0)
	local count = 0

	for k, v in pairs(others) do
		local dist = self.position:distTo(v.position)

		if dist > 0 and dist < separation then
			local diff = self.position - v.position

			diff:norm()
			diff:div(dist) -- Далеко - меньше, ближе - больше
			steer:add(diff)

			count = count + 1
		end
	end

	if count > 0 then
		--steer:div(count)
	end

	if steer:mag() > 0 then
		steer:norm()
		steer:mul(self.maxSpeed)
		steer:sub(self.velocity)
		steer:limit(self.maxForce)
	end

    return steer
end

-- Подражание
function Boid:align(others)
	local alignment = 50
	local sum = Vector:create(0, 0)
	local count = 0

	for k, v in pairs(others) do
		local dist = self.position:distTo(v.position)

		if dist > 0 and dist < alignment then
			sum:add(v.velocity)
			count = count + 1
		end
	end

	if count > 0 then
		--sum:div(count)
		sum:norm()
		sum:mul(self.maxSpeed)

		local steer = sum - self.velocity

		steer:limit(self.maxForce)

		return steer
	else
		return Vector:create(0, 0)
	end
end

-- Нахождение средней позиции
function Boid:cohesion(others)
	local neighbours = 50
	local sum = Vector:create(0, 0)
	local count = 0

	for k, v in pairs(others) do
		local dist = self.position:distTo(v.position)

		if dist > 0 and dist < neighbours then
			sum:add(v.velocity)
			count = count + 1
		end
	end

	if count > 0 then
		sum:div(count)
		return self:seek(sum)
	else
		return Vector:create(0, 0)
	end

	return Vector:create(0, 0)
end

function Boid:borders()
    if self.position.x < -self.r then
        self.position.x = width - self.r
    end
    if self.position.x > width + self.r then
        self.position.x = self.r
    end

    if self.position.y < -self.r then
        self.position.y = height - self.r
    end
    if self.position.y > height + self.r then
        self.position.y = self.r
    end
end

function Boid:draw()
    r, g, b, a = love.graphics.getColor()

    love.graphics.setColor(.1, .1 + 0.5*self.prox, self.prox)
    local theta = self.velocity:heading() + math.pi / 2
    love.graphics.push()
    love.graphics.translate(self.position.x, self.position.y)
    love.graphics.rotate(theta)
    love.graphics.polygon("fill", self.vertices)
    love.graphics.pop()

    love.graphics.setColor(r, g, b, a)
end

