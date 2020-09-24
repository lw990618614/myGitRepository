local exports = exports or {}
local beautyScript = {}
beautyScript.__index = beautyScript

function beautyScript.new(construct, ...)
    local self = setmetatable({}, beautyScript)
    self.smoothMaterial = nil
    if construct and beautyScript.constructor then beautyScript.constructor(self, ...) end
    return self
end



function beautyScript:onStart(comp)
    local scene = comp.entity.scene
    local entities = scene.entities
    local smoothTag = 1
    for i = 0, entities:size() - 1 do
        local entity = entities:get(i)
        if entity:hasTag(smoothTag) then
            local renderer = entity:getComponent("MeshRenderer")
            if renderer ~= nil then
                self.smoothMaterial = renderer.materials:get(0)
                local cfg = Amaz.BuiltinObject:getBuiltinEffectConfig()
                self.smoothMaterial.properties:setFloat("blurAlpha", cfg:getInternalBeautySmooth())
                self.smoothMaterial.properties:setFloat("whiten", cfg:getInternalBeautyWhiten())
                self.smoothMaterial.properties:setFloat("sharpen", cfg:getInternalBeautySharp())
                break
            end
        end

    end

end


function beautyScript:onUpdate(comp, deltaTime)

end

function beautyScript:onEvent(comp, event)
    -- print("event.type = " .. event.type .. ", event.name: " .. event.args:get(0) .. ", event.key: " .. event.args:get(1) .. ", event.value: " ..  event.args:get(2))
    if event.args:get(0) == "SetEffectIntensity" then
        if event.args:get(1) == "Internal_Beauty" then
            -- 设置磨皮程度
            self.smoothMaterial.properties:setFloat("blurAlpha", event.args:get(2))
        elseif event.args:get(1) == "Internal_Whiten" then
            -- 设置美白程度
            self.smoothMaterial.properties:setFloat("whiten", event.args:get(2))
        elseif event.args:get(1) == "Internal_Sharpen" then
            -- 设置锐化程度
            self.smoothMaterial.properties:setFloat("sharpen", event.args:get(2))
        end
    end
end

exports.beautyScript = beautyScript

return exports
