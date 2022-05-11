Output Format Changes Between Versions: ``{{cookiecutter.old_version}}`` and ``{{cookiecutter.new_version}}``
=============================================================================================================

Versions and Options
--------------------

Scancode Versions
^^^^^^^^^^^^^^^^^

- ``v{{cookiecutter.new_version}}``
- ``v{{cookiecutter.old_version}}``


Scancode Output Format Version
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This is introduced in scancode ``30.x.x`` for the first time.
Scancode ``v30.1.0`` has output format version ``1.0.0``.

CLI Args
^^^^^^^^

- ``--copyright``
- ``--licence``
- ``--info``
- ``--packages``
- ``--email``
- ``--url``

The input for the scan was this `folder <https://github.com/nexB/scancode-toolkit-reference-scans/tree/main/scan-data/samples>`_.

See `scancode-toolkit CLI reference <https://scancode-toolkit.readthedocs.io/en/latest/cli-reference/list-options.html>`_ for more details.

Changes in Output Data
----------------------

Fill this section with changes in Output format. (Refer the Diffs)


YAML Diff
---------

.. literalinclude:: ./yaml/scancode-{{cookiecutter.new_version}}-clipeu-{{cookiecutter.latest_commit}}.yaml
   :diff: ./yaml/scancode-{{cookiecutter.old_version}}-clipeu-{{cookiecutter.latest_commit}}.yaml

JSON Diff
---------

.. literalinclude:: ./json/scancode-{{cookiecutter.new_version}}-clipeu-{{cookiecutter.latest_commit}}.json
   :diff: ./json/scancode-{{cookiecutter.old_version}}-clipeu-{{cookiecutter.latest_commit}}.json
