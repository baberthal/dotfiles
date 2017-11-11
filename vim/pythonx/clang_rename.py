"""
Minimal clang-rename integration with Vim.
Before installing, make sure one of the following requirements is satisfied:
    * clang-rename is in your PATH
    * `g:clang_rename_path` points to a valid clang-rename executable
    * `binary` in this file points to a valid clang-rename executable
"""

from __future__ import print_function
import vim
import subprocess
import sys


def GetSymbolOffset():
    offset = int(vim.eval('line2byte(line("."))+col(".")')) - 2
    if offset < 0:
        print >> sys.stderr, """Couldn't determine cursor position.
                                File maybe empty?"""
        exit(1)
    return offset


class Renamer(object):
    """Responsible for running clang-rename"""

    DEFAULT_CLANG_RENAME_BINARY = 'clang-rename'
    _clang_rename_binary = None

    @classmethod
    def GetClangRenameBinary(klass):
        """TODO: Docstring for GetClangRenameBinary.
        :returns: TODO

        """
        if klass._clang_rename_binary is not None:
            return klass._clang_rename_binary

        if vim.eval("exists('g:clang_rename_path')"):
            klass._clang_rename_binary = vim.eval('g:clang_rename_path')
        else:
            klass._clang_rename_binary = klass.DEFAULT_CLANG_RENAME_BINARY

        return klass._clang_rename_binary

    @classmethod
    def RequestNewSymbolName(self):
        message = 'New name:'
        given = vim.eval("input('{}\n')".format(message))
        return given

    def __init__(self, newname=None):
        """ """
        self._new_name = newname if newname else Renamer.RequestNewSymbolName()
        self._binary = Renamer.GetClangRenameBinary()
        self._file_name = vim.current.buffer.name
        self._offset = GetSymbolOffset()
        self._extra_args = []
        if vim.eval("exists('g:clang_rename_extra_args')") == "1":
            self._extra_args += list(vim.bindeval('g:clang_rename_extra_args'))
        if vim.eval("exists('g:compilation_db_path')") == "1":
            self._extra_args += ['-p', vim.eval('g:compilation_db_path')]

    def run(self):
        """TODO: Docstring for run.
        """
        command = self._rename_command()
        p = subprocess.Popen(command,
                             stdout=subprocess.PIPE,
                             stderr=subprocess.PIPE)
        stdout, stderr = p.communicate()
        if stderr:
            print(stderr)

        vim.command('checktime')

    def _rename_command(self):
        command = [
            self._binary,
            self._file_name,
            '-i',
            '-offset', str(self._offset),
            '-new-name', str(self._new_name)
        ]

        command += [arg for arg in self._extra_args]

        print("Running command {0}".format(command))

        return command

    def _fail(self, message):
        print >> sys.stderr, message
        exit(1)


def Main(name):
    renamer = Renamer(newname=name)
    renamer.run()


if __name__ == '__main__':
    Main()
