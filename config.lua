local isJudge = false
local isPolice = false
local isMedic = false
local isDoctor = false
local isDead = false
local isInstructorMode = true
local myJob = "unemployed"
local isHandcuffed = false
local isHandcuffedAndWalking = false
local hasOxygenTankOn = false
local gangNum = 0
local cuffStates = {}
local acePermissions = {}
local useAcePermissions = true

local function collectAcePermissions()
    local permissions = {}
    local seen = {}

    local function addPermission(permission)
        if permission and not seen[permission] then
            seen[permission] = true
            permissions[#permissions + 1] = permission
        end
    end

    for _, menuConfig in ipairs(rootMenuConfig or {}) do
        addPermission(menuConfig.acePermission)
    end

    for _, menuConfig in pairs(newSubMenus or {}) do
        addPermission(menuConfig.acePermission)
    end

    return permissions
end

local function hasAcePermission(permission)
    if not useAcePermissions then
        return true
    end

    if permission == nil then
        return true
    end

    return acePermissions[permission] == true
end

local function requestAcePermissions()
    TriggerServerEvent("menu:refreshPermissions", collectAcePermissions())
end

AddEventHandler("onClientResourceStart", function(resourceName)
    if resourceName == GetCurrentResourceName() then
        requestAcePermissions()
    end
end)

AddEventHandler("playerSpawned", requestAcePermissions)

RegisterNetEvent("menu:setPermissions")
AddEventHandler("menu:setPermissions", function(permissions)
    if type(permissions) ~= "table" then
        return
    end

    acePermissions = permissions
end)

rootMenuConfig =  {
    --[[
        Exemple :

        {
            id = "police-vehicle",
            displayName = "Police",
            icon = "#police-vehicle",
            enableMenu = function()
                return (hasAcePermission("radialmenu.police") and not isDead and IsPedInAnyVehicle(PlayerPedId(), false))
            end,
            subMenus = {"general:unseatnearest", "police:runplate", "police:toggleradar"}
        },
    ]]
    -- Main menu
    {
        id = "vetement",
        displayName = "Clothing",
        icon = "#tshirt",
        enableMenu = function()
            return not isDead
        end,
        subMenus = {}
    },
    {
        id = "actions",
        displayName = "Actions",
        icon = "#magic",
        enableMenu = function()
            return (hasAcePermission("radialmenu.police") and not isDead)
        end,
        subMenus = {
            "police:cuff",
            "police:drag",
            "police:putinvehicle",
            "police:frisk",
            "police:checklicenses",
            "police:removeweapons",
            "police:escort",
            "police:runplate",
            "police:toggleradar"
        }
    },
    {
        id = "animations",
        displayName = "Emotes",
        icon = "#animation",
        enableMenu = function()
            return not isDead
        end,
        subMenus = { "animations:crossarms", "animations:sit", "animations:sitchair", "animations:salute", "animations:surrender", "animations:finger", "animations:stop",  "animations:pushup",  "animations:hug",  "animations:karate" }
    },
    {
        id = "walking",
        displayName = "Walking Styles",
        icon = "#walking",
        enableMenu = function()
            return not isDead
        end,
        subMenus = { "walk:brave", "walk:hurry", "walk:alien", "walk:tipsy", "walk:injured","walk:tough", "walk:default"}
    },
    -- Job Menu
    {
        id = "police-action",
        displayName = "Police",
        icon = "#police-action",
        acePermission = "radialmenu.police",
        enableMenu = function()
            return (hasAcePermission("radialmenu.police") and not isDead)
        end,
        subMenus = {"police:cuff", "police:drag", "police:putinvehicle", "police:checklicenses", "police:removeweapons", "police:escort", "police:frisk"}
    },
    {
        id = "police-vehicle",
        displayName = "Police Vehicle",
        icon = "#police-vehicle",
        acePermission = "radialmenu.police",
        enableMenu = function()
            return (hasAcePermission("radialmenu.police") and not isDead and IsPedInAnyVehicle(PlayerPedId(), false))
        end,
        subMenus = {"police:runplate", "police:toggleradar"}
    },
    {
        id = "medic",
        displayName = "Medical",
        icon = "#medic",
        acePermission = "radialmenu.medic",
        enableMenu = function()
            return (hasAcePermission("radialmenu.medic") and not isDead)
        end,
        subMenus = {}
    },
    {
        id = "vehicle",
        displayName = "Vehicle Options",
        icon = "#vehicle-options-vehicle",
        functionName = "veh:options",
        enableMenu = function()
            return (not isDead and IsPedInAnyVehicle(PlayerPedId(), false))
        end
    }
}

newSubMenus = {
      --[[
        Exemple :

        ["expressions:drunk"] = {
        title="Drunk",
        icon="#expressions-drunk",
        functionName = "expressions",
        functionParameters =  { "mood_drunk_1" }
        },
      ]]


    -- Animations
    ['animations:stop'] = {
        title="Stop Animation",
        icon="#stop-anim",
        functionName = "e c",
    },
    ['animations:crossarms'] = {
        title = "Cross Arms",
        icon = "#animation",
        functionName = "e cop2"
    },   
    ['animations:sit'] = {
        title = "Sit on Ground",
        icon = "#animation",
        functionName = "e sit"
    },
    ['animations:sitchair'] = {
        title = "Sit on Chair",
        icon = "#animation",
        functionName = "e sitchair"
    },
    ['animations:salute'] = {
        title = "Salute",
        icon = "#animation",
        functionName = "e salute"
    },
    ['animations:surrender'] = {
        title = "Surrender",
        icon = "#animation",
        functionName = "e surrender"
    },
    ['animations:finger'] = {
        title = "Finger",
        icon = "#animation",
        functionName = "e finger"
    },
    ['animations:pushup'] = {
        title = "Pushups",
        icon = "#animation",
        functionName = "e pushup"
    },
    ['animations:hug'] = {
        title = "Hug",
        icon = "#animation",
        functionName = "e hug"
    },
    ['animations:karate'] = {
        title = "Karate",
        icon = "#animation",
        functionName = "e karate"
    },


    -- Walk 
    ['walk:brave'] = {
        title = "Brave",
        icon = "#animation-brave",
        functionName = "walk brave"
    },
    ['walk:hurry'] = {
        title = "Hurry",
        icon = "#animation-hurry",
        functionName = "walk hurry"
    },
    ['walk:alien'] = {
        title = "Alien",
        icon = "#animation-alien",
        functionName = "walk alien"
    },
    ['walk:tipsy'] = {
        title = "Tipsy",
        icon = "#animation-tipsy",
        functionName = "walk drunk"
    },
    ['walk:injured'] = {
        title = "Injured",
        icon = "#animation-injured",
        functionName = "walk injured"
    },
    ['walk:tough'] = {
        title = "Tough",
        icon = "#animation-tough",
        functionName = "walk toughguy"
    },
    ['walk:default'] = {
        title = "Default",
        icon = "#animation-default",
        functionName = "walk reset"
    },

    -- Medic
    ['medic:revive'] = {
        title = "Revive",
        icon = "#medic-revive",
        functionName = "revive",
        acePermission = "radialmenu.medic"
    },
    ['medic:heal'] = {
        title = "Heal",
        icon = "#medic-heal",
        functionName = "ems:heal",
        acePermission = "radialmenu.medic"
    },

    -- Police
    ['police:cuff'] = {
        title = "Cuff",
        icon = "#cuffs-cuff",
        functionName = "police:cuffFromMenu",
        acePermission = "radialmenu.police"
    },
    ['police:drag'] = {
        title = "Drag",
        icon = "#general-escort",
        functionName = "police:dragFromMenu",
        acePermission = "radialmenu.police"
    },
    ['police:putinvehicle'] = {
        title = "Place in Vehicle",
        icon = "#general-put-in-veh",
        functionName = "police:putInVehicleFromMenu",
        acePermission = "radialmenu.police"
    },
    ['police:checklicenses'] = {
        title = "Check Licenses",
        icon = "#police-check-licenses",
        functionName = "police:checkLicenses",
        acePermission = "radialmenu.police"
    },
    ['police:removeweapons'] = {
        title = "Remove Weapon License",
        icon = "#police-action-remove-weapons",
        functionName = "police:removeWeapon",
        acePermission = "radialmenu.police"
    },
    ['police:escort'] = {
        title = "Escort",
        icon = "#police-action-gsr",
        functionName = "escortPlayer",
        acePermission = "radialmenu.police"
    },
    ['police:toggleradar'] = {
        title = "Toggle Radar",
        icon = "#police-vehicle-radar",
        functionName = "startSpeedo",
        acePermission = "radialmenu.police"
    },
    ['police:runplate'] = {
        title = "Run Plate",
        icon = "#police-vehicle-plate",
        functionName = "clientcheckLicensePlate",
        acePermission = "radialmenu.police"
    },
    ['police:frisk'] = {
        title = "Frisk",
        icon = "#police-action-frisk",
        functionName = "police:frisk",
        acePermission = "radialmenu.police"
    },

}

RegisterNetEvent("menu:setCuffState")
AddEventHandler("menu:setCuffState", function(pTargetId, pState)
    cuffStates[pTargetId] = pState
end)


RegisterNetEvent("isJudge")
AddEventHandler("isJudge", function()
    isJudge = true
end)

RegisterNetEvent("isJudgeOff")
AddEventHandler("isJudgeOff", function()
    isJudge = false
end)

RegisterNetEvent("np-jobmanager:playerBecameJob")
AddEventHandler("np-jobmanager:playerBecameJob", function(job, name, notify)
    if isMedic and job ~= "ambulance" then isMedic = false end
    if isPolice and job ~= "police" then isPolice = false end
    if isDoctor and job ~= "doctor" then isDoctor = false end
    if job == "police" then isPolice = true end
    if job == "ambulance" then isMedic = true end
    if job == "doctor" then isDoctor = true end
    myJob = job
end)

RegisterNetEvent('pd:deathcheck')
AddEventHandler('pd:deathcheck', function()
    if not isDead then
        isDead = true
    else
        isDead = false
    end
end)

RegisterNetEvent("drivingInstructor:instructorToggle")
AddEventHandler("drivingInstructor:instructorToggle", function(mode)
    if myJob == "driving instructor" then
        isInstructorMode = mode
    end
end)

RegisterNetEvent("police:currentHandCuffedState")
AddEventHandler("police:currentHandCuffedState", function(pIsHandcuffed, pIsHandcuffedAndWalking)
    isHandcuffedAndWalking = pIsHandcuffedAndWalking
    isHandcuffed = pIsHandcuffed
end)

RegisterNetEvent("menu:hasOxygenTank")
AddEventHandler("menu:hasOxygenTank", function(pHasOxygenTank)
    hasOxygenTankOn = pHasOxygenTank
end)

RegisterNetEvent('enablegangmember')
AddEventHandler('enablegangmember', function(pGangNum)
    gangNum = pGangNum
end)

function GetPlayers()
    local players = {}

    for i = 0, 255 do
        if NetworkIsPlayerActive(i) then
            players[#players+1]= i
        end
    end

    return players
end

function GetClosestPlayer()
    local players = GetPlayers()
    local closestDistance = -1
    local closestPlayer = -1
    local closestPed = -1
    local ply = PlayerPedId()
    local plyCoords = GetEntityCoords(ply, 0)
    if not IsPedInAnyVehicle(PlayerPedId(), false) then
        for index,value in ipairs(players) do
            local target = GetPlayerPed(value)
            if(target ~= ply) then
                local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
                local distance = #(vector3(targetCoords["x"], targetCoords["y"], targetCoords["z"]) - vector3(plyCoords["x"], plyCoords["y"], plyCoords["z"]))
                if(closestDistance == -1 or closestDistance > distance) and not IsPedInAnyVehicle(target, false) then
                    closestPlayer = value
                    closestPed = target
                    closestDistance = distance
                end
            end
        end
        return closestPlayer, closestDistance, closestPed
    end
end

trainstations = {
    {-547.34057617188,-1286.1752929688,25.3059978411511},
    {-892.66284179688,-2322.5168457031,-13.246466636658},
    {-1100.2299804688,-2724.037109375,-8.3086919784546},
    {-1071.4924316406,-2713.189453125,-8.9240007400513},
    {-875.61907958984,-2319.8686523438,-13.241264343262},
    {-536.62890625,-1285.0009765625,25.301458358765},
    {270.09558105469,-1209.9177246094,37.465930938721},
    {-287.13568115234,-327.40936279297,8.5491418838501},
    {-821.34295654297,-132.45257568359,18.436864852905},
    {-1359.9794921875,-465.32354736328,13.531299591064},
    {-498.96591186523,-680.65930175781,10.295949935913},
    {-217.97073364258,-1032.1605224609,28.724565505981},
    {113.90325164795,-1729.9976806641,28.453630447388},
    {117.33223724365,-1721.9318847656,28.527353286743},
    {-209.84713745117,-1037.2414550781,28.722997665405},
    {-499.3971862793,-665.58514404297,10.295639038086},
    {-1344.5224609375,-462.10494995117,13.531820297241},
    {-806.85192871094,-141.39852905273,18.436403274536},
    {-302.21514892578,-327.28854370117,8.5495929718018},
    {262.01733398438,-1198.6135253906,37.448017120361},
    {2072.4086914063,1569.0856933594,76.712524414063},
    {664.93090820313,-997.59942626953,22.261747360229},
    {190.62687683105,-1956.8131103516,19.520135879517},
    {2611.0278320313,1675.3806152344,26.578210830688},
    {2615.3901367188,2934.8666992188,39.312232971191},
    {2885.5346679688,4862.0146484375,62.551517486572},
    {47.061096191406,6280.8969726563,31.580261230469},
    {2002.3624267578,3619.8029785156,38.568252563477},
    {2609.7016601563,2937.11328125,39.418235778809}
}
