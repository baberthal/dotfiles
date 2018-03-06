"""
File: user_options_store.py
Author: J. Morgan Lieberthal
Email: morgan@jmorgan.org
Github: https://github.com/baberthal
Description: Stores User Options in a frozen dict
"""

import json
import os
from frozendict import frozendict
from helpers.util import ReadFile

_USER_OPTIONS = {}


def SetAll(new_opts):
    global _USER_OPTIONS
    _USER_OPTIONS = frozendict(new_opts)


def GetAll():
    return _USER_OPTIONS


def Value(key):
    return _USER_OPTIONS[key]


def DefaultOptions():
    settings_path = os.path.join(
        os.path.dirname(os.path.abspath(__file__)), "default_settings.json")
    options = json.loads(ReadFile(settings_path))
    return options
