Output Format Changes in packages Between Versions: ``{{cookiecutter.old_version}}`` and ``{{cookiecutter.new_version}}``
=========================================================================================================================

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

- ``--packages``

See `scancode-toolkit CLI reference <https://scancode-toolkit.readthedocs.io/en/latest/cli-reference/list-options.html>`_ for more details.

Changes in Output Data
----------------------

Fill this section with changes in Output format. (Refer the Diffs)


YAML Diff
---------

.. literalinclude:: ./yaml/scancode-{{cookiecutter.new_version}}-packages-{{cookiecutter.latest_commit}}.yaml
   :diff: ./yaml/scancode-{{cookiecutter.old_version}}-packages-{{cookiecutter.latest_commit}}.yaml

JSON Diff
---------

.. literalinclude:: ./json/scancode-{{cookiecutter.new_version}}-packages-{{cookiecutter.latest_commit}}.json
   :diff: ./json/scancode-{{cookiecutter.old_version}}-packages-{{cookiecutter.latest_commit}}.json
