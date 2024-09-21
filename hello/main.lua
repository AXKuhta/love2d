
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
	fly.x = x or 0
	fly.y = y or 0
	fly.speed = speed or 1

	return fly
end



function love.load()
	background = love.graphics.newImage("resources/background.png")
	fly = love.graphics.newImage("resources/mosquito_small.png")

	w = background:getWidth()
	h = background:getHeight()

	love.window.setMode(w, h)

	love.graphics.setBackgroundColor(.6, .8, 1.)
end

function love.update(dt)
	x = x + a_x * dt
	y = y + a_y * dt

	x = x % w
	y = y % h
end

function love.draw()
	love.graphics.draw(background, 0, 0)
	love.graphics.draw(fly, x, y)
	love.graphics.print("FPS: " .. tostring(love.timer.getFPS()), 10, 10)
end
