#!/usr/bin/env python3

from subprocess import check_output
deps = [
        {'name': 'ctags', 'progs': ['ctags'], 'required': True},
        {'name': 'npm', 'progs': ['npm', 'node'], 'required': True},
        {'name': 'yarn', 'progs': ['yarn'], 'required': True},
        {'name': 'coqide', 'progs': ['coqide'], 'required': False},
        {'name': 'Build essentials', 'progs': ['gcc', 'make'], 'required': True},
        {'name': 'hasktags', 'progs': ['hasktags'], 'required': False},
        {'name': 'clang', 'progs': ['clang', 'llc-11'], 'required': True},
        {'name': 'i3', 'progs': ['i3'], 'required': False},
]

for dep in deps:
    try:
        for prog in dep['progs']:
            check_output(['which', prog])
    except:
        if dep['required']:
            print('ERROR: Missing dependency: ' + str(dep['name']))
            exit(1)
        else:
            print('WARNING: Missing suggested dependency: ' + str(dep['name']))
