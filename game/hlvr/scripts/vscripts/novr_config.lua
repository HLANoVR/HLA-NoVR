STEAM_DECK=true
DEFAULT_MENU=false
if GlobalSys:CommandLineCheck("-steamdeck") then
    STEAM_DECK=true
    DEFAULT_MENU=true
end
if GlobalSys:CommandLineCheck("-defaultmenu") then
    DEFAULT_MENU=true
end
AUTO_FLASHLIGHT=true
if GlobalSys:CommandLineCheck("-noautoflashlight") then
    AUTO_FLASHLIGHT=false
end
NO_CULL=false
if GlobalSys:CommandLineCheck("-nocull") then
    NO_CULL=true
end
if GlobalSys:CommandLineCheck("-novr_launcher") then
    DEFAULT_MENU=false
end
if GlobalSys:CommandLineCheck("-novr_basichud") then
    STEAM_DECK=true
end
if GlobalSys:CommandLineCheck("-novr_classichud") then
    STEAM_DECK=false
end