# -*- coding: utf-8 -*-
"""
  pythonx.license
  ~~~~~~~~~~~~~~~

  License helpers for file headers and such.

  :copyright: (c) 2021 by J. Morgan Lieberthal.
  :license: MIT, see LICENSE for more details.
"""

import re

class License(object):
  LOOKUPS = [
    (re.compile(r'^Apache\s*(?P<version>[\d\.]*)', re.I), lambda m: License("Apache", version=(m.group('version') or 2))),
    (re.compile(r'^MIT$', re.I), lambda m: License("MIT")),
    (re.compile(r'(?:proprietary|all rights reserved)', re.I), lambda m: License("All rights reserved", is_open_source=False))
  ]

  @classmethod
  def lookup(cls, name):
    """TODO: Docstring for lookup_license.

    :type name: string
    :returns: TODO

    """
    for pattern, factory in cls.LOOKUPS:
      m = pattern.match(name)
      if m:
        return factory(m)
    return None

  def __init__(self, name, version = None, is_open_source = True):
    self.name = name
    self.version = int(version) if version is not None else None
    self.is_open_source = is_open_source

  @property
  def full_name(self):
    result = ''
    if self.is_open_source:
      result += 'the {name} License'.format(name=self.name)
      if self.version is not None:
        result += ', Version {:.1f}'.format(float(self.version))
    else:
      result += 'All rights reserved.'
    return result

  @property
  def text_desc(self):
    if self.is_open_source:
      return 'Licensed under {}'.format(self.full_name)
    else:
      return self.full_name

  def __repr__(self):
    return self.text_desc

  def __str__(self):
    return self.text_desc
