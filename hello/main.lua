
x = 0
y = 0

-- px per second inertia
a_x = 30
a_y = 60

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
	fly.a_x = 30
	fly.a_y = 60
	fly.speed = speed or 1

	return fly
end

function Fly:update(dt)
	local rnd_x = love.math.random(0, 3)
	local rnd_y = love.math.random(0, 3)

	self.x = self.x + self.a_x * dt * rnd_x
	self.y = self.y + self.a_y * dt * rnd_y

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

	fly = Fly:create()
end

function love.update(dt)
	fly:update(dt)
end

function love.draw()
	love.graphics.draw(background, 0, 0)
	fly:draw()
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
