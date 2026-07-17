DoIncludeScript("bindings.lua", nil)

_G.flashlight_on = "0"
_G.distillery_elev_called = 0
local distillery_elev_called_count = 0

function Spawn()
	-- Registers a function to get called each time the entity updates, or "thinks"
	thisEntity:SetContextThink(nil, MainThinkFunc, 0)
end

function MainThinkFunc()
	local playerEnt_pos = Entities:GetLocalPlayer()
	local startVector = playerEnt_pos:EyePosition()
	local playerHealth = playerEnt_pos:GetHealth()
	local traceTable =
	{
		startpos = startVector;
		endpos = startVector + RotatePosition(Vector(0,0,0), playerEnt_pos:EyeAngles(), Vector(200, 0, 0));
		ignore = playerEnt_pos;
		mask =  33636363; -- TRACE_MASK_PLAYER_SOLID from L4D2 script API, may not be correct for Source 2.
	}
	local fullpos = string.sub(string.format("%s", startVector),26,-2)
	--print(fullpos)
	local xpos_index = string.find(fullpos, " ")
	--print(xpos_index)
	local xpos = tonumber(string.sub(fullpos,0,xpos_index - 1))
	--print("Current x position: " .. xpos)
	local ypos_index = string.find(fullpos, " ", xpos_index + 1)
	--print(ypos_index)
	local ypos = tonumber(string.sub(fullpos,xpos_index + 1,ypos_index - 1))
	--print("Current y position: " .. ypos)
	local zpos = tonumber(string.sub(fullpos,ypos_index + 1,fullpos:len()))
	--print("Current z position: " .. zpos)
	
	-- POSITION
	if GetMapName() == "a1_intro_world" then
		if ( xpos > 464 and xpos < 519 ) and ( ypos > -2374 and ypos < -2303 ) then
			if _G.end_vent_shown == nil then
				local ent = SpawnEntityFromTableSynchronous("game_text", {["effect"]=2, ["spawnflags"]=1, ["color"]="230 230 230", ["color2"]="0 0 0", ["fadein"]=0, ["fadeout"]=0.15, ["fxtime"]=0.25, ["holdtime"]=5, ["x"]=-1, ["y"]=0.6})
				DoEntFireByInstanceHandle(ent, "SetText", "Press [" .. INTERACT .. "] to open the vent\n\nPress [" .. CROUCH .. "] and [" .. JUMP .. "] to get into the vent", 0, nil, nil)
				DoEntFireByInstanceHandle(ent, "Display", "", 0, nil, nil)
                SendToConsole("snd_sos_start_soundevent Instructor.StartLesson")
				_G.end_vent_shown = "1"
			end
		elseif ( xpos > 562 and xpos < 655 ) and ( ypos > -2359 and ypos < -2310 ) then
			SendToConsole("ent_fire 563_vent_phys_hinge setoffset 0")
		end
	elseif GetMapName() == "a1_intro_world_2" then
		if ( xpos > -1370.55 and xpos < -1366.44 ) and ( ypos > 2295 and ypos < 2343 ) and ( zpos > -100 and zpos < -90 ) then
			SendToConsole("setpos_player 1 -1408 2307 -114")
			SendToConsole("ent_fire 4962_car_door_left_front open")
		elseif ( xpos > -1745 and xpos < -1710 ) and ( ypos > 324 and ypos < 327 ) and ( zpos > 140 and zpos < 143 ) then
			SendToConsole("setpos_player 1 -1727.60 303.17 94.03")
        elseif (xpos > -921 and xpos < -903 ) and ( ypos > 894 and ypos < 955 ) then
			if _G.playground_ladder_shown == nil then
				local ent = SpawnEntityFromTableSynchronous("game_text", {["effect"]=2, ["spawnflags"]=1, ["color"]="230 230 230", ["color2"]="0 0 0", ["fadein"]=0, ["fadeout"]=0.15, ["fxtime"]=0.25, ["holdtime"]=5, ["x"]=-1, ["y"]=0.6})
				DoEntFireByInstanceHandle(ent, "SetText", "Press [" .. INTERACT .. "] to climb up the slide", 0, nil, nil)
				DoEntFireByInstanceHandle(ent, "Display", "", 0, nil, nil)
                SendToConsole("snd_sos_start_soundevent Instructor.StartLesson")
				_G.playground_ladder_shown = "1"
			end
		end
	elseif GetMapName() == "a3_station_street" then
		if ( xpos > 1436 and xpos < 1462 ) and ( ypos > -1370 and ypos < -1366 ) then
			SendToConsole("setpos_player 1 1449.94 -1393.25 160.53")
			SendToConsole("ent_fire 2860_window_wedge break")
			SendToConsole("ent_fire 2860_window_sliding1 wake")
		end
	elseif GetMapName() == "a3_hotel_interior_rooftop" then
		if ( xpos > 753.8 and xpos < 765 ) and ( ypos > -1440 and ypos < -1407 ) then
			SendToConsole("setpos_player 1 791.77 -1425.97 576.66")
			SendToConsole("ent_fire zombieparty_window_slideconstraint setoffset 0")
		end
	elseif GetMapName() == "a3_distillery" then
		if ( xpos > 611 and xpos < 667 ) and ( ypos > -934 and ypos < -895 ) then
			if _G.hold_mouth_shown == nil then
				local ent = SpawnEntityFromTableSynchronous("game_text", {["effect"]=2, ["spawnflags"]=1, ["color"]="230 230 230", ["color2"]="0 0 0", ["fadein"]=0, ["fadeout"]=0.15, ["fxtime"]=0.25, ["holdtime"]=5, ["x"]=-1, ["y"]=0.6})
				DoEntFireByInstanceHandle(ent, "SetText", "Hold [" .. COVER_MOUTH .. "] to Cover Mouth", 0, nil, nil)
				DoEntFireByInstanceHandle(ent, "Display", "", 0, nil, nil)
                SendToConsole("snd_sos_start_soundevent Instructor.StartLesson")
				_G.hold_mouth_shown = "1"
			end
		end
	elseif GetMapName() == "a4_c17_zoo" then
		if ( xpos > 5377 and xpos < 5414 ) and ( ypos > -1870 and ypos < -1868 ) and ( zpos > -90 and zpos < -80 ) then
			SendToConsole("setpos_player 1 5395.52 -1920.89 -115")
        elseif ( xpos > 5385 and xpos < 5405 ) and ( ypos > -1898 and ypos < -1888 ) and ( zpos > -90 and zpos < -85 ) then
			SendToConsole("setpos_player 1 5403.25 -1851.70 -115")
		end
	end

	-- LADDERS
	if GetMapName() == "a1_intro_world" then
		if pointInRect(xpos, ypos, 623, 653, -1778, -1732) then
			do_ladder(zpos, -141.97, "651.21 -1758.18 ", -1)
		end
	elseif GetMapName() == "a1_intro_world_2" then
        if pointInRect(xpos, ypos, -1296, -1260, 557, 595) then
			do_ladder(zpos, -63.97, "-1265.48 578.31 ", 129)
		end
	elseif GetMapName() == "a2_pistol" then
		if pointInRect(xpos, ypos, 413, 441, 870, 923) then
			do_ladder(zpos, 456.61, "439.27 895.84 ", 585)
		end
	elseif GetMapName() == "a2_headcrabs_tunnel" then
		if pointInRect(xpos, ypos, 331, 367, -284, -242) then
			do_ladder(zpos, -62.44, "348.03 -247.97 ", 64)
		end
	elseif GetMapName() == "a3_hotel_lobby_basement" then
		if pointInRect(xpos, ypos, 951, 994, -1508, -1477) then
			do_ladder(zpos, 208.50, "976.36 -1481.18 ", 336)
		end
	elseif GetMapName() == "a3_hotel_underground_pit" then
		if pointInRect(xpos, ypos, 2220, 2257, -1048, -1010) then
			do_ladder(zpos, 528.03, "2240.91 -1018.12 ", 618)
		end
	elseif GetMapName() == "a3_hotel_interior_rooftop" then
		if pointInRect(xpos, ypos, 2340, 2382, -1858, -1825) then
			do_ladder(zpos, 448.03, "2373.02 -1841.31 ", 617)
		elseif pointInRect(xpos, ypos, 2236, 2340, -1846, -1814) then
			do_ladder(zpos, 758.25, "2328.50 -1832.33 ", 900)
		end
	elseif GetMapName() == "a3_c17_processing_plant" then
		if pointInRect(xpos, ypos, -78, 36, -2235, -2198) then
			do_ladder(zpos, 760.03, "-69.59 -2216.18 ", 928)
		elseif pointInRect(xpos, ypos, 351, 410, -2484, -2444) then
			do_ladder(zpos, 328.03, "407.27 -2464.08 ", 473)
		elseif pointInRect(xpos, ypos, -245, -227, -2869, -2814) then
			do_ladder(zpos, 392.03, "-233.63 -2856.03 ", 471) -- can't get off the bottom
		elseif pointInRect(xpos, ypos, 312, 346, -3527, -3478) then
			do_ladder(zpos, 312.03, "327.32 -3491.01 ", 440)
		elseif pointInRect(xpos, ypos, -1412, -1369, -2508, -2471) then
			do_ladder(zpos, 113.87, "-1391.85 -2493.97 ", 497, Vector(0, 0, -1))
		end
	elseif GetMapName() == "a3_distillery" then
		if pointInRect(xpos, ypos, 2, 42, -510, -456) then
			do_ladder(zpos, 218.15, "20.84 -497.35 ", 514)
		elseif pointInRect(xpos, ypos, 124, 518, -250, -210) then
			do_ladder(zpos, 426.03, "139.24 -225.97 ", 512)
		elseif pointInRect(xpos, ypos, -36, 0, -163, -118) then
            if playerEnt_pos:Attribute_GetIntValue("pulled_larry_ladder", 0) == 1 then
                do_ladder(zpos, 426.03, "-23.33 -151.73 ", 610)
            end
		elseif pointInRect(xpos, ypos, 533, 582, 1579, 1616) then
			do_ladder(zpos, 578.00, "546.95 1597.03 ", 728)
		elseif pointInRect(xpos, ypos, 1012, 1043, 1760, 1796) then
            if playerEnt_pos:Attribute_GetIntValue("cellar_ladder_down", 0) == 1 then
                do_ladder(zpos, 482.03, "1036.45 1776.16 ", 609)
            end
		end
	elseif GetMapName() == "a4_c17_tanker_yard" then
		if pointInRect(xpos, ypos, 6967, 6987, 2567, 2619) then
			do_ladder(zpos, 13.03, "6980.50 2591.92 ", 311)
		elseif pointInRect(xpos, ypos, 6069, 6112, 3885, 3922) then
			do_ladder(zpos, 420.03, "6079.96 3903.27 ", 736)
		elseif pointInRect(xpos, ypos, 5439, 5487, 4857, 4895) then
			do_ladder(zpos, 288.03, "5454.97 4875.76 ", 448)
		elseif pointInRect(xpos, ypos, 5406, 5427, 5742, 5773) then
			do_ladder(zpos, 288.03, "5419.98 5756.60 ", 462, Vector(0, -0.5, 0.5))
		end
	elseif GetMapName() == "a4_c17_water_tower" then
		if pointInRect(xpos, ypos, 3278, 3314, 6029, 6061) then
			do_ladder(zpos, 64.03, "3311.53 6048.56 ", 192)
		elseif pointInRect(xpos, ypos, 2981, 3025, 5863, 5899) then -- joining to go back down doesn't quite work yet!
			do_ladder(zpos, -303.97, "2991.97 5880.39 ", -8)
		elseif pointInRect(xpos, ypos, 2327, 2381, 6213, 6247) then
			do_ladder(zpos, -177.97, "2355.19 6218.02 ", -104)
		elseif pointInRect(xpos, ypos, 2410, 2449, 6671, 6711) then
			do_ladder(zpos, 160.03, "2431.19 6677.94 ", 360)
		elseif pointInRect(xpos, ypos, 2829, 2864, 6132, 6177) then
			do_ladder(zpos, 384.78, "2848.55 6143.97 ", 600)
		end
	elseif GetMapName() == "a4_c17_parking_garage" then
		if pointInRect(xpos, ypos, -356, -314, -431, -401) then
            if playerEnt_pos:Attribute_GetIntValue("toner_ladder_down", 0) == 1 then
                do_ladder(zpos, 67.00, "-327.90 -418.57 ", 200)
            end
        end
	elseif GetMapName() == "a5_vault" then
		if pointInRect(xpos, ypos, -484, -443, 2882, 2900) then
            do_ladder(zpos, -501.88, "-454.75 2893.53 ", -389, Vector(0, 0, 0.75), Vector(0, 0, -2))
        end
	end

	-- FLASHLIGHT
	if playerEnt_pos:Attribute_GetIntValue("auto_flashlight", 1) == 1 then
		if Entities:GetLocalPlayer():Attribute_GetIntValue("flashlight_on", 0) == 1 and _G.flashlight_on == "0" then -- to help with turning on the auto flashlight after reload
			SendToConsole("disable_flashlight; inv_flashlight")
		end
		if string.match(GetMapName(), "a2_headcrabs_tunnel") then
			if ( xpos > 991 and xpos < 1072 ) and ( ypos > -2456 and ypos < -2375 ) then
				Entities:GetLocalPlayer():Attribute_SetIntValue("flashlight_on", 0) -- make sure the flashlight is turned off on the next map
				_G.flashlight_on = "0"
			elseif (xpos > 1107 and xpos < 1212 ) and ( ypos > -2424 and ypos < -2375 ) then
				if Entities:GetLocalPlayer():Attribute_GetIntValue("flashlight_on", 0) == 0 then
					SendToConsole("inv_flashlight")
				end
			end
		elseif string.match(GetMapName(), "a2_drainage") then
			if (xpos > 1405 and xpos < 1477 ) and ( ypos > -1842 and ypos < -1794 ) then
				Entities:GetLocalPlayer():Attribute_SetIntValue("flashlight_on", 0) -- make sure the flashlight is turned off on the next map
				_G.flashlight_on = "0"
			elseif ( xpos > 883 and xpos < 960 ) and ( ypos > -2600 and ypos < -2400 ) and ( zpos > 100 and zpos < 210 ) then
				if Entities:GetLocalPlayer():Attribute_GetIntValue("flashlight_on", 0) == 0 then
					SendToConsole("inv_flashlight")
				end
			elseif ( xpos > 1313 and xpos < 1362 ) and ( ypos > -1940 and ypos < -1838 ) then
				if Entities:GetLocalPlayer():Attribute_GetIntValue("flashlight_on", 0) == 0 then
					SendToConsole("inv_flashlight")
				end
			end
		elseif string.match(GetMapName(), "a3_hotel_interior_rooftop") then
			if ( xpos > 1855 and xpos < 1934 ) and ( ypos > -2528 and ypos < -2455 ) then
				SendToConsole("disable_flashlight")
				if Entities:FindByName(nil, "player_flashlight") then SendToConsole("ent_remove player_flashlight") end
				_G.flashlight_on = "0"
			end
		elseif string.match(GetMapName(), "a3_distillery") then
			if _G.distillery_elev_called == 1 then
				if distillery_elev_called_count < 260 then
					distillery_elev_called_count = distillery_elev_called_count + 1
				elseif distillery_elev_called_count == 260 then
					if _G.flashlight_on == "0" then
						SendToConsole("inv_flashlight")
						_G.flashlight_on = "1"
					end
					distillery_elev_called_count = 261
				end
			end
			if ( xpos > 150 and xpos < 430 ) and ( ypos > 1080 and ypos < 1500 ) and ( zpos > 250 and zpos < 400 ) then
				if _G.flashlight_on == "0" then
					SendToConsole("inv_flashlight")
					_G.flashlight_on = "1"
				end
			end
		elseif string.match(GetMapName(), "a4_c17_zoo") then
			if ( xpos > 7582 and xpos < 7720 ) and ( ypos > -3810 and ypos < -3380 ) then
				if _G.flashlight_on == "0" then
					SendToConsole("inv_flashlight")
					_G.flashlight_on = "1"
				end
			elseif ( xpos > 7274 and xpos < 7533 ) and ( ypos > -3772 and ypos < -3619 ) then
				SendToConsole("disable_flashlight")
				if Entities:FindByName(nil, "player_flashlight") then SendToConsole("ent_remove player_flashlight") end
				_G.flashlight_on = "0"
			elseif ( xpos > 4940 and xpos < 5033 ) and ( ypos > -1946 and ypos < -1739 ) then
				if _G.flashlight_on == "0" then
					SendToConsole("inv_flashlight")
					_G.flashlight_on = "1"
				end
			elseif ( xpos > 5071 and xpos < 5161 ) and ( ypos > -1843 and ypos < -1714 ) then
				SendToConsole("disable_flashlight")
				if Entities:FindByName(nil, "player_flashlight") then SendToConsole("ent_remove player_flashlight") end
				_G.flashlight_on = "0"
			end
		elseif string.match(GetMapName(), "a4_c17_tanker_yard") then
			if ( xpos > 6015 and xpos < 6073 ) and ( ypos > 3892 and ypos < 4044 ) and ( zpos > 380 and zpos < 430 ) then
				if _G.flashlight_on == "0" then
					SendToConsole("inv_flashlight")
					_G.flashlight_on = "1"
				end
			elseif ( xpos > 6124 and xpos < 6180 ) and ( ypos > 4171 and ypos < 4240 ) then
				SendToConsole("disable_flashlight")
				if Entities:FindByName(nil, "player_flashlight") then SendToConsole("ent_remove player_flashlight") end
				_G.flashlight_on = "0"
			end
		end
	end
	
	return 0.1
