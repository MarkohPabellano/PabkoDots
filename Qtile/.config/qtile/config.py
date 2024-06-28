import os
import subprocess
from typing import Callable, List  # noqa: F401

from libqtile import hook

#from libqtile.extension.dmenu import DmenuRun
from libqtile.extension.window_list import WindowList
from libqtile.extension.command_set import CommandSet

# import layout objects
# from libqtile.layout.columns import Columns
from libqtile.layout.xmonad import MonadTall, MonadWide
from libqtile.layout.stack import Stack
from libqtile.layout.floating import Floating

# import widgets and bar

from libqtile.config import Click, Drag, DropDown, Group, Key, Match, ScratchPad, Screen
from libqtile.lazy import lazy
# from libqtile.utils import guess_terminal

from colors import solarized

from bar3 import bar

mod = "mod4"
alt = "mod1"
terminal = "kitty"

keys = [
    # Switch between windows
    # Key([mod], "j", lazy.layout.left(), desc="Move focus to left"),
    # Key([mod], "k", lazy.layout.right(), desc="Move focus to right"),
    # Key([mod],"space", lazy.layout.next(), desc="Move window focus to other window"),
    # Key([mod], "j", lazy.layout.down(), desc='Move focus down in current stack pane' ),
    # Key([mod], "k", lazy.layout.up(), desc='Move focus up in current stack pane' ),
    Key([mod], "j", lazy.group.next_window(), desc='Move focus next in current stack pane' ),
    Key([mod], "k", lazy.group.prev_window(), desc='Move focus prev in current stack pane' ),
    # Switch to windows within the current group
    # Key([alt, "shift"], "1", lazy.group[1].toscreen(toggle=False), desc="Switch to window 1"),
    # Key([alt, "shift"], "2", lazy.group[2].toscreen(toggle=False), desc="Switch to window 2"),

    # Applications
    Key([mod], "r", lazy.spawn("rofi -show combi -combi-modi drun,run -modi combi -show-icons"), desc="spawn rofi"),
    Key([mod], "period", lazy.spawn("rofi -modi emoji -show emoji"), desc="spawn rofi"),
    Key([alt], "s", lazy.spawn("flameshot gui"), desc="Open flameshot gui"),
    Key([alt], "period", lazy.spawn("/home/marks/.config/rofi/powermenu/type-1/powermenu.sh"), desc="powermenu"),
    Key(["control", "shift"], "e", lazy.spawn("emacsclient -c -a emacs"), desc='Doom Emacs'),


    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.

    # Window controls
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), lazy.layout.section_down(), desc='Move windows down in current stack' ),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), lazy.layout.section_up(), desc='Move windows up in current stack' ),
    Key([mod], "h", lazy.layout.shrink(),lazy.layout.decrease_nmaster(), desc='Shrink window (MonadTall), decrease number in master pane (Tile)' ),
    Key([mod], "l", lazy.layout.grow(), lazy.layout.increase_nmaster(), desc='Expand window (MonadTall), increase number in master pane (Tile)' ),
    Key([mod], "n", lazy.layout.normalize(), desc='normalize window size ratios' ), 
    Key([mod], "m", lazy.layout.maximize(), desc='toggle window between minimum and maximum sizes'),
    Key([mod], "z", lazy.window.toggle_minimize(), desc='Minimize focused window'),
    Key([mod, "shift"], "f", lazy.window.toggle_floating(),desc='toggle floating'),
    Key([mod], "f", lazy.window.toggle_fullscreen(), desc='toggle fullscreen' ),
    Key([mod], "b", lazy.hide_show_bar(), desc="Hides the bar"),

    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key([mod, "shift"], "Return", lazy.layout.toggle_split(), desc="Toggle between split and unsplit sides of stack"),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
  

    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "shift", "control"], "h", lazy.layout.swap_column_left()),
    Key([mod, "shift", "control"], "l", lazy.layout.swap_column_right()),
    Key([mod, "shift"], "space", lazy.layout.flip()),
    Key([mod, "control"], "r", lazy.restart(), desc="Restart Qtile"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    #Key([mod, "shift"], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),

    #Volume control using PipeWire
    Key([], "XF86AudioLowerVolume", lazy.spawn("pamixer --decrease 5")),
    Key([], "XF86AudioRaiseVolume", lazy.spawn("pamixer --increase 5")),
    Key([], "XF86AudioMute", lazy.spawn("pamixer --toggle-mute")),

    # Brightness control using brillo
    Key([], "XF86MonBrightnessUp", lazy.spawn("brillo -q -A 10")),
    Key([], "XF86MonBrightnessDown", lazy.spawn("brillo -q -U 10")),

    # Microphone mute/unmute using PipeWire (commands might vary)
    Key([], "XF86AudioMicMute", lazy.spawn("pactl set-source-mute @DEFAULT_SOURCE@ toggle")),
]


