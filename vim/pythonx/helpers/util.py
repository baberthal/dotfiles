"""
File: util.py
Author: J. Morgan Lieberthal
Email: morgan@jmorgan.org
Github: https://github.com/baberthal
Description: General Utility Functions
"""


def ReadFile(filepath):
    with open(filepath, encoding='utf8') as f:
        return f.read()
