Output Format Changes in packages Between Versions: ``30.1.0`` and ``31.0.0b4``
=========================================================================================================================

Versions and Options
--------------------

Scancode Versions
^^^^^^^^^^^^^^^^^

- ``v31.0.0b4``
- ``v30.1.0``


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

.. literalinclude:: ./yaml/scancode-31.0.0b4-packages-37d4e0a.yaml
   :diff: ./yaml/scancode-30.1.0-packages-37d4e0a.yaml

JSON Diff
---------

.. literalinclude:: ./json/scancode-31.0.0b4-packages-37d4e0a.json
   :diff: ./json/scancode-30.1.0-packages-37d4e0a.json
