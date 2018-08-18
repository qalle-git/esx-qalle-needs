ESX                             = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(1)
	end
  	PlayerData = ESX.GetPlayerData()
end)

RegisterCommand('pee', function()
    TriggerEvent('esx_status:getStatus', 'pee', function(status)
        if status.val > 200000 and not peeing then
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                --checks female or male
                if skin.sex == 0 then
                    TriggerServerEvent('esx-qalle-needs:sync', GetPlayerServerId(PlayerId()), 'pee', 'male')
                else
                    TriggerServerEvent('esx-qalle-needs:sync', GetPlayerServerId(PlayerId()), 'pee', 'female')
                end
            end)
        end
    end)
end, false)

RegisterCommand('poop', function()
    TriggerEvent('esx_status:getStatus', 'poop', function(status)
        if status.val > 200000 and not peeing then
            TriggerServerEvent('esx-qalle-needs:sync', GetPlayerServerId(PlayerId()), 'water')
            print('poop')
        else
            ESX.ShowNotification('Du är ej skitnödig')
        end
    end)
end, false)

RegisterNetEvent('esx-qalle-needs:syncCL')
AddEventHandler('esx-qalle-needs:syncCL', function(ped, need, sex)
    if need == 'pee' then
        Pee(ped, sex)
    else
        Poop(ped)
    end
end)

local peeing = false
local pooping = false

function Pee(ped, sex)
    local Player = ped
    local PlayerPed = GetPlayerPed(GetPlayerFromServerId(ped))

    local particleDictionary = "core"
    local particleName = "ent_amb_peeing"
    local animDictionary = 'missbigscore1switch_trevor_piss'
    local animName = 'piss_loop'

    RequestNamedPtfxAsset(particleDictionary)

    while not HasNamedPtfxAssetLoaded(particleDictionary) do
        Citizen.Wait(0)
    end

    RequestAnimDict(animDictionary)

    while not HasAnimDictLoaded(animDictionary) do
        Citizen.Wait(0)
    end

    RequestAnimDict('missfbi3ig_0')

    while not HasAnimDictLoaded('missfbi3ig_0') do
        Citizen.Wait(1)
    end

    if sex == 'male' then
        peeing = true

        SetPtfxAssetNextCall(particleDictionary)

        TriggerServerEvent('esx-qalle-needs:add', GetPlayerServerId(Player), 'pee', 1000000)

        bone   = GetPedBoneIndex(PlayerPed, 11816)

        local heading = GetEntityPhysicsHeading(PlayerPed)

        TaskPlayAnim(PlayerPed, animDictionary, animName, 8.0, -8.0, -1, 0, 0, false, false, false)

        local effect = StartParticleFxLoopedOnPedBone(particleName, PlayerPed, 0.0, 0.0, -0.1, -90.0, 0.0, 20.0, bone, 2.0, false, false, false)

        Wait(3500)
        peeing = false

        StopParticleFxLooped(effect, 0)
    else
        peeing = true

        SetPtfxAssetNextCall(particleDictionary)

        TriggerServerEvent('esx-qalle-needs:add', GetPlayerServerId(Player), 'pee', 1000000)

        bone = GetPedBoneIndex(PlayerPed, 11816)

        local heading = GetEntityPhysicsHeading(PlayerPed)

        TaskPlayAnim(PlayerPed, 'missfbi3ig_0', 'shit_loop_trev', 8.0, -8.0, -1, 0, 0, false, false, false)

        local effect = StartParticleFxLoopedOnPedBone(particleName, PlayerPed, 0.0, 0.0, -0.55, 0.0, 0.0, 20.0, bone, 2.0, false, false, false)

        Wait(3500)
        peeing = false

        Citizen.Wait(100)
        StopParticleFxLooped(effect, 0)
    end
end

function Poop(ped)
    local Player = ped
    local PlayerPed = GetPlayerPed(GetPlayerFromServerId(ped))

    local particleDictionary = "scr_amb_chop"
    local particleName = "ent_anim_dog_poo"
    local animDictionary = 'missfbi3ig_0'
    local animName = 'shit_loop_trev'

    RequestNamedPtfxAsset(particleDictionary)

    while not HasNamedPtfxAssetLoaded(particleDictionary) do
        Citizen.Wait(0)
    end

    RequestAnimDict(animDictionary)

    while not HasAnimDictLoaded(animDictionary) do
        Citizen.Wait(0)
    end

    pooping = true

    SetPtfxAssetNextCall(particleDictionary)

    --gets bone on specified ped
    bone = GetPedBoneIndex(PlayerPed, 11816)

    --adds to status
    TriggerServerEvent('esx-qalle-needs:add', GetPlayerServerId(Player), 'poop', 1000000)

    --animation
    TaskPlayAnim(PlayerPed, animDictionary, animName, 8.0, -8.0, -1, 0, 0, false, false, false)

    --2 effets for more shit
    effect = StartParticleFxLoopedOnPedBone(particleName, PlayerPed, 0.0, 0.0, -0.6, 0.0, 0.0, 20.0, bone, 2.0, false, false, false)
    Wait(3500)
    effect2 = StartParticleFxLoopedOnPedBone(particleName, PlayerPed, 0.0, 0.0, -0.6, 0.0, 0.0, 20.0, bone, 2.0, false, false, false)
    Wait(1000)

    pooping = false

    StopParticleFxLooped(effect, 0)
    Wait(10)
    StopParticleFxLooped(effect2, 0)
end
