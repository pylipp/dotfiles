# Autogenerated config.py
# Documentation:
#   qute://help/configuring.html
#   qute://help/settings.html

# Uncomment this to still load settings configured via autoconfig.yml
# config.load_autoconfig()

# Always restore open sites when qutebrowser is reopened.
# Type: Bool
c.auto_save.session = True

# Background color of selected even tabs.
# Type: QtColor
c.colors.tabs.selected.even.bg = 'darkorange'

# Background color of selected odd tabs.
# Type: QtColor
c.colors.tabs.selected.odd.bg = 'darkorange'

# The editor (and arguments) to use for the `open-editor` command. `{}`
# gets replaced by the filename of the file to be edited.
# Type: ShellCommand
c.editor.command = ['st', '-e', '/usr/bin/vim', '{}']

# Default monospace fonts. Whenever "monospace" is used in a font
# setting, it's replaced with the fonts listed here.
# Type: Font
c.fonts.monospace = 'Inconsolata'

# Automatically enter insert mode if an editable element is focused
# after loading the page.
# Type: Bool
c.input.insert_mode.auto_load = True

# Enable 'copy-to-clipboard' button functionality
c.content.javascript.can_access_clipboard = True

# Padding around text for tabs
# Type: Padding
c.tabs.padding = {'top': 2, 'bottom': 2, 'right': 5, 'left': 5}

# The position of the tab bar.
# Type: Position
# Valid values:
#   - top
#   - bottom
#   - left
#   - right
c.tabs.position = 'bottom'

# Bindings for normal mode
config.bind('<ctrl+\\>', 'tab-focus last')
config.bind('<ctrl+r>', 'reload')
config.bind('gT', 'set-cmd-text -s :open -t !dcc')
config.bind('gD', 'spawn --userscript ~/.files/local/share/qutebrowser/userscripts/getbib')
