
require("perlin")

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

	fly.noisex = Noise:create(1, 1, 256)
	fly.noisey = Noise:create(1, 1, 256)
	fly.tx = love.math.random()
	fly.ty = love.math.random()

	return fly
end

function Fly:update(dt)
	self.tx = self.tx + .001
	self.ty = self.ty + .0015

	local x = self.noisex:call(self.tx)
	local y = self.noisey:call(self.ty)

	self.x = remap(x, 0, 1, 0, w - 50)
	self.y = remap(y, 0, 1, 0, h - 50)
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

	herd = HerdFlies:create("asd", 0, 0, w, h, 100, 40)

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
