"""
File: util.py
Author: J. Morgan Lieberthal
Email: morgan@jmorgan.org
Github: https://github.com/baberthal
Description: General Utility Functions
"""

import re


def lpad(string, n=1):
    """Pad `string` with `n` spaces, on the left side only

    :type string: str
    :type n: int
    :returns: str
    """
    return (' ' * n) + string


def rpad(string, n=1):
    """Pad `string` with `n` spaces, on the left side only

    :type string: str
    :type n: int
    :returns: str
    """
    return string + (' ' * n)


def lpad_if(cond, string, n=1):
    """TODO: Docstring for rpad_if.

    :type cond: bool
    :type string: str
    :type n: int
    :returns: str

    """
    return lpad(string, n) if cond else string


def rpad_if(cond, string, n=1):
    """TODO: Docstring for rpad_if.

    :type cond: bool
    :type string: str
    :type n: int
    :returns: str

    """
    return rpad(string, n) if cond else string


def ReadFile(filepath):
    with open(filepath, encoding='utf8') as f:
        return f.read()


def ToCIdentifier(arg):
    """
    Converts `arg` into a valid C identifer, by replacing disallowed
    characters with '' or '_'.

    :type arg: str
    :returns: str
    """
    return re.sub(r'[^A-Z0-9]', '_', arg.replace('-', ''), flags=re.IGNORECASE)
