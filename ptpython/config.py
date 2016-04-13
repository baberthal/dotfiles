"""
Configuration example for ``ptpython``.
Copy this file to ~/.ptpython/config.py
"""
from __future__ import unicode_literals
from prompt_toolkit.keys import Keys
from pygments.token import Token
from ptpython.layout import CompletionVisualisation
from ptpython.style import default_ui_style
from ptpython.prompt_style import PromptStyle
from jml_styles.jml_code_style import JMLCodeStyle
from jml_styles.jml_prompt import JMLPrompt, jml_ui_style

__all__ = (
    'configure',
)


def configure(repl):
    """
    Configuration method. This is called during the start-up of ptpython.
    :param repl: `PythonRepl` instance.
    """

    repl.all_prompt_styles['jml'] = JMLPrompt(repl)

    # Show function signature (bool).
    repl.show_signature = True

    # Show docstring (bool).
    repl.show_docstring = False

    # Show the "[Meta+Enter] Execute" message when pressing [Enter] only
    # inserts a newline instead of executing the code.
    repl.show_meta_enter_message = True

    # Show completions. (NONE, POP_UP, MULTI_COLUMN or TOOLBAR)
    repl.completion_visualisation = CompletionVisualisation.POP_UP

    # When CompletionVisualisation.POP_UP has been chosen, use this
    # scroll_offset in the completion menu.
    repl.completion_menu_scroll_offset = 0

    # Show line numbers (when the input contains multiple lines.)
    repl.show_line_numbers = False

    # Show status bar.
    repl.show_status_bar = True

    # When the sidebar is visible, also show the help text.
    repl.show_sidebar_help = True

    # Highlight matching parethesis.
    repl.highlight_matching_parenthesis = False

    # Line wrapping. (Instead of horizontal scrolling.)
    repl.wrap_lines = True

    # Mouse support.
    repl.enable_mouse_support = True

    # Complete while typing. (Don't require tab before the
    # completion menu is shown.)
    repl.complete_while_typing = True

    # Vi mode.
    repl.vi_mode = True

    # Paste mode. (When True, don't insert whitespace after new line.)
    repl.paste_mode = False

    # Use the classic prompt. (Display '>>>' instead of 'In [1]'.)
    repl.prompt_style = 'jml'  # 'classic' or 'ipython'

    # History Search.
    # When True, going back in history will filter the history on the records
    # starting with the current input. (Like readline.)
    # Note: When enable, please disable the `complete_while_typing` option.
    #       otherwise, when there is a completion available, the arrows will
    #       browse through the available completions instead of the history.
    repl.enable_history_search = False

    # Enable auto suggestions. (Pressing right arrow will complete the input,
    # based on the history.)
    repl.enable_auto_suggest = False

    # Enable open-in-editor. Pressing C-X C-E in emacs mode or 'v' in
    # Vi navigation mode will open the input in the current editor.
    repl.enable_open_in_editor = True

    # Enable system prompt. Pressing meta-! will display the system prompt.
    # Also enables Control-Z suspend.
    repl.enable_system_bindings = True

    # Ask for confirmation on exit.
    repl.confirm_exit = False

    # Enable input validation. (Don't try to execute when the input contains
    # syntax errors.)
    repl.enable_input_validation = True

    # Use this colorscheme for the code.
    repl.use_code_colorscheme('jml_code')

    # Enable 24bit True color. (Not all terminals support this. -- maybe check
    # $TERM before changing.)
    repl.true_color = False

    # Install custom colorscheme named 'my-colorscheme' and use it.
    repl.install_ui_colorscheme('jml-ui-colorscheme', jml_ui_style)
    repl.use_ui_colorscheme('jml-ui-colorscheme')

    # Add custom key binding for PDB.
    @repl.add_key_binding(Keys.ControlB)
    def _(event):
        ' Pressing Control-B will insert "pdb.set_trace()" '
        event.cli.current_buffer.insert_text('\nimport pdb; pdb.set_trace()\n')

    # Typing ControlE twice should also execute the current command.
    # (Alternative for Meta-Enter.)
    @repl.add_key_binding(Keys.ControlE, Keys.ControlE)
    def _(event):
        b = event.current_buffer
        if b.accept_action.is_returnable:
            b.accept_action.validate_and_handle(event.cli, b)

    """
    # Custom key binding for some simple autocorrection while typing.
    corrections = {
        'impotr': 'import',
        'pritn': 'print',
    }
    @repl.add_key_binding(' ')
    def _(event):
        ' When a space is pressed. Check & correct word before cursor. '
        b = event.cli.current_buffer
        w = b.document.get_word_before_cursor()
        if w is not None:
            if w in corrections:
                b.delete_before_cursor(count=len(w))
                b.insert_text(corrections[w])
        b.insert_text(' ')
    """


# Custom colorscheme for the UI. See `ptpython/layout.py` and
# `ptpython/style.py` for all possible tokens.
_solarized_ui_style = {}
_solarized_ui_style.update(default_ui_style)
_solarized_ui_style.update({
    Token.Prompt.Default:                   '#93a1a1 nobold',
    Token.Prompt.Number:                    '#6c71c4',
    Token.Prompt.Name:                      '#b58900 nobold',

    Token.Toolbar.Status:                   'bg:#000000 #839496',
    Token.Toolbar.Status.InputMode:         'bg:#000000 #2aa198',
    Token.Toolbar.Status.Key:               'bg:#000000 #cb4b16 bold',
    Token.Toolbar.Status.PythonVersion:     'bg:#000000 #6c71c4',

    Token.Out:                              '#839496',
    Token.Out.Number:                       '#2aa198',

    Token.Toolbar.Search: '#22aaaa noinherit',
    Token.Toolbar.Search.Text: 'noinherit',

    Token.Toolbar.System: '#22aaaa noinherit',
    Token.Toolbar.Arg: '#22aaaa noinherit',
    Token.Toolbar.Arg.Text: 'noinherit',

    Token.Sidebar: 'bg:#586e75 #000000',
    Token.Sidebar.Title: 'bg:#2aa198 #ffffff',
    Token.Sidebar.Label: 'bg:#bbbbbb #222222',
    Token.Sidebar.Status: 'bg:#dddddd #000011',
})
