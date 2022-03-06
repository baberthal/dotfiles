"""
C++ Snippet Helpers
"""

from skeleton_snippets import MakeFileHeader, GetProjectName, GetProjectNamespace
from helpers.file_header import FileHeader
from helpers.path_utils import RelativeFilePath
from helpers.util import ToCIdentifier
from helpers.vimsupport import GetCurrentBufferFilepath
import re

__all__ = [
    "GetProjectName",
    "GetProjectNamespace",
    "MakeSectionLine",
    "MakeFileHeader",
    "HeaderGuard",
    "HasContainingClass",
    "FindContainingClassName",
    "WriteDocstringArgs"
]


# Some notes about the below regex:
#   * it assumes and macros between "class" and [class-name] will be ALL_CAPS.
#   * it assumes you're not a lunatic and don't name your classes with ALL_CAPS
#   * it assumes the name of the class is the last identifier before the `{`
#     or before the `:` if the class is a descendant of another.
CLASS_DEFINITION_RE = re.compile(
    r'(?:class|struct) (?:\s*)(\w+)(?:\s+:\s+[\w\s]*)?\s*{'
)


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


def HasContainingClass(buffer, cursor_line):
    """Returns a boolean value indicating if the cursor position (x, cursor_line)
    is inside of a c++ class definition.

    :type buffer: vim.buffer
    :type cursor_line: int
    :returns: bool

    """
    return (FindContainingClassName(buffer, cursor_line) is not None)


def FindContainingClassName(buffer, cursor_line):
    """Finds the name of the class which contains the current cursor, if any. If
    a containing class definition could not be found, returns None. Can be used
    in conjunction with HasContainingClass(buffer, cursor_line) as a custom
    snippet context in UltiSnips.

    :type buffer: vim.buffer
    :type cursor_line: int
    :returns: str or None

    """
    # get a slice of the buffer from the first line current line,
    # then join the lines so we can perform a multi-line regex match
    buffer_slice = '\n'.join(buffer[0:cursor_line])

    # match the buffer against the class definition regex.
    # TODO: This needs to perform an incremental search in reverse order rather
    # than just matching the regexp against the entire buffer
    result = [m for m in CLASS_DEFINITION_RE.finditer(buffer_slice)][-1]

    # return none if there is no match
    if result is None:
        return None

    # return the result of the first match group (i.e. the class name)
    return result.group(1)


def MakeFileHeader(snip, t, width, pad=True, short=False, comment_style='cpp'):
    header = FileHeader(snip, short=short, comment_style=comment_style)
    return header.render(t, width=width, pad=pad)


def WriteDocstringArgs(arglist, snip):
    """Extract the list of comma-separated arguments in `arglist`, and write
    them as doxygen markup to `snip`

    :type arglist: str
    :type snip: UltiSnips.TextObjects.SnippetUtil
    :returns: None

    """
    args = str(arglist).split(",")
    if len(args) > 1:
        c = 0
        for arg in args:
            if c == 0:
                snip.rv += arg
                c = 1
            else:
                snip += '*       : %s' % arg.strip()
    else:
        snip.rv = args[0]


def _RemoveTopLevelInclude(filename):
    parts = filename.split('/')
    if len(parts) == 1:
        return filename
    return '/'.join(parts[1:])
