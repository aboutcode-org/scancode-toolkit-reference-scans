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
import saneyaml


def load_json(path):
    with open(path, 'r') as file_handler:
        data = json.load(file_handler)
    return data


def write_json(data, path):
    with open(path, 'w') as file_handler:
        json.dump(data, file_handler, indent=2)


def load_yaml(path):
    data = saneyaml.load(open(path).read())
    return data


def write_yaml(data, path):
    with open(path, 'w') as file:
        file.write(saneyaml.dump(data, indent=4))


def clean_data_headers(data):

    data["headers"][0]["options"].pop("input")

    if "--json-pp" in data["headers"][0]["options"]:
        data["headers"][0]["options"].pop("--json-pp")
    if "--yaml" in data["headers"][0]["options"]:
        data["headers"][0]["options"].pop("--yaml")

    data["headers"][0].pop("start_timestamp")
    data["headers"][0].pop("end_timestamp")

    return data


@click.command()
@click.option('-j', '--json',
              type=click.Path(dir_okay=False, writable=True, readable=False),
              default=None,
              metavar='FILE',
              )
@click.option('-y', '--yaml',
              type=click.Path(dir_okay=False, writable=True, readable=False),
              default=None,
              metavar='FILE',
              )
@click.help_option('-h', '--help')
def cli(json, yaml):
    """
    Write Licenses/Rules from scancode into a CSV file with all details.
    Output can be optionally filtered by category/license-key.
    """
    if json:
        data = load_json(path=json)
        data = clean_data_headers(data)
        write_json(data=data, path=json)

    if yaml:
        data = load_yaml(path=yaml)
        data = clean_data_headers(data)
        write_yaml(data=data, path=yaml)


if __name__ == '__main__':
    cli()
