Scene = {}
Scene.__index = Scene

function Scene:create()
	local scene = {}
	setmetatable(scene, Scene)
	scene.entities = {}
	return scene
end

function Scene:add(entity)
	self.entities[#self.entities + 1] = entity
end

function Scene:draw()
	for i=1, #self.entities do
		self.entities[i]:draw()
	end
end

function Scene:update(dt)
	for i=1, #self.entities do
		self.entities[i]:update(dt)
	end
end
