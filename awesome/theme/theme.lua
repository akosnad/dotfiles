--[[

     Powerarrow Dark Awesome WM theme
     github.com/lcpz
     modified to follow Xresources colors

--]]

local gears      = require("gears")
local lain       = require("lain")
local awful      = require("awful")
local naughty    = require("naughty")
local beautiful  = require("beautiful")
local wibox      = require("wibox")
local xresources = require("beautiful.xresources")
local dpi        = xresources.apply_dpi

local settings   = require("theme/settings")

local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility
local primary_screen = screen[1]

local theme = settings.theme
local markup = lain.util.markup
local separators = lain.util.separators

local function keyboardlayout()
    local w = awful.widget.keyboardlayout:new()
    w.widget.font = theme.font
    return w
end

-- Textclock
local clockicon = wibox.widget.imagebox(theme.widget_clock)
local clock = awful.widget.watch(
    "date +'%b %d. %a %T'", 1,
    function(widget, stdout)
        widget:set_markup(" " .. markup.font(theme.font, stdout))
    end
)

-- Calendar
--[[ theme.cal = lain.widget.cal({
    attach_to = { clock },
    notification_preset = {
        font = "Terminus 10",
        fg   = theme.fg_normal,
        bg   = theme.bg_normal
    }
})
--]]


-- Mail IMAP check
-- local mailicon = wibox.widget.imagebox(theme.widget_mail)
--[[ commented because it needs to be set before use
mailicon:buttons(my_table.join(awful.button({ }, 1, function () awful.spawn(mail) end)))
theme.mail = lain.widget.imap({
    timeout  = 180,
    server   = "server",
    mail     = "mail",
    password = "keyring get mail",
    settings = function()
        if mailcount > 0 then
            widget:set_markup(markup.font(theme.font, " " .. mailcount .. " "))
            mailicon:set_image(theme.widget_mail_on)
        else
            widget:set_text("")
            mailicon:set_image(theme.widget_mail)
        end
    end
})
--]]

-- MPRIS
local music_icon = wibox.widget.imagebox(theme.widget_music)
theme.mpris, theme.mpris_timer = awful.widget.watch(
    { awful.util.shell, "-c",
    "playerctl status && playerctl metadata --format '{{artist}}' && playerctl metadata --format '{{title}}'" },
    2,
    function(widget, stdout)
         local escape_f  = require("awful.util").escape
         local lines = {}
         for s in stdout:gmatch("[^\r\n]+") do
             table.insert(lines, s)
         end
         local mpris_now = {
             state        = "N/A",
             artist       = "N/A",
             title        = "N/A",
             art_url      = "N/A",
             album        = "N/A",
             album_artist = "N/A"
         }

         mpris_now.state = string.match(stdout, "Playing") or
                           string.match(stdout, "Paused")  or "N/A"

         mpris_now.artist = lines[2]
         mpris_now.title = lines[3]

        --[[
         for k, v in string.gmatch(stdout, "'[^:]+:([^']+)':[%s]<%[?'([^']+)'%]?>")
         do
             if     k == "artUrl"      then mpris_now.art_url      = v
             elseif k == "artist"      then mpris_now.artist       = escape_f(v)
             elseif k == "title"       then mpris_now.title        = escape_f(v)
             elseif k == "album"       then mpris_now.album        = escape_f(v)
             elseif k == "albumArtist" then mpris_now.album_artist = escape_f(v)
             end
         end
         --]]
--        widget:set_text(mpris_now.artist .. " - " .. mpris_now.title)
        widget:set_markup(markup.font(theme.font, " " .. mpris_now.artist .. " - " .. mpris_now.title .. " "))
    end
)

-- MEM
local memicon = wibox.widget.imagebox(theme.widget_mem)
local mem = lain.widget.mem({
    settings = function()
        widget:set_markup(markup.font(theme.font, " " .. mem_now.used .. "MB "))
    end
})

-- CPU
local cpuicon = wibox.widget.imagebox(theme.widget_cpu)
local cpu = lain.widget.cpu({
    settings = function()
        widget:set_markup(markup.font(theme.font, " " .. cpu_now.usage .. "% "))
    end
})

