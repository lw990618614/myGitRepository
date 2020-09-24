local exports = exports or {}

local distortionScript = distortionScript or {}

distortionScript.__index = distortionScript

function distortionScript.new(construct, ...)
    local self = setmetatable({}, distortionScript)
    -- 启用形变人脸ID名单
    self.definedFaceList = nil
    -- 大眼瘦脸程度
    self.faceEyeIntensity = nil
    -- 形变参数
    self.distortionParams = nil
    self.distortionRenderer = nil
    self.distortionMaterial = nil
    -- 人脸部位划分个数
    self.facePartsCount = 10
    -- 各个部位程度
    self.partIntensity = Amaz.FloatVector()
    if construct and distortionScript.constructor then
        distortionScript.constructor(self, ...)
    end
    return self
end

function distortionScript:constructor()

end


function distortionScript:onStart(comp)
    local scene = comp.entity.scene
    local entities = scene.entities
    local distortionTag = 3
    for i = 0, entities:size() - 1 do
        local entity = entities:get(i)
        if entity:hasTag(distortionTag) then
            local renderer = entity:getComponent("MeshRenderer")
            if renderer ~= nil then
                self.distortionRenderer = renderer
                self.distortionMaterial = renderer.materials:get(0)
                break
            end
        end
    end    
    -- 初始化人脸各部位形变程度
    for i = 0 ,self.facePartsCount - 1 do
        self.partIntensity:pushBack(1.0)
    end

    local cfg = Amaz.BuiltinObject:getBuiltinEffectConfig()
    self.faceEyeIntensity:set(0, cfg:getInternalReshapeEye())
    self.faceEyeIntensity:set(1, cfg:getInternalReshapeFace())
end


function distortionScript:onUpdate(comp, deltaTime)
    local faceAlgoRet = Amaz.Algorithm:getAEAlgorithmResult()
    local count = faceAlgoRet:getFaceCount()
    print("detected face count:"..count)
    local surfaceWidth = Amaz.BuiltinObject.getOutputTextureWidth()
    local surfaceHeight = Amaz.BuiltinObject.getOutputTextureHeight()    
    -- local surfaceWidth = 720
    -- local surfaceHeight = 1280        

    local u_counts = Amaz.FloatVector()
    local u_centers = Amaz.Vec2Vector()
    local u_radius = Amaz.Vec2Vector()
    local u_scales = Amaz.FloatVector()
    local u_angles = Amaz.FloatVector()
    local u_mins = Amaz.FloatVector()
    local u_maxs = Amaz.FloatVector()
    local u_types = Amaz.FloatVector()
    local u_intensitys = Amaz.FloatVector()
    local u_faceRoll = Amaz.FloatVector()

    local facePointsNum = 106
    local detectedFacePoints = Amaz.Vec2Vector()
    local faceRolls = Amaz.FloatVector()
    for i = 0,count -1 do
        local oneFacePointsArray = faceAlgoRet:getFaceBaseInfo(i).points_array
        for j = 0,facePointsNum - 1 do
            detectedFacePoints:pushBack(oneFacePointsArray:get(j))
        end
        faceRolls:pushBack(faceAlgoRet:getFaceBaseInfo(i).roll)
    end

    local viewport = Amaz.Vector2f()
    viewport.x = surfaceWidth
    viewport.y = surfaceHeight
    
    for i = 0,self.definedFaceList:size() - 1 do
        print("params index:"..i.." value:"..self.definedFaceList:get(i))
    end


    for i = 0 ,self.facePartsCount - 1 do
        if i <=1 then
            self.partIntensity:set(i,self.faceEyeIntensity:get(0))
        elseif i >=6 and i <=8 then
            self.partIntensity:set(i,self.faceEyeIntensity:get(1))
        end
        local curIntensity = self.partIntensity:get(i)
        print("intensity index: "..i.." value:"..curIntensity)
    end  

    -- 计算形变参数
    Amaz.FaceDeformationUtils.calcDistortion(self.distortionParams, viewport, count, self.definedFaceList, detectedFacePoints, false,
        self.partIntensity,faceRolls,u_faceRoll,u_centers,u_radius,u_scales,u_angles,u_intensitys,u_counts,u_mins,u_maxs,u_types)
    self.distortionRenderer.props:setFloatVector("u_counts", u_counts)
    self.distortionRenderer.props:setVec2Vector("u_centers", u_centers)
    self.distortionRenderer.props:setVec2Vector("u_radius", u_radius)
    self.distortionRenderer.props:setFloatVector("u_scales", u_scales)
    self.distortionRenderer.props:setFloatVector("u_angles", u_angles)
    self.distortionRenderer.props:setFloatVector("u_mins", u_mins)
    self.distortionRenderer.props:setFloatVector("u_maxs", u_maxs)
    self.distortionRenderer.props:setFloatVector("u_types", u_types)
    self.distortionRenderer.props:setFloatVector("u_intensitys", u_intensitys)
    self.distortionRenderer.props:setFloatVector("u_faceRoll", u_faceRoll)

    self.distortionMaterial.properties:setFloat("u_aspectRatio", surfaceHeight/surfaceWidth)

end

function distortionScript:onEvent(comp, event)
    if event.args:get(0) == "SetEffectIntensity"  then
        if event.args:get(1) == "Internal_FaceDistortion_Eye" then
            self.faceEyeIntensity:set(0,event.args:get(2))
        elseif event.args:get(1) == "Internal_FaceDistortion_Face" then
            self.faceEyeIntensity:set(1,event.args:get(2))
        end
    end



end

exports.distortionScript = distortionScript

return exports
