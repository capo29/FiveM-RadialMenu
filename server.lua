local function buildPermissionTable(src, requestedPermissions)
    local permissions = {}

    if type(requestedPermissions) ~= "table" then
        return permissions
    end

    for _, permission in ipairs(requestedPermissions) do
        if type(permission) == "string" then
            permissions[permission] = IsPlayerAceAllowed(src, permission)
        end
    end

    return permissions
end

RegisterNetEvent("menu:refreshPermissions")
AddEventHandler("menu:refreshPermissions", function(requestedPermissions)
    local src = source
    local permissions = buildPermissionTable(src, requestedPermissions)
    TriggerClientEvent("menu:setPermissions", src, permissions)
end)