groups = [
    Group('1', label="", 
          matches=[
            Match(wm_class='firefox'), 
            Match(wm_class='brave'), 
            Match(wm_class='qutebrowser')], 
          layout="monadtall"),
    Group('2', label="", layout="monadtall"),
    Group('3', label="", layout="monadtall"),
    Group('4', label="", 
          matches=[
            Match(wm_class='discord'), 
            Match(wm_class='zoom'), 
            Match(wm_class="teams-for-linux")], 
          layout="monadtall"),
    Group('5', label="", 
          matches=[
            Match(wm_class="Spotify")], 
          layout="monadtall"),
    Group('6', label="", layout="monadtall"),
    Group('7', label="", layout="monadtall"),
    Group('8', label="", layout="monadtall"),
    Group('9', label="󰊼", layout="monadtall"),
    Group('0', label="", layout="monadtall"),
]



for i in groups:
    keys.extend([
        # mod1 + letter of group = switch to group
        Key([mod], i.name, lazy.group[i.name].toscreen(),
            desc="Switch to group {}".format(i.name)),

        # Key([mod], i.name, lazy.function(go_to_group(i.name))),

        # Or, use below if you prefer not to switch to that group.
        # mod1 + shift + letter of group = move focused window to group
        Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
            desc="move focused window to group {}".format(i.name)),
    ])

# Append scratchpad with dropdowns to groups
groups.append(ScratchPad('scratchpad', [
    DropDown('term', 'kitty', width=0.4, height=0.5, x=0.3, y=0.1, opacity=1),
    DropDown('mixer', 'pavucontrol', width=0.4,
             height=0.6, x=0.3, y=0.1, opacity=1),
    DropDown('pomo', 'pomotroid', x=0.4, y=0.2, opacity=1),
    DropDown('bitwarden', 'bitwarden-desktop',
             width=0.4, height=0.6, x=0.3, y=0.1, opacity=1),
]))
# extend keys list with keybinding for scratchpad
keys.extend([
    Key(["control"], "1", lazy.group['scratchpad'].dropdown_toggle('term')),
    Key(["control"], "2", lazy.group['scratchpad'].dropdown_toggle('mixer')),
    Key(["control"], "3", lazy.group['scratchpad'].dropdown_toggle('pomo')),
    Key(["control"], "4", lazy.group['scratchpad'].dropdown_toggle('bitwarden')),
])

layouts = [
    Stack(
        border_normal=solarized['yellow'],
        border_focus=solarized['red'],
        border_width=4,
        num_stacks=1,
        margin=0,
    ),
    MonadTall(
        border_normal=solarized['violet'],
        border_focus=solarized['magenta'],
        margin=0,
        border_width=4,
        #single_border_width=1,
        #single_margin=0,
    ),
    #Columns(
    #    border_normal=gruvbox['dark-gray'],
    #    border_focus=gruvbox['cyan'],
    #    border_width=3,
    #    border_normal_stack=gruvbox['dark-gray'],
    #    border_focus_stack=gruvbox['dark-green'],
    #    border_on_single=2,
    #    margin=8,
    #    margin_on_single=8,
    #)
]

floating_layout = Floating(
    border_normal=solarized['black2'],
    border_focus=solarized['green'],
    border_width=2,
    float_rules=[
        *Floating.default_float_rules,
        Match(wm_class='confirmreset'),  # gitk
        Match(wm_class='makebranch'),  # gitk
        Match(wm_class='maketag'),  # gitk
        Match(wm_class='ssh-askpass'),  # ssh-askpass
        Match(title='branchdialog'),  # gitk
        Match(title='pinentry'),  # GPG key password entry
        Match(wm_class="missioncenter"),
        Match(title="Android Emulator - pixel5:5554"),
        Match(wm_class="Genymotion Player"),
        Match(title="AICOMS"),
        Match(wm_class="blueman-manager"),
        Match(wm_class="pavucontrol"),
        Match(wm_class="zoom "),
        Match(wm_class="bitwarden"),
        Match(wm_class="nemo"),
        Match(wm_class="xarchiver"),
    ])

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]
widget_defaults = dict(
    font='Caskaydia Cove Nerd Font',
    fontsize=13,
    padding=10,
    foreground=solarized['white1'],
)

extension_defaults = widget_defaults.copy()

screens = [Screen(bottom=bar)]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
follow_mouse_focus = True
bring_front_click = True
cursor_warp = False
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True
auto_minimize = True
wmname = "Qtile"


@ hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser('~/.config/qtile/autostart.sh')
    subprocess.run([home])
