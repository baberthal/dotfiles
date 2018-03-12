"""
C++ Snippet Helpers
"""

import os
import vim
import re

from skeleton_snippets import GetProjectName, GetProjectNamespace

__all__ = [
    "GetProjectName", "GetProjectNamespace", "MakeSectionLine",
    "RelativeFilePath", "MakeHeaderGuardIdentifier", "MakeFileHeader"
]


def MakeSectionLine(twidth, tail=None):
    start = '//===---'
    end = tail if tail else '---===//'
    ndashes = twidth - len(start) - len(end)
    mid = ndashes * '-'
    return start, mid, end


def _GetFTMode():
    ft = vim.eval("&filetype")  # type: str

    if not ft:
        return None

    MODE_MAP = {'cpp': 'C++', 'c': 'C'}

    mode = MODE_MAP[ft.lower()] if ft.lower() in MODE_MAP else ft.lower()

    return mode if mode else ft.lower()


def RelativeFilePath(filename):
    parts = filename.split(os.path.sep)
    result = None
    if 'include' in parts:
        idx = parts.index('include')
        result = os.path.sep.join(parts[idx + 1:])
    elif 'lib' in parts:
        idx = parts.index('lib')
        result = os.path.sep.join(parts[idx + 1:])
    else:
        result = os.path.split(filename)[-1]

    return result


def MakeHeaderGuardIdentifier(filename):
    filename = os.path.splitext(filename)[0]
    relpath = RelativeFilePath(filename)
    return _to_c_ident(relpath).upper()


def _GetFileHeaderParts(fullpath):
    mode = _GetFTMode() or 'C++'
    filepath = RelativeFilePath(fullpath)
    leader = '//===- {0} - '.format(_RemoveTopLevelInclude(filepath))
    trailer = '-*- {0} -*-===//'.format(mode)

    return [leader, trailer]


def MakeFileHeader(path, twidth, bwidth=None):
    b, e = _GetFileHeaderParts(path)
    bwidth_inner = bwidth - 1 - max(len(b), len(e)) if bwidth else twidth + 2
    ndashes = (bwidth_inner - twidth) - len(e)
    eline = ' ' + ndashes * '-' + e
    return b, eline


def _RemoveTopLevelInclude(filename):
    parts = filename.split('/')
    if len(parts) == 1:
        return filename
    return '/'.join(parts[1:])


VALID_IDENT_REGEXP = re.compile('[^A-Z0-9_]', re.IGNORECASE)


def _to_c_ident(name):
    """Convert `name` to a valid C-style identifer

    :type name: str
    :rtype: str

    """
    return VALID_IDENT_REGEXP.sub('_', name)
