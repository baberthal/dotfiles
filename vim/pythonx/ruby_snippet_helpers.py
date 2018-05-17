# -*- coding: utf-8 -*-
"""
    ruby_snippet_helpers
    ~~~~~~~~~~~~~~~~~~~~~~~~

    DESCRIPTION

    :copyright: (c) 2018 by J. Morgan Lieberthal.
    :license: MIT
"""

import logging
import os
import re

from helpers import path_utils

DIR_OF_THIS_SCRIPT = os.path.abspath(os.path.dirname(__file__))
DEFAULT_LOG_DIR = os.path.realpath(
    os.path.join(DIR_OF_THIS_SCRIPT, '..', 'logs'))

logging.basicConfig(
    filename=os.path.join(DEFAULT_LOG_DIR, 'pysnips.log'), level=logging.DEBUG)


def Classify(basename):
    """TODO: Docstring for Classify.

    :type basename: TODO
    :returns: TODO

    """

    def doit(match):
        return match.group(2).upper()

    return re.sub(r'(_|^)(.)', doit, basename)


def ExtractClassPath(filename):
    """TODO: Docstring for ExtractClassPath.

    :type filename: TODO
    :returns: TODO

    """
    parts = _ExtractRelativePathParts(filename)
    return [os.path.splitext(p)[0] for p in parts]


def RelativePathFromNearestLibDirectory(filename):
    """TODO: Docstring for RelativePathFromNearestLibDirectory.

    :type filename: TODO
    :returns: TODO

    """
    return os.path.join(*_ExtractRelativePathParts(filename))


def _ExtractRelativePathParts(filename):
    parts = path_utils.splitparts(filename)
    if 'lib' in parts:
        index = parts.index('lib')
        logging.debug("Index of 'lib' in parts: {0}".format(index))
        subset = parts[index + 1:]
        logging.debug("New subset after slice: {0}".format(subset))
        return subset

    logging.warning("Unable to find 'lib' in parts: {0}".format(parts))
    return [os.path.split(filename)[-1]]
