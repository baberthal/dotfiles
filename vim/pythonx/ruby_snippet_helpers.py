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
import inflector

DIR_OF_THIS_SCRIPT = os.path.abspath(os.path.dirname(__file__))
DEFAULT_LOG_DIR = os.path.realpath(
    os.path.join(DIR_OF_THIS_SCRIPT, '..', 'logs'))

logging.basicConfig(
    filename=os.path.join(DEFAULT_LOG_DIR, 'pysnips.log'), level=logging.DEBUG)

SPEC_DIRECTORY_MAPPINGS = {
    'controller': ['spec', 'controllers'],
    'helper': ['spec', 'helpers'],
    'job': ['spec', 'jobs'],
    'mailer': ['spec', 'mailers'],
    'model': ['spec', 'models'],
    'request': ['spec', '(requests|integration|api)'],
    'routing': ['spec', 'routing'],
    'view': ['spec', 'views'],
    'feature': ['spec', 'feature'],
    'system': ['spec', 'system'],
}


def Classify(basename):
    """TODO: Docstring for Classify.

    :type basename: TODO
    :returns: TODO

    """
    # return re.sub(r'(_|^)(.)', lambda m: m.group(2).upper(), basename)
    return inflector.camelize(basename)


def ClassifySpec(filepath):
    """TODO: Docstring for ClassifySpec.

    :type filepath: TODO
    :returns: str

    """
    basename = re.sub(r'spec/(?:\w+)/(.+)_spec(?:\.rb)?', '\\1', filepath)
    return Classify(basename)


def InferSpecType(filepath):
    """TODO: Docstring for InferSpecType.

    :type filepath: TODO
    :returns: TODO

    """
    pass


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
    return os.path.join(*_ExtractRelativePathParts(filename, topdir='lib'))


def SpecPathForFilename(filename):
    """TODO: Docstring for SpecPathForFilename.

    :type filename: TODO
    :returns: TODO

    """
    relative_parts = _ExtractRelativePathParts(filename, topdir='spec')
    return os.path.join(*relative_parts[1:])


def _ExtractRelativePathParts(filename, topdir='lib'):
    parts = path_utils.splitparts(filename)
    if topdir in parts:
        index = parts.index(topdir)
        logging.debug("Index of '{1}' in parts: {0}".format(index, topdir))
        subset = parts[index + 1:]
        logging.debug("New subset after slice: {0}".format(subset))
        return subset

    logging.warning("Unable to find '{1}' in parts: {0}".format(parts, topdir))
    return [os.path.split(filename)[-1]]
