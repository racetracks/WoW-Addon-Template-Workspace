-- check_load.lua
-- The addon loads, sets up its root table and saved variables, and the
-- slash command prints the version.
--   lua5.1 tools/harness/run.lua . - - tools/harness/check_load.lua
local fails = 0
local function check(ok, what)
	print((ok and "PASS " or "FAIL ") .. what)
	if not ok then fails = fails + 1 end
end

check(type(NS) == "table", "core root table exists")
check(_G.MyAddon == NS, "the root table is the global MyAddon")
check(type(MyAddonDB) == "table", "MyAddonDB is created at ADDON_LOADED")
check(NS.db == MyAddonDB, "NS.db points at MyAddonDB")

local line = ""
local realPrint = print
print = function(msg) line = tostring(msg) end
SlashCmdList.MYADDON("")
print = realPrint
check(line:find("^MyAddon ") ~= nil, "/myaddon prints the version")

if fails > 0 then os.exit(1) end
