Scancode-toolkit Reference Scans
================================

This repository houses reference scans for `scancode-toolkit <https://github.com/aboutcode-org/scancode-toolkit>`_,
and also documentation with diffs of scan output between different versions of scancode-toolkit.

The documentation is hosted at https://scancode-toolkit-reference-scans.readthedocs.io/en/latest/.

Updating after new Scancode Release
-----------------------------------

After a new scancode-toolkit release, to generate reference scans and output version diffs
documentation, the steps are:

    1. Run scancode for the latest and previous versions for the same sample scan data.
    2. Document Output Version diffs.

This is automated by the `script <https://github.com/aboutcode-org/scancode-toolkit-reference-scans/blob/main/etc/shell-scripts/run_scancode_version_compare.sh>`_ at::

    scancode-toolkit-reference-scans/etc/shell-scripts/run_scancode_version_compare.sh

Using this script the steps to generate scans and document output versions diffs are as follows.

Run Script
^^^^^^^^^^

Give script permission to execute::

    chmod u+x ./etc/shell-scripts/run_scancode_version_compare.sh

Run the script::

    VERSION_OLD="21.8.4" VERSION_NEW="30.1.0" ./etc/shell-scripts/run_scancode_version_compare.sh

Here ``VERSION_OLD`` and ``VERSION_NEW`` should be replaced by the last and latest version numbers
for scancode-toolkit for which the reference scans and output versions differences has to be
documented.

Describe Output Format Changes
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

For the .rst file present in ``scancode-toolkit-reference-scans/docs/source/outputs/latest/``
folder, (For example: ``clipeu-v30.1.0-v21.8.4-1a0bd63.rst``) the relevant sections
has to be updated. The section ``Changes in Output Data`` has to be updated with:

    - additions
    - deletions
    - modifications

For each of the following sections:

    - ``Headers``
    - ``Files:Licenses``
    - ``Files:Packages``
    - Other Codebase/Resource Level Attribute Changes

Commit and Push changes
-----------------------

Now the changes made have to be commited and pushed to GitHub. The ReadTheDocs page build is
triggured automatically and the new docs will be hosted.
