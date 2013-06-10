-- Enable / disable combat
function CheckButton1_OnClick()
	SlashCmdList.MYPETBATTLE('')
end

-- Automatic queue and join pet battle PvP
function CheckButton2_OnClick()
	SlashCmdList.MYPETBATTLE('join_pvp')
end

-- Enable automatic capture rares if you have room for more of that specie
function CheckButton3_OnClick()
	SlashCmdList.MYPETBATTLE('capture_rares')
end

-- Make random team based on desired pet level
function Button_MakeRandomTeam_OnClick()
	local desiredPetLevel = EditBox_PetLevel:GetText()  -- Get user input for desired pet level
	MyPetBattle.setTeam(desiredPetLevel)                -- Setup our team
	-- Save desired pet level for next time we log in
	MPB_EDITBOX_DESIRED_PET_LEVEL = desiredPetLevel
	-- Clear focus from the editbox
	EditBox_PetLevel:ClearFocus()                       
end

-- Print summary of your per journal rares
function Button_PetJournalSummary_OnClick()
	print("|cFF4169E1 :: Pet Journal summary report ::")
	
	local numPets, numOwned = C_PetJournal.GetNumPets()
--	print("Total owned pets: " .. numOwned)

	local petLevel = nil
	local rareCount = 0
	local n_ = nil
	for petLevel = 1, 25 do
		local petCount = 0
		for n_=1, numOwned do
			local petID, _, owned, _, level, _, isRevoked, speciesName, icon, petType, _, _, _, _, canBattle, _, _, obtainable = C_PetJournal.GetPetInfoByIndex(n_)
			local health, maxHealth, power, speed, rarity = C_PetJournal.GetPetStats(petID)
			
			if petLevel == level and owned and canBattle and not isRevoked and rarity == 4 then
				petCount = petCount + 1
				rareCount = rareCount + 1
			end
		end
		print("Level: " .. petLevel .. ", Count: #"  .. petCount)
	end
	print("Total |cFF0066FFrares|r owned: " .. rareCount)
end

function MyPetBattleForm_OnLoad()

	-- Load version from TOC and set label
	GUI_FontString_version:SetText("v"..GetAddOnMetadata("MyPetBattle", "Version"))
end

-- Open configuration panel
function Button_open_config_panel_OnClick()
	InterfaceOptionsFrame_OpenToCategory("MPB Options Panel")
end
