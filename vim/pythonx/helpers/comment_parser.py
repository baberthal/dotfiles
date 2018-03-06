# -*- coding: utf-8 -*-
"""
    skeleton_snippets.comment_parser
    ~~~~~~~~~~~~~~~~~~

    Comment Parser class

    :copyright: (c) 2018 by J. Morgan Lieberthal.
    :license: MIT, see LICENSE for more details.
"""

import string


class CommentParser(object):
    """Class for parsing comments from vim"""

    def __init__(self, input_str):
        """
        Create a CommentParser with a given input string

        :type input_str: str

        """
        super(CommentParser, self).__init__()
        self.input = input_str
        self._i = iter(input_str.split(','))
        self._result = []

    def parse(self):
        """TODO: Docstring for parse.
        :returns: TODO

        """
        try:
            while True:
                flags, text = self._GetFlags()
                if len(flags) == 0:
                    self._result.append(self._BuildOther(text))
                elif 's' in flags and 'O' not in flags:
                    self._result.append(self._BuildTriple(flags, text))
                elif 'b' in flags:
                    self._result.insert(0, self._BuildSingleChar(text))
        except StopIteration:
            return self._result

    #  Private Methods {{{ #

    def _GetFlags(self):
        """TODO: Docstring for _GetFlags.
        :rtype: tuple(str, str)

        """
        return next(self._i).split(':', 1)

    def _BuildTriple(self, flags, text):
        """TODO: Docstring for _BuildTriple.

        :type flags: TODO
        :type text: TODO
        :returns: TODO

        """
        ctriple = ['TRIPLE']
        indent = ''

        if flags[-1] in string.digits:
            indent = ' ' * int(flags[-1])
        ctriple.append(text)

        flags, text = self._GetFlags()
        assert flags[0] == 'm'
        ctriple.append(text)

        flags, text = self._GetFlags()
        assert flags[0] == 'e'
        ctriple.append(text)
        ctriple.append(indent)

        return ctriple

    def _BuildSingleChar(self, text):
        """TODO: Docstring for _BuildSingleChar.

        :type text: TODO
        :returns: TODO

        """
        if len(text) == 1:
            return ('SINGLE_CHAR', text, text, text, '')

    def _BuildOther(self, text):
        """TODO: Docstring for _BuildOther.

        :type text: TODO
        :returns: TODO

        """
        return ('OTHER', text, text, text, '')

    #  }}} Private Methods #
