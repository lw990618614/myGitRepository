local exports = exports or {}
local beautyScript = {}
beautyScript.__index = beautyScript

function beautyScript.new(construct, ...)
    local self = setmetatable({}, beautyScript)
    self.blusherMaterial = nil
    self.lipsMaterial = nil
    if construct and beautyScript.constructor then beautyScript.constructor(self, ...) end
    return self
end



function beautyScript:onStart(comp)
    local cfg = Amaz.BuiltinObject:getBuiltinEffectConfig()
    local scene = comp.entity.scene
    local entities = scene.entities
    for i = 0, entities:size() - 1 do
         local entity = entities:get(i)
         print(entity.name)
        if entity.name == "blusher" then
            local renderer = entity:getComponent("MeshRenderer")
            if renderer ~= nil then
                print("get lips material")
                self.blusherMaterial = renderer.materials:get(0)
                self.blusherMaterial.properties:setFloat("_intensity", cfg:getInternalMakeupLips())
            end
        end
        if entity.name == "lips" then
            local renderer = entity:getComponent("MeshRenderer")
            if renderer ~= nil then
                print("get blusher material")
                self.lipsMaterial = renderer.materials:get(0)
                self.lipsMaterial.properties:setFloat("_intensity", cfg:getInternalMakeupBlusher())
            end
        end
    end
end


function beautyScript:onUpdate(comp, deltaTime)
    -- self.lipsMaterial.properties:setFloat("openMouth", 1.0)
end

function beautyScript:onEvent(comp, event)
    if event.args:get(0) == "SetEffectIntensity" then
        if event.args:get(1) == "Internal_Blusher" then
            self.blusherMaterial.properties:setFloat("_intensity", event.args:get(2))
        elseif event.args:get(1) == "Internal_Lips" then
            self.lipsMaterial.properties:setFloat("_intensity", event.args:get(2))
        end
    end
end

exports.beautyScript = beautyScript

return exports
