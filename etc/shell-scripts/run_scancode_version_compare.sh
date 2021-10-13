#! /bin/bash
# Halt script on error
set -e

# Set up a clean environment
./configure --clean
./configure --dev

# Activate the Virtual Environment
source venv/bin/activate

# Fail if New and Old version numbers don't exist
if [[ "$VERSION_OLD" == "" ]]; then
    echo "VERSION_OLD must be provided as an environment variable"
    exit 1
fi

if [[ "$VERSION_NEW" == "" ]]; then
    echo "VERSION_NEW must be provided as an environment variable"  
    exit 1
fi

# Get the latest commit
COMMIT_LATEST="$(git log -1 --format=format:'%h' --abbrev-commit)"

# Clean the /outputs/latest/ directory by moving scans to /outputs/archive/
mv docs/source/outputs/latest/json/* docs/source/outputs/archive/json/
mv docs/source/outputs/latest/yaml/* docs/source/outputs/archive/yaml/

# Install and run scans for the Old Scancode Version
pip install scancode-toolkit==$VERSION_OLD --force-reinstall

OLD_JSON_PATH="./docs/source/outputs/archive/json/scancode-$VERSION_OLD-clipeu-$COMMIT_LATEST.json"
OLD_YAML_PATH="./docs/source/outputs/archive/yaml/scancode-$VERSION_OLD-clipeu-$COMMIT_LATEST.yaml"

scancode -clipeu --json-pp $OLD_JSON_PATH --yaml $OLD_YAML_PATH ./scan-data/samples/

# Force reinstall the New Scancode Version and run scans again
pip install scancode-toolkit==$VERSION_NEW --force-reinstall

NEW_JSON_PATH="./docs/source/outputs/latest/json/scancode-$VERSION_NEW-clipeu-$COMMIT_LATEST.json"
NEW_YAML_PATH="./docs/source/outputs/latest/yaml/scancode-$VERSION_NEW-clipeu-$COMMIT_LATEST.yaml"

scancode -clipeu --json-pp $NEW_JSON_PATH --yaml $NEW_YAML_PATH ./scan-data/samples/

# Clean up scan header files to generate cleaner diffs
python3 ./etc/scripts/clean_json_yaml_scan_headers.py \
    --json "$OLD_JSON_PATH" \
    --yaml "$OLD_YAML_PATH"

python3 ./etc/scripts/clean_json_yaml_scan_headers.py \
    --json "$NEW_JSON_PATH" \
    --yaml "$NEW_YAML_PATH"

# Set the values in cookiecutter.json 
python3 ./etc/scripts/modify_cookiecutter_json.py \
    --cookiecutter-location ./templates/cookiecutter.json \
    --new-version "$VERSION_NEW" \
    --old-version "$VERSION_OLD" \
    --latest-commit "$COMMIT_LATEST"

# Create the .rst file with the cookiecutter template
pip install cookiecutter
cookiecutter templates --no-input
mv latest/* docs/source/outputs/latest/
rm -r latest/
