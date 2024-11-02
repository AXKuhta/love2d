
require("vec")
require("circle")
require("line_circle")

w = 500
h = 500
width = w
height = h

function love.load()
	love.window.setMode(w, h)

	circ1 = Circle:create(Vec2:create(w/2 + 5, h/2), 20)
	circ2 = Circle:create(Vec2:create(w/2 - 5, h/2), 20)

	circ1.velocity.x = 5
	circ2.velocity.x = -5

	ax = 0
    ay = 250
    bx = 20
    by = 275
    vl1 = 1

    cx = width
    cy = 250
    dx = width - 20
    dy = 275
    vl2 = -1

    p1x = 100
    p1y = 350
    p2x = 0
    p2y = 350
    pv = 1

    r3 = 30
    xc3 = width - r3
    yc3 = 350
    vc3 = -1
end

function love.update(dt)
	x, y = love.mouse.getPosition()
	v = Vec2:create(x, y)

	circ1:update(dt)
	circ2:update(dt)

	if circ1:collide_with_circle(circ2) then
		print("collide")
	end

	if circ2:collide_with_circle(circ1) then
		print("collide 2")
	end

	ax = ax + vl1
    bx = bx + vl1
    if bx > width or ax < 0 then
        vl1 = -vl1
    end

    cx = cx + vl2
    dx = dx + vl2
    if cx > width or dx < 0 then
        vl2 = -vl2
    end

    if love.keyboard.isDown("space") then

        p1x = p1x + pv
        p2x = p2x + pv
        if p2x > width or p1x < 0 then
            pv = -pv
        end

        xc3 = xc3 + vc3
        if xc3 > width - r3 or xc3 < r3 then
            vc3 = -vc3
        end
    end
end

function love.draw()
	circ1:draw()
	circ2:draw()

	love.graphics.setColor(1, 1, 1)
    if line_collision() then
        love.graphics.setColor(1, 0, 0)
    end
    love.graphics.setLineWidth(2)
    love.graphics.line(ax, ay, bx, by)
    love.graphics.line(cx, cy, dx, dy)

    love.graphics.setColor(1, 1, 1)
    local result = line_circle_collision()
    if result then
        love.graphics.setColor(0, 1, 0)
        for count = 1, #result do
            x = result[count][1]
            y = result[count][2]
            love.graphics.circle("fill", x, y, 4)
        end
        love.graphics.setColor(1, 0, 0)
    end
    love.graphics.line(p1x, p1y, p2x, p2y)
    love.graphics.circle("fill", xc3, yc3, r3)
    

    love.graphics.setLineWidth(1)
end
