# Autogenerated config.py
# Documentation:
#   qute://help/configuring.html
#   qute://help/settings.html

# Uncomment this to still load settings configured via autoconfig.yml
# config.load_autoconfig()

# Aliases for commands. The keys of the given dictionary are the
# aliases, while the values are the commands they map to.
# Type: Dict
c.aliases = {'w': 'session-save', 'q': 'close', 'qa': 'quit', 'wq': 'quit --save', 'wqa': 'quit --save', 'mpv': 'spawn --userscript ~/.files/qute-userscripts/view_in_mpv'}

# Always restore open sites when qutebrowser is reopened.
# Type: Bool
c.auto_save.session = True

# User agent to send. Unset to send the default. Note that the value
# read from JavaScript is always the global value.
# Type: String
config.set('content.headers.user_agent', 'Mozilla/5.0 (X11; Linux x86_64; rv:70.0) Gecko/20100101 Firefox/70.0', 'https://accounts.google.com/*')

# Allow JavaScript to read from or write to the clipboard. With
# QtWebEngine, writing the clipboard as response to a user interaction
# is always allowed.
# Type: Bool
c.content.javascript.can_access_clipboard = True

# Enable JavaScript.
# Type: Bool
config.set('content.javascript.enabled', True, 'file://*')

# Enable JavaScript.
# Type: Bool
config.set('content.javascript.enabled', True, 'chrome://*/*')

# Enable JavaScript.
# Type: Bool
config.set('content.javascript.enabled', True, 'qute://*/*')

# Editor (and arguments) to use for the `open-editor` command. The
# following placeholders are defined: * `{file}`: Filename of the file
# to be edited. * `{line}`: Line in which the caret is found in the
# text. * `{column}`: Column in which the caret is found in the text. *
# `{line0}`: Same as `{line}`, but starting from index 0. * `{column0}`:
# Same as `{column}`, but starting from index 0.
# Type: ShellCommand
c.editor.command = ['st', '-e', '/usr/bin/vim', '{}']

# Automatically enter insert mode if an editable element is focused
# after loading the page.
# Type: Bool
c.input.insert_mode.auto_load = True

# Padding (in pixels) around text for tabs.
# Type: Padding
c.tabs.padding = {'bottom': 2, 'right': 5, 'top': 2, 'left': 5}

# Position of the tab bar.
# Type: Position
# Valid values:
#   - top
#   - bottom
#   - left
#   - right
c.tabs.position = 'bottom'

# Background color of selected odd tabs.
# Type: QtColor
c.colors.tabs.selected.odd.bg = 'darkorange'

# Background color of selected even tabs.
# Type: QtColor
c.colors.tabs.selected.even.bg = 'darkorange'

# Default monospace fonts. Whenever "monospace" is used in a font
# setting, it's replaced with the fonts listed here.
# Type: Font
c.fonts.default_family = 'Inconsolata'

# Bindings for normal mode
config.bind('<Ctrl+\\>', 'tab-focus last')
config.bind('<Ctrl+r>', 'reload')
config.bind('gD', 'spawn --userscript ~/.files/qute-userscripts/getbib')
config.bind('gT', 'set-cmd-text -s :open -t !dcc')

# Bindings for insert mode
config.bind('<Ctrl+k>', 'spawn --userscript ~/.files/qute-userscripts/qute-keepass -p ~/.database.kdbx', mode='insert')
config.bind('<Ctrl+p>', "spawn --userscript ~/.files/qute-userscripts/qute-pass -d 'dmenu -l 5 -b' -u '(.+)@.*'", mode='insert')
