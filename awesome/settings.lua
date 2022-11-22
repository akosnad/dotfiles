local settings = {
    terminal      = "urxvt",
    vi_focus      = false, -- vi-like client focus https://github.com/lcpz/awesome-copycats/issues/275
    cycle_prev    = true,  -- cycle with only the previously focused client or all https://github.com/lcpz/awesome-copycats/issues/274
    editor        = os.getenv("EDITOR") or "nvim",
    browser       = "google-chrome-stable",
    scrlocker     = "sh -c 'sleep 2; light-locker-command -l'",
--    scrlocker     = "xset dpms force off",
    screenshot    = "flameshot gui",
    tag_cachefile = "/tmp/awesome_tag_cache"
}

return settings
