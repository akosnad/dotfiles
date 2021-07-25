local settings = {
    themes = {
        "blackburn",       -- 1
        "copland",         -- 2
        "dremora",         -- 3
        "holo",            -- 4
        "multicolor",      -- 5
        "powerarrow",      -- 6
        "powerarrow-dark", -- 7
        "rainbow",         -- 8
        "steamburn",       -- 9
        "vertex"           -- 10
    },
    terminal     = "urxvtc",
    vi_focus     = false, -- vi-like client focus https://github.com/lcpz/awesome-copycats/issues/275
    cycle_prev   = true,  -- cycle with only the previously focused client or all https://github.com/lcpz/awesome-copycats/issues/274
    editor       = os.getenv("EDITOR") or "nvim",
    browser      = "google-chrome-stable",
    scrlocker    = "sh -c 'sleep 2; light-locker-command -l'",
--    scrlocker    = "xset dpms force off",
    screenshot   = "flameshot gui",
}
settings.chosen_theme = settings.themes[7]

return settings
