"""Helper methods for UltiSnips snippets"""


def MakeCXXFileHeader(textwidth):
    head = '//===---'
    tail = '-*- C++ -*-===//'

    middle = '-' * textwidth

    return ''.join(head, tail, middle)
