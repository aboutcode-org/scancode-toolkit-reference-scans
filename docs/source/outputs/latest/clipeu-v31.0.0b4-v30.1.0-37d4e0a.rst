Output Format Changes Between Versions: ``30.1.0`` and ``31.0.0b4``
=============================================================================================================

Versions and Options
--------------------

Scancode Versions
^^^^^^^^^^^^^^^^^

- ``v31.0.0b4``
- ``v30.1.0``


Scancode Output Format Version
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

- ``v30.1.0`` has output format version ``1.0.0``.
- ``v31.0.0b4`` has output format version ``2.0.0``.

CLI Args
^^^^^^^^

- ``--copyright``
- ``--licence``
- ``--info``
- ``--packages``
- ``--email``
- ``--url``

The input for the scan was this `folder <https://github.com/aboutcode-org/scancode-toolkit-reference-scans/tree/main/scan-data/samples>`_.

See `scancode-toolkit CLI reference <https://scancode-toolkit.readthedocs.io/en/latest/cli-reference/list-options.html>`_ for more details.

Changes in Output Data
----------------------

Changes [Addition]
^^^^^^^^^^^^^^^^^^

Header ``extra_data`` changes:

- A new header level ``extra_data`` attribute ``system_environment`` has been added.
  It has the following attributes: ``operating_system``, ``cpu_architecture``,
  ``platform``, ``platform_version``, ``python_version``.

Top-level/Codebase-level changes:

- A new codebase level attribute ``packages`` has been added.
- A new codebase level attribute ``dependencies`` has been added.

Resource-level changes:

- There is a new resource-level attribute ``for_packages``.

Changes in ``package-data`` (Resource level attribute):

- The package_data attribute ``dependencies`` now has a new attribute ``resolved_package``.

Changes [Modification/Deletion]
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Resource-level changes:

- The resource level attribute ``packages`` has been renamed to ``package_data``.

Changes in ``package-data`` (Resource level attribute):

- The package_data attribute ``root_path`` has been deleted from ``package_data``.
- The package_data attribute ``requirement`` is renamed to ``extracted_requirement``.

Changes in ``copyrights`` (Resource level attribute):

- The copyrights attribute ``value`` is renamed to ``copyright``.

Changes in ``holders`` (Resource level attribute):

- The holders attribute ``value`` is renamed to ``holder``.

Changes in ``authors`` (Resource level attribute):

- The authors attribute ``value`` is renamed to ``author``.


Explanation
^^^^^^^^^^^

There are major changes in package detection and reporting.
Codebase-level attribute ``packages`` created from one or more ``package_data``
and files for the packages are reported.

The specific changes made are:

- The resource level attribute ``packages`` has been renamed to ``package_data``,
  as these are really package data that are being detected, such as manifests,
  lockfiles or other package data.

- A new top-level attribute ``packages`` has been added which contains package
  instances created from ``package_data`` detected in the codebase. This has the
  data attributes of a ``package_data`` field plus others:
  ``package_uuid``, ``package_data_files`` and ``files``.

- A new codebase level attribute ``dependencies`` has been added which contains dependency
  instances created from lockfiles detected in the codebase.

- The package attribute ``root_path`` has been deleted from ``package_data`` in favour
  of the new format where there is no root conceptually, just a list of files for each
  package.

- There is a new resource-level attribute ``for_packages`` which refers to packages
  through package_uuids (pURL + uuid string).

- The package_data attribute ``dependencies`` (which is a list of DependentPackages),
  now has a new attribute ``resolved_package`` with a package data mapping.
  Also the ``requirement`` attribute is renamed to ``extracted_requirement``.

There are additions in the header level ``extra_data`` for holding system and system_environment
data for better reporting:

- A new header level ``extra_data`` attribute ``system_environment`` has been added.
  It has the following attributes: ``operating_system``, ``cpu_architecture``,
  ``platform``, ``platform_version``, ``python_version``.

As there are major modifications and deletions in the result data structure, the
output format version has been increased to ``2.0.0`` from ``1.0.0``.


YAML Diff
---------

.. literalinclude:: ./yaml/scancode-31.0.0b4-clipeu-37d4e0a.yaml
   :diff: ./yaml/scancode-30.1.0-clipeu-37d4e0a.yaml

JSON Diff
---------

.. literalinclude:: ./json/scancode-31.0.0b4-clipeu-37d4e0a.json
   :diff: ./json/scancode-30.1.0-clipeu-37d4e0a.json
