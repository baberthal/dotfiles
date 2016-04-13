from __future__ import unicode_literals
from pygments.token import Token, Keyword, Name, Comment, String, Error, \
        Number, Operator, Generic
from pygments.style import Style

from ptpython.prompt_style import PromptStyle

# Custom Prompt
class JMLPrompt(PromptStyle):
    def __init__(self, python_input):
        self.python_input = python_input

    def in_tokens(self, cli):
        return [
            (Token.Prompt.Name, '(main)'),
            (Token.Prompt.Default, '['),
            (Token.Prompt.Number, '%s' % self.python_input.current_statement_index),
            (Token.Prompt.Default, '] >>  '),
        ]

    def in2_tokens(self, cli, width):
        return [
            (Token.In, '... >>  '.rjust(width))
        ]

    def out_tokens(self, cli):
        return [
            (Token.Out, 'Result ['),
            (Token.Out.Number, '%s' % self.python_input.current_statement_index),
            (Token.Out, ']:  '),
        ]

class JMLCodeStyle(Style):
    default_style = ""
    styles = {
        Comment:          '#586e75',
        Keyword:          '#859900',
        Name:             '#268bd2',
        Name.Function:    '#268bd2',
        Name.Class:       '#cb4b16',
        String:           '#2aa198',
        Error:            '#cb4b16',
    }
