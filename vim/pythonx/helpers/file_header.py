# -*- coding: utf-8 -*-
"""
    vim.file_header
    ~~~~~~~~~~~~~~~

    File Header Generator

    :copyright: (c) 2018 by J. Morgan Lieberthal.
    :license: MIT, see LICENSE for more details.
"""


class FileHeader(object):
    MODE_MAP = {
        'cpp': 'C++',
        'c': 'C',
    }

    def __init__(self):
        super(FileHeader, self).__init__()
