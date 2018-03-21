"""
C++ Snippet Helpers
"""

from skeleton_snippets import GetProjectName, GetProjectNamespace
from helpers.file_header import FileHeader
from helpers.path_utils import RelativeFilePath
from helpers.util import ToCIdentifier
from helpers.vimsupport import GetCurrentBufferFilepath

__all__ = [
    "GetProjectName",
    "GetProjectNamespace",
    "MakeSectionLine",
    "MakeFileHeader",
]


def MakeSectionLine(twidth, tail=None):
    start = '//===---'
    end = tail if tail else '---===//'
    ndashes = twidth - len(start) - len(end)
    mid = ndashes * '-'
    return start, mid, end


def HeaderGuard(filename=None, snip=None):
    """Generate a header-guard identifer for use in a c or c++ header.

    If the `snip` argument is passed, the header guard will be written directly
    to it. In either case, the identifer for `filename` is returned.

    :type filename: str or None
    :type snip: UltiSnips.TextObjects.SnippetUtil
    :returns: str

    """
    filename = filename or GetCurrentBufferFilepath()
    ident = ToCIdentifier(RelativeFilePath(filename)).upper()
    return ident


def MakeFileHeader(snip, t, width, pad=True):
    header = FileHeader(snip)
    return header.render(t, width=width, pad=pad)


def _RemoveTopLevelInclude(filename):
    parts = filename.split('/')
    if len(parts) == 1:
        return filename
    return '/'.join(parts[1:])
