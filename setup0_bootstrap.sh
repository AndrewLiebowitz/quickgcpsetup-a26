#!/bin/bash
# Dynamically identify the environment
ORG_ID=$(gcloud organizations list --format="value(ID)" --limit=1)
USER_EMAIL=$(gcloud config get-value account)

if [ -z "$ORG_ID" ]; then
    echo "Error: No Organization found. Ensure you are logged in to a Workspace/Cloud Identity account."
    exit 1
fi

echo "Detected Org ID: $ORG_ID"
echo "Granting folderCreator role to $USER_EMAIL..."

# Grant the initial permission required to start the hierarchy
gcloud organizations add-iam-policy-binding "$ORG_ID" \
    --member="user:$USER_EMAIL" \
    --role="roles/resourcemanager.folderCreator"

# Initialize the config file for subsequent steps
echo "export ORG_ID=$ORG_ID" > config.sh
echo "export CSV_FILE='users.csv'" >> config.sh
echo "export FOLDER_NAME='a26'" >> config.sh

echo "Bootstrap complete. Created config.sh. Please ensure CSV_FILE name in config.sh matches your uploaded file."
