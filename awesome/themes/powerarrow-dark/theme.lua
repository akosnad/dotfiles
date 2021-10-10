--[[

     Powerarrow Dark Awesome WM theme
     github.com/lcpz
     modified to follow Xresources colors

--]]

local gears     = require("gears")
local lain      = require("lain")
local awful     = require("awful")
local naughty   = require("naughty")
local beautiful = require("beautiful")
local wibox     = require("wibox")
local xresources= require("beautiful.xresources")
local dpi       = xresources.apply_dpi
local xrdb      = xresources.get_current_theme()

local os = os
local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility
local primary_screen = screen[1]

local theme                                     = {}
theme.dir                                       = os.getenv("HOME") .. "/.config/awesome/themes/powerarrow-dark"
theme.wallpaper                                 = theme.dir .. "/../black.png"
theme.font                                      = "Terminus 9"
theme.bg_normal     = xrdb.background
theme.bg_focus      = xrdb.color10
theme.bg_urgent     = xrdb.color9
theme.bg_minimize   = theme.bg_normal
theme.bg_systray    = theme.bg_normal

theme.fg_normal     = xrdb.foreground
theme.fg_focus      = xrdb.color13
theme.fg_urgent     = xrdb.color15
theme.fg_minimize   = xrdb.color12

theme.useless_gap   = dpi(3)
theme.border_width  = dpi(2)
theme.border_normal = xrdb.color0
theme.border_focus  = theme.bg_focus
theme.border_marked = theme.bg_focus

theme.border_width                              = dpi(1)
theme.border_normal                             = xrdb.color0
theme.border_focus                              = theme.bg_focus
theme.border_marked                             = theme.border_marked
theme.tasklist_bg_focus                         = theme.bg_focus
theme.titlebar_bg_focus                         = theme.bg_focus
theme.titlebar_bg_normal                        = theme.bg_normal
theme.titlebar_fg_focus                         = theme.fg_focus
theme.tooltip_fg                                = theme.fg_normal
theme.tooltip_bg                                = theme.bg_normal
theme.menu_height                               = dpi(16)
theme.menu_width                                = dpi(140)
theme.menu_submenu_icon                         = theme.dir .. "/icons/submenu.png"
theme.taglist_squares_sel                       = theme.dir .. "/icons/square_sel.png"
theme.taglist_squares_unsel                     = theme.dir .. "/icons/square_unsel.png"
theme.layout_tile                               = theme.dir .. "/icons/tile.png"
theme.layout_tileleft                           = theme.dir .. "/icons/tileleft.png"
theme.layout_tilebottom                         = theme.dir .. "/icons/tilebottom.png"
theme.layout_tiletop                            = theme.dir .. "/icons/tiletop.png"
theme.layout_fairv                              = theme.dir .. "/icons/fairv.png"
theme.layout_fairh                              = theme.dir .. "/icons/fairh.png"
theme.layout_spiral                             = theme.dir .. "/icons/spiral.png"
theme.layout_dwindle                            = theme.dir .. "/icons/dwindle.png"
theme.layout_max                                = theme.dir .. "/icons/max.png"
theme.layout_fullscreen                         = theme.dir .. "/icons/fullscreen.png"
theme.layout_magnifier                          = theme.dir .. "/icons/magnifier.png"
theme.layout_floating                           = theme.dir .. "/icons/floating.png"
theme.widget_ac                                 = theme.dir .. "/icons/ac.png"
theme.widget_battery                            = theme.dir .. "/icons/battery.png"
theme.widget_battery_low                        = theme.dir .. "/icons/battery_low.png"
theme.widget_battery_empty                      = theme.dir .. "/icons/battery_empty.png"
theme.widget_mem                                = theme.dir .. "/icons/mem.png"
theme.widget_cpu                                = theme.dir .. "/icons/cpu.png"
theme.widget_temp                               = theme.dir .. "/icons/temp.png"
theme.widget_net                                = theme.dir .. "/icons/net.png"
theme.widget_hdd                                = theme.dir .. "/icons/hdd.png"
theme.widget_music                              = theme.dir .. "/icons/note.png"
theme.widget_music_on                           = theme.dir .. "/icons/note_on.png"
theme.widget_vol                                = theme.dir .. "/icons/vol.png"
theme.widget_vol_low                            = theme.dir .. "/icons/vol_low.png"
theme.widget_vol_no                             = theme.dir .. "/icons/vol_no.png"
theme.widget_vol_mute                           = theme.dir .. "/icons/vol_mute.png"
theme.widget_mail                               = theme.dir .. "/icons/mail.png"
theme.widget_mail_on                            = theme.dir .. "/icons/mail_on.png"
theme.tasklist_plain_task_name                  = true
theme.tasklist_disable_icon                     = true
theme.useless_gap                               = dpi(0)
theme.titlebar_close_button_focus               = theme.dir .. "/icons/titlebar/close_focus.png"
theme.titlebar_close_button_normal              = theme.dir .. "/icons/titlebar/close_normal.png"
theme.titlebar_ontop_button_focus_active        = theme.dir .. "/icons/titlebar/ontop_focus_active.png"
theme.titlebar_ontop_button_normal_active       = theme.dir .. "/icons/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_inactive      = theme.dir .. "/icons/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_inactive     = theme.dir .. "/icons/titlebar/ontop_normal_inactive.png"
theme.titlebar_sticky_button_focus_active       = theme.dir .. "/icons/titlebar/sticky_focus_active.png"
theme.titlebar_sticky_button_normal_active      = theme.dir .. "/icons/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_inactive     = theme.dir .. "/icons/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_inactive    = theme.dir .. "/icons/titlebar/sticky_normal_inactive.png"
theme.titlebar_floating_button_focus_active     = theme.dir .. "/icons/titlebar/floating_focus_active.png"
theme.titlebar_floating_button_normal_active    = theme.dir .. "/icons/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_inactive   = theme.dir .. "/icons/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_inactive  = theme.dir .. "/icons/titlebar/floating_normal_inactive.png"
theme.titlebar_maximized_button_focus_active    = theme.dir .. "/icons/titlebar/maximized_focus_active.png"
theme.titlebar_maximized_button_normal_active   = theme.dir .. "/icons/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_inactive  = theme.dir .. "/icons/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_inactive = theme.dir .. "/icons/titlebar/maximized_normal_inactive.png"

