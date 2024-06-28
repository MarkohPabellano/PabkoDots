from libqtile.bar import Bar

# Widgets Important
from libqtile.widget.groupbox import GroupBox
from libqtile.widget.currentlayout import CurrentLayout
from libqtile.widget.window_count import WindowCount
from libqtile.widget.tasklist import TaskList
from libqtile.widget.cpu import CPU
from libqtile.widget.memory import Memory
from libqtile.widget.net import Net
from libqtile.widget.systray import Systray
from libqtile.widget.clock import Clock
from libqtile.widget.spacer import Spacer
from libqtile.widget.textbox import TextBox
from qtile_extras.widget import UPowerWidget
from qtile_extras.widget.decorations import RectDecoration
#from libqtile.widget.image import Image

from colors import gruvbox
from unicodes import left_half_circle, right_powerline_pua, left_powerline_pua
from libqtile import qtile
#from libqtile import lazy

#Define programs for mouse callbacks opening
def spawn_rofi():
    qtile.cmd_spawn("rofi -show drun")

def spawn_powermenu():
    qtile.cmd_spawn("/home/marks/.config/rofi/powermenu/type-1/powermenu.sh")

def spawn_missioncenter():
    qtile.cmd_spawn("missioncenter")

bar = Bar([
    #left_half_circle(gruvbox['yellow']),
     TextBox(
         text = '󰣇',
         fontsize = 20,
         foreground = gruvbox['fg'],
         mouse_callbacks = {'Button1': spawn_rofi, 'Button3': spawn_powermenu},
     ),

    left_powerline_pua(gruvbox['dark-blue']),
     Systray(
        padding=5,
        #foreground = gruvbox['bg'],
    ),
    #Spacer(length=10),
    left_powerline_pua(gruvbox['yellow']), 
    CurrentLayout(
        background=gruvbox['yellow'],

        ),

    #Spacer(length=10),

    left_powerline_pua(gruvbox['dark-blue']),
    #left_half_circle(gruvbox['dark-blue']),
    #WindowCount(
    #    text_format='缾 {num}',
    #    background=gruvbox['dark-blue'],
    #    show_zero=True
    #),

    #Spacer(length=10),
    #left_powerline_pua(gruvbox['cyan']),


    #left_half_circle(gruvbox['cyan']),
    Clock(
        background=gruvbox['cyan'],
        format='󰸘 %Y-%m-%d %a %r'),

    #right_powerline_pua(gruvbox['cyan']),

    #Spacer(length=10),

    # Prompt(foreground=gruvbox['fg']),
    left_powerline_pua(gruvbox['fg']),

    GroupBox(
        disable_drag=True,
        active=gruvbox['bg'],
        inactive=gruvbox['gray'],
        highlight_method='line',
        block_highlight_text_color=gruvbox['red'],
        borderwidth=0,
        highlight_color=gruvbox['fg'],
        background=gruvbox['fg'],
        #margin_y = 2,
        #margin_x = 3,
        #padding_y = 2,
        #padding_x = 3,
        #decorations = [
        #    RectDecoration (
        #        colour = gruvbox['fg'],
        #        padding_y = 5,
        #        radius = 2,
        #        filled = True
        #    ),
        #],
        ),

    #Spacer(length=10),

    left_powerline_pua(gruvbox['fg']),

    #left_half_circle(gruvbox['bg']),
     TaskList(
        foreground=gruvbox['fg'],
        icon_size = 1,
        #font = "JetBrainsMono Nerd Font",
        #background
        borderwidth = 2,
        border =gruvbox['blue'],
        margin = 5,
        padding = 1,
        highlight_method = "border",
        title_width_method = "uniform",
        urgent_alert_method = "border",
        urgent_border = '#ffffff',
        rounded = False,
        #txt_floating = "",
        #txt_maximized = "🗖 ",
         #txt_minimized = "",
         ),
    right_powerline_pua(gruvbox['dark-cyan']),

    #Spacer(length=10),

    #left_half_circle(gruvbox['dark-cyan']),
    CPU(
        format=' {freq_current}GHz {load_percent}%',
        background=gruvbox['dark-cyan'],
        mouse_callbacks = {'Button1': spawn_missioncenter},
        #decorations = [btest
        #    RectDecoration (
        #        colour = gruvbox['fg'],
        #        padding_y = 50,
        #        radius = 2,
        #       filled = True
        #    ),
        #],
    ),

    right_powerline_pua(gruvbox['dark-cyan']),

    #Spacer(length=10),

    #left_half_circle(gruvbox['dark-magenta']),
    Memory(
        format='󰍛 {MemUsed: .0f}{mm}/{MemTotal: .0f}{mm}',
        background=gruvbox['dark-blue'],
        mouse_callbacks = {'Button1': spawn_missioncenter},
        ),

    right_powerline_pua(gruvbox['dark-blue']),

    #Spacer(length=10),

    #left_half_circle(gruvbox['dark-blue']),
    #Net(
    #    background=gruvbox['yellow']
    #),
    #Spacer(length=10),
    UPowerWidget(
        border_colour=gruvbox['green'],
        foreground=gruvbox['fg'],
        border_critical_colour=gruvbox['red']
    ),
    right_powerline_pua(gruvbox['yellow']),

    #Spacer(length=3),
    
],
    margin=[10, 10, 10, 10],
    background= '#00000000', 
    #gruvbox['bg0'],
    #'#00000000',
    opacity=1,
    size=30,
)
