"""
File: path_utils.py
Author: J. Morgan Lieberthal
Email: morgan@jmorgan.org
Github: https://github.com/baberthal
Description: Path-related utilities
"""

import os


def splitparts(path):
    """TODO: Docstring for splitparts.

    :type path: TODO
    :returns: TODO

    """
    parts = []
    while True:
        path, current = os.path.split(path)

        if current != '':
            parts.append(current)
        else:
            if path != '':
                parts.append(path)
            break
    parts.reverse()
    return parts


def RelativePath(filename, to=None):
    parts = splitparts(filename)

    if to in parts:
        idx = parts.index(to)
        print("found '%{0}'. Index: %{1}".format(to, idx))
        return os.path.join(*parts[idx + 1:])

    return os.path.spilt(filename)[-1]


def RelativeFilePath(filename):
    """Compute the relative path of `filename`, from the closest 'include',
    'lib', or 'src' directory.

    :type filename: str
    :returns: str
    """
    parts = splitparts(filename)
    result = None
    for src_dir in ['include', 'lib', 'src']:
        if src_dir in parts:
            idx = parts.index(src_dir)
            result = os.path.join(*parts[idx + 1:])
    return result or os.path.split(filename)[-1]


def ShortPath(filename):
    return os.path.split(filename)[-1]
