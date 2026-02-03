#!/bin/bash
source config.sh

gcloud billing accounts list

# Prompt for the Billing Account ID if not already in config
if [ -z "$BILLING_ACCOUNT_ID" ]; then
    read -p "Enter your Billing Account ID (e.g., 012345-6789AB-CDEFGH): " BILLING_ACCOUNT_ID
    echo "export BILLING_ACCOUNT_ID=$BILLING_ACCOUNT_ID" >> config.sh
fi

echo "Step 4: Linking projects in folder $FOLDER_ID to billing account $BILLING_ACCOUNT_ID..."

# Get all project IDs currently inside the folder
PROJECTS=$(gcloud projects list --filter="parent.id=$FOLDER_ID AND parent.type=folder" --format="value(projectId)")

for PROJECT_ID in $PROJECTS; do
    echo "Linking $PROJECT_ID..."
    gcloud billing projects link "$PROJECT_ID" --billing-account="$BILLING_ACCOUNT_ID"
done

echo "Done. All projects in the folder are now billing-enabled."
