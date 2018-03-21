"""
File: vimsupport.py
Author: J. Morgan Lieberthal
Email: morgan@jmorgan.org
Github: https://github.com/baberthal
Description: Support Functions for Vim Integration
"""

import os
import vim


def GetCurrentBufferFilepath():
    """TODO: Docstring for GetCurrentBufferFilepath.
    :returns: str
    """
    return (GetBufferFilepath(vim.current.buffer)
            or GetVariableValue('expand("%")'))


def GetBufferFilepath(buffer_object):
    """TODO: Docstring for GetBufferFilepath.

    :type buffer_object: vim.Buffer
    :returns: str

    """
    if buffer_object.name:
        return os.path.normpath(ToUnicode(buffer_object.name))
    return None


def ToUnicode(value):
    if not value:
        return str()
    if isinstance(value, str):
        return value
    if isinstance(value, bytes):
        return str(value, 'utf8')
    return str(value)


def VariableExists(variable):
    """
    :rtype: bool
    """
    return GetBoolValue("exists('{0}')".format(EscapeForVim(variable)))


def GetVariableValue(variable):
    """
    :rtype: str
    """
    return vim.eval(variable)


def GetBoolValue(variable):
    """
    :rtype: bool
    """
    return bool(int(vim.eval(variable)))


def GetIntValue(variable):
    """
    :rtype: int
    """
    return int(vim.eval(variable))


def EscapeForVim(text):
    """
    :rtype: str
    """
    return ToUnicode(text.replace("'", "''"))


def VimExprToPythonType(expr):
    """Returns a Python type from the return value of the supplied Vim
    expression.  If the expression returns a list, dict or other non-string
    type, then it is returned unmodified. If the string return can be converted
    to an integer, returns an integer, otherwise returns the result converted
    to a Unicode string."""

    result = vim.eval(expr)

    if not (isinstance(result, str) or isinstance(result, bytes)):
        return result

    try:
        return int(result)
    except ValueError:
        return ToUnicode(result)


def Evaluate(expr):
    return vim.eval(expr)


def CurrentFiletypes():
    return ToUnicode(vim.eval('&filetype')).split('.')


def GetBufferFiletypes(bufnr):
    command = 'getbufvar({0}, "&ft")'.format(bufnr)
    return ToUnicode(vim.eval(command)).split('.')


def FiletypesForBuffer(buffer_obj):
    return GetBufferFiletypes(buffer_obj.number)