-- Coretemp
local tempicon = wibox.widget.imagebox(theme.widget_temp)
local temp = lain.widget.temp({
    settings = function()
        widget:set_markup(markup.font(theme.font, " " .. coretemp_now .. "°C "))
    end
})

-- / fs
local fsicon = wibox.widget.imagebox(theme.widget_hdd)
theme.fs = lain.widget.fs({
    notification_preset = { fg = theme.fg_normal, bg = theme.bg_normal, font = "Terminus 10" },
    settings = function()
        widget:set_markup(markup.font(theme.font, " " .. fs_now["/"].percentage .. "% "))
    end
})

-- Battery
local baticon = wibox.widget.imagebox(theme.widget_battery)
local bat = lain.widget.bat({
    settings = function()
        if bat_now.status and bat_now.status ~= "N/A" then
            widget:set_markup(markup.font(theme.font, " " .. bat_now.perc .. "% " .. bat_now.time .. " "))
            if bat_now.ac_status == 1 then
                baticon:set_image(theme.widget_ac)
                widget:set_markup(markup.font(theme.font, " " .. bat_now.perc .. "% "))
            elseif not bat_now.perc and tonumber(bat_now.perc) <= 5 then
                baticon:set_image(theme.widget_battery_empty)
            elseif not bat_now.perc and tonumber(bat_now.perc) <= 15 then
                baticon:set_image(theme.widget_battery_low)
            else
                baticon:set_image(theme.widget_battery)
            end
        else
            widget:set_markup(markup.font(theme.font, " AC "))
            baticon:set_image(theme.widget_ac)
        end
    end
})

-- Pulse volume
local volicon = wibox.widget.imagebox(theme.widget_vol)
theme.volume = lain.widget.pulse({
    settings = function()
        if volume_now == nil then
            volicon:set_image(theme.widget_vol)
            widget:set_markup(markup.font(theme.font, "N/A "))
            return
        elseif volume_now.muted == "yes" then
            volicon:set_image(theme.widget_vol_mute)
        elseif tonumber(volume_now.left) == 0 then
            volicon:set_image(theme.widget_vol_no)
        elseif tonumber(volume_now.left) <= 50 then
            volicon:set_image(theme.widget_vol_low)
        else
            volicon:set_image(theme.widget_vol)
        end

        widget:set_markup(markup.font(theme.font, " " .. volume_now.left .. "% "))
    end
})
theme.volume.widget:buttons(awful.util.table.join(
                               awful.button({}, 4, function ()
                                     awful.util.spawn("pactl set-sink-volume 0 -1%")
                                     theme.volume.update()
                               end),
                               awful.button({}, 5, function ()
                                     awful.util.spawn("pactl set-sink-volume 0 +1%")
                                     theme.volume.update()
                               end),
                               awful.button({}, 1, function ()
                                     awful.util.spawn("pavucontrol")
                               end)
))

-- Net
local neticon = wibox.widget.imagebox(theme.widget_net)
local net = lain.widget.net({
    settings = function()
        widget:set_markup(markup.font(theme.font,
                          markup("#7AC82E", " " .. string.format("%06.1f", net_now.received))
                          .. " " ..
                          markup("#46A8C3", " " .. string.format("%06.1f", net_now.sent) .. " ")))
    end,
    notify = "off"
})

-- Separators
local spr     = wibox.widget.textbox(' ')
local arrl_dl = separators.arrow_left(theme.bg_focus, "alpha")
local arrl_ld = separators.arrow_left("alpha", theme.bg_focus)


local function table_length(t)
    local n = 0
    for _ in pairs(t) do n = n + 1 end
    return n
end

-- Helper for adding widgets to a taskbar
local function add_widgets(widgets, layout, side)
    local setup = {
        layout = layout
    }
    local odd = false
    for i, widget_group in pairs(widgets) do
        if side == "right" and i ~= 1 then
            if odd then
                table.insert(setup, arrl_ld)
            else
                table.insert(setup, arrl_dl)
            end
        end
        for _, w in pairs(widget_group) do
            if odd then
                table.insert(setup,
                    wibox.container.background(w, theme.bg_focus)
                )
            else
                table.insert(setup, w)
            end
        end
        if side == "left" and i ~= table_length(widgets) then
            if odd then
                table.insert(setup, arrl_dl)
            else
                table.insert(setup, arrl_ld)
            end
        end

        odd = not odd
    end
    return setup
