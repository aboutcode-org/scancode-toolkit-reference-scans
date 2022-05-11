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

echo "Installing and Running Scans for scancode-toolkit $VERSION_OLD"
echo "---------------------------------------------------------"
echo ""

# Install and run scans for the Old Scancode Version
pip install scancode-toolkit==$VERSION_OLD --force-reinstall

# Sample -clipeu

OLD_JSON_PATH="./docs/source/outputs/latest/json/scancode-$VERSION_OLD-clipeu-$COMMIT_LATEST.json"
OLD_YAML_PATH="./docs/source/outputs/latest/yaml/scancode-$VERSION_OLD-clipeu-$COMMIT_LATEST.yaml"

scancode -clipeu --json-pp $OLD_JSON_PATH --yaml $OLD_YAML_PATH ./scan-data/samples/

# Packages -p

PACKAGES_OLD_JSON_PATH="./docs/source/outputs/latest/json/scancode-$VERSION_OLD-packages-$COMMIT_LATEST.json"
PACKAGES_OLD_YAML_PATH="./docs/source/outputs/latest/yaml/scancode-$VERSION_OLD-packages-$COMMIT_LATEST.yaml"

scancode -p --json-pp $PACKAGES_OLD_JSON_PATH --yaml $PACKAGES_OLD_YAML_PATH ./scan-data/packages/python-sample/

echo "Installing and Running Scans for scancode-toolkit $VERSION_NEW"
echo "---------------------------------------------------------"
echo ""

# Force reinstall the New Scancode Version and run scans again
pip install scancode-toolkit==$VERSION_NEW --force-reinstall

# Sample -clipeu

NEW_JSON_PATH="./docs/source/outputs/latest/json/scancode-$VERSION_NEW-clipeu-$COMMIT_LATEST.json"
NEW_YAML_PATH="./docs/source/outputs/latest/yaml/scancode-$VERSION_NEW-clipeu-$COMMIT_LATEST.yaml"

scancode -clipeu --json-pp $NEW_JSON_PATH --yaml $NEW_YAML_PATH ./scan-data/samples/

# Packages -p

PACKAGES_NEW_JSON_PATH="./docs/source/outputs/latest/json/scancode-$VERSION_NEW-packages-$COMMIT_LATEST.json"
PACKAGES_NEW_YAML_PATH="./docs/source/outputs/latest/yaml/scancode-$VERSION_NEW-packages-$COMMIT_LATEST.yaml"

scancode -p --json-pp $PACKAGES_NEW_JSON_PATH --yaml $PACKAGES_NEW_YAML_PATH ./scan-data/packages/python-sample/

echo "Running Scans successful!"
echo "---------------------------------------------------------"
echo ""

# Clean up scan header files to generate cleaner diffs
python3 ./etc/scripts/clean_json_yaml_scan_headers.py \
    --json "$OLD_JSON_PATH" \
    --yaml "$OLD_YAML_PATH"

python3 ./etc/scripts/clean_json_yaml_scan_headers.py \
    --json "$PACKAGES_OLD_JSON_PATH" \
    --yaml "$PACKAGES_OLD_YAML_PATH"

python3 ./etc/scripts/clean_json_yaml_scan_headers.py \
    --json "$NEW_JSON_PATH" \
    --yaml "$NEW_YAML_PATH"

python3 ./etc/scripts/clean_json_yaml_scan_headers.py \
    --json "$PACKAGES_NEW_JSON_PATH" \
    --yaml "$PACKAGES_NEW_YAML_PATH"

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

echo "Generating Documentation successful! \n"
echo "---------------------------------------------------------"
echo ""

echo "   outputs/latest/clipeu-v$VERSION_NEW-v$VERSION_OLD-$COMMIT_LATEST" >> ./docs/source/index.rst
echo "   outputs/latest/packages-v$VERSION_NEW-v$VERSION_OLD-$COMMIT_LATEST" >> ./docs/source/index.rst

echo "   latest/clipeu-v$VERSION_NEW-v$VERSION_OLD-$COMMIT_LATEST" >> ./docs/source/outputs/index.rst
echo "   latest/packages-v$VERSION_NEW-v$VERSION_OLD-$COMMIT_LATEST" >> ./docs/source/outputs/index.rst

echo "Generated Documentation added to toctree!"
echo "---------------------------------------------------------"
echo ""

./configure --docs
cd docs
./scripts/sphinx_build_link_check.sh
./scripts/doc8_style_check.sh
make html

echo "Documentation build successful!"
echo "---------------------------------------------------------"
echo ""

if [[ "$SHOW_DOCS" == "TRUE" ]]; then
    see build/html/index.html
    exit 1
fi