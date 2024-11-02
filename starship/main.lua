
require("vec")
require("mover")
require("obstacle")
require("collisions")

w = 500
h = 500

function love.load()
	love.window.setMode(w, h)
	starship = Mover:create(
		Vec2:create(200, 200),
		10, 80, 1
	)

	obstacle = Obstacle:create(Vec2:create(w/2, h/2))

	gravity = Vec2:create(0, 0.2)
end

function love.update(dt)
	x, y = love.mouse.getPosition()
	v = Vec2:create(x, y)

	if love.keyboard.isDown("left") then
		starship.angle = starship.angle - 0.05
	elseif love.keyboard.isDown("right") then
		starship.angle = starship.angle + 0.05
	end
	
	if love.keyboard.isDown("up") then
		local x = 0.1 * math.cos(starship.angle)
		local y = 0.1 * math.sin(starship.angle)
		starship:apply_force( Vec2:create(x, y) )
		starship.active = true
	else
		starship.active = false
	end

	-- mover_a:apply_force(gravity)
	-- mover_b:apply_force(gravity)
	-- mover_a:apply_friction(0.005)
	-- mover_b:apply_friction(0.005)

	starship:collide_with_obstacle(obstacle)

	starship:update(dt)
	obstacle:update(dt)
end

function love.draw()
	starship:draw()
	obstacle:draw()
end