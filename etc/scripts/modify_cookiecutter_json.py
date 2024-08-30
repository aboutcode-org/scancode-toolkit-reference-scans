# -*- coding: utf-8 -*-
#
# Copyright (c) nexB Inc. and others. All rights reserved.
# ScanCode is a trademark of nexB Inc.
# SPDX-License-Identifier: Apache-2.0
# See http://www.apache.org/licenses/LICENSE-2.0 for the license text.
# See https://github.com/aboutcode-org/scancode-toolkit for support or download.
# See https://aboutcode.org for more information about nexB OSS projects.
#

import click
import json


def write_json(data, path):
    with open(path, 'w') as file_handler:
        json.dump(data, file_handler, indent=2)


@click.command()
@click.option('-c', '--cookiecutter-location',
              type=click.Path(dir_okay=False, writable=True, readable=False),
              default=None,
              metavar='FILE',
              )
@click.option('-n', '--new-version',
              type=str,
              default=None,
              metavar='STRING',
              )
@click.option('-o', '--old-version',
              type=str,
              default=None,
              metavar='STRING',
              )
@click.option('-l', '--latest-commit',
              type=str,
              default=None,
              metavar='STRING',
              )
@click.help_option('-h', '--help')
def cli(cookiecutter_location, new_version, old_version, latest_commit):
    """
    Write a cookiecutter.json with scancode versions `new_version` and `old_version`,
    and `latest_commit`.
    """
    data = {}
    data["dir_name"] = "latest"
    data["new_version"] = new_version
    data["old_version"] = old_version
    data["latest_commit"] = latest_commit

    write_json(data=data, path=cookiecutter_location)


if __name__ == '__main__':
    cli()
