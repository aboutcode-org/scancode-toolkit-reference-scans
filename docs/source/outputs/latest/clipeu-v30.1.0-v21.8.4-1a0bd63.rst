Output Format Changes Between Versions: ``21.8.4`` and ``30.1.0``
=============================================================================================================

Versions and Options
--------------------

Scancode Versions
^^^^^^^^^^^^^^^^^

- ``v30.1.0``
- ``v21.8.4``


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

See `scancode-toolkit CLI reference <https://scancode-toolkit.readthedocs.io/en/latest/cli-reference/list-options.html>`_ for more details.

Changes in Output Data
----------------------

Headers
^^^^^^^

Additions:

- ``output_format_version`` added.
- ``spdx_license_list_version`` added in ``extra_data``.

Files: Licenses
^^^^^^^^^^^^^^^

Additions:

- ``is_unknown`` added.
- ``referenced_filenames`` and ``has_unknown`` added in ``matched_rule``.


YAML Diff
---------

.. literalinclude:: ./yaml/scancode-30.1.0-clipeu-1a0bd63.yaml
   :diff: ../archive/yaml/scancode-21.8.4-clipeu-1a0bd63.yaml

JSON Diff
---------

.. literalinclude:: ./json/scancode-30.1.0-clipeu-1a0bd63.json
   :diff: ../archive/json/scancode-21.8.4-clipeu-1a0bd63.json