theme.hotkeys_modifiers_fg = xrdb.color8

local markup = lain.util.markup
local separators = lain.util.separators

local keyboardlayout = awful.widget.keyboardlayout:new()

-- Textclock
local clockicon = wibox.widget.imagebox(theme.widget_clock)
local clock = awful.widget.watch(
    "date +'%a %d %b %R'", 60,
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
            if bat_now.ac_status == 1 then
                baticon:set_image(theme.widget_ac)
            elseif not bat_now.perc and tonumber(bat_now.perc) <= 5 then
                baticon:set_image(theme.widget_battery_empty)
            elseif not bat_now.perc and tonumber(bat_now.perc) <= 15 then
                baticon:set_image(theme.widget_battery_low)
            else
                baticon:set_image(theme.widget_battery)
            end
            widget:set_markup(markup.font(theme.font, " " .. bat_now.perc .. "% "))
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
        if volume_now.muted == "yes" then
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
    end
})

-- Separators
local spr     = wibox.widget.textbox(' ')
local arrl_dl = separators.arrow_left(theme.bg_focus, "alpha")
local arrl_ld = separators.arrow_left("alpha", theme.bg_focus)

-- Helper for adding widgets to a taskbar
function add_widgets(widgets, layout)
    local setup = {
        layout = layout
    }
    local odd = true
    for i, widget_group in pairs(widgets) do
        if odd then
            table.insert(setup, arrl_ld)
        else
            table.insert(setup, arrl_dl)
        end
        for j, w in pairs(widget_group) do
            if odd then
                table.insert(setup,
                    wibox.container.background(w, theme.bg_focus)
                )
            else
                table.insert(setup, w)
            end
        end
        odd = not odd
    end
    return setup
