# -*- coding: utf-8 -*-
"""
  vim.skeleton_snippets
  ~~~~~~~~~~~~~~~~~~~~~

  Skeleton Snippet Helpers

  :copyright: (c) 2018 by J. Morgan Lieberthal.
  :license: MIT, see LICENSE for more details.
"""

from helpers.comment_parser import CommentParser
from helpers.vimsupport import GetVariableValue, VariableExists
from helpers.file_header import FileHeader
import vim

###############################################################################
#                           File Skeleton Functions                           #
###############################################################################


def MakeFileHeader(snip, t, width):
    """

    :type snip: TODO
    :type t: TODO
    :type width: TODO
    :returns: TODO

    """
    header = FileHeader(snip)
    header.render(t, width)


###############################################################################
#                          Project Helper Functions                           #
###############################################################################


def GetProjectNamespace():
    if VariableExists('g:snips_project_namespace'):
        return GetVariableValue('g:snips_project_namespace')
    return GetProjectName()


def GetProjectName():
    """Returns the project name, either by querying vim for the variable
    ('g:snips_project'), or infering the project name from vim's cwd.

    :rtype: str

    """
    if VariableExists('g:snips_project'):
        return GetVariableValue('g:snips_project')
    return InferProjectName()


def InferProjectName():
    """Infers the project name from vim's working directory

    :rtype: str

    """
    return vim.eval("fnamemodify(getcwd(), ':t')")


###############################################################################
#                          General Helper Functions                           #
###############################################################################

#  Get Comment Format {{{ #


def GetCommentFormat():
    """
    Returns a 4-element tuple (first_line, middle_lines, end_line, indent)
    representing the comment format for the current file.

    It first looks at the 'commentstring', if that ends with %s, it uses that.
    Otherwise it parses '&comments' and prefers single character comment
    markers if there are any.

    :rtype: tuple(str, str, str, str)
    """
    commentstring = GetVariableValue('&commentstring')
    if commentstring.endswith('%s'):
        c = commentstring[:-2]
        return (c, c, c, '')
    comments = _ParseComments(GetVariableValue('&comments'))
    for c in comments:
        if c[0] == 'SINGLE_CHAR':
            return c[1:]
    return comments[0][1:]


def _ParseComments(s):
    """
    Parses vim's comments option to extract the comment format.

    :type string: str
    :rtype: str

    """
    return CommentParser(s).parse()


#  }}} Get Comment Format #
