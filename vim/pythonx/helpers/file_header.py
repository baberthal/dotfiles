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

from .path_utils import RelativeFilePath
from .util import rpad_if, lpad_if

# DEFAULT_FORMAT = '//===- %(fn)s - %(desc)s %(dashes)s -*- %(ft)s -*-===//'


class FileHeader(object):
    """Represents a file header"""
    MODE_MAP = {'cpp': 'C++', 'c': 'C'}
    DEFAULT_PREFIX = '//===- %(filename)s -'
    DEFAULT_SUFFIX = '-*- %(mode)s -*-===//'
    DEFAULT_FORMAT = '%(prefix)s %(desc)s %(dashes)s%(suffix)s'

    def __init__(self, snip=None, filename=None, prefix=None, suffix=None, bar_format=None):
        """
        :type snip: UltiSnips.TextObjects.SnippetUtil
        """
        super(FileHeader, self).__init__()
        self.snip = snip
        self._width = GetIntValue('&textwidth') or 80
        self._filename = filename

        self.prefix_format = prefix or self.DEFAULT_PREFIX
        self.suffix_format = suffix or self.DEFAULT_SUFFIX

    def render(self, t, width=None, pad=True):
        prefix = self.prefix_format % {'filename': self.filename}
        suffix = self.suffix_format % {'mode': self.mode}
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
