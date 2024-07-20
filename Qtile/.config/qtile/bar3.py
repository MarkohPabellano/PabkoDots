from libqtile.bar import Bar

# Widgets Important
from libqtile.widget.currentlayout import CurrentLayoutIcon
from libqtile.widget.groupbox import GroupBox
from libqtile.widget.tasklist import TaskList
from libqtile.widget.textbox import TextBox
from libqtile.widget.systray import Systray
from libqtile.widget.clock import Clock
#from libqtile.widget.quick_exit import QuickExit
from libqtile.widget.battery import Battery

from colors import solarized
from libqtile import qtile

#Define programs for mouse callbacks opening
def spawn_rofi():
    qtile.cmd_spawn("rofi -show drun")

def spawn_powermenu():
    qtile.cmd_spawn("/home/marks/.config/rofi/powermenu/type-1/powermenu.sh")

def spawn_missioncenter():
    qtile.cmd_spawn("missioncenter")
bar = Bar([
           CurrentLayoutIcon(
            scale = 0.7,
            background=solarized['black2'],
        ),
        GroupBox(
        disable_drag=True,
        active=solarized['red'],
        inactive=solarized['gray2'],
        highlight_method='line',
        block_highlight_text_color=solarized['black2'],
        borderwidth=4,
        border = solarized['black2'],
        highlight_color=solarized['white1'],
        background= solarized['black1'],
        this_current_screen_border = solarized['cyan'], 
        #this_screen_border = solarized['gray4'],
        padding = 3,
        #margin_y = 5,
        #margin_x = 5,
        #padding_y = 5,
        #padding_x = 7,
        #decorations = [
        #    RectDecoration (
        #        colour = gruvbox['fg'],
        #        padding_y = 5,
        #        radius = 2,
        #        filled = True
        #    ),
        #],
        ),
        TaskList(
            foreground=solarized['white1'],
            icon_size = 1,
            #font = "JetBrainsMono Nerd Font",
            background = solarized['black2'],
            borderwidth = 2,
            border = solarized['cyan'],
            margin = 3,
            padding = 1,
            highlight_method = "border",
            title_width_method = "uniform",
            urgent_alert_method = "border",
            urgent_border = solarized['cyan'],
            rounded = False,
            #txt_floating = "",
            #txt_maximized = "🗖 ",
            #txt_minimized = "",
            ),
        Clock(
            format = '󰸘 %Y-%m-%d %a %r',
            background = solarized['black2'], 
        ),
        Battery(
            format = '{char} {percent:2.0%}',
        ),
        Systray(
            background=solarized['black2'],
            padding = 5,
        ),
        ],
            margin=[0, 0, 0, 0],
            background= solarized['black1'], 
            #gruvbox['bg0'],
            #'#00000000',
            opacity=1,
            size=24,
            # border_width=[2, 0, 2, 0],  # Draw top and bottom borders
            # border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta
        )
        # You can uncomment this variable if you see that on X11 floating resize/moving is laggy
        # By default we handle these events delayed to already improve performance, however your system might still be struggling
        # This variable is set to None (no cap) by default, but you can set it to 60 to indicate that you limit it to 60 events per second
        # x11_drag_polling_rate = 60,