#!/bin/bash
source config.sh

echo "Step 3: Creating Projects and Assigning Owners..."

EMAILS=$(tail -n +2 "$CSV_FILE" | cut -d',' -f3 | tr -d '\r')

for EMAIL in $EMAILS; do
    # Create a unique Project ID: 'a26-' + username + 4 random chars
    USER_PART=$(echo $EMAIL | cut -d'@' -f1 | tr -cd '[:alnum:]' | tr '[:upper:]' '[:lower:]')
    RANDOM_SUFFIX=$(cat /dev/urandom | tr -dc 'a-z0-9' | fold -w 4 | head -n 1)
    PROJECT_ID="a26-${USER_PART}-${RANDOM_SUFFIX}"

    echo "------------------------------------------------"
    echo "User: $EMAIL"
    echo "Project: $PROJECT_ID"

    # 1. Create the project
    gcloud projects create "$PROJECT_ID" --folder="$FOLDER_ID"

    if [ $? -eq 0 ]; then
        # 2. Grant Owner role to the user on the new project
        echo "Assigning Owner role..."
        gcloud projects add-iam-policy-binding "$PROJECT_ID" \
            --member="user:$EMAIL" \
            --role="roles/owner"
    else
        echo "FAILED to create project for $EMAIL"
    fi
done

echo "------------------------------------------------"
echo "Project creation process finished."