end

function get_on_ladder(starting_point)
	local playerEnt_pos = Entities:GetLocalPlayer()
    if Entities:GetLocalPlayer():Attribute_GetIntValue("player_on_ladder", 0) == 0 then
        playerEnt_pos:SetVelocity(Vector(0, 0, 0))
        if playerEnt_pos:Attribute_GetIntValue("pressing_forward", 0) == 1 then
            SendToConsole("setpos_player 1 " .. starting_point .. ";-forward_climb;+forward_climb")
        else
            SendToConsole("setpos_player 1 " .. starting_point .. ";-forward_climb")
        end
        Entities:GetLocalPlayer():Attribute_SetIntValue("player_on_ladder", 1)
    end
end

function get_off_ladder(top_bottom, push_direction)
    if Entities:GetLocalPlayer():Attribute_GetIntValue("player_on_ladder", 0) == 1 then
        local playerEnt_pos = Entities:GetLocalPlayer()
        if push_direction == nil then
            if top_bottom == "bottom" then
                playerEnt_pos:SetVelocity(Vector(playerEnt_pos:GetForwardVector().x - (playerEnt_pos:GetForwardVector().x * 2), playerEnt_pos:GetForwardVector().y - (playerEnt_pos:GetForwardVector().y * 2), 0):Normalized() * 150)
                if playerEnt_pos:Attribute_GetIntValue("pressing_back", 0) == 1 then
                    SendToConsole("-forward_climb;-back_descend;+back_descend")
                else
                    SendToConsole("-forward_climb;-back_descend")
                end
            else
                playerEnt_pos:SetVelocity(Vector(playerEnt_pos:GetForwardVector().x, playerEnt_pos:GetForwardVector().y, 0):Normalized() * 150)
                if playerEnt_pos:Attribute_GetIntValue("pressing_forward", 0) == 1 then
                    SendToConsole("-forward_climb;-back_descend;+forward_climb")
                else
                    SendToConsole("-forward_climb;-back_descend;")
                end
            end
        else
            if top_bottom == "bottom" then
                playerEnt_pos:SetVelocity(Vector(push_direction.z, push_direction.y, push_direction.z) * 150)
                if playerEnt_pos:Attribute_GetIntValue("pressing_back", 0) == 1 then
                    SendToConsole("-forward_climb;-back_descend;+back_descend")
                else
                    SendToConsole("-forward_climb;-back_descend;")
                end
            else
                playerEnt_pos:SetVelocity(Vector(push_direction.z, push_direction.y, push_direction.z) * 150)
                if playerEnt_pos:Attribute_GetIntValue("pressing_forward", 0) == 1 then
                    SendToConsole("-forward_climb;-back_descend;+forward_climb")
                else
                    SendToConsole("-forward_climb;-back_descend;")
                end
            end
        end
        SendToConsole("+iv_duck;-iv_duck")
        Entities:GetLocalPlayer():Attribute_SetIntValue("player_on_ladder", 0)
        playerEnt_pos:Attribute_SetIntValue("climb_dir", 0)
    end
end

function pointInRect(x, y, left, right, bottom, top)
    return x > left and x < right and y > bottom and y < top
end

function do_ladder(zpos, bottom_eye_height, join_point, top_eye_height, top_push_dir, bottom_push_dir)
    local playerEnt_pos = Entities:GetLocalPlayer()
	if (zpos > (bottom_eye_height - 38) and zpos < (bottom_eye_height + 0.1)) and playerEnt_pos:Attribute_GetIntValue("climb_dir", 0) ~= 2 then
		get_on_ladder(join_point .. (bottom_eye_height - 53))
	else
		if zpos > top_eye_height then
            if top_push_dir ~= nil then
                get_off_ladder("top", top_push_dir)
            else
                get_off_ladder("top")
            end
		elseif zpos < (bottom_eye_height + 3) then
            if bottom_push_dir ~= nil then
                get_off_ladder("bottom", bottom_push_dir)
            else
                get_off_ladder("bottom")
            end
		end
	end
end