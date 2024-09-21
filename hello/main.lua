
-- Класс ну типа
Fly = {}
Fly.__index = Fly

function Fly:create(path, x, y, speed)
	local fly = {}

	setmetatable(fly, Fly) -- Объект описывается табличкой

	fly.path = path
	fly.image = love.graphics.newImage("resources/mosquito_small.png")
	fly.x = x or 0
	fly.y = y or 0
	fly.speed = speed or 40

	return fly
end

function Fly:update(dt)
	local state = love.math.random(0, 3)
	local a_x = 0
	local a_y = 0

	if state == 0 then
		a_x = self.speed
	elseif state == 1 then
		a_x = -self.speed
	elseif state == 2 then
		a_y = self.speed
	elseif state == 3 then
		a_y = -self.speed
	end

	self.x = self.x + a_x * dt * self.speed
	self.y = self.y + a_y * dt * self.speed

	self.x = self.x % w
	self.y = self.y % h
end

function Fly:draw()
	love.graphics.draw(self.image, self.x, self.y)
end

function love.load()
	background = love.graphics.newImage("resources/background.png")

	w = background:getWidth()
	h = background:getHeight()

	love.window.setMode(w, h)

	love.graphics.setBackgroundColor(.6, .8, 1.)

	herd = HerdFlies:create("asd", 0, 0, w, h, 10, 40)

	--fly = Fly:create()
end

function love.update(dt)
	--fly:update(dt)
	herd:update(dt)
end

function love.draw()
	love.graphics.draw(background, 0, 0)
	--fly:draw()
	herd:draw()
	love.graphics.print("FPS: " .. tostring(love.timer.getFPS()), 10, 10)
end

HerdFlies = {}
HerdFlies.__index = HerdFlies

function HerdFlies:create(path, xmin, xmax, ymin, ymax, n, speed)
	local flies = {}
	setmetatable(flies, HerdFlies)
	flies.n = n
	flies.objs = {}
	for i=1, n do
		local x = love.math.random(xmin, xmax)
		local y = love.math.random(ymin, ymax)
		flies.objs[i] = Fly:create(path, x, y, speed)
	end

	return flies
end

function HerdFlies:update(dt)
	for i=1, self.n do
		self.objs[i]:update(dt)
	end
end

function HerdFlies:draw()
	for i=1, self.n do
		self.objs[i]:draw()
	end
end
