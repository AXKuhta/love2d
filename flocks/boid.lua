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
    return boid
end

function Boid:update(boids)
    self:flock(boids)
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
    return Vector:create(0, 0)
end

function Boid:separate(others)
    return Vector:create(0, 0)
end

function Boid:align(others)
        return Vector:create(0, 0)
end

function Boid:cohesion(others)
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

    love.graphics.setColor(1, 1, 1)
    local theta = self.velocity:heading() + math.pi / 2
    love.graphics.push()
    love.graphics.translate(self.position.x, self.position.y)
    love.graphics.rotate(theta)
    love.graphics.polygon("fill", self.vertices)
    love.graphics.pop()

    love.graphics.setColor(r, g, b, a)
end

