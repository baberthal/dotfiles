"""
File: inflector/__init__.py
Author: J. Morgan Lieberthal
Email: morgan@jmorgan.org
Github: https://github.com/baberthal
Description:
"""

from . import inflection


def camelize(string, uppercase_first_letter=True):
    if uppercase_first_letter:
        parts = [inflection.camelize(p) for p in string.split('/')]
        return '::'.join(parts)
    else:
        return inflection.camelize(string, uppercase_first_letter)
