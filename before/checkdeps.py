#!/usr/bin/env python3

from subprocess import check_output
deps = [
        {'name': 'ctags', 'progs': ['ctags']},
        {'name': 'npm', 'progs': ['npm', 'node']},
        {'name': 'yarn', 'progs': ['yarn']},
        {'name': 'coqide', 'progs': ['coqide']},
        {'name': 'Build essentials', 'progs': ['gcc', 'make']},
        {'name': 'hasktags', 'progs': ['hasktags']},
]

for dep in deps:
    try:
        for prog in dep['progs']:
            check_output(['which', prog])
    except:
        print('Missing dependency: ' + str(dep['name']))
        exit(1)
