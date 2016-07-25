import difflib
import json
import subprocess
import sys
import vim

binary = 'rubocop'
if vim.eval('exists("g:rubocop_path")') == "1":
    binary = vim.eval('g:rubocop_path')

rbformat_config = None
if vim.eval('exists("g:rbformat_config")') == "1":
    rbformat_config = vim.eval('g:rbformat_config')

rbformat_rubocop_extra_args = None
if vim.eval('exists("g:rbformat_rubocop_extra_args")') == "1":
    rbformat_rubocop_extra_args = vim.eval('g:rbformat_rubocop_extra_args')

def main():
    buf = vim.current.buffer
    text = '\n'.join(buf)

    command = [binary, '--auto-correct', '-s']
    if rbformat_config:
        command.extend(['--config', rbformat_config])

    if rbformat_rubocop_extra_args:
        command.extend([rbformat_rubocop_extra_args])

    command.extend(['.'])

    p = subprocess.Popen(command,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            stdin=subprocess.PIPE)

    stdout, stderr = p.communicate(input=text)

    if stderr:
        print stderr

    if not stdout:
        print ('No output from rubocop (crashed?).\n')

    else:
        lines = stdout.split('\n')
        sequence = difflib.SequenceMatcher(None, vim.current.buffer, lines)
        for op in reversed(sequence.get_opcodes()):
            if op[0] is not 'equal':
                vim.current.buffer[op[1]:op[2]] = lines[op[3]:op[4]]

main()
