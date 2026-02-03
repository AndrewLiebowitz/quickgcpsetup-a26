#!/bin/bash
source config.sh

echo "Step 2: Granting 'Browser' role at Folder level..."

# Extract emails from column 3, skip header, remove carriage returns
EMAILS=$(tail -n +2 "$CSV_FILE" | cut -d',' -f3 | tr -d '\r')

for EMAIL in $EMAILS; do
    echo "Granting Browser access to: $EMAIL"
    gcloud resource-manager folders add-iam-policy-binding "$FOLDER_ID" \
        --member="user:$EMAIL" \
        --role="roles/browser" \
        --condition=None --quiet > /dev/null
done

echo "Done. All users can now see the folder hierarchy."
