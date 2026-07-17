-- Script originally made by JJL772: https://github.com/JJL772/half-life-alyx-scripts
Convars:RegisterConvar("sv_jump_force", "180", "The force applied to the player when jumping", 0)

Convars:RegisterCommand("jumpfixed", function()
	local player = Entities:GetLocalPlayer()
    if player:Attribute_GetIntValue("sprinting", 0) == 1 then
        SendToConsole("ent_fire player_speedmod ModifySpeed 2")
    end
	if player ~= nil and player:GetVelocity().z > -30 then
		player:ApplyAbsVelocityImpulse(Vector(0,0,400))
		player:SetThink(normalizeJump, self, 0.02)
	end

    count = 0
    player:SetThink(function()
        if count == 1 then
            if player:Attribute_GetIntValue("sprinting", 0) == 1 then
                SendToConsole("ent_fire player_speedmod ModifySpeed 3.5")
            end
        else
            count = 1
            return 0.5
        end
    end, "Return to sprint", 0)
end, "Jump, but fixed!", 0)

function normalizeJump(player)
	local vel = player:GetVelocity()
    if player:Attribute_GetIntValue("sprinting", 0) == 1 then
        player:SetVelocity(Vector(vel.x * 4, vel.y * 4, Convars:GetFloat("sv_jump_force")))
    else
        player:SetVelocity(Vector(vel.x * 3, vel.y * 3, Convars:GetFloat("sv_jump_force")))
    end
end