end


-- Primary screen widgets
local primary_widgets = {
    { spr, volicon, theme.volume.widget },
            --wibox.container.background(mailicon, theme.bg_focus),
            --wibox.container.background(theme.mail.widget, theme.bg_focus),
    { memicon, mem.widget },
    { cpuicon, cpu.widget },
            --wibox.container.background(tempicon, theme.bg_focus),
            --wibox.container.background(temp.widget, theme.bg_focus),
    { fsicon, theme.fs.widget },
    { baticon, bat.widget },
    { neticon, net.widget },
    { clockicon, clock, spr },
}

-- Secondary screen widgets
local secondary_widgets = {}

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

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, awful.util.tasklist_buttons)

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s, height = dpi(20), bg = theme.bg_systray, fg = theme.fg_normal })

    -- Notification bar
    s.notif_wb = awful.wibar({ position = "bottom", screen = s, height = dpi(48), bg = theme.bg_systray, fg = theme.fg_normal, visible = false })

    if s == primary_screen then
    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            --spr,
            s.mytaglist,
            s.mypromptbox,
            spr,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            wibox.widget.systray(),
            keyboardlayout,
            spr,
            add_widgets(primary_widgets, wibox.layout.fixed.horizontal),
            wibox.container.background(s.mylayoutbox, theme.bg_focus),
        },
    }
    -- Notification bar setup
    --[[
    s.notif_wb:setup {
        nil,
        {
            base_layout = wibox.widget {
                spacing_widget = wibox.widget {
                    orientation = 'vertical',
                    span_ratio  = 0.5,
                    widget      = wibox.widget.separator,
                },
                forced_height = 30,
                spacing       = 3,
                layout        = wibox.layout.flex.horizontal
            },
            widget_template = {
                {
                    naughty.widget.icon,
                    {
                        naughty.widget.title,
                        naughty.widget.message,
                        {
                            layout = wibox.widget {
                                -- Adding the wibox.widget allows to share a
                                -- single instance for all spacers.
                                spacing_widget = wibox.widget {
                                    orientation = 'vertical',
                                    span_ratio  = 0.9,
                                    widget      = wibox.widget.separator,
                                },
                                spacing = 3,
                                layout  = wibox.layout.flex.horizontal
                            },
                            widget = naughty.list.widgets,
                        },
                        layout = wibox.layout.align.vertical
                    },
                    spacing = 10,
                    fill_space = true,
                    layout  = wibox.layout.fixed.horizontal
                },
                margins = 5,
                widget  = wibox.container.margin
            },
            widget = naughty.list.notifications,
        },
        -- Add a button to dismiss all notifications, because why not.
        {
            {
                text   = 'Dismiss all',
                align  = 'center',
                valign = 'center',
                widget = wibox.widget.textbox
            },
            buttons = gears.table.join(
                awful.button({ }, 1, function() naughty.destroy_all_notifications() end)
            ),
            forced_width       = 75,
            shape              = gears.shape.rounded_bar,
            shape_border_width = 1,
            shape_border_color = beautiful.bg_highlight,
            widget = wibox.container.background
        },
        layout = wibox.layout.align.horizontal
    }
    -- We don't want to have that bar all the time, only when there is content.
    naughty.connect_signal('property::active', function()
        s.notif_wb.visible = #naughty.active > 0
    --    notif_wb.visible = true
    end)
    --]]
    else -- Screens other than primary
    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            --spr,
            s.mytaglist,
            s.mypromptbox,
            spr,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            spr,
            --arrl_ld,
            --wibox.container.background(music_icon, theme.bg_focus),
            --wibox.container.background(theme.mpris, theme.bg_focus),
            --arrl_dl,
            clockicon,
            clock,
            spr,
            arrl_ld,
            wibox.container.background(s.mylayoutbox, theme.bg_focus),
        },
    }
    end
end

return theme
