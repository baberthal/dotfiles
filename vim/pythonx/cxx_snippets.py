"""
C++ Snippet Helpers
"""

import os
import vim

__all__ = [
    "InferProjectName",
    "MakeSectionLine",
    "RelativeFilePath",
    "MakeHeaderGuardIdentifier",
    "MakeFileHeader"
]


def InferProjectName():
    return vim.eval("fnamemodify(getcwd(), ':t')")


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

    mode = {
        'cpp': 'C++',
        'c': 'C'
    }[ft.lower()]

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
    parts = relpath.split(os.path.sep)  # type: List[str]
    ident = [p.upper() for p in parts]
    return '_'.join(ident)


def _GetFileHeaderParts(fullpath):
    mode = _GetFTMode() or 'C++'
    filepath = RelativeFilePath(fullpath)
    leader = '//===--- {0} - '.format(filepath)
    trailer = '-*- {0} -*-===//'.format(mode)

    return [leader, trailer]


def MakeFileHeader(path, twidth, bwidth=None):
    b, e = _GetFileHeaderParts(path)
    bwidth_inner = bwidth - 1 - max(len(b), len(e)) if bwidth else twidth + 2
    ndashes = (bwidth_inner - twidth) - len(e)
    eline = ' ' + ndashes * '-' + e
    return b, eline
