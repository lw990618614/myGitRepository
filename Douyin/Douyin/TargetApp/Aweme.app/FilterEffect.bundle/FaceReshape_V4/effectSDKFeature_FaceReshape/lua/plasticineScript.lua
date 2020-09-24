local exports = exports or {}

local plasticineScript = plasticineScript or {}

plasticineScript.__index = plasticineScript

function plasticineScript.new(construct, ...)
    local self = setmetatable({}, plasticineScript)
    
    --橡皮泥形变实体列表
    self.plsentList = {}

    self.eyeIntensity = 0.0
    self.faceIntensity = 0.0

    if construct and plasticineScript.constructor then
        plasticineScript.constructor(self, ...)
    end
    return self
end

function plasticineScript:constructor()

end


function plasticineScript:onStart(comp)
    print "zwh onStart"
    local scene = comp.entity.scene
    local entities = scene.entities

    table.insert( self.plsentList , scene:findEntityBy("face0_entity") )
    table.insert( self.plsentList , scene:findEntityBy("face1_entity") )
    table.insert( self.plsentList , scene:findEntityBy("face2_entity") )
    table.insert( self.plsentList , scene:findEntityBy("face3_entity") )
    table.insert( self.plsentList , scene:findEntityBy("face4_entity") )

    local cfg = Amaz.BuiltinObject:getBuiltinEffectConfig()
    for k,v in ipairs(self.plsentList) do
        local defcom = v:getComponent("PlasticineDeformationComponent")
        self.faceIntensity = defcom.zoomface
        self.eyeIntensity = defcom.zoomeye

        defcom.zoomface = self.faceIntensity * cfg:getInternalReshapeFace()
        defcom.zoomeye = self.eyeIntensity * cfg:getInternalReshapeEye()
    end

    print ("zwh size: ",#self.plsentList)
end


function plasticineScript:onUpdate(comp, deltaTime)
    
end

function plasticineScript:onEvent(comp, event)
    if event.args:get(0) == "SetEffectIntensity"  then
        if event.args:get(1) == "Internal_FaceDistortion_Eye" then
            print ("zwh onEvent ",event.args:get(0),event.args:get(1),event.args:get(2) )
            for k,v in ipairs(self.plsentList) do 
                local defcom = v:getComponent("PlasticineDeformationComponent")
                defcom.zoomeye = self.eyeIntensity*event.args:get(2)
            end
        elseif event.args:get(1) == "Internal_FaceDistortion_Face" then
            print ("zwh onEvent ",event.args:get(0),event.args:get(1),event.args:get(2) )
            for k,v in ipairs(self.plsentList) do 
                local defcom = v:getComponent("PlasticineDeformationComponent")
                defcom.zoomface = self.faceIntensity*event.args:get(2)
            end
        end
    end
end

exports.plasticineScript = plasticineScript

return exports
