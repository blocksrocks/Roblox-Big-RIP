local DEBUG_MODE = true

local function Repeat(interval, ...)
	while true do
		local arguments = {pcall(...)}

		local success = table.remove(arguments, 1)

		if DEBUG_MODE then
			print(success and "Success" or "Fail")
		end

		if success then
			return unpack(arguments)
		end

		wait(interval)
	end
end

return Repeat