#!/bin/bash
# --- Configuration ---
ORG_ID="120263950329"
FOLDER_NAME="a26"

echo "Step 1: Finding or Creating Folder..."

# Find the folder ID if it exists
FOLDER_ID=$(gcloud resource-manager folders list --organization=$ORG_ID --filter="display_name=$FOLDER_NAME" --format="value(ID)")

if [ -z "$FOLDER_ID" ]; then
    echo "Folder '$FOLDER_NAME' not found. Creating it..."
    FOLDER_ID=$(gcloud resource-manager folders create --display-name=$FOLDER_NAME --organization=$ORG_ID --format="value(name)" | cut -d'/' -f2)
else
    echo "Found existing folder: $FOLDER_NAME ($FOLDER_ID)"
fi

# Save the ID for use in the next scripts
echo "export FOLDER_ID=$FOLDER_ID" > config.sh
echo "export CSV_FILE='users.csv - aliebowitz (1).csv'" >> config.sh

echo "Done. FOLDER_ID is saved to config.sh"
