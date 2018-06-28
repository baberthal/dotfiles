"""
File: tshelpers.py
Author: J. Morgan Lieberthal
Email: morgan@jmorgan.org
Github: https://github.com/baberthal
Description: Typescript Snippet Helpers
"""

import inflector


def Classify(basename):
    """TODO: Docstring for Classify.

    :type basename: TODO
    :returns: TODO

    """
    return inflector.camelize(basename)


def Functionify(basename):
    """TODO: Docstring for Functionify.

    :type basename: TODO
    :returns: TODO

    """
    return inflector.camelize(basename, False)
