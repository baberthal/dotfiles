# -*- coding: utf-8 -*-
"""
    vim.file_header
    ~~~~~~~~~~~~~~~

    File Header Generator

    :copyright: (c) 2018 by J. Morgan Lieberthal.
    :license: MIT, see LICENSE for more details.
"""

from .vimsupport import (CurrentFiletypes, GetIntValue,
                         GetCurrentBufferFilepath)

from .path_utils import RelativeFilePath, ShortPath
from .util import rpad_if, lpad_if

# DEFAULT_FORMAT = '//===- %(fn)s - %(desc)s %(dashes)s -*- %(ft)s -*-===//'


class FileHeader(object):
    """Represents a file header"""
    MODE_MAP = {'cpp': 'C++', 'c': 'C'}
    COMMENT_MAP = {
      'cpp': {
        'start': '//',
        'end': '//',
      },
      'c': {
        'start': '/*',
        'end': '*\\'
      }
    }
    DEFAULT_PREFIX = '%(comment_start)s===- %(filename)s -'
    DEFAULT_SUFFIX = '-*- %(mode)s -*-===%(comment_end)s'
    DEFAULT_FORMAT = '%(prefix)s %(desc)s %(dashes)s%(suffix)s'

    def __init__(self, snip=None, filename=None, prefix=None, suffix=None, bar_format=None, short=False, comment_style='cpp'):
        """
        :type snip: UltiSnips.TextObjects.SnippetUtil
        """
        super(FileHeader, self).__init__()
        self.snip = snip
        self._width = GetIntValue('&textwidth') or 80
        self._filename = filename
        self._comment_style = self._validate_comment_style(comment_style)

        self.prefix_format = prefix or self.DEFAULT_PREFIX
        self.suffix_format = suffix or self.DEFAULT_SUFFIX

        self.short = short

    def render(self, t, width=None, pad=True):
        prefix = self.prefix_format % {'comment_start': self.comment_start, 'filename': self.filename}
        suffix = self.suffix_format % {'mode': self.mode, 'comment_end': self.comment_end}
        if width:
            bar_width = width - len(prefix) - len(suffix)
            bar_width = bar_width - 2 if pad else bar_width
        else:
            bar_width = len(t[1]) + 2

        n = (bar_width - len(t[1])) if pad else bar_width
        return (rpad_if(pad, prefix), lpad_if(pad, ('-' * n) + suffix))

    @property
    def width(self):
        """:returns: int"""
        if self.snip and not self.snip.c:
            return self._width

    @property
    def filename(self):
        """
        :returns: str

        """
        if self._filename is None:
            if self.short:
                return ShortPath(GetCurrentBufferFilepath())
            return RelativeFilePath(GetCurrentBufferFilepath())
        return self._filename

    @property
    def mode(self):
        """Return the pretty name of the current filetype
        :returns: str
        """
        ft = CurrentFiletypes()[0].lower()
        if ft in self.MODE_MAP:
            return ' {0} '.format(self.MODE_MAP[ft])
        else:
            return '-'


    def _validate_comment_style(self, comment_style):
        """TODO: Docstring for _validate_comment_style.

        :type comment_style: TODO
        :returns: TODO

        """
        if comment_style == 'c' or comment_style == 'cpp' or comment_style == 'c++':
            return comment_style
        raise "Invalid comment style"


    @property
    def comment_format(self):
        ft = CurrentFiletypes()[0].lower()
        if ft not in self.COMMENT_MAP:
            ft = self._comment_style
        return self.COMMENT_MAP[ft]


    @property
    def comment_start(self):
        return self.comment_format['start']


    @property
    def comment_end(self):
        return self.comment_format['end']


