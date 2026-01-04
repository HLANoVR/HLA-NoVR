STEAM_DECK=false
DEFAULT_MENU=false
if GlobalSys:CommandLineCheck("-steamdeck") then
    STEAM_DECK=true
    DEFAULT_MENU=true
end
if GlobalSys:CommandLineCheck("-defaultmenu") then
    STEAM_DECK=false
    DEFAULT_MENU=true
end