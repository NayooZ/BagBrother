--[[
	bank.lua
		A specialized version of the wildpants frame for the bank
--]]

local ADDON, Addon = ...
local C = LibStub('C_Everywhere').Container
local Bank = Addon.Frame:NewClass('BankFrame')
Bank.Title = LibStub('AceLocale-3.0'):GetLocale(ADDON).TitleBank
Bank.Item = Addon.InventoryItem
Bank.Bags = Addon.BankBags

function Bank:OnHide()
	self:Super(Bank):OnHide()
	CloseBankFrame()
end

function Bank:SortItems()
	if C.SortBankBags then
		C.SortBankBags()

		if self.SortReagents then
			self:Delay(.3, 'SortReagents')
		end
	else
		self:Super(Bank):SortItems(self)
	end
end

if REAGENTBANK_CONTAINER then
	function Bank:SortReagents()
		C.SortReagentBankBags()
	end

	function Bank:IsShowingBag(bag)
		local profile = self:GetProfile()
		if not profile.exclusiveReagent or bag == REAGENTBANK_CONTAINER or profile.hiddenBags[REAGENTBANK_CONTAINER] then
			return not profile.hiddenBags[bag]
		end
	end
end