end


function theme.at_screen_connect(s)
    -- Quake application
    s.quake = lain.util.quake({ app = awful.util.terminal })

    -- If wallpaper is a function, call it with the screen
    local wallpaper = theme.wallpaper
    if type(wallpaper) == "function" then
        wallpaper = wallpaper(s)
    end
    gears.wallpaper.maximized(wallpaper, s, true)

    -- Tags
    awful.tag(awful.util.tagnames, s, awful.layout.layouts)

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(my_table.join(
                           awful.button({}, 1, function () awful.layout.inc( 1) end),
                           awful.button({}, 2, function () awful.layout.set( awful.layout.layouts[1] ) end),
                           awful.button({}, 3, function () awful.layout.inc(-1) end),
                           awful.button({}, 4, function () awful.layout.inc( 1) end),
                           awful.button({}, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, awful.util.taglist_buttons)

    local function tasklist_format(index)
        local r = index % 2
        if r == 0 then
            return {
                arr = arrl_dl,
                bg = wibox.container.background(theme.bg_normal),
            }
        else
            return {
                arr = arrl_ld,
                bg = wibox.container.background(theme.bg_normal),
            }
        end
    end

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist{
        screen = s,
        filter = awful.widget.tasklist.filter.currenttags,
        buttons = awful.util.tasklist_buttons,
        layout = {
            layout = wibox.layout.flex.horizontal
        },
        widget_template = {
            {
                {
                    id = 'arrow',
                    widget = wibox.container.margin
                },
                {
                    {
                        id     = 'icon_role',
                        widget = wibox.widget.imagebox,
                    },
                    margins = dpi(4),
                    widget  = wibox.container.margin,
                },
                {
                    id     = 'text_role',
                    widget = wibox.widget.textbox,
                },
                layout = wibox.layout.fixed.horizontal,
            },
            id     = 'background_role',
            widget = wibox.container.background,
            nil,
-- TODO: style tasklist to be consistent with arrows on the wibar
--[[            update_callback = function(self, c, index, objects)
                if c == client.focus then
                    self:get_children_by_id('arrow')[1].widget = arrl_dl
                else
                   self:get_children_by_id('arrow')[1].widget = arrl_ld
                end
            end, --]]
        }
    }

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s, height = dpi(20), bg = theme.bg_systray, fg = theme.fg_normal })

    -- Notification bar
    s.notif_wb = awful.wibar({ position = "bottom", screen = s, height = dpi(48), bg = theme.bg_systray, fg = theme.fg_normal, visible = false })



    -- Primary screen widgets
    local primary_widgets = {
        { spr, wibox.widget.systray(), spr },
        { volicon, theme.volume.widget },
                --wibox.container.background(mailicon, theme.bg_focus),
                --wibox.container.background(theme.mail.widget, theme.bg_focus),
        { memicon, mem.widget },
        { cpuicon, cpu.widget },
        --{ tempicon, temp.widget },
        { fsicon, theme.fs.widget },
        { baticon, bat.widget },
        { neticon, net.widget },
        { keyboardlayout() },
        { clockicon, clock },
        { s.mylayoutbox },
    }

    -- Secondary screen widgets
    local secondary_widgets = {
        { clockicon, clock },
        { s.mylayoutbox }
    }

    -- Common widgets - left side
    local common_widgets = {
        { s.mytaglist, s.mypromptbox },
    }

    if s == primary_screen then
    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            --spr,
            add_widgets(common_widgets, wibox.layout.fixed.horizontal, "left"),
        },
        {
            layout = wibox.layout.flex.horizontal,
            s.mytasklist, -- Middle widget
        },
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            add_widgets(primary_widgets, wibox.layout.fixed.horizontal, "right"),
        },
    }
    else -- Screens other than primary
    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            --spr,
            add_widgets(common_widgets, wibox.layout.fixed.horizontal, "left"),
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            add_widgets(secondary_widgets, wibox.layout.fixed.horizontal, "right"),
        },
    }
    end
end

return theme
